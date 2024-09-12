using L_L.Business.Services;
using Microsoft.AspNetCore.Mvc;

namespace L_L.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly UserService userService;

        public UserController(UserService userService)
        {
            this.userService = userService;
        }

        [HttpGet]
        public IActionResult Get()
        {
            var users = userService.GetAllUser();
            return Ok(users);
        }
    }
}
