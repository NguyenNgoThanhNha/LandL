using L_L.Business.Models;

namespace L_L.Business.Commons.Request
{
    public class UpdateDeliveryInfoRequest
    {
        public string orderDetailId { get; set; }
        public DeliveryInfoModel DeliveryInfo { get; set; }
    }
}
