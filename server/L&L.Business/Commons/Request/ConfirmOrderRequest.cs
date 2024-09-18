using System.ComponentModel.DataAnnotations;

namespace L_L.Business.Commons.Request;

public class ConfirmOrderRequest
{
    [Required(ErrorMessage = "Order Detail Id is requrired")]
    public int orderDetailId { get; set; }
    
    [Required(ErrorMessage = "Total Amount is requrired")]
    public decimal totalAmount { get; set; }
    
    public PayOsRequest Request { get; set; }
}