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

            var adminRole = new UserRole { RoleName = "Admin" };
            var customerRole = new UserRole { RoleName = "Customer" };
            var driverRole = new UserRole { RoleName = "Driver" };
            List<UserRole> userRoles = new()
            {
                adminRole,
                customerRole,
                driverRole,
            };
            var customer = new User
            {
                UserName = "Customer",
                Password = SecurityUtil.Hash("123456"),
                FullName = "Customer",
                Email = "customer@gmail.com",
                Gender = "Male",
                City = "HCM",
                Address = "HCM",
                PhoneNumber = "12345",
                Status = "Active",
                TypeLogin = "Normal",
                UserRole = customerRole,
            };
            var superAdmin = new User
            {
                UserName = "Admin",
                Password = SecurityUtil.Hash("123456"),
                FullName = "Admin",
                Email = "admin@gmail.com",
                Gender = "Male",
                City = "HCM",
                Address = "HCM",
                PhoneNumber = "12345",
                Status = "Active",
                TypeLogin = "Normal",
                UserRole = adminRole,
            };
            var driver = new User
            {
                UserName = "Driver",
                Password = SecurityUtil.Hash("123456"),
                FullName = "Driver",
                Email = "driver@gmail.com",
                Gender = "Male",
                City = "HCM",
                Address = "HCM",
                PhoneNumber = "12345",
                Status = "Active",
                TypeLogin = "Normal",
                UserRole = driverRole,
            };

            List<User> users = new()
            {
                driver,
                superAdmin,
                customer,
            };

            // Add vehicletypes
            var vehicleTypes = new List<VehicleType>
            {
                new VehicleType { VehicleTypeName = "0.5 Tấn", BaseRate = 150000 },
                new VehicleType { VehicleTypeName = "1.25 Tấn", BaseRate = 200000 },
                new VehicleType { VehicleTypeName = "1.9 Tấn", BaseRate = 230000 },
                new VehicleType { VehicleTypeName = "2.4 Tấn", BaseRate = 260000 },
                new VehicleType { VehicleTypeName = "3.5 Tấn", BaseRate = 320000 },
                new VehicleType { VehicleTypeName = "5 Tấn", BaseRate = 350000 },
                new VehicleType { VehicleTypeName = "7 Tấn", BaseRate = 400000 },
                new VehicleType { VehicleTypeName = "10 Tấn", BaseRate = 500000 },
            };

            await _context.VehicleTypes.AddRangeAsync(vehicleTypes);
            await _context.SaveChangesAsync();

            var shippingRates = new List<ShippingRate>
            {
                // Shipping rates for 0.5 Tấn
                new ShippingRate { VehicleTypeId = vehicleTypes[0].VehicleTypeId, DistanceFrom = 4, DistanceTo = 4, RatePerKM = 150000 }, // 4 KM ĐẦU
                new ShippingRate { VehicleTypeId = vehicleTypes[0].VehicleTypeId, DistanceFrom = 5, DistanceTo = 15, RatePerKM = 16000 },
                new ShippingRate { VehicleTypeId = vehicleTypes[0].VehicleTypeId, DistanceFrom = 16, DistanceTo = 100, RatePerKM = 15000 },
                new ShippingRate { VehicleTypeId = vehicleTypes[0].VehicleTypeId, DistanceFrom = 101, DistanceTo = null, RatePerKM = 12000 },

                // Shipping rates for 1.25 Tấn
                new ShippingRate { VehicleTypeId = vehicleTypes[1].VehicleTypeId, DistanceFrom = 4, DistanceTo = 4, RatePerKM = 200000 }, // 4 KM ĐẦU
                new ShippingRate { VehicleTypeId = vehicleTypes[1].VehicleTypeId, DistanceFrom = 5, DistanceTo = 15, RatePerKM = 18000 },
                new ShippingRate { VehicleTypeId = vehicleTypes[1].VehicleTypeId, DistanceFrom = 16, DistanceTo = 100, RatePerKM = 16000 },
                new ShippingRate { VehicleTypeId = vehicleTypes[1].VehicleTypeId, DistanceFrom = 101, DistanceTo = null, RatePerKM = 13000 },

                // Shipping rates for 1.9 Tấn
                new ShippingRate { VehicleTypeId = vehicleTypes[2].VehicleTypeId, DistanceFrom = 4, DistanceTo = 4, RatePerKM = 230000 }, // 4 KM ĐẦU
                new ShippingRate { VehicleTypeId = vehicleTypes[2].VehicleTypeId, DistanceFrom = 5, DistanceTo = 15, RatePerKM = 19000 },
                new ShippingRate { VehicleTypeId = vehicleTypes[2].VehicleTypeId, DistanceFrom = 16, DistanceTo = 100, RatePerKM = 17000 },
                new ShippingRate { VehicleTypeId = vehicleTypes[2].VehicleTypeId, DistanceFrom = 101, DistanceTo = null, RatePerKM = 14000 },

                // Shipping rates for 2.4 Tấn
                new ShippingRate { VehicleTypeId = vehicleTypes[3].VehicleTypeId, DistanceFrom = 4, DistanceTo = 4, RatePerKM = 260000 }, // 4 KM ĐẦU
                new ShippingRate { VehicleTypeId = vehicleTypes[3].VehicleTypeId, DistanceFrom = 5, DistanceTo = 15, RatePerKM = 20000 },
                new ShippingRate { VehicleTypeId = vehicleTypes[3].VehicleTypeId, DistanceFrom = 16, DistanceTo = 100, RatePerKM = 18000 },
                new ShippingRate { VehicleTypeId = vehicleTypes[3].VehicleTypeId, DistanceFrom = 101, DistanceTo = null, RatePerKM = 15000 },

                // Shipping rates for 3.5 Tấn
                new ShippingRate { VehicleTypeId = vehicleTypes[4].VehicleTypeId, DistanceFrom = 4, DistanceTo = 4, RatePerKM = 320000 }, // 4 KM ĐẦU
                new ShippingRate { VehicleTypeId = vehicleTypes[4].VehicleTypeId, DistanceFrom = 5, DistanceTo = 15, RatePerKM = 21000 },
                new ShippingRate { VehicleTypeId = vehicleTypes[4].VehicleTypeId, DistanceFrom = 16, DistanceTo = 100, RatePerKM = 19000 },
                new ShippingRate { VehicleTypeId = vehicleTypes[4].VehicleTypeId, DistanceFrom = 101, DistanceTo = null, RatePerKM = 16000 },

                // Shipping rates for 5 Tấn
                new ShippingRate { VehicleTypeId = vehicleTypes[5].VehicleTypeId, DistanceFrom = 4, DistanceTo = 4, RatePerKM = 350000 }, // 4 KM ĐẦU
                new ShippingRate { VehicleTypeId = vehicleTypes[5].VehicleTypeId, DistanceFrom = 5, DistanceTo = 15, RatePerKM = 22000 },
                new ShippingRate { VehicleTypeId = vehicleTypes[5].VehicleTypeId, DistanceFrom = 16, DistanceTo = 100, RatePerKM = 20000 },
                new ShippingRate { VehicleTypeId = vehicleTypes[5].VehicleTypeId, DistanceFrom = 101, DistanceTo = null, RatePerKM = 17000 },

                // Shipping rates for 7 Tấn
                new ShippingRate { VehicleTypeId = vehicleTypes[6].VehicleTypeId, DistanceFrom = 4, DistanceTo = 4, RatePerKM = 400000 }, // 4 KM ĐẦU
                new ShippingRate { VehicleTypeId = vehicleTypes[6].VehicleTypeId, DistanceFrom = 5, DistanceTo = 15, RatePerKM = 24000 },
                new ShippingRate { VehicleTypeId = vehicleTypes[6].VehicleTypeId, DistanceFrom = 16, DistanceTo = 100, RatePerKM = 22000 },
                new ShippingRate { VehicleTypeId = vehicleTypes[6].VehicleTypeId, DistanceFrom = 101, DistanceTo = null, RatePerKM = 19000 },

                // Shipping rates for 10 Tấn
                new ShippingRate { VehicleTypeId = vehicleTypes[7].VehicleTypeId, DistanceFrom = 4, DistanceTo = 4, RatePerKM = 500000 }, // 4 KM ĐẦU
                new ShippingRate { VehicleTypeId = vehicleTypes[7].VehicleTypeId, DistanceFrom = 5, DistanceTo = 15, RatePerKM = 27000 },
                new ShippingRate { VehicleTypeId = vehicleTypes[7].VehicleTypeId, DistanceFrom = 16, DistanceTo = 100, RatePerKM = 25000 },
                new ShippingRate { VehicleTypeId = vehicleTypes[7].VehicleTypeId, DistanceFrom = 101, DistanceTo = null, RatePerKM = 22000 },
            };

            await _context.ShippingRates.AddRangeAsync(shippingRates);
            await _context.SaveChangesAsync();

            var packageTypes = new List<PackageType>
            {
                // T1: ≤ 0.5 Tấn
                new PackageType { WeightLimit = 0.5m, DimensionLimit = "Từ 2.05 x 1.31 x 1.10 đến 2.20 x 1.50 x 1.41", VehicleRangeMin = 500, VehicleRangeMax = 799 },

                // T2: ≤ 0.8 Tấn
                new PackageType { WeightLimit = 0.8m, DimensionLimit = "Từ 2.54 x 1.42 x 1.16 đến 2.68 x 1.50 x 1.58", VehicleRangeMin = 800, VehicleRangeMax = 999 },

                // T3: ≤ 1 Tấn
                new PackageType { WeightLimit = 1.0m, DimensionLimit = "Từ 2.85 x 1.45 x 1.20 đến 3.05 x 1.52 x 1.60", VehicleRangeMin = 1000, VehicleRangeMax = 1249 },

                // T4: ≤ 1.25 Tấn
                new PackageType { WeightLimit = 1.25m, DimensionLimit = "Từ 3.17 x 1.61 x 1.41 đến 3.39 x 1.64 x 1.95", VehicleRangeMin = 1250, VehicleRangeMax = 1499 },

                // T5: ≤ 1.9 Tấn
                new PackageType { WeightLimit = 1.9m, DimensionLimit = "Từ 3.27 x 1.64 x 1.41 đến 3.52 x 1.68 x 1.95", VehicleRangeMin = 1500, VehicleRangeMax = 1999 },

                // T6: ≤ 2.4 Tấn
                new PackageType { WeightLimit = 2.4m, DimensionLimit = "Từ 3.55 x 1.70 x 1.41 đến 3.80 x 1.75 x 1.95", VehicleRangeMin = 2000, VehicleRangeMax = 2999 },

                // T7: ≤ 2.5 Tấn
                new PackageType { WeightLimit = 2.5m, DimensionLimit = "Từ 3.65 x 1.80 x 1.41 đến 3.85 x 1.90 x 1.95", VehicleRangeMin = 3000, VehicleRangeMax = 3999 },

                // T8: ≤ 4 Tấn
                new PackageType { WeightLimit = 4.0m, DimensionLimit = "Từ 3.80 x 1.80 x 1.41 đến 4.10 x 1.90 x 2.05", VehicleRangeMin = 4000, VehicleRangeMax = 4999 },

                // T9: ≤ 5 Tấn
                new PackageType { WeightLimit = 5.0m, DimensionLimit = "Từ 4.15 x 1.80 x 1.78 đến 4.35 x 1.93 x 2.25", VehicleRangeMin = 5000, VehicleRangeMax = 7999 },

                // T10: ≤ 8 Tấn
                new PackageType { WeightLimit = 8.0m, DimensionLimit = "Từ 5.22 x 2.18 x 1.78 đến 5.80 x 2.35 x 2.25", VehicleRangeMin = 8000, VehicleRangeMax = 9999 },

                // T11: ≤ 10 Tấn
                new PackageType { WeightLimit = 10.0m, DimensionLimit = "Từ 6.33 x 2.50 x 1.80 đến 7.32 x 2.35 x 2.25", VehicleRangeMin = 10000, VehicleRangeMax = 14999 },
            };

            await _context.PackageTypes.AddRangeAsync(packageTypes);
            await _context.SaveChangesAsync();

            var vehiclePackageRelations = new List<VehiclePackageRelation>();

            // Define weight limits corresponding to each package type.
            var weightLimits = new List<decimal> { 0.5m, 0.8m, 1.0m, 1.25m, 1.9m, 2.4m, 2.5m, 3.5m, 5.0m, 7.0m, 10.0m };

            // Vehicle mappings with their respective weight limits and IDs.
            var vehicleMappings = new List<(int VehicleTypeId, decimal WeightLimit)>
            {
                (1, 0.5m),
                (2, 1.25m),  // VehicleTypeId = 2 can carry up to 3 packages: 0.5, 0.8, 1.0
                (3, 1.9m),
                (4, 2.4m),
                (5, 3.5m),
                (6, 5.0m),
                (7, 7.0m),
                (8, 10.0m)
            };

            // Define specific constraints for each vehicle type
            var vehicleConstraints = new Dictionary<int, List<decimal>>
            {
                { 1, new List<decimal> {  } },
                { 2, new List<decimal> { 0.5m, 0.8m, 1.0m } },
                { 3, new List<decimal> { 0.5m, 0.8m, 1.0m, 1.25m } },
                { 4, new List<decimal> { 0.5m, 0.8m, 1.0m, 1.25m, 1.9m } },
                { 5, new List<decimal> { 0.5m, 0.8m, 1.0m, 1.25m, 1.9m, 2.4m } },
                { 6, new List<decimal> { 0.5m, 0.8m, 1.0m, 1.25m, 1.9m, 2.4m, 2.5m } },
                { 7, new List<decimal> { 0.5m, 0.8m, 1.0m, 1.25m, 1.9m, 2.4m, 2.5m, 3.5m } },
                { 8, new List<decimal> { 0.5m, 0.8m, 1.0m, 1.25m, 1.9m, 2.4m, 2.5m, 3.5m, 5.0m, 7.0m, 10.0m } }
            };

            // Populate vehicle-package relations based on the defined constraints
            foreach (var vehicle in vehicleMappings)
            {
                var allowedPackageWeights = vehicleConstraints[vehicle.VehicleTypeId];

                foreach (var weightLimit in weightLimits)
                {
                    if (allowedPackageWeights.Contains(weightLimit))
                    {
                        vehiclePackageRelations.Add(new VehiclePackageRelation
                        {
                            VehicleTypeId = vehicle.VehicleTypeId,
                            PackageTypeId = weightLimits.IndexOf(weightLimit) + 1
                        });
                    }
                }
            }

            // Handle the case where there are fewer vehicle-package relations than expected.
            if (vehiclePackageRelations.Count < weightLimits.Count)
            {
                Console.WriteLine($"Warning: Only {vehiclePackageRelations.Count} vehicle-package relations were created. Ensure that all package types are covered.");
            }


            // Add Range
            await _context.UserRoles.AddRangeAsync(userRoles);
            await _context.Users.AddRangeAsync(users);
            await _context.VehiclePackageRelations.AddRangeAsync(vehiclePackageRelations);

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
