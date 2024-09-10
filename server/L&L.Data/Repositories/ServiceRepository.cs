using L_L.Data.Base;
using L_L.Data.Entities;

namespace L_L.Data.Repositories
{
    public class ServiceRepository : GenericRepository<Service, int>
    {
        public ServiceRepository(AppDbContext dbContext) : base(dbContext)
        {
        }
    }
}
