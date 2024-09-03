using Microsoft.AspNetCore.Http;
using System.ComponentModel.DataAnnotations;

namespace L_L.Business.Commons.Request
{
    public class UpdateInfoRequest
    {
        public string? UserName { get; set; }

        [MaxLength(100)]
        public string? Password { get; set; }

        [MaxLength(50)]
        public string? FullName { get; set; }

        [MaxLength(100)]
        public string? Gender { get; set; }

        [MaxLength(100)]
        public string? Level { get; set; }

        [MaxLength(255)]
        public string? Address { get; set; }

        public DateTime? BirthDate { get; set; }

        [MaxLength(15)]
        public string? PhoneNumber { get; set; }
        public IFormFile? Avatar { get; set; }
    }
}
