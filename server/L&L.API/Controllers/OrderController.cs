using L_L.Business.Commons;
using L_L.Business.Commons.Request;
using L_L.Business.Commons.Response;
using L_L.Business.Models;
using L_L.Business.Services;
using L_L.Business.Ultils;
using Microsoft.AspNetCore.Mvc;

namespace L_L.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        private readonly OrderService orderService;
        private readonly OrderDetailService orderDetailService;
        private readonly UserService userService;

        public OrderController(OrderService orderService, OrderDetailService orderDetailService, UserService userService)
        {
            this.orderService = orderService;
            this.orderDetailService = orderDetailService;
            this.userService = userService;
        }

        [HttpGet("GetAll")]
        public async Task<IActionResult> GetAllOrder()
        {
            var listOrder = await orderService.GetAll();
            return Ok(ApiResult<List<OrderModel>>.Succeed(listOrder));
        }

        [HttpPost("Create_Order")]
        public async Task<IActionResult> CreateOrder([FromBody] CreateOrderRequest request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ApiResult<ResponseMessage>.Error(new ResponseMessage()
                {
                    message = "All request are required!"
                }));
            }

            // create order
            var orderCreate = await orderService.CreateOrder(request.TotalAmount);
            if (orderCreate == null)
            {
                return BadRequest(ApiResult<ResponseMessage>.Error(new ResponseMessage()
                {
                    message = "Error in create order"
                }));
            }

            // create order detail
            var orderDetailCreate = await orderDetailService.CreateOrderDetail(orderCreate.OrderId, request);
            if (orderDetailCreate == null)
            {
                return BadRequest(ApiResult<ResponseMessage>.Error(new ResponseMessage()
                {
                    message = "Error in create order detail"
                }));
            }

            return Ok(ApiResult<ResponseMessage>.Error(new ResponseMessage()
            {
                message = "Create order success!"
            }));
        }

        [HttpPut("Update-Status/{id}")]
        public async Task<IActionResult> UpdateStatusOrder([FromRoute] string id, [FromBody] StatusEnums status)
        {
            var order = await orderService.GetOrder(int.Parse(id));
            if (order == null)
            {
                return BadRequest(ApiResult<ResponseMessage>.Error(new ResponseMessage()
                {
                    message = "Order not found!"
                }));
            }

            var result = await orderService.UpdateStatus(status, order);

            if (result)
            {
                return Ok(ApiResult<ResponseMessage>.Succeed(new ResponseMessage()
                {
                    message = "Update order status success!"
                }));
            }

            return Ok(ApiResult<ResponseMessage>.Error(new ResponseMessage()
            {
                message = "Update order status error!"
            }));
        }

        [HttpGet("public-order")]
        public async Task<IActionResult> PublicOrder()
        {
            var listOrderDetail = await orderService.PublicOrder();
            return Ok(ApiResult<List<OrderDetailsModel>>.Succeed(listOrderDetail));
        }

    }
}
