﻿// <auto-generated />
using System;
using L_L.Data.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace L_L.Data.Migrations
{
    [DbContext(typeof(AppDbContext))]
    partial class AppDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.5")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("L_L.Data.Entities.Blog", b =>
                {
                    b.Property<int>("BlogId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("BlogId"));

                    b.Property<int>("UserId")
                        .HasColumnType("integer");

                    b.Property<string>("content")
                        .HasColumnType("text");

                    b.Property<string>("description")
                        .HasColumnType("text");

                    b.Property<string>("status")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("thumbnail")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("title")
                        .HasColumnType("text");

                    b.HasKey("BlogId");

                    b.HasIndex("UserId");

                    b.ToTable("Blog");
                });

            modelBuilder.Entity("L_L.Data.Entities.BlogRating", b =>
                {
                    b.Property<int>("BlogRatingId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("BlogRatingId"));

                    b.Property<int>("BlogId")
                        .HasColumnType("integer");

                    b.Property<int>("Rating")
                        .HasColumnType("integer");

                    b.Property<int>("TotalRating")
                        .HasColumnType("integer");

                    b.Property<int>("UserId")
                        .HasColumnType("integer");

                    b.HasKey("BlogRatingId");

                    b.HasIndex("BlogId");

                    b.HasIndex("UserId");

                    b.ToTable("BlogRating");
                });

            modelBuilder.Entity("L_L.Data.Entities.Hub", b =>
                {
                    b.Property<int>("HubId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("HubId"));

                    b.Property<string>("Content")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int>("RecipientId")
                        .HasColumnType("integer");

                    b.Property<int>("SenderId")
                        .HasColumnType("integer");

                    b.HasKey("HubId");

                    b.HasIndex("RecipientId");

                    b.HasIndex("SenderId");

                    b.ToTable("Hub");
                });

            modelBuilder.Entity("L_L.Data.Entities.Order", b =>
                {
                    b.Property<int>("OrderId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("OrderId"));

                    b.Property<string>("CouponCode")
                        .HasColumnType("text");

                    b.Property<int>("CustomerId")
                        .HasColumnType("integer");

                    b.Property<DateTime?>("DeliveryDate")
                        .HasColumnType("timestamp without time zone");

                    b.Property<double?>("DiscountAmount")
                        .HasColumnType("double precision");

                    b.Property<int>("DriverId")
                        .HasColumnType("integer");

                    b.Property<DateTime?>("ExpectedDeliveryDate")
                        .HasColumnType("timestamp without time zone");

                    b.Property<string>("GiftMessage")
                        .HasColumnType("text");

                    b.Property<string>("InvoiceNumber")
                        .HasColumnType("text");

                    b.Property<bool>("IsGift")
                        .HasColumnType("boolean");

                    b.Property<string>("Notes")
                        .HasColumnType("text");

                    b.Property<DateTime?>("OrderDate")
                        .HasColumnType("timestamp without time zone");

                    b.Property<DateTime?>("PaymentDate")
                        .HasColumnType("timestamp without time zone");

                    b.Property<string>("PaymentMethod")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("ShippingAddress")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<double?>("ShippingCost")
                        .HasColumnType("double precision");

                    b.Property<string>("ShippingMethod")
                        .HasColumnType("text");

                    b.Property<string>("Status")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<double?>("TaxAmount")
                        .HasColumnType("double precision");

                    b.Property<double>("TotalAmount")
                        .HasColumnType("double precision");

                    b.Property<string>("TrackingNumber")
                        .HasColumnType("text");

                    b.HasKey("OrderId");

                    b.HasIndex("CustomerId");

                    b.HasIndex("DriverId");

                    b.ToTable("Order");
                });

            modelBuilder.Entity("L_L.Data.Entities.OrderDetails", b =>
                {
                    b.Property<int>("OrderDetailId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("OrderDetailId"));

                    b.Property<int>("OrderId")
                        .HasColumnType("integer");

                    b.Property<int>("Quantity")
                        .HasColumnType("integer");

                    b.Property<int>("ServiceId")
                        .HasColumnType("integer");

                    b.Property<double>("TotalPrice")
                        .HasColumnType("double precision");

                    b.Property<double>("UnitPrice")
                        .HasColumnType("double precision");

                    b.HasKey("OrderDetailId");

                    b.HasIndex("OrderId");

                    b.HasIndex("ServiceId");

                    b.ToTable("OrderDetails");
                });

            modelBuilder.Entity("L_L.Data.Entities.OrderTracking", b =>
                {
                    b.Property<int>("OrderTrackingId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("OrderTrackingId"));

                    b.Property<string>("Carrier")
                        .HasColumnType("text");

                    b.Property<string>("CarrierTrackingUrl")
                        .HasColumnType("text");

                    b.Property<DateTime?>("DeliveryConfirmedDate")
                        .HasColumnType("timestamp without time zone");

                    b.Property<string>("DeliveryInstructions")
                        .HasColumnType("text");

                    b.Property<bool>("IsDelivered")
                        .HasColumnType("boolean");

                    b.Property<string>("Location")
                        .HasColumnType("text");

                    b.Property<int>("OrderId")
                        .HasColumnType("integer");

                    b.Property<string>("Status")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<DateTime?>("UpdateDate")
                        .HasColumnType("timestamp without time zone");

                    b.HasKey("OrderTrackingId");

                    b.HasIndex("OrderId");

                    b.ToTable("OrderTracking");
                });

            modelBuilder.Entity("L_L.Data.Entities.PackageType", b =>
                {
                    b.Property<int>("PackageTypeId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("PackageTypeId"));

                    b.Property<string>("DimensionLimit")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.Property<int>("VehicleRangeMax")
                        .HasColumnType("integer");

                    b.Property<int>("VehicleRangeMin")
                        .HasColumnType("integer");

                    b.Property<decimal>("WeightLimit")
                        .HasColumnType("decimal(19, 2)");

                    b.HasKey("PackageTypeId");

                    b.ToTable("PackageType");
                });

            modelBuilder.Entity("L_L.Data.Entities.Service", b =>
                {
                    b.Property<int>("ServiceId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("ServiceId"));

                    b.Property<int?>("PackageTypeId")
                        .HasColumnType("integer");

                    b.Property<int?>("ShippingRateRateId")
                        .HasColumnType("integer");

                    b.Property<int?>("TruckId")
                        .HasColumnType("integer");

                    b.HasKey("ServiceId");

                    b.HasIndex("PackageTypeId");

                    b.HasIndex("ShippingRateRateId");

                    b.HasIndex("TruckId");

                    b.ToTable("Service");
                });

            modelBuilder.Entity("L_L.Data.Entities.ShippingRate", b =>
                {
                    b.Property<int>("RateId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("RateId"));

                    b.Property<int>("DistanceFrom")
                        .HasColumnType("integer");

                    b.Property<int?>("DistanceTo")
                        .HasColumnType("integer");

                    b.Property<decimal>("RatePerKM")
                        .HasColumnType("decimal(19, 2)");

                    b.Property<int>("VehicleTypeId")
                        .HasColumnType("integer");

                    b.HasKey("RateId");

                    b.HasIndex("VehicleTypeId");

                    b.ToTable("ShippingRate");
                });

            modelBuilder.Entity("L_L.Data.Entities.Truck", b =>
                {
                    b.Property<int>("TruckId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("TruckId"));

                    b.Property<string>("Color")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("Dimensions")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("EngineNumber")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("FrameNumber")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("LoadCapacity")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("Manufacturer")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("PlateCode")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("Status")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int?>("TotalBill")
                        .HasColumnType("integer");

                    b.Property<string>("TruckName")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int>("TruckTypeVehicleTypeId")
                        .HasColumnType("integer");

                    b.Property<int>("TypeId")
                        .HasColumnType("integer");

                    b.Property<string>("VehicleModel")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("TruckId");

                    b.HasIndex("TruckTypeVehicleTypeId");

                    b.ToTable("Truck");
                });

            modelBuilder.Entity("L_L.Data.Entities.User", b =>
                {
                    b.Property<int>("UserId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("UserId"));

                    b.Property<string>("Address")
                        .HasMaxLength(255)
                        .HasColumnType("character varying(255)");

                    b.Property<string>("Avatar")
                        .HasColumnType("text");

                    b.Property<DateTime?>("BirthDate")
                        .HasColumnType("timestamp without time zone");

                    b.Property<string>("City")
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.Property<string>("CreateBy")
                        .HasColumnType("text");

                    b.Property<DateTimeOffset?>("CreateDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("character varying(255)");

                    b.Property<string>("FullName")
                        .HasMaxLength(50)
                        .HasColumnType("character varying(50)");

                    b.Property<string>("Gender")
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.Property<string>("ModifyBy")
                        .HasColumnType("text");

                    b.Property<DateTimeOffset?>("ModifyDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("OTPCode")
                        .HasColumnType("text");

                    b.Property<string>("Password")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.Property<string>("PhoneNumber")
                        .HasMaxLength(15)
                        .HasColumnType("character varying(15)");

                    b.Property<int>("RoleID")
                        .HasColumnType("integer");

                    b.Property<string>("Status")
                        .HasColumnType("text");

                    b.Property<string>("TypeLogin")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("UserName")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("character varying(255)");

                    b.HasKey("UserId");

                    b.HasIndex("RoleID");

                    b.ToTable("User");
                });

            modelBuilder.Entity("L_L.Data.Entities.UserRole", b =>
                {
                    b.Property<int>("RoleId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("RoleId"));

                    b.Property<string>("RoleName")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("character varying(50)");

                    b.HasKey("RoleId");

                    b.ToTable("UserRole");
                });

            modelBuilder.Entity("L_L.Data.Entities.VehiclePackageRelation", b =>
                {
                    b.Property<int>("VehicleTypeId")
                        .HasColumnType("integer");

                    b.Property<int>("PackageTypeId")
                        .HasColumnType("integer");

                    b.Property<int>("RelationId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("RelationId"));

                    b.HasKey("VehicleTypeId", "PackageTypeId");

                    b.HasIndex("PackageTypeId");

                    b.ToTable("VehiclePackageRelation", (string)null);
                });

            modelBuilder.Entity("L_L.Data.Entities.VehicleType", b =>
                {
                    b.Property<int>("VehicleTypeId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("VehicleTypeId"));

                    b.Property<decimal>("BaseRate")
                        .HasColumnType("decimal(19, 2)");

                    b.Property<string>("VehicleTypeName")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("character varying(50)");

                    b.HasKey("VehicleTypeId");

                    b.ToTable("VehicleType");
                });

            modelBuilder.Entity("L_L.Data.Entities.Blog", b =>
                {
                    b.HasOne("L_L.Data.Entities.User", "UserBlog")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("UserBlog");
                });

            modelBuilder.Entity("L_L.Data.Entities.BlogRating", b =>
                {
                    b.HasOne("L_L.Data.Entities.Blog", "BlogRate")
                        .WithMany()
                        .HasForeignKey("BlogId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("L_L.Data.Entities.User", "UserRate")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("BlogRate");

                    b.Navigation("UserRate");
                });

            modelBuilder.Entity("L_L.Data.Entities.Hub", b =>
                {
                    b.HasOne("L_L.Data.Entities.User", "Recipient")
                        .WithMany()
                        .HasForeignKey("RecipientId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("L_L.Data.Entities.User", "Sender")
                        .WithMany()
                        .HasForeignKey("SenderId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Recipient");

                    b.Navigation("Sender");
                });

            modelBuilder.Entity("L_L.Data.Entities.Order", b =>
                {
                    b.HasOne("L_L.Data.Entities.User", "UserOrder")
                        .WithMany()
                        .HasForeignKey("CustomerId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("L_L.Data.Entities.User", "OrderDriver")
                        .WithMany()
                        .HasForeignKey("DriverId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("OrderDriver");

                    b.Navigation("UserOrder");
                });

            modelBuilder.Entity("L_L.Data.Entities.OrderDetails", b =>
                {
                    b.HasOne("L_L.Data.Entities.Order", "OrderInfo")
                        .WithMany()
                        .HasForeignKey("OrderId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("L_L.Data.Entities.Service", "ServiceInfo")
                        .WithMany()
                        .HasForeignKey("ServiceId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("OrderInfo");

                    b.Navigation("ServiceInfo");
                });

            modelBuilder.Entity("L_L.Data.Entities.OrderTracking", b =>
                {
                    b.HasOne("L_L.Data.Entities.Order", "OrderInfo")
                        .WithMany()
                        .HasForeignKey("OrderId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("OrderInfo");
                });

            modelBuilder.Entity("L_L.Data.Entities.Service", b =>
                {
                    b.HasOne("L_L.Data.Entities.PackageType", "PackageType")
                        .WithMany()
                        .HasForeignKey("PackageTypeId");

                    b.HasOne("L_L.Data.Entities.ShippingRate", "ShippingRate")
                        .WithMany()
                        .HasForeignKey("ShippingRateRateId");

                    b.HasOne("L_L.Data.Entities.Truck", "Truck")
                        .WithMany()
                        .HasForeignKey("TruckId");

                    b.Navigation("PackageType");

                    b.Navigation("ShippingRate");

                    b.Navigation("Truck");
                });

            modelBuilder.Entity("L_L.Data.Entities.ShippingRate", b =>
                {
                    b.HasOne("L_L.Data.Entities.VehicleType", "VehicleType")
                        .WithMany("ShippingRates")
                        .HasForeignKey("VehicleTypeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("VehicleType");
                });

            modelBuilder.Entity("L_L.Data.Entities.Truck", b =>
                {
                    b.HasOne("L_L.Data.Entities.VehicleType", "TruckType")
                        .WithMany()
                        .HasForeignKey("TruckTypeVehicleTypeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("TruckType");
                });

            modelBuilder.Entity("L_L.Data.Entities.User", b =>
                {
                    b.HasOne("L_L.Data.Entities.UserRole", "UserRole")
                        .WithMany()
                        .HasForeignKey("RoleID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("UserRole");
                });

            modelBuilder.Entity("L_L.Data.Entities.VehiclePackageRelation", b =>
                {
                    b.HasOne("L_L.Data.Entities.PackageType", "PackageType")
                        .WithMany("VehiclePackageRelations")
                        .HasForeignKey("PackageTypeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired()
                        .HasConstraintName("FK_VehiclePackageRelation2");

                    b.HasOne("L_L.Data.Entities.VehicleType", "VehicleType")
                        .WithMany("VehiclePackageRelations")
                        .HasForeignKey("VehicleTypeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired()
                        .HasConstraintName("FK_VehiclePackageRelation1");

                    b.Navigation("PackageType");

                    b.Navigation("VehicleType");
                });

            modelBuilder.Entity("L_L.Data.Entities.PackageType", b =>
                {
                    b.Navigation("VehiclePackageRelations");
                });

            modelBuilder.Entity("L_L.Data.Entities.VehicleType", b =>
                {
                    b.Navigation("ShippingRates");

                    b.Navigation("VehiclePackageRelations");
                });
#pragma warning restore 612, 618
        }
    }
}
