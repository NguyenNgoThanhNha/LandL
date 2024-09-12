using AutoMapper;
using L_L.Business.Models;
using L_L.Data.Entities;
using L_L.Data.UnitOfWorks;
using Microsoft.EntityFrameworkCore;

namespace L_L.Business.Services
{
    public class PackageTypeService
    {
        private readonly UnitOfWorks unitOfWorks;
        private readonly IMapper mapper;

        public PackageTypeService(UnitOfWorks unitOfWorks, IMapper mapper)
        {
            this.unitOfWorks = unitOfWorks;
            this.mapper = mapper;
        }
        public async Task<PacketTypeModel> FilterPacketType(decimal weightDecimal, decimal lengthDecimal, decimal widthDecimal, decimal heightDecimal)
        {
            // Retrieve all matching packages
            var packageTypes = await unitOfWorks.PacketTypeRepository
                .FindByCondition(pt => pt.WeightLimit >= weightDecimal &&
                     pt.LengthMin <= lengthDecimal && pt.LengthMax >= lengthDecimal &&
                     pt.WidthMin <= widthDecimal && pt.WidthMax >= widthDecimal &&
                     pt.HeightMin <= heightDecimal && pt.HeightMax >= heightDecimal)
                .ToListAsync(); // Ensure ToListAsync() is called to get all matching records

            if (packageTypes == null || !packageTypes.Any())
            {
                return null;
            }

            // Select the largest package based on a criterion
            var largestPackage = packageTypes
                .OrderBy(pt => pt.WeightLimit) // Adjust this criterion based on what defines "largest"
                .FirstOrDefault();

            return mapper.Map<PacketTypeModel>(largestPackage);
        }

        public async Task<List<PacketTypeModel>> RecommendPacketTypes(decimal weightDecimal, decimal lengthDecimal, decimal widthDecimal, decimal heightDecimal)
        {
            // Tìm tất cả các gói có WeightLimit lớn hơn trọng lượng nhập vào
            var packageTypesGreater = await unitOfWorks.PacketTypeRepository
                .FindByCondition(pt =>
                    pt.WeightLimit > weightDecimal) // Trọng lượng lớn hơn
                .OrderBy(pt => pt.WeightLimit) // Sắp xếp theo WeightLimit để tìm các gói lớn hơn theo thứ tự
                .ToListAsync();

            // Tìm tất cả các gói có WeightLimit nhỏ hơn trọng lượng nhập vào
            var packageTypesLesser = await unitOfWorks.PacketTypeRepository
                .FindByCondition(pt =>
                    pt.WeightLimit < weightDecimal) // Trọng lượng nhỏ hơn
                .OrderByDescending(pt => pt.WeightLimit) // Sắp xếp theo WeightLimit giảm dần để lấy gói gần nhất nhỏ hơn
                .ToListAsync();

            if (!packageTypesGreater.Any() && !packageTypesLesser.Any())
            {
                return null;
            }

            // Lấy gói có WeightLimit lớn hơn gần nhất
            var closestGreaterPackage = mapper.Map<PacketTypeModel>(packageTypesGreater.FirstOrDefault());

            // Lấy gói có WeightLimit lớn hơn một bậc (nếu có)
            var nextGreaterPackage = mapper.Map<PacketTypeModel>(packageTypesGreater.Skip(1).FirstOrDefault());

            // Lấy gói có WeightLimit nhỏ hơn gần nhất
            var closestLesserPackage = mapper.Map<PacketTypeModel>(packageTypesLesser.FirstOrDefault());

            // Tạo danh sách kết quả
            var recommendedPackages = new List<PacketTypeModel>();

            if (closestGreaterPackage != null)
                recommendedPackages.Add(closestGreaterPackage);

            if (nextGreaterPackage != null)
                recommendedPackages.Add(nextGreaterPackage);

            if (closestLesserPackage != null)
                recommendedPackages.Add(closestLesserPackage);

            // Đảm bảo không có trùng lặp trong danh sách
            recommendedPackages = recommendedPackages
                .GroupBy(pt => pt.WeightLimit)
                .Select(g => g.First())
                .ToList();

            return mapper.Map<List<PacketTypeModel>>(recommendedPackages);
        }

