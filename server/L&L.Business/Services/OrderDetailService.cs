using AutoMapper;
using L_L.Business.Commons.Request;
using L_L.Business.Exceptions;
using L_L.Business.Models;
using L_L.Data.UnitOfWorks;
using Microsoft.EntityFrameworkCore;

namespace L_L.Business.Services
{
    public class OrderDetailService
    {
        private readonly UnitOfWorks unitOfWorks;
        private readonly IMapper mapper;

        public OrderDetailService(UnitOfWorks unitOfWorks, IMapper mapper)
        {
            this.unitOfWorks = unitOfWorks;
            this.mapper = mapper;
        }

        public async Task<List<OrderDetailsModel>> GetAll()
        {
            return mapper.Map<List<OrderDetailsModel>>(unitOfWorks.OrderDetailRepository.GetAll().ToListAsync());
        }

        public async Task<OrderDetailsModel> CreateOrderDetail(int orderId, CreateOrderRequest req)
        {
            var order = await unitOfWorks.OrderRepository.GetByIdAsync(orderId);
            if (order == null)
            {
                throw new BadRequestException("Order not found!");
            }

            // create product
            var product = await unitOfWorks.ProductRepository.AddAsync(new Data.Entities.Product()
            {

            });
            return null;
        }
    }
}
