using AutoMapper;
using L_L.Business.Commons.Request;
using L_L.Business.Exceptions;
using L_L.Business.Models;
using L_L.Business.Ultils;
using L_L.Data.Entities;
using L_L.Data.UnitOfWorks;
using Microsoft.EntityFrameworkCore;
using NetTopologySuite.Geometries;

namespace L_L.Business.Services
{
    public class OrderService
    {
        private readonly UnitOfWorks unitOfWorks;
        private readonly IMapper _mapper;

        public OrderService(UnitOfWorks unitOfWorks, IMapper mapper)
        {
            this.unitOfWorks = unitOfWorks;
            _mapper = mapper;
        }

        public async Task<List<OrderModel>> GetAll()
        {
            return _mapper.Map<List<OrderModel>>(await unitOfWorks.OrderRepository.GetAll().ToListAsync());
        }

        public async Task<OrderModel> CreateOrder(string amount)
        {
            var order = new OrderModel();
            order.Status = StatusEnums.Processing.ToString();
            order.TotalAmount = decimal.Parse(amount);
            var orderCreate = await unitOfWorks.OrderRepository.AddAsync(_mapper.Map<Order>(order));
            var result = await unitOfWorks.OrderRepository.Commit();
            if (result > 0)
            {
                return _mapper.Map<OrderModel>(orderCreate);
            }
            return null;
        }

        public async Task<OrderModel> GetOrder(int id)
        {
            var order = await unitOfWorks.OrderRepository.GetByIdAsync(id);
            if (order != null)
            {
                return _mapper.Map<OrderModel>(order);
            }
            return null;
        }

        public async Task<bool> UpdateStatus(StatusEnums status, OrderModel order)
        {
            order.Status = status.ToString();

            var existingOrder = await unitOfWorks.OrderRepository.GetByIdAsync(order.OrderId);
            if (existingOrder == null)
            {
                return false;
            }

            _mapper.Map(order, existingOrder);

            unitOfWorks.OrderRepository.Update(existingOrder);

            await unitOfWorks.OrderRepository.Commit();
            return true;
        }

        public async Task<List<OrderDetailsModel>> PublicOrder()
        {
            var listOrderDetail = await unitOfWorks.OrderDetailRepository.GetAll()
                .Include(o => o.DeliveryInfoDetail)  // Include bảng DeliveryInfo
                /*                .Include(o => o.TruckInfo)           // Include bảng Truck*/
                .Include(o => o.ProductInfo)         // Include bảng Product
                .Include(o => o.OrderInfo)           // Include bảng Order
                /*                .Include(o => o.UserOrder)           // Include bảng User*/
                .Where(o => o.Status == StatusEnums.Processing.ToString())
                .ToListAsync();
            return _mapper.Map<List<OrderDetailsModel>>(listOrderDetail);
        }

        public async Task<bool> AddDriverToOrderDetail(AcceptDriverRequest req)
        {
            // get order detail
            var orderDetail = await unitOfWorks.OrderDetailRepository.GetByIdAsync(int.Parse(req.orderDetailId));
            if (orderDetail == null)
            {
                throw new BadRequestException("Order detail not found!");
            }

            var order = await unitOfWorks.OrderRepository.GetByIdAsync(int.Parse(req.orderDetailId));
            if (order?.OrderId != orderDetail.OrderId)
            {
                throw new BadRequestException("Order detail of order are invalid!");
            }

            order.DriverId = int.Parse(req.driverId);

            var orderUpdate = unitOfWorks.OrderRepository.Update(order);

            var result = await unitOfWorks.OrderRepository.Commit();

            return result > 0;
        }

        public async Task<ProductsModel> UpdateProductInOrderDetail(string orderDetailId, ProductsModel productsModel)
        {
            var orderDetail = await unitOfWorks.OrderDetailRepository.GetByIdAsync(int.Parse(orderDetailId));
            if (orderDetail == null)
            {
                throw new BadRequestException("Order detail of product is not found");
            }
            if (orderDetail.ProductId != productsModel.ProductId)
            {
                throw new BadRequestException("Order detail have not product with info product provide!");
            }
            var productUpdate = await unitOfWorks.ProductRepository.GetByIdAsync(productsModel.ProductId);
            productUpdate.ProductName = productsModel.ProductName;
            productUpdate.ProductDescription = productsModel.ProductDescription;
            var resultUpdate = unitOfWorks.ProductRepository.Update(productUpdate);
            var result = await unitOfWorks.ProductRepository.Commit();
            if (result > 0)
            {
                return _mapper.Map<ProductsModel>(resultUpdate);
            }
            return null;
        }