        public async Task<List<VehicleTypeModel>> MatchingBaseOnPacketType(PacketTypeModel packageType)
        {
            // Fetch the vehicle types based on the package type's ID and include related entities
            var vehicleTypes = await unitOfWorks.PacketTypeRepository
                .FindByCondition(x => x.PackageTypeId == packageType.PackageTypeId)
                .Include(x => x.VehiclePackageRelations) // Assuming VehiclePackageRelations is a navigation property
                .Select(x => x.VehiclePackageRelations.Select(vpr => vpr.VehicleType)) // Adjust this based on your actual entity relationships
                .ToListAsync();


            var flattenedVehicleTypes = vehicleTypes
                .SelectMany(vpr => vpr)
                .ToList();

            return mapper.Map<List<VehicleTypeModel>>(flattenedVehicleTypes);
        }

        // weight of packet = tấn
        public async Task<decimal> CaculatorService(decimal distance, decimal weight, VehicleTypeModel vehicleType, int orderCount)
        {
            // Constants
            decimal baseDistance = 4; // 4 km đầu
            decimal discountFactor = 1 - (orderCount * 0.1m); // Giảm giá dựa trên số đơn H
            if (discountFactor < 0) discountFactor = 0; // Không cho phép giảm giá quá 100%

            // Base cost cho 4 km đầu
            decimal baseCostForFirst4Km = vehicleType.BaseRate;

            // Nếu distance >= 5km, tính chi phí theo ShippingRate cho phần vượt quá 4km
            decimal additionalCost = 0;
            if (distance > baseDistance)
            {
                var shippingRate = await GetShippingRate(vehicleType.VehicleTypeId, distance);
                if (shippingRate != null)
                {
                    // Tính khoảng cách vượt quá 4km
                    decimal extraDistance = distance - baseDistance;
                    additionalCost = extraDistance * shippingRate.RatePerKM;
                }
            }

            // Tính toán tỷ lệ chi phí theo tấn
            decimal ratePerTon = await GetRatePerTon(vehicleType);

            // Phương trình tính chi phí
            decimal cost = (baseCostForFirst4Km / discountFactor) + (weight * ratePerTon) + additionalCost;

            return cost;
        }

        // Lấy ShippingRate dựa trên VehicleTypeId và khoảng cách
        private async Task<ShippingRate> GetShippingRate(int vehicleTypeId, decimal distance)
        {
            return await unitOfWorks.ShippingRateRepository
                .FindByCondition(sr => sr.VehicleTypeId == vehicleTypeId && sr.DistanceFrom <= distance &&
                    (sr.DistanceTo == null || sr.DistanceTo >= distance))
                .OrderByDescending(sr => sr.DistanceTo) // Chọn ShippingRate với DistanceTo gần nhất nhưng không nhỏ hơn distance
                .FirstOrDefaultAsync();
        }

        // Lấy tỷ lệ chi phí theo tấn (RatePerTon) từ bảng ShippingRate
        private async Task<decimal> GetRatePerTon(VehicleType vehicleType)
        {
            // Giả định rằng bạn có thể tính tỷ lệ chi phí theo tấn từ ShippingRate
            // Bạn có thể cần phải điều chỉnh tùy thuộc vào cách bạn lưu trữ hoặc tính toán tỷ lệ này
            // Ví dụ:
            // return vehicleType.BaseRate / 1000; // Ví dụ tỷ lệ theo tấn nếu base rate đại diện cho 1000 kg

            // Hoặc nếu bạn có một bảng hoặc công thức khác để tính tỷ lệ theo tấn, hãy sử dụng nó
            // Trong trường hợp này, bạn có thể cần điều chỉnh cách tính toán theo tỷ lệ thực tế
            throw new NotImplementedException("Chưa có cách tính tỷ lệ chi phí theo tấn.");
        }



    }
}
