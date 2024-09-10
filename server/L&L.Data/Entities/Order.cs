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

        public DateTime? RecieveDate { get; set; } // ngày nhận hàng
        public DateTime? ExpectedRecieveDate { get; set; } // ngày dự kiến nhận hàng

        public DateTime? ExpectedDeliveryDate { get; set; } // ngày dự kiến giao hàng

        public DateTime? DeliveryDate { get; set; } // ngày giao hàng

        [Required]
        public string From { get; set; } = string.Empty;

        [Required]
        public string To { get; set; } = string.Empty;

        [Required]
        public string PaymentMethod { get; set; } = string.Empty;

        [Required]
        public double TotalAmount { get; set; }

        public string Status { get; set; } = string.Empty;

        public string? Notes { get; set; }

        [ForeignKey("UserOrder")]
        public int CustomerId { get; set; }
        public virtual User UserOrder { get; set; }

        [ForeignKey("OrderDriver")]
        public int DriverId { get; set; }
        public virtual User OrderDriver { get; set; }
    }


}
