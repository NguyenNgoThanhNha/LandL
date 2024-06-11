using L_L.Data.UnitOfWorks;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace L_L.Business.Services
{
    public class UserService
    {
        private readonly UnitOfWorks unitOfWorks;

        public UserService(UnitOfWorks unitOfWorks)
        {
            this.unitOfWorks = unitOfWorks;
        }
    }
}
