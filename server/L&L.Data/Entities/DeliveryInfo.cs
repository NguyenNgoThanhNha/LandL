﻿using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace L_L.Data.Entities
{
    [Table("DeliveryInfo")]
    public class DeliveryInfo
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int DeliveryInfoId { get; set; }
        public string? ReceiverName { get; set; }
        public string? SenderName { get; set; }
        public string? ReceiverPhone { get; set; }
        public string? SenderPhone { get; set; }
        public string? DeliveryLocaTion { get; set; }
        public string? PickUpLocation { get; set; }
        public DateTime? OrderDate { get; set; }
        public DateTime? RecieveDate { get; set; } // ngày nhận hàng
        public DateTime? ExpectedRecieveDate { get; set; } // ngày dự kiến nhận hàng
        public DateTime? ExpectedDeliveryDate { get; set; } // ngày dự kiến giao hàng
        public DateTime? DeliveryDate { get; set; } // ngày giao hàng
    }
}
