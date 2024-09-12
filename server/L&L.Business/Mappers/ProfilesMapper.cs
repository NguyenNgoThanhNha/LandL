﻿using AutoMapper;
using L_L.Business.Models;
using L_L.Data.Entities;

namespace L_L.Business.Mappers
{
    public class ProfilesMapper : Profile
    {
        public ProfilesMapper()
        {
            CreateMap<User, UserModel>().ReverseMap();
            CreateMap<PackageType, PacketTypeModel>().ReverseMap();
            CreateMap<VehicleType, VehicleTypeModel>().ReverseMap();
        }
    }
}
