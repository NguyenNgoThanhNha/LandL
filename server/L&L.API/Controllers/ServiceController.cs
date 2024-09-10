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
        public IActionResult Get()
        {
            return Ok();
        }
    }
}
