using Microsoft.IdentityModel.Tokens;

namespace L_L.Business.Commons.Response
{
    public class SignUpResponse
    {
        public string? message { get; set; }
        public SecurityToken? Token { get; set; }
    }
}
