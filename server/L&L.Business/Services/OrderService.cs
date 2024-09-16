using AutoMapper;
using L_L.Business.Commons.Request;
using L_L.Business.Exceptions;
using L_L.Business.Models;
using L_L.Business.Ultils;
using L_L.Data.Entities;
using L_L.Data.UnitOfWorks;
using Microsoft.EntityFrameworkCore;

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
    }
}
