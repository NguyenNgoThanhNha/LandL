using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace L_L.Data.Entities
{
    [Table("OrderDetails")]
    public class OrderDetails
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int OrderDetailId { get; set; }

        [Required]
        public int Quantity { get; set; }

        [Required]
        public double UnitPrice { get; set; }

        [Required]
        public double TotalPrice { get; set; }

        [Required]
        [ForeignKey("OrderDetailInfo")]
        public int OrderId { get; set; }
        public virtual Order OrderInfo { get; set; }

        [Required]
        [ForeignKey("ServiceInfo")]
        public int ServiceId { get; set; }
        public virtual Service ServiceInfo { get; set; }
    }
}
