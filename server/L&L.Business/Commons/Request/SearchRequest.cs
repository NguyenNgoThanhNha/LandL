namespace L_L.Business.Commons.Request
{
    public class SearchRequest
    {
        public string From { get; set; }
        public string To { get; set; }
        public string Distance { get; set; }
        public DateTime? Time { get; set; }
        public string Weight { get; set; }
        public string Length { get; set; }
        public string Width { get; set; }
        public string Height { get; set; }
    }
}
