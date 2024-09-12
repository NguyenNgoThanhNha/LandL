using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace L_L.Data.Migrations
{
    /// <inheritdoc />
    public partial class initdb : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "PackageType",
                columns: table => new
                {
                    PackageTypeId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    WeightLimit = table.Column<decimal>(type: "numeric(19,2)", nullable: false),
                    LengthMin = table.Column<decimal>(type: "numeric(19,2)", nullable: false),
                    LengthMax = table.Column<decimal>(type: "numeric(19,2)", nullable: false),
                    WidthMin = table.Column<decimal>(type: "numeric(19,2)", nullable: false),
                    WidthMax = table.Column<decimal>(type: "numeric(19,2)", nullable: false),
                    HeightMin = table.Column<decimal>(type: "numeric(19,2)", nullable: false),
                    HeightMax = table.Column<decimal>(type: "numeric(19,2)", nullable: false),
                    VehicleRangeMin = table.Column<int>(type: "integer", nullable: false),
                    VehicleRangeMax = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PackageType", x => x.PackageTypeId);
                });

            migrationBuilder.CreateTable(
                name: "UserRole",
                columns: table => new
                {
                    RoleId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    RoleName = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserRole", x => x.RoleId);
                });

            migrationBuilder.CreateTable(
                name: "VehicleType",
                columns: table => new
                {
                    VehicleTypeId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    VehicleTypeName = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    BaseRate = table.Column<decimal>(type: "numeric(19,2)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VehicleType", x => x.VehicleTypeId);
                });

            migrationBuilder.CreateTable(
                name: "User",
                columns: table => new
                {
                    UserId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    UserName = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false),
                    Password = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    FullName = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: true),
                    Email = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false),
                    Avatar = table.Column<string>(type: "text", nullable: true),
                    Gender = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true),
                    City = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true),
                    Address = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: true),
                    BirthDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: true),
                    OTPCode = table.Column<string>(type: "text", nullable: true),
                    PhoneNumber = table.Column<string>(type: "character varying(15)", maxLength: 15, nullable: true),
                    STK = table.Column<string>(type: "text", nullable: true),
                    Bank = table.Column<string>(type: "text", nullable: true),
                    AccountBalance = table.Column<string>(type: "text", nullable: true),
                    CreateBy = table.Column<string>(type: "text", nullable: true),
                    CreateDate = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    ModifyBy = table.Column<string>(type: "text", nullable: true),
                    ModifyDate = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    Status = table.Column<string>(type: "text", nullable: true),
                    TypeLogin = table.Column<string>(type: "text", nullable: false),
                    RoleID = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_User", x => x.UserId);
                    table.ForeignKey(
                        name: "FK_User_UserRole_RoleID",
                        column: x => x.RoleID,
                        principalTable: "UserRole",
                        principalColumn: "RoleId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ShippingRate",
                columns: table => new
                {
                    RateId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    VehicleTypeId = table.Column<int>(type: "integer", nullable: false),
                    DistanceFrom = table.Column<int>(type: "integer", nullable: false),
                    DistanceTo = table.Column<int>(type: "integer", nullable: true),
                    RatePerKM = table.Column<decimal>(type: "numeric(19,2)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ShippingRate", x => x.RateId);
                    table.ForeignKey(
                        name: "FK_ShippingRate_VehicleType_VehicleTypeId",
                        column: x => x.VehicleTypeId,
                        principalTable: "VehicleType",
                        principalColumn: "VehicleTypeId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Truck",
                columns: table => new
                {
                    TruckId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    TruckName = table.Column<string>(type: "text", nullable: false),
                    Status = table.Column<string>(type: "text", nullable: false),
                    PlateCode = table.Column<string>(type: "text", nullable: false),
                    Color = table.Column<string>(type: "text", nullable: false),
                    TotalBill = table.Column<int>(type: "integer", nullable: true),
                    Manufacturer = table.Column<string>(type: "text", nullable: false),
                    VehicleModel = table.Column<string>(type: "text", nullable: false),
                    FrameNumber = table.Column<string>(type: "text", nullable: false),
                    EngineNumber = table.Column<string>(type: "text", nullable: false),
                    LoadCapacity = table.Column<string>(type: "text", nullable: false),
                    Dimensions = table.Column<string>(type: "text", nullable: false),
                    TypeId = table.Column<int>(type: "integer", nullable: false),
                    TruckTypeVehicleTypeId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Truck", x => x.TruckId);
                    table.ForeignKey(
                        name: "FK_Truck_VehicleType_TruckTypeVehicleTypeId",
                        column: x => x.TruckTypeVehicleTypeId,
                        principalTable: "VehicleType",
                        principalColumn: "VehicleTypeId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "VehiclePackageRelation",
                columns: table => new
                {
                    VehicleTypeId = table.Column<int>(type: "integer", nullable: false),
                    PackageTypeId = table.Column<int>(type: "integer", nullable: false),
                    RelationId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VehiclePackageRelation", x => new { x.VehicleTypeId, x.PackageTypeId });
                    table.ForeignKey(
                        name: "FK_VehiclePackageRelation1",
                        column: x => x.VehicleTypeId,
                        principalTable: "VehicleType",
                        principalColumn: "VehicleTypeId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_VehiclePackageRelation2",
                        column: x => x.PackageTypeId,
                        principalTable: "PackageType",
                        principalColumn: "PackageTypeId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Blog",
                columns: table => new
                {
                    BlogId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    title = table.Column<string>(type: "text", nullable: true),
                    content = table.Column<string>(type: "text", nullable: true),
                    description = table.Column<string>(type: "text", nullable: true),
                    thumbnail = table.Column<string>(type: "text", nullable: false),
                    status = table.Column<string>(type: "text", nullable: false),
                    UserId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Blog", x => x.BlogId);
                    table.ForeignKey(
                        name: "FK_Blog_User_UserId",
                        column: x => x.UserId,
                        principalTable: "User",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Hub",
                columns: table => new
                {
                    HubId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    SenderId = table.Column<int>(type: "integer", nullable: false),
                    RecipientId = table.Column<int>(type: "integer", nullable: false),
                    Content = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Hub", x => x.HubId);
                    table.ForeignKey(
                        name: "FK_Hub_User_RecipientId",
                        column: x => x.RecipientId,
                        principalTable: "User",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Hub_User_SenderId",
                        column: x => x.SenderId,
                        principalTable: "User",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Order",
                columns: table => new
                {
                    OrderId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    OrderDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: true),
                    RecieveDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: true),
                    ExpectedRecieveDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: true),
                    ExpectedDeliveryDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: true),
                    DeliveryDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: true),
                    From = table.Column<string>(type: "text", nullable: false),
                    To = table.Column<string>(type: "text", nullable: false),
                    PaymentMethod = table.Column<string>(type: "text", nullable: false),
                    TotalAmount = table.Column<double>(type: "double precision", nullable: false),
                    OrderCount = table.Column<int>(type: "integer", nullable: false),
                    Status = table.Column<string>(type: "text", nullable: false),
                    Notes = table.Column<string>(type: "text", nullable: true),
                    CustomerId = table.Column<int>(type: "integer", nullable: false),
                    DriverId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Order", x => x.OrderId);
                    table.ForeignKey(
                        name: "FK_Order_User_CustomerId",
                        column: x => x.CustomerId,
                        principalTable: "User",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Order_User_DriverId",
                        column: x => x.DriverId,
                        principalTable: "User",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Service",
                columns: table => new
                {
                    ServiceId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    TruckId = table.Column<int>(type: "integer", nullable: true),
                    PackageTypeId = table.Column<int>(type: "integer", nullable: true),
                    ShippingRateRateId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Service", x => x.ServiceId);
                    table.ForeignKey(
                        name: "FK_Service_PackageType_PackageTypeId",
                        column: x => x.PackageTypeId,
                        principalTable: "PackageType",
                        principalColumn: "PackageTypeId");
                    table.ForeignKey(
                        name: "FK_Service_ShippingRate_ShippingRateRateId",
                        column: x => x.ShippingRateRateId,
                        principalTable: "ShippingRate",
                        principalColumn: "RateId");
                    table.ForeignKey(
                        name: "FK_Service_Truck_TruckId",
                        column: x => x.TruckId,
                        principalTable: "Truck",
                        principalColumn: "TruckId");
                });

            migrationBuilder.CreateTable(
                name: "BlogRating",
                columns: table => new
                {
                    BlogRatingId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Rating = table.Column<int>(type: "integer", nullable: false),
                    TotalRating = table.Column<int>(type: "integer", nullable: false),
                    BlogId = table.Column<int>(type: "integer", nullable: false),
                    UserId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BlogRating", x => x.BlogRatingId);
                    table.ForeignKey(
                        name: "FK_BlogRating_Blog_BlogId",
                        column: x => x.BlogId,
                        principalTable: "Blog",
                        principalColumn: "BlogId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_BlogRating_User_UserId",
                        column: x => x.UserId,
                        principalTable: "User",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "OrderTracking",
                columns: table => new
                {
                    OrderTrackingId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Status = table.Column<string>(type: "text", nullable: false),
                    UpdateDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: true),
                    Location = table.Column<string>(type: "text", nullable: true),
                    IsDelivered = table.Column<bool>(type: "boolean", nullable: false),
                    DeliveryConfirmedDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: true),
                    ConfirmImage = table.Column<string>(type: "text", nullable: true),
                    OrderId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OrderTracking", x => x.OrderTrackingId);
                    table.ForeignKey(
                        name: "FK_OrderTracking_Order_OrderId",
                        column: x => x.OrderId,
                        principalTable: "Order",
                        principalColumn: "OrderId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "OrderDetails",
                columns: table => new
                {
                    OrderDetailId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Quantity = table.Column<int>(type: "integer", nullable: false),
                    UnitPrice = table.Column<double>(type: "double precision", nullable: false),
                    TotalPrice = table.Column<double>(type: "double precision", nullable: false),
                    Status = table.Column<string>(type: "text", nullable: false),
                    OrderId = table.Column<int>(type: "integer", nullable: false),
                    ServiceId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OrderDetails", x => x.OrderDetailId);
                    table.ForeignKey(
                        name: "FK_OrderDetails_Order_OrderId",
                        column: x => x.OrderId,
                        principalTable: "Order",
                        principalColumn: "OrderId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_OrderDetails_Service_ServiceId",
                        column: x => x.ServiceId,
                        principalTable: "Service",
                        principalColumn: "ServiceId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Blog_UserId",
                table: "Blog",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_BlogRating_BlogId",
                table: "BlogRating",
                column: "BlogId");

            migrationBuilder.CreateIndex(
                name: "IX_BlogRating_UserId",
                table: "BlogRating",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Hub_RecipientId",
                table: "Hub",
                column: "RecipientId");

            migrationBuilder.CreateIndex(
                name: "IX_Hub_SenderId",
                table: "Hub",
                column: "SenderId");

            migrationBuilder.CreateIndex(
                name: "IX_Order_CustomerId",
                table: "Order",
                column: "CustomerId");

            migrationBuilder.CreateIndex(
                name: "IX_Order_DriverId",
                table: "Order",
                column: "DriverId");

            migrationBuilder.CreateIndex(
                name: "IX_OrderDetails_OrderId",
                table: "OrderDetails",
                column: "OrderId");

            migrationBuilder.CreateIndex(
                name: "IX_OrderDetails_ServiceId",
                table: "OrderDetails",
                column: "ServiceId");

            migrationBuilder.CreateIndex(
                name: "IX_OrderTracking_OrderId",
                table: "OrderTracking",
                column: "OrderId");

            migrationBuilder.CreateIndex(
                name: "IX_Service_PackageTypeId",
                table: "Service",
                column: "PackageTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_Service_ShippingRateRateId",
                table: "Service",
                column: "ShippingRateRateId");

            migrationBuilder.CreateIndex(
                name: "IX_Service_TruckId",
                table: "Service",
                column: "TruckId");

            migrationBuilder.CreateIndex(
                name: "IX_ShippingRate_VehicleTypeId",
                table: "ShippingRate",
                column: "VehicleTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_Truck_TruckTypeVehicleTypeId",
                table: "Truck",
                column: "TruckTypeVehicleTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_User_RoleID",
                table: "User",
                column: "RoleID");

            migrationBuilder.CreateIndex(
                name: "IX_VehiclePackageRelation_PackageTypeId",
                table: "VehiclePackageRelation",
                column: "PackageTypeId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "BlogRating");

            migrationBuilder.DropTable(
                name: "Hub");

            migrationBuilder.DropTable(
                name: "OrderDetails");

            migrationBuilder.DropTable(
                name: "OrderTracking");

            migrationBuilder.DropTable(
                name: "VehiclePackageRelation");

            migrationBuilder.DropTable(
                name: "Blog");

            migrationBuilder.DropTable(
                name: "Service");

            migrationBuilder.DropTable(
                name: "Order");

            migrationBuilder.DropTable(
                name: "PackageType");

            migrationBuilder.DropTable(
                name: "ShippingRate");

            migrationBuilder.DropTable(
                name: "Truck");

            migrationBuilder.DropTable(
                name: "User");

            migrationBuilder.DropTable(
                name: "VehicleType");

            migrationBuilder.DropTable(
                name: "UserRole");
        }
    }
}
