using L_L.Business.Commons;
using L_L.Business.Commons.Request;
using L_L.Business.Commons.Response;
using L_L.Business.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.IdentityModel.Tokens.Jwt;

namespace L_L.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly AuthService authService;

        public AuthController(AuthService authService)
        {
            this.authService = authService;
        }

        [AllowAnonymous]
        [HttpPost("signup")]
        public async Task<IActionResult> Signup([FromBody] SignUpRequest req)
        {
            // Check model validation
            if (!ModelState.IsValid)
            {
                // Handle validation errors
                return BadRequest(new ApiResult<object>
                {
                    Success = false,
                    Result = ModelState.Values.SelectMany(v => v.Errors.Select(e => e.ErrorMessage))
                });
            }
            var res = await authService.Signup(req);
            if (!res)
            {
                var resultFail = new SignUpResponse
                {
                    message = "Sign up fail"
                };
                return BadRequest(ApiResult<SignUpResponse>.Succeed(resultFail));
            }
            var result = new SignUpResponse
            {
                message = "Sign up success"
            };

            return Ok(ApiResult<SignUpResponse>.Succeed(result));
        }

        [AllowAnonymous]
        [HttpPost("login")]
        public IActionResult Login([FromBody] SignInRequest req)
        {
            // Check model validation
            if (!ModelState.IsValid)
            {
                // Handle validation errors
                return BadRequest(new ApiResult<string>
                {
                    Success = false,
                    Result = ModelState.Values.SelectMany(v => v.Errors.Select(e => e.ErrorMessage)).ToString()
                });
            }

            var loginResult = authService.SignIn(req.Email, req.Password);
            if (loginResult.Token == null)
            {
                var result = ApiResult<Dictionary<string, string[]>>.Fail(new Exception("Username or password is invalid"));
                return BadRequest(result);
            }

            var handler = new JwtSecurityTokenHandler();
            var res = new SignInResponse
            {
                message = "Sign In Successfully",
                Token = handler.WriteToken(loginResult.Token)
            };
            return Ok(ApiResult<SignInResponse>.Succeed(res));
        }
    }
}
