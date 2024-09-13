using L_L.Business.Models;

namespace L_L.Business.Commons.Response
{
    public class SearchResponse
    {
        public List<VehicleTypeModel> VehicleTypes { get; set; }
        public Dictionary<int, decimal> VehicleCost { get; set; }
    }
}
