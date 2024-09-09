using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace L_L.Data.Entities
{
    [Table("Service")]
    public class Service
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ServiceId { get; set; }
        public Truck? Truck { get; set; }
        public PackageType? PackageType { get; set; }
        public ShippingRate? ShippingRate { get; set; }
    }
}
