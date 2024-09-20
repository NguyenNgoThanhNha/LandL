using Microsoft.AspNetCore.Authorization;

namespace L_L.API.Handler
{
    public class AdminHandler : AuthorizationHandler<AdminRequirement>
    {
        protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, AdminRequirement requirement)
        {
            // Kiểm tra nếu người dùng có vai trò cần thiết
            if (context.User.IsInRole(requirement.RequiredRole))
            {
                context.Succeed(requirement);
            }
            else
            {
                context.Fail();
            }

            return Task.CompletedTask;
        }
    }


}
