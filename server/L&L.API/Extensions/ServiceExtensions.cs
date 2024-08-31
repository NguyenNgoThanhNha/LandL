using AutoMapper;
using L_L.Business.Mappers;
using L_L.Business.Middlewares;
using L_L.Business.Services;
using L_L.Business.Ultils;
using L_L.Data.Base;
using L_L.Data.Entities;
using L_L.Data.SeedData;
using L_L.Data.UnitOfWorks;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System.Text;

namespace L_L.API.Extensions
{

    public static class ServiceExtensions
    {
        public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddScoped<ExceptionMiddleware>();
            services.AddControllers();
            services.AddEndpointsApiExplorer();
            services.AddSwaggerGen();

            //Add Mapper
            var mapperConfig = new MapperConfiguration(mc =>
            {
                mc.AddProfile(new ProfilesMapper());
            });

            IMapper mapper = mapperConfig.CreateMapper();
            services.AddSingleton(mapper);

            //Set time
            AppContext.SetSwitch("Npgsql.EnableLegacyTimestampBehavior", true);

            var jwtSettings = configuration.GetSection(nameof(JwtSettings)).Get<JwtSettings>();
            services.Configure<JwtSettings>(configuration.GetSection(nameof(JwtSettings)));
            services.AddSingleton(sp => sp.GetRequiredService<IOptions<JwtSettings>>().Value);

            services.Configure<MailSettings>(configuration.GetSection(nameof(MailSettings)));

            services.Configure<CloundSettings>(configuration.GetSection(nameof(CloundSettings)));

            services.AddAuthorization();

            services.AddAuthentication(options =>
            {
                options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
            })
                .AddJwtBearer(options =>
                {
                    options.TokenValidationParameters = new TokenValidationParameters()
                    {
                        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings.Key)),
                        ValidateIssuer = false,
                        ValidateAudience = false,
                        ValidateLifetime = true,
                        ValidateIssuerSigningKey = true
                    };
                });

            services.AddDbContext<AppDbContext>();

            /*Config repository*/
            services.AddScoped(typeof(IRepository<,>), typeof(GenericRepository<,>));

            /*Register UnitOfWorks*/
            services.AddScoped<UnitOfWorks>();

            /*Init Data*/
            services.AddScoped<DatabaseInitialiser>();

            /*Config Service*/
            services.AddScoped<UserService>();
            services.AddScoped<AuthService>();

            return services;
        }
    };
}
