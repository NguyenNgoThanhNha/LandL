using System.ComponentModel.DataAnnotations;

namespace L_L.Business.Commons.Request
{
    public class SignInRequest
    {
        [Required(ErrorMessage = "Email is required")]
        [EmailAddress(ErrorMessage = "Invalid email format")]
        public string Email { get; set; } = null!;

        [Required(ErrorMessage = "Password is required")]
        [StringLength(100, ErrorMessage = "Password length can't be more than 100.")]
        public string Password { get; set; } = null!;
    }
}
