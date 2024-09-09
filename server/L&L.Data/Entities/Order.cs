using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace L_L.Data.Entities
{
    [Table("Order")]
    public class Order
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int OrderId { get; set; }

        public DateTime? OrderDate { get; set; }

        public DateTime? ExpectedDeliveryDate { get; set; }

        public DateTime? DeliveryDate { get; set; }

        [Required]
        public string ShippingAddress { get; set; } = string.Empty;

        [Required]
        public string PaymentMethod { get; set; } = string.Empty;

        [Required]
        public double TotalAmount { get; set; }

        public string Status { get; set; } = string.Empty;

        public string? Notes { get; set; }

        // New Properties
        public string? TrackingNumber { get; set; }
        public string? InvoiceNumber { get; set; }
        public double? ShippingCost { get; set; }
        public string? ShippingMethod { get; set; }
        public bool IsGift { get; set; } = false;
        public string? GiftMessage { get; set; }
        public DateTime? PaymentDate { get; set; }
        public double? TaxAmount { get; set; }
        public string? CouponCode { get; set; }
        public double? DiscountAmount { get; set; }

        [ForeignKey("UserOrder")]
        public int CustomerId { get; set; }
        public virtual User UserOrder { get; set; }

        [ForeignKey("OrderDriver")]
        public int DriverId { get; set; }
        public virtual User OrderDriver { get; set; }
    }


}
