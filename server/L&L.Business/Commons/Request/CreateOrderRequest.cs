using System.ComponentModel.DataAnnotations;

namespace L_L.Business.Commons.Request;

public class CreateOrderRequest
{
    [Required]
    public string From { get; set; }
    [Required]
    public string To { get; set; }
    [Required]
    public string longFrom { get; set; }
    [Required]
    public string latFrom { get; set; }
    [Required]
    public string longTo { get; set; }
    [Required]
    public string latTo { get; set; }
    [Required]
    public DateTime PickupTime { get; set; } // Pickup time
    [Required]
    public string Weight { get; set; }
    [Required]
    public string Length { get; set; }
    [Required]
    public string Width { get; set; }
    [Required]
    public string Height { get; set; }

    public string Email { get; set; }

}