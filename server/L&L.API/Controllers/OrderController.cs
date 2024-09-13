using L_L.Business.Services;
using Microsoft.AspNetCore.Mvc;

namespace L_L.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        private readonly OrderService orderService;
        private readonly OrderDetailService orderDetailService;

        public OrderController(OrderService orderService, OrderDetailService orderDetailService)
        {
            this.orderService = orderService;
            this.orderDetailService = orderDetailService;
        }

        [HttpPost("Create_Order")]
        public async Task<IActionResult> CreateOrder()
        {
            var listOrder = await orderService.GetAll();
            var lisrOrderDetail = await orderDetailService.GetAll();
            return Ok(listOrder);
        }

    }
}
