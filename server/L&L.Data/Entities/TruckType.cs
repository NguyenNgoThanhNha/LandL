using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace L_L.Data.Entities
{
    [Table("TruckType")]
    public class TruckType
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int TruckTypeId { get; set; }

        [Required]
        public string TypeName { get; set; } = string.Empty;
    }
}
