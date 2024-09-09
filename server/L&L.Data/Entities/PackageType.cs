using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace L_L.Data.Entities
{
    [Table("PackageType")]
    public class PackageType
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int PackageTypeId { get; set; }

        [Column(TypeName = "decimal(19, 2)")]
        public decimal WeightLimit { get; set; }

        [Required]
        [MaxLength(100)]
        public string DimensionLimit { get; set; }

        public int VehicleRangeMin { get; set; }

        public int VehicleRangeMax { get; set; }

        // Navigation property
        public ICollection<VehiclePackageRelation> VehiclePackageRelations { get; set; }
    }

}
