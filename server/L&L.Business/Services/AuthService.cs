﻿using AutoMapper;
using L_L.Business.Commons.Request;
using L_L.Business.Dtos;
using L_L.Business.Exceptions;
using L_L.Business.Models;
using L_L.Business.Ultils;
using L_L.Data.Entities;
using L_L.Data.Helpers;
using L_L.Data.UnitOfWorks;
using Microsoft.EntityFrameworkCore;
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
        private readonly IMapper _mapper;

        public AuthService(UnitOfWorks unitOfWorks, JwtSettings jwtSettings, IMapper mapper)
        {
            _unitOfWorks = unitOfWorks;
            _jwtSettings = jwtSettings;
            _mapper = mapper;
        }

        public async Task<UserModel> FirstStep(UserModel req, string typeAccount)
        {
            var userEntity = _mapper.Map<User>(req);
            var user = _unitOfWorks.UserRepository.FindByCondition(x => x.Email == req.Email).FirstOrDefault();

            if (user != null && user.OTPCode != "0" && user.Status == "InActive")
            {
                if (typeAccount == "Customer")
                {
                    user.RoleID = 2;
                }
                else if (typeAccount == "Driver")
                {
                    user.RoleID = 3;
                }
                user.Status = "InActive";
                user.CreateDate = DateTimeOffset.Now.AddMinutes(2);
                user.Password = SecurityUtil.Hash(req.Password);
                user.OTPCode = new Random().Next(100000, 999999).ToString();
                user.TypeLogin = "Normal";

                user = _unitOfWorks.UserRepository.Update(user);
                int rs = await _unitOfWorks.UserRepository.Commit();
                if (rs > 0)
                {
                    return _mapper.Map<UserModel>(user);
                }
                else
                {
                    return null;
                }
            }
            if (typeAccount == "Customer")
            {
                userEntity.RoleID = 2;
            }
            else if (typeAccount == "Driver")
            {
                userEntity.RoleID = 3;
            }
            userEntity.Status = "InActive";
            userEntity.CreateDate = DateTimeOffset.Now.AddMinutes(2);
            userEntity.Password = SecurityUtil.Hash(req.Password!);
            userEntity.TypeLogin = "Normal";
            var existedUser = _unitOfWorks.UserRepository.FindByCondition(x => x.Email == req.Email).FirstOrDefault();
            if (existedUser != null)
            {
                throw new BadRequestException("email already exist");
            }
            userEntity = await _unitOfWorks.UserRepository.AddAsync(userEntity);
            int result = await _unitOfWorks.UserRepository.Commit();
            if (result > 0)
            {
                // get latest userID
                //newUser.UserId = _userRepository.GetAll().OrderByDescending(x => x.);
                req.UserId = userEntity.UserId;
                return _mapper.Map<UserModel>(userEntity);
            }
            else
            {
                return null;
            }
        }

        public LoginResult SignIn(string email, string password)
        {
            var user = _unitOfWorks.AuthRepository.FindByCondition(u => u.Email == email).FirstOrDefault();


            if (user is null || user.Status == "InActive")
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
            if (!user.Password!.Equals(hash))
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

        public async Task<LoginResult> SignInWithGG(LoginWithGGRequest req)
        {
            var user = _unitOfWorks.AuthRepository.FindByCondition(u => u.Email == req.Email).FirstOrDefault();

            if (user != null)
            {
                // Generate JWT or another token here if needed.
                return new LoginResult
                {
                    Authenticated = true,
                    Token = CreateJwtToken(user)
                };
            }

            var userModel = new UserModel
            {
                Email = req.Email,
                FullName = req.FullName,
                UserName = req.UserName,
                Password = SecurityUtil.Hash("123456"),
                Avatar = req.Avatar,
                OTPCode = "0",
                TypeLogin = "Google",
                RoleID = req.TypeAccount == "Customer" ? 2 : req.TypeAccount == "Driver" ? 3 : 0 // Adjust 0 if you have a default RoleID
            };

            var userRegister = _mapper.Map<User>(userModel);

            await _unitOfWorks.UserRepository.AddAsync(userRegister);
            int result = await _unitOfWorks.UserRepository.Commit();

            if (result > 0)
            {
                // Generate JWT or another token here if needed.
                return new LoginResult
                {
                    Authenticated = true,
                    Token = CreateJwtToken(userRegister)
                };
            }

            return new LoginResult
            {
                Authenticated = false,
                Token = null
            };
        }


        public async Task<UserModel> GetUserByEmail(string email)
        {
            return _mapper.Map<UserModel>(_unitOfWorks.UserRepository.FindByCondition(x => x.Email == email).FirstOrDefault());
        }

        public async Task<UserModel> GetUserInToken(string token)
        {
            if (string.IsNullOrWhiteSpace(token))
            {
                throw new BadRequestException("Authorization header is missing or invalid.");
            }
            // Decode the JWT token
            var handler = new JwtSecurityTokenHandler();
            var jwtToken = handler.ReadJwtToken(token);

            // Check if the token is expired
            if (jwtToken.ValidTo < DateTime.UtcNow)
            {
                throw new BadRequestException("Token has expired.");
            }

            string email = jwtToken.Claims.FirstOrDefault(c => c.Type == "email")?.Value;

            var user = await _unitOfWorks.UserRepository.FindByCondition(x => x.Email == email).FirstOrDefaultAsync();
            if (user is null)
            {
                throw new BadRequestException("Can not found User");
            }
            return _mapper.Map<UserModel>(user);
        }

        public async Task<UserModel> ForgotPass(UserModel req)
        {
            var userEntity = _mapper.Map<User>(req);
            var user = _unitOfWorks.UserRepository.FindByCondition(x => x.Email == req.Email).FirstOrDefault();

            if (user != null && user.Status == "Active")
            {
                user.CreateDate = DateTimeOffset.Now.AddMinutes(2);
                user.OTPCode = new Random().Next(100000, 999999).ToString();

                user = _unitOfWorks.UserRepository.Update(user);
                int rs = await _unitOfWorks.UserRepository.Commit();
                if (rs > 0)
                {
                    return _mapper.Map<UserModel>(user);
                }
                else
                {
                    return null;
                }
            }
            else
            {
                return null;
            }
        }

        public async Task<UserModel> ResendOtp(string email)
        {
            var user = _unitOfWorks.UserRepository.FindByCondition(x => x.Email == email).FirstOrDefault();

            var twoMinuteAgo = user.CreateDate.Value.AddMinutes(-2);

            if (DateTimeOffset.Now < twoMinuteAgo && DateTimeOffset.Now > user.CreateDate)
            {
                throw new BadRequestException("OTP code is expired");
            }

            if (user != null)
            {
                user.CreateDate = DateTimeOffset.Now.AddMinutes(2);
                user.OTPCode = new Random().Next(100000, 999999).ToString();

                user = _unitOfWorks.UserRepository.Update(user);
                int rs = await _unitOfWorks.UserRepository.Commit();
                if (rs > 0)
                {
                    return _mapper.Map<UserModel>(user);
                }
                else
                {
                    return null;
                }
            }
            else
            {
                return null;
            }
        }


        public async Task<bool> UpdatePass(string email, string password)
        {
            var user = _unitOfWorks.UserRepository.FindByCondition(x => x.Email == email).FirstOrDefault();

            if (user != null && user.Status == "Active" && user.OTPCode == "0")
            {
                user.ModifyDate = DateTimeOffset.Now;
                user.Password = SecurityUtil.Hash(password);

                user = _unitOfWorks.UserRepository.Update(user);
                int rs = await _unitOfWorks.UserRepository.Commit();
                if (rs > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }



        public async Task<bool> SubmitOTP(SubmitOTPResquest req)
        {
            var existedUser = _unitOfWorks.UserRepository.FindByCondition(x => x.Email == req.Email).FirstOrDefault();

            if (existedUser is null)
            {
                throw new BadRequestException("Account does not exist");
            }

            if (req.OTP != existedUser.OTPCode)
            {
                throw new BadRequestException("OTP Code is not Correct");
            }

            var result = 0;

            var twoMinuteAgo = existedUser.CreateDate.Value.AddMinutes(-2);

            if (DateTimeOffset.Now > twoMinuteAgo && DateTimeOffset.Now < existedUser.CreateDate)
            {
                existedUser.Status = "Active";
                existedUser.OTPCode = "0";
                _unitOfWorks.UserRepository.Update(existedUser);
                result = await _unitOfWorks.UserRepository.Commit();
            }
            else
            {
                throw new BadRequestException("OTP code is expired");
            }

            if (result > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public async Task<bool> ChangeStatus(int userId, string status)
        {

            var userChange = await _unitOfWorks.UserRepository.GetByIdAsync(userId);
            if (userChange != null)
            {
                if (status == "Active" || status == "InActive")
                {
                    userChange.Status = status;
                    _unitOfWorks.UserRepository.Update(userChange);
                }
                else
                {
                    throw new BadRequestException("Invalid provided status");
                }
                var rs = await _unitOfWorks.UserRepository.Commit();
                return rs > 0;
            }
            else
            {
                throw new BadRequestException("Can Not Find The User To Change");
            }

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
            new Claim("IsCustomer", userRole.RoleName == "Customer" ? "Customer" : "Admin")
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
