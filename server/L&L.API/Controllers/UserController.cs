using L_L.Business.Commons;
using L_L.Business.Commons.Request;
using L_L.Business.Commons.Response;
using L_L.Business.Services;
using Microsoft.AspNetCore.Authorization;
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

        [Authorize(Roles = "Admin")]
        [HttpGet("Get-All")]
        public IActionResult Get()
        {
            var users = userService.GetAllUser();
            return Ok(ApiResult<GetAllUserResponse>.Succeed(new GetAllUserResponse()
            {
                data = users
            }));
        }

        [Authorize(Roles = "Admin")]
        [HttpPut("UpdateCost")]
        public async Task<IActionResult> UpdateCost([FromQuery] string email, [FromBody] UpdateCostRequest req)
        {
            var currentUser = await userService.GetUserByEmail(email);

            if (currentUser == null)
            {
                return NotFound(ApiResult<UpdateUserRespone>.Error(new UpdateUserRespone
                {
                    message = "User not found"
                }));
            }

            var result = await userService.UpdateCost(req.cost, email);

            if (result)
            {
                return Ok(ApiResult<UpdateUserRespone>.Succeed(new UpdateUserRespone
                {
                    message = "Update cost success"
                }));
            }

            return BadRequest(ApiResult<UpdateUserRespone>.Error(new UpdateUserRespone
            {
                message = "Error in update cost"
            }));
        }

        [HttpPatch("UpdateInfo")]
        public async Task<IActionResult> UpdateInfo(string email, [FromForm] UpdateInfoRequest req)
        {

            /*            Request.Headers.TryGetValue("Authorization", out var token);
                        token = token.ToString().Split()[1];
                        var currentUser = await _userService.GetUserInToken(token);*/

            var currentUser = await userService.GetUserByEmail(email);

            if (currentUser == null)
            {
                return NotFound(ApiResult<UpdateUserRespone>.Error(new UpdateUserRespone
                {
                    message = "User not found"
                }));
            }


            var updatedUser = await userService.UpdateInfoUser(currentUser, req);

            if (updatedUser != null)
            {
                return Ok(ApiResult<UpdateUserRespone>.Succeed(new UpdateUserRespone
                {
                    data = updatedUser,
                    message = "Update Info Success"
                }));
            }
            else
            {
                return BadRequest(ApiResult<UpdateUserRespone>.Error(new UpdateUserRespone
                {
                    message = "Invalid data provided"
                }));
            }
        }

    }
}
