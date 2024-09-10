using L_L.Business.Commons.Request;
using L_L.Data.UnitOfWorks;

namespace L_L.Business.Services
{
    public class ServiceService
    {
        private readonly UnitOfWorks unitOfWorks;

        public ServiceService(UnitOfWorks unitOfWorks)
        {
            this.unitOfWorks = unitOfWorks;
        }

        public Task<string> SearchService(SearchRequest req)
        {

            return null;
        }
    }
}
