using L_L.Data.Entities;
using L_L.Data.Repositories;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace L_L.Data.UnitOfWorks
{
    public class UnitOfWorks 
    {
        private readonly AppDbContext _dbContext;
        private UserRepository _userRepo;

        public UnitOfWorks(AppDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public UserRepository UserRepository
        {
            get { return _userRepo ??= new UserRepository(_dbContext); }
        }
    }
}
