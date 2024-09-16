using System.ComponentModel.DataAnnotations;

namespace L_L.Business.Commons.Request
{
    public class SearchRequest
    {
        [Required(ErrorMessage = "From is required.")]
        public string From { get; set; }

        [Required(ErrorMessage = "To is required.")]
        public string To { get; set; }

        [Required(ErrorMessage = "Distance is required.")]
        public string Distance { get; set; }

        [Required(ErrorMessage = "Time is required.")]
        public DateTime? Time { get; set; }

        [Required(ErrorMessage = "Weight is required.")]
        public string Weight { get; set; }

        [Required(ErrorMessage = "Length is required.")]
        public string Length { get; set; }

        [Required(ErrorMessage = "Width is required.")]
        public string Width { get; set; }

        [Required(ErrorMessage = "Height is required.")]
        public string Height { get; set; }
    }
}
