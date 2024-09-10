using L_L.Business.Commons.Request;
using Microsoft.AspNetCore.Mvc;

namespace L_L.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ServiceController : ControllerBase
    {
        public ServiceController()
        {

        }

        [HttpGet("Search")]
        public IActionResult Get([FromBody] SearchRequest req)
        {
            return Ok();
        }
    }
}
