using L_L.Business.Commons;
using L_L.Business.Commons.Request;
using L_L.Business.Commons.Response;
using L_L.Business.Models;
using L_L.Business.Services;
using L_L.Business.Ultils;
using Microsoft.AspNetCore.Authorization;
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
                var errors = ModelState.Values
                    .SelectMany(v => v.Errors)
                    .Select(e => e.ErrorMessage)
                    .ToList();

                return BadRequest(ApiResult<List<string>>.Error(errors));
            }

            // create order
            var orderCreate = await orderService.CreateOrder(request.TotalAmount.ToString());
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

            return BadRequest(ApiResult<ResponseMessage>.Error(new ResponseMessage()
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

        [HttpPost("accept-driver")]
        public async Task<IActionResult> AddDriverToOrderDetail([FromBody] AcceptDriverRequest req)
        {
            if (!ModelState.IsValid)
            {
                var errors = ModelState.Values
                    .SelectMany(v => v.Errors)
                    .Select(e => e.ErrorMessage)
                    .ToList();

                return BadRequest(ApiResult<List<string>>.Error(errors));
            }
            var result = await orderService.AddDriverToOrderDetail(req);
            if (!result)
            {
                return BadRequest(ApiResult<ResponseMessage>.Error(new ResponseMessage()
                {
                    message = "Error in accept order!"
                }));
            }
            return Ok(ApiResult<ResponseMessage>.Succeed(new ResponseMessage()
            {
                message = "Accept order success"
            }));
        }

        [HttpPatch("UpdateProductInfo")]
        public async Task<IActionResult> UpdateOrderDetail([FromBody] UpdateProductInfoRequest req)
        {
            if (!ModelState.IsValid)
            {
                var errors = ModelState.Values
                    .SelectMany(v => v.Errors)
                    .Select(e => e.ErrorMessage)
                    .ToList();

                return BadRequest(ApiResult<List<string>>.Error(errors));
            }
            var updateProductResult = await orderService.UpdateProductInOrderDetail(req.orderDetailId, req.Products);
            if (updateProductResult == null)
            {
                return BadRequest(ApiResult<ResponseMessage>.Error(new ResponseMessage()
                {
                    message = $"Error in update product of Order Detail with ${req.orderDetailId}"
                }));
            }
            return Ok(ApiResult<ResponseMessage>.Succeed(new ResponseMessage()
            {
                message = "Update product in order detail success"
            }));
        }

        [Authorize(Roles = "Driver")]
        [HttpGet("GetOrderDriver")]
        public async Task<IActionResult> GetOrderOfDriver()
        {
            Request.Headers.TryGetValue("Authorization", out var token);
            token = token.ToString().Split()[1];
            var currentUser = await userService.GetUserInToken(token);
            if (currentUser == null)
            {
                return BadRequest(ApiResult<ResponseMessage>.Error(new ResponseMessage()
                {
                    message = "Driver not found"
                }));
            }

            var listOrder = await orderService.GetOrderForDriver(currentUser.UserId.ToString());

            if (listOrder == null)
            {
                return Ok(ApiResult<ResponseMessage>.Succeed(new ResponseMessage()
                {
                    message = "Currently, can not find order suitable"
                }));
            }

            return Ok();
        }
    }
}
