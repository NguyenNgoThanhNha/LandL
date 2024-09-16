using AutoMapper;
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

        public async Task<OrderModel> CreateOrder()
        {
            var order = new OrderModel();
            order.Status = StatusEnums.Processing.ToString();
            order.TotalAmount = 0;
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
            var orderStatusUpdate = unitOfWorks.OrderRepository.Update(_mapper.Map<Order>(order));
            if (orderStatusUpdate != null)
            {
                await unitOfWorks.OrderRepository.Commit();
                return true;
            }
            return false;
        }
    }
}
