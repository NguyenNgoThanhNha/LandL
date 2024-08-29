using L_L.Data.Entities;
using L_L.Data.Helpers;
using Microsoft.AspNetCore.Builder;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
namespace L_L.Data.SeedData
{
    public interface IDataaseInitialiser
    {
        Task InitialiseAsync();
        Task SeedAsync();
        Task TrySeedAsync();
    }

    public class DatabaseInitialiser : IDataaseInitialiser
    {
        public readonly AppDbContext _context;

        public DatabaseInitialiser(AppDbContext context)
        {
            _context = context;
        }

        public async Task InitialiseAsync()
        {
            try
            {
                // Migration Database - Create database if it does not exist
                await _context.Database.MigrateAsync();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                throw;
            }
        }

        public async Task SeedAsync()
        {
            try
            {
                await TrySeedAsync();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                throw;
            }
        }

        public async Task TrySeedAsync()
        {
            if (_context.UserRoles.Any() && _context.Users.Any())
            {
                return;
            }

            var superAdminRole = new UserRole { RoleName = "Super Admin" };
            var adminRole = new UserRole { RoleName = "Admin" };
            var instructorRole = new UserRole { RoleName = "Instructor" };
            var traineeRole = new UserRole { RoleName = "Trainee" };
            List<UserRole> userRoles = new()
            {
                superAdminRole,
                adminRole,
                instructorRole,
                traineeRole
            };
            var instructor = new User
            {
                UserName = "Instructor",
                Password = SecurityUtil.Hash("123456"),
                FullName = "Instructor",
                Email = "instructor@gmail.com",
                Gender = "Male",
                Level = "Senior",
                Address = "HCM",
                PhoneNumber = "12345",
                Status = "Active",
                UserRole = instructorRole,
            };
            var superAdmin = new User
            {
                UserName = "SuperAdmin",
                Password = SecurityUtil.Hash("123456"),
                FullName = "SuperAdmin",
                Email = "superadmin@gmail.com",
                Gender = "Male",
                Level = "boss",
                Address = "HCM",
                PhoneNumber = "12345",
                Status = "Active",
                UserRole = superAdminRole,
            };
            var admin = new User
            {
                UserName = "Admin",
                Password = SecurityUtil.Hash("123456"),
                FullName = "Admin",
                Email = "admin@gmail.com",
                Gender = "Male",
                Level = "boss",
                Address = "HCM",
                PhoneNumber = "12345",
                Status = "Active",
                UserRole = adminRole,
            };

            List<User> users = new()
            {
                instructor,
                superAdmin,
                admin,
            };



            // Add Range training program
            await _context.UserRoles.AddRangeAsync(userRoles);
            await _context.Users.AddRangeAsync(users);

            // Save to DB
            await _context.SaveChangesAsync();
        }
    }

    public static class DatabaseInitialiserExtension
    {
        public static async Task InitialiseDatabaseAsync(this WebApplication app)
        {
            // Create IServiceScope to resolve service scope
            using var scope = app.Services.CreateScope();
            var initializer = scope.ServiceProvider.GetRequiredService<DatabaseInitialiser>();

            await initializer.InitialiseAsync();

            // Try to seeding data
            await initializer.SeedAsync();
        }
    }
}
