using L_L.Business.Commons;
using L_L.Business.Commons.Request;
using L_L.Business.Commons.Response;
using L_L.Business.Models;
using L_L.Business.Services;
using Microsoft.AspNetCore.Mvc;

namespace L_L.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly PackageTypeService packageTypeService;

        public ProductController(PackageTypeService packageTypeService)
        {
            this.packageTypeService = packageTypeService;
        }

        [HttpPost("Search")]
        public async Task<IActionResult> Search([FromBody] SearchRequest req)
        {
            if (req == null)
            {
                return BadRequest(ApiResult<ResponseMessage>.Error(new ResponseMessage
                {
                    message = "Request data cannot be null."
                }));
            }

            // Validate request parameters
            if (!decimal.TryParse(req.Weight, out decimal weightDecimal) ||
                !decimal.TryParse(req.Length, out decimal lengthDecimal) ||
                !decimal.TryParse(req.Width, out decimal widthDecimal) ||
                !decimal.TryParse(req.Height, out decimal heightDecimal) ||
                !decimal.TryParse(req.Distance, out decimal distanceDecimal) ||
                weightDecimal <= 0 || lengthDecimal <= 0 || widthDecimal <= 0 || heightDecimal <= 0 || distanceDecimal <= 0)
            {
                return BadRequest(ApiResult<ResponseMessage>.Error(new ResponseMessage
                {
                    message = "Invalid weight, length, width, or height format. Ensure all values are positive numbers."
                }));
            }

            // Tìm package type phù hợp với yêu cầu
            var packetTypeMatch = await packageTypeService.FilterPacketType(weightDecimal, lengthDecimal, widthDecimal, heightDecimal);

            // Nếu không tìm thấy gói phù hợp
            if (packetTypeMatch == null)
            {
                // Gọi hàm recommend để gợi ý các gói gần nhất
                var recommendedPackages = await packageTypeService.RecommendPacketTypes(weightDecimal, lengthDecimal, widthDecimal, heightDecimal);

                if (recommendedPackages == null || !recommendedPackages.Any())
                {
                    return NotFound(ApiResult<ResponseMessage>.Error(new ResponseMessage
                    {
                        message = "No matching or recommended package types found."
                    }));
                }

                // Trả về danh sách các gói recommend
                return Ok(ApiResult<SearchServiceResponse>.Succeed(new SearchServiceResponse()
                {
                    message = "Sorry, we could not find the exact service you requested. Below are some packages that might suit your needs.",
                    ListPacketRecommended = recommendedPackages
                }));
            }

            // Get the list of vehicle types based on the matched package type
            var listVehicleType = await packageTypeService.MatchingBaseOnPacketType(packetTypeMatch);

            if (listVehicleType != null && !listVehicleType.Any())
            {
                // khối lượng package
                var weight = lengthDecimal * heightDecimal * widthDecimal;

                // get order count
                var oderCount = 1;

                Dictionary<int, decimal> listCost = new Dictionary<int, decimal>();

                foreach (var vehicleType in listVehicleType)
                {
                    var cost = await packageTypeService.CaculatorService(distanceDecimal, weight, vehicleType, oderCount);
                    listCost.Add(vehicleType.VehicleTypeId, cost);
                }
            }

            return Ok(ApiResult<List<VehicleTypeModel>>.Succeed(listVehicleType));
        }

    }
}
