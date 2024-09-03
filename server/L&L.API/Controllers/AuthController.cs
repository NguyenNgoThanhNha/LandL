using L_L.Business.Commons;
using L_L.Business.Commons.Request;
using L_L.Business.Commons.Response;
using L_L.Business.Exceptions;
using L_L.Business.Models;
using L_L.Business.Services;
using L_L.Business.Ultils;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.IdentityModel.Tokens.Jwt;
using System.Text.RegularExpressions;

namespace L_L.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly AuthService authService;
        private readonly MailService mailService;

        public AuthController(AuthService authService, MailService mailService)
        {
            this.authService = authService;
            this.mailService = mailService;
        }

        [HttpPost("FirstStep")]
        public async Task<IActionResult> FirstStepResgisterInfo(FirstStepResquest req)
        {
            Regex regex = new Regex(@"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
            if (!regex.IsMatch(req.Email))
            {
                return BadRequest(ApiResult<FirstStepResgisterInfoResponse>.Error(new FirstStepResgisterInfoResponse
                {
                    message = "Invalid email format: " + req.Email
                }));
            }
            var otp = 0;
            var Password = req.Password;
            var email = req.Email;
            var link = req.Link;
            var user = await authService.GetUserByEmail(email);
            if (user != null && user.OTPCode == "0")
            {
                return BadRequest(ApiResult<FirstStepResgisterInfoResponse>.Error(new FirstStepResgisterInfoResponse
                {
                    message = "Account Already Exists"
                }));
            }

            if (user != null && user.CreateDate > DateTime.Now && user.OTPCode != "0")
            {
                return BadRequest(ApiResult<FirstStepResgisterInfoResponse>.Error(new FirstStepResgisterInfoResponse
                {
                    message = "OTP Code is not expired"
                }));
            }

            if (user == null)
            {
                otp = new Random().Next(100000, 999999);
                var href = link + req.Email;
                var mailData = new MailData()
                {
                    EmailToId = email,
                    EmailToName = "KayC",
                    EmailBody = $@"
<div style=""max-width: 400px; margin: 50px auto; padding: 30px; text-align: center; font-size: 120%; background-color: #f9f9f9; border-radius: 10px; box-shadow: 0 0 20px rgba(0, 0, 0, 0.1); position: relative;"">
    <img src=""https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRDn7YDq7gsgIdHOEP2_Mng6Ym3OzmvfUQvQ&usqp=CAU"" alt=""Noto Image"" style=""max-width: 100px; height: auto; display: block; margin: 0 auto; border-radius: 50%;"">
    <h2 style=""text-transform: uppercase; color: #3498db; margin-top: 20px; font-size: 28px; font-weight: bold;"">Welcome to Team 3</h2>
    <a href=""{href}"" style=""display: inline-block; background-color: #3498db; color: #fff; text-decoration: none; padding: 10px 20px; border-radius: 5px; margin-bottom: 20px;"">Click here to verify</a>
    <div style=""font-size: 18px; color: #555; margin-bottom: 30px;"">Your OTP Code is: <span style=""font-weight: bold; color: #e74c3c;"">{otp}</span></div>
    <p style=""color: #888; font-size: 14px;"">Powered by Team 3</p>
</div>",
                    EmailSubject = "OTP Verification"
                };


                var result = await mailService.SendEmailAsync(mailData);
                if (!result)
                {
                    throw new BadRequestException("Send Email Fail");
                }
            }
            var createUserModel = new UserModel
            {
                Email = req.Email,
                OTPCode = otp.ToString(),
                Password = Password,
                UserName = req.UserName,
                FullName = req.FullName,
                Address = req.Address,
                City = req.City,
                PhoneNumber = req.Phone
            };
            var userModel = await authService.FirstStep(createUserModel, req.TypeAccount);

            if (userModel.OTPCode != otp.ToString())
            {
                var href = link + req.Email;
                var mailUpdateData = new MailData()
                {
                    EmailToId = email,
                    EmailToName = "KayC",
                    EmailBody = $@"
<div style=""max-width: 400px; margin: 50px auto; padding: 30px; text-align: center; font-size: 120%; background-color: #f9f9f9; border-radius: 10px; box-shadow: 0 0 20px rgba(0, 0, 0, 0.1); position: relative;"">
    <img src=""https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRDn7YDq7gsgIdHOEP2_Mng6Ym3OzmvfUQvQ&usqp=CAU"" alt=""Noto Image"" style=""max-width: 100px; height: auto; display: block; margin: 0 auto; border-radius: 50%;"">
    <h2 style=""text-transform: uppercase; color: #3498db; margin-top: 20px; font-size: 28px; font-weight: bold;"">Welcome to Team 3</h2>
    <a href=""{href}"" style=""display: inline-block; background-color: #3498db; color: #fff; text-decoration: none; padding: 10px 20px; border-radius: 5px; margin-bottom: 20px;"">Click here to verify</a>
    <div style=""font-size: 18px; color: #555; margin-bottom: 30px;"">Your OTP Code is: <span style=""font-weight: bold; color: #e74c3c;"">{userModel.OTPCode}</span></div>
    <p style=""color: #888; font-size: 14px;"">Powered by Team 3</p>
</div>",
                    EmailSubject = "OTP Verification"
                };
                var rsUpdate = await mailService.SendEmailAsync(mailUpdateData);
                if (!rsUpdate)
                {
                    throw new BadRequestException("Send Email Fail");
                }
            }

            return Ok(ApiResult<FirstStepResgisterInfoResponse>.Succeed(new FirstStepResgisterInfoResponse
            {
                message = "Check Email and Verify OTP",
            }));
        }

        [HttpPost("SubmitOTP")]
        public async Task<IActionResult> SubmitOTP(SubmitOTPResquest req)
        {
            var result = await authService.SubmitOTP(req);
            if (!result)
            {
                throw new BadRequestException("OTP Code is not Correct");
            }
            return Ok(ApiResult<FirstStepResgisterInfoResponse>.Succeed(new FirstStepResgisterInfoResponse
            {
                message = $"Create new Account Success for email: {req.Email}"
            }));
        }


        [HttpGet("GetTimeOTP")]
        [Authorize(Roles = "Customer")]
        public async Task<IActionResult> GetTimeOTP(string email)
        {
            var user = await authService.GetUserByEmail(email);
            if (user == null)
            {
                return NotFound(ApiResult<GetTimeOTP>.Error(new GetTimeOTP
                {
                    Message = "User Not Found"
                }));
            }

            else
            {
                DateTimeOffset utcTime = DateTimeOffset.Parse(user.CreateDate.ToString());
                return Ok(ApiResult<GetTimeOTP>.Succeed(new GetTimeOTP
                {
                    Message = "Success",
                    EndTime = utcTime
                }));

            }
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

        [AllowAnonymous]
        [HttpPost("login-google")]
        public async Task<IActionResult> LoginWithGoogle([FromBody] SignInRequest req)
        {
            if (req == null)
            {
                return BadRequest(ApiResult<SignInResponse>.Error(new SignInResponse
                {
                    message = "Invalid request data!"
                }));
            }

            var loginResult = await authService.SignInWithGG(req);

            if (loginResult.Authenticated)
            {
                var res = new SignInResponse
                {
                    message = "Sign In Successfully",
                };
                return Ok(ApiResult<SignInResponse>.Succeed(res));
            }

            return BadRequest(ApiResult<SignInResponse>.Error(new SignInResponse
            {
                message = "Error in login with Google!"
            }));
        }

    }
}