        public async Task<DeliveryInfoModel> UpdateDiveryInOrderDetail(string orderDetailId, DeliveryInfoModel deliveryInfoModel)
        {
            var orderDetail = await unitOfWorks.OrderDetailRepository.GetByIdAsync(int.Parse(orderDetailId));
            if (orderDetail == null)
            {
                throw new BadRequestException("Order detail of product is not found");
            }
            if (orderDetail.DeliveryInfoId != deliveryInfoModel.DeliveryInfoId)
            {
                throw new BadRequestException("Order detail have not delivery info with info provide!");
            }
            var deiveryUpdate = await unitOfWorks.DeliveryInfoRepository.GetByIdAsync(deliveryInfoModel.DeliveryInfoId);
            deiveryUpdate.SenderName = deliveryInfoModel.SenderName;
            deiveryUpdate.SenderPhone = deliveryInfoModel.SenderPhone;
            deiveryUpdate.ReceiverName = deliveryInfoModel.ReceiverName;
            deiveryUpdate.ReceiverPhone = deliveryInfoModel.ReceiverPhone;
            deiveryUpdate.PickUpLocation = deliveryInfoModel.PickUpLocation;
            deiveryUpdate.DeliveryLocaTion = deliveryInfoModel.DeliveryLocaTion;
            var resultUpdate = unitOfWorks.DeliveryInfoRepository.Update(deiveryUpdate);
            var result = await unitOfWorks.ProductRepository.Commit();
            if (result > 0)
            {
                return _mapper.Map<DeliveryInfoModel>(resultUpdate);
            }
            return null;
        }

        public async Task<List<OrderDetailsModel>> GetOrderForDriver(string driverId, GetOrderOfDriverRequest req)
        {
            // Get the driver details
            var driver = await unitOfWorks.UserRepository.GetByIdAsync(int.Parse(driverId));
            if (driver == null)
            {
                throw new BadRequestException("Driver not found!");
            }

            // Get the truck details associated with the driver
            var truckOfDriver = await unitOfWorks.TruckRepository.FindByCondition(x => x.UserId == driver.UserId).FirstOrDefaultAsync();
            if (truckOfDriver == null)
            {
                throw new BadRequestException("Truck of driver not found!");
            }

            // Fetch list of order details that are still processing
            var listOrderDetail = await unitOfWorks.OrderDetailRepository.GetAll()
                .Include(x => x.ProductInfo)
                .Include(x => x.DeliveryInfoDetail)
                .Where(x => x.Status == StatusEnums.Processing.ToString())
                .ToListAsync();

            var validOrders = new List<OrderDetailsModel>();

            foreach (var orderDetail in listOrderDetail)
            {
                // Check if truck capacity allows carrying the product
                var product = orderDetail.ProductInfo;

                // Parse the product's dimensions (assuming TotalDimension is in the format "length*width*height")
                var dimensions = product.TotalDismension.Split('*').Select(decimal.Parse).ToList();
                decimal productVolume = dimensions[0] * dimensions[1] * dimensions[2];
                decimal productWeight = decimal.Parse(product.Weight);

                // Compare product's volume and weight with truck's capacity
                if (decimal.Parse(truckOfDriver.LoadCapacity) >= productWeight &&
                    truckOfDriver.DimensionsLength >= dimensions[0] &&
                    truckOfDriver.DimensionsWidth >= dimensions[1] &&
                    truckOfDriver.DimensionsHeight >= dimensions[2])
                {
                    // Now check proximity to driver
                    double driverLatitude = double.Parse(req.latCurrent);
                    double driverLongitude = double.Parse(req.longCurrent);
                    double deliveryLatitude = double.Parse(orderDetail.DeliveryInfoDetail.LatDelivery);
                    double deliveryLongitude = double.Parse(orderDetail.DeliveryInfoDetail.LongDelivery);

                    // Use NetTopologySuite for distance calculation
                    var driverLocation = new Coordinate(driverLongitude, driverLatitude);
                    var deliveryLocation = new Coordinate(deliveryLongitude, deliveryLatitude);
                    var pointA = new Point(driverLocation);
                    var pointB = new Point(deliveryLocation);
                    var distanceToDelivery = pointA.Distance(pointB) * 1000; // Convert from degrees to meters

                    if (distanceToDelivery <= 5000) // For example, orders within a 5km radius
                    {
                        validOrders.Add(new OrderDetailsModel
                        {
                            OrderDetailId = orderDetail.OrderDetailId,
                            Quantity = orderDetail.Quantity,
                            PaymentMethod = orderDetail.PaymentMethod,
                            UnitPrice = orderDetail.UnitPrice,
                            TotalPrice = orderDetail.TotalPrice,
                            Status = orderDetail.Status,
                            /*                            VehicleTypeId = orderDetail.VehicleTypeId,*/
                            /*                            SenderId = orderDetail.SenderId,
                                                        UserOrder = orderDetail.UserOrder,*/
                            OrderId = orderDetail.OrderId,
                            OrderInfo = orderDetail.OrderInfo,
                            ProductId = orderDetail.ProductId,
                            ProductInfo = orderDetail.ProductInfo,
                            /*                            TruckId = truckOfDriver.TruckId,  // Assign the driver's truck
                                                        TruckInfo = truckOfDriver,        // Include truck info*/
                            DeliveryInfoId = orderDetail.DeliveryInfoId,
                            DeliveryInfoDetail = orderDetail.DeliveryInfoDetail
                        });
                    }
                }
            }

            return validOrders;
        }



    }
}
