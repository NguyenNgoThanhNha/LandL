using L_L.Data.Entities;
using L_L.Data.UnitOfWorks;
using Microsoft.EntityFrameworkCore;

namespace L_L.Business.Services
{
    public class OrderService
    {
        private readonly UnitOfWorks unitOfWorks;

        public OrderService(UnitOfWorks unitOfWorks)
        {
            this.unitOfWorks = unitOfWorks;
        }

        public async Task<List<Order>> GetAll()
        {
            return await unitOfWorks.OrderRepository.GetAll().ToListAsync();
        }
    }
}
