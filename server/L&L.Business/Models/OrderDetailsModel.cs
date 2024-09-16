using L_L.Data.Entities;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace L_L.Business.Models
{
    public class OrderDetailsModel
    {
        public int OrderDetailId { get; set; }
        public int? Quantity { get; set; }
        public string? PaymentMethod { get; set; } = string.Empty;
        public decimal? UnitPrice { get; set; }
        public decimal? TotalPrice { get; set; }
        public string Status { get; set; }


        [ForeignKey("UserOrder")]
        public int SenderId { get; set; }
        public virtual User UserOrder { get; set; }

        [Required]
        [ForeignKey("OrderDetailInfo")]
        public int OrderId { get; set; }
        public virtual Order OrderInfo { get; set; }

        [Required]
        [ForeignKey("OrderProduct")]
        public int ProductId { get; set; }
        public virtual Product ProductInfo { get; set; }

        [Required]
        [ForeignKey("OrderTruck")]
        public int TruckId { get; set; }
        public virtual Truck TruckInfo { get; set; }

        [Required]
        [ForeignKey("OrderDelivery")]
        public int DeliveryInfoId { get; set; }
        public virtual DeliveryInfo DeliveryInfoDetail { get; set; }
    }
}
