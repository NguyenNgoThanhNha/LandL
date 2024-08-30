using L_L.Data.Enums;
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

        public Kilometer? Kilometer { get; set; }

        public Size? Size { get; set; }

        public ProductType? ProductType { get; set; }

        public TypeTruck? TruckType { get; set; }
    }
}
