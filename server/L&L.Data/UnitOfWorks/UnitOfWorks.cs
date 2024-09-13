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
        private VehicleTypeRepository _vehicleTypeRepo;
        private PacketTypeRepository _packageTypeRepo;
        private ShippingRateRepository _shippingRateRepo;
        private OrderRepository _orderRepo;
        private OrderDetailRepository _orderDetailRepo;

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

        public VehicleTypeRepository VehicleTypeRepository
        {
            get { return _vehicleTypeRepo ??= new VehicleTypeRepository(_dbContext); }
        }

        public PacketTypeRepository PacketTypeRepository
        {
            get { return _packageTypeRepo ??= new PacketTypeRepository(_dbContext); }
        }
        public ShippingRateRepository ShippingRateRepository
        {
            get { return _shippingRateRepo ??= new ShippingRateRepository(_dbContext); }
        }
        public OrderRepository OrderRepository
        {
            get { return _orderRepo ??= new OrderRepository(_dbContext); }
        }
        public OrderDetailRepository OrderDetailRepository
        {
            get { return _orderDetailRepo ??= new OrderDetailRepository(_dbContext); }
        }
    }
}
