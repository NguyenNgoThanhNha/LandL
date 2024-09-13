using L_L.Data.Entities;
using L_L.Data.UnitOfWorks;
using Microsoft.EntityFrameworkCore;

namespace L_L.Business.Services
{
    public class OrderDetailService
    {
        private readonly UnitOfWorks unitOfWorks;

        public OrderDetailService(UnitOfWorks unitOfWorks)
        {
            this.unitOfWorks = unitOfWorks;
        }

        public async Task<List<OrderDetails>> GetAll()
        {
            return await unitOfWorks.OrderDetailRepository.GetAll().ToListAsync();
        }
    }
}
