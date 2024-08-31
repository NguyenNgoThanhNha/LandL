using Microsoft.EntityFrameworkCore;

namespace L_L.Data.Entities
{
    public class AppDbContext : DbContext
    {
        public AppDbContext()
        {

        }
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }
        #region Dbset
        public DbSet<User> Users { get; set; }
        public DbSet<UserRole> UserRoles { get; set; }
        public DbSet<Blog> Blogs { get; set; }
        public DbSet<BlogRating> BlogRatings { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderDetails> OrderDetails { get; set; }
        public DbSet<OrderTracking> OrderTrackings { get; set; }
        public DbSet<Hub> Hubs { get; set; }
        public DbSet<Truck> Trucks { get; set; }
        public DbSet<TruckType> TruckTypes { get; set; }
        public DbSet<Service> Services { get; set; }
        #endregion
    }
}
