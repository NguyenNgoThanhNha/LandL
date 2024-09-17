using L_L.Business.Models;

namespace L_L.Business.Commons.Request
{
    public class UpdateProductInfoRequest
    {
        public string orderDetailId { get; set; }
        public ProductsModel Products { get; set; }
    }
}
