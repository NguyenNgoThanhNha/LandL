using L_L.Data.Entities;
using L_L.Data.Repositories;

namespace L_L.Data.UnitOfWorks
{
    public class UnitOfWorks
    {
        private readonly AppDbContext _dbContext;
        private UserRepository _userRepo;
        private AuthRepository _authRepo;
        private UserRoleRepository _userRoleRepo;
        private ServiceRepository _serviceRepo;
        private VehicleTypeRepository _vehicleTypeRepo;
        private PacketTypeRepository _packageTypeRepo;

        public UnitOfWorks(AppDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public UserRepository UserRepository
        {
            get { return _userRepo ??= new UserRepository(_dbContext); }
        }

        public AuthRepository AuthRepository
        {
            get { return _authRepo ??= new AuthRepository(_dbContext); }
        }

        public UserRoleRepository UserRoleRepository
        {
            get { return _userRoleRepo ??= new UserRoleRepository(_dbContext); }
        }

        public ServiceRepository ServiceRepository
        {
            get { return _serviceRepo ??= new ServiceRepository(_dbContext); }
        }

        public VehicleTypeRepository VehicleTypeRepository
        {
            get { return _vehicleTypeRepo ??= new VehicleTypeRepository(_dbContext); }
        }

        public PacketTypeRepository PacketTypeRepository
        {
            get { return _packageTypeRepo ??= new PacketTypeRepository(_dbContext); }
        }
    }
}
