using System.ComponentModel.DataAnnotations;

namespace L_L.Business.Commons.Request
{
    public class SignUpRequest
    {
        [Required(ErrorMessage = "Email is required")]
        [EmailAddress(ErrorMessage = "Invalid email format")]
        public string Email { get; set; } = null!;

        [Required(ErrorMessage = "Password is required")]
        [StringLength(100, ErrorMessage = "Password length can't be more than 100.")]
        public string Password { get; set; } = null!;

        [Required(ErrorMessage = "Fullname is required")]
        [StringLength(50, ErrorMessage = "Fullname length can't be more than 50.")]
        public string Fullname { get; set; } = null!;

        [Required(ErrorMessage = "Username is required")]
        [StringLength(50, ErrorMessage = "Username length can't be more than 50.")]
        public string Username { get; set; } = null!;

        [Required(ErrorMessage = "Gender is required")]
        public string Gender { get; set; } = null!;

        [Required(ErrorMessage = "Address is required")]
        [StringLength(255, ErrorMessage = "Address length can't be more than 255.")]
        public string Address { get; set; } = null!;

        [Required(ErrorMessage = "Phone number is required")]
        [Phone(ErrorMessage = "Invalid phone number format")]
        [StringLength(15, ErrorMessage = "Phone number length can't be more than 15.")]
        public string Phone { get; set; } = null!;
    }

}
