using L_L.Business.Commons.Request;
using L_L.Business.Dtos;
using L_L.Business.Exceptions;
using L_L.Business.Ultils;
using L_L.Data.Entities;
using L_L.Data.Helpers;
using L_L.Data.UnitOfWorks;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace L_L.Business.Services
{
    public class AuthService
    {
        private readonly UnitOfWorks _unitOfWorks;
        private readonly JwtSettings _jwtSettings;

        public AuthService(UnitOfWorks unitOfWorks, JwtSettings jwtSettings)
        {
            _unitOfWorks = unitOfWorks;
            _jwtSettings = jwtSettings;
        }

        public async Task<bool> Signup(SignUpRequest req)
        {
            var user = _unitOfWorks.AuthRepository.FindByCondition(u => u.Email == req.Email).FirstOrDefault();
            if (user is not null)
            {
                throw new BadRequestException("username or email already exists");
            }

            var userAdd = await _unitOfWorks.AuthRepository.AddAsync(new User
            {
                Email = req.Email,
                Password = SecurityUtil.Hash(req.Password),
                FullName = req.Fullname,
                UserName = req.Username,
                Gender = req.Gender,
                Address = req.Address,
                PhoneNumber = req.Phone,
                Status = "Active",
                RoleID = 2,
            });
            var res = await _unitOfWorks.AuthRepository.Commit();
            return res > 0;
        }

        public LoginResult SignIn(string email, string password)
        {
            var user = _unitOfWorks.AuthRepository.FindByCondition(u => u.Email == email).FirstOrDefault();


            if (user is null)
            {
                return new LoginResult
                {
                    Authenticated = false,
                    Token = null,
                };
            }
            var userRole = _unitOfWorks.UserRoleRepository.FindByCondition(ur => ur.RoleId == user.RoleID).FirstOrDefault();

            user.UserRole = userRole!;

            var hash = SecurityUtil.Hash(password);
            if (!user.Password.Equals(hash))
            {
                return new LoginResult
                {
                    Authenticated = false,
                    Token = null,
                };
            }

            return new LoginResult
            {
                Authenticated = true,
                Token = CreateJwtToken(user),
            };
        }

        private SecurityToken CreateJwtToken(User user)
        {
            var utcNow = DateTime.UtcNow;
            var userRole = _unitOfWorks.UserRoleRepository.FindByCondition(u => u.RoleId == user.RoleID).FirstOrDefault();
            var authClaims = new List<Claim>
        {
            new(JwtRegisteredClaimNames.NameId, user.UserId.ToString()),
/*            new(JwtRegisteredClaimNames.Sub, user.UserName),*/
            new(JwtRegisteredClaimNames.Email, user.Email),
            new(ClaimTypes.Role, userRole.RoleName),
            new(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
        };

            var key = Encoding.ASCII.GetBytes(_jwtSettings.Key);

            var tokenDescriptor = new SecurityTokenDescriptor()
            {
                Subject = new ClaimsIdentity(authClaims),
                SigningCredentials =
                    new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256),
                Expires = utcNow.Add(TimeSpan.FromHours(1)),
            };

            var handler = new JwtSecurityTokenHandler();

            var token = handler.CreateToken(tokenDescriptor);

            return token;
        }
    }
}
