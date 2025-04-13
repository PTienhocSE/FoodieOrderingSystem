USE [master]
GO
/****** Object:  Database [ordering_system]    Script Date: 4/13/2025 10:22:11 AM ******/
CREATE DATABASE [ordering_system]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ordering_system', FILENAME = N'D:\Workspace\SQL Sever\MSSQL15.MSSQLSERVER\MSSQL\DATA\ordering_system.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ordering_system_log', FILENAME = N'D:\Workspace\SQL Sever\MSSQL15.MSSQLSERVER\MSSQL\DATA\ordering_system_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ordering_system] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ordering_system].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ordering_system] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ordering_system] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ordering_system] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ordering_system] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ordering_system] SET ARITHABORT OFF 
GO
ALTER DATABASE [ordering_system] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ordering_system] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ordering_system] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ordering_system] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ordering_system] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ordering_system] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ordering_system] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ordering_system] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ordering_system] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ordering_system] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ordering_system] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ordering_system] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ordering_system] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ordering_system] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ordering_system] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ordering_system] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ordering_system] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ordering_system] SET RECOVERY FULL 
GO
ALTER DATABASE [ordering_system] SET  MULTI_USER 
GO
ALTER DATABASE [ordering_system] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ordering_system] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ordering_system] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ordering_system] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ordering_system] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ordering_system] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ordering_system', N'ON'
GO
ALTER DATABASE [ordering_system] SET QUERY_STORE = OFF
GO
USE [ordering_system]
GO
/****** Object:  Table [dbo].[CartItem]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartItem](
	[CartItemID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NULL,
	[ShopID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CartItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[PostID] [int] NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discount]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount](
	[DiscountID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[DiscountPercentage] [decimal](5, 2) NOT NULL,
	[DiscountCODE] [nvarchar](100) NOT NULL,
	[NumberOfDiscount] [int] NOT NULL,
	[TotalUse] [int] NOT NULL,
	[Status] [int] NULL,
	[ShopID] [int] NULL,
	[MinimumAmount] [decimal](10, 2) NULL,
	[MaximumAmount] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Favourite]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favourite](
	[UserID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[FeedbackID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[Comment] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[FeedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [int] NOT NULL,
	[UserID] [int] NULL,
	[PaymentStatus] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[DeliveryOption] [nvarchar](50) NULL,
	[TimePickup] [datetime] NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
	[DiscountID] [int] NULL,
	[PaymentOption] [nvarchar](50) NOT NULL,
	[DeliveryStatus] [nvarchar](50) NULL,
	[isRefund] [int] NULL,
	[PaymentID] [nvarchar](8) NULL,
	[Phone] [nvarchar](11) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItem]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItem](
	[OrderItemID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[ProductID] [int] NULL,
	[Quantity] [int] NOT NULL,
	[TotalPrice] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[password_reset_tokens]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[password_reset_tokens](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[token] [varchar](255) NOT NULL,
	[expiration_time] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Post]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Post](
	[PostID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ImgURL] [nvarchar](200) NOT NULL,
	[Heading] [nvarchar](max) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Status] [bit] NOT NULL,
	[ShopID] [int] NULL,
	[CategoryID] [int] NULL,
	[PurchaseCount] [int] NULL,
	[Rating] [decimal](3, 2) NULL,
	[ProductImg] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImage]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImage](
	[ImageID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[IsAvatar] [bit] NULL,
	[ImgURL] [nvarchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Refund]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Refund](
	[RefundID] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[RefundReason] [nvarchar](max) NOT NULL,
	[RefundAmount] [decimal](10, 2) NOT NULL,
	[RefundStatus] [varchar](50) NOT NULL,
	[created_at] [datetime] NULL,
	[RefundReasonImg] [nvarchar](100) NULL,
	[RefundOption] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RefundID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RewardRedemption]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RewardRedemption](
	[RedemptionID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[NumberOfPoint] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RedemptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shop]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shop](
	[ShopID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [bit] NOT NULL,
	[ShopImage] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[TimeOpen] [time](7) NULL,
	[TimeClose] [time](7) NULL,
	[ShopWallet] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ShopID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] NOT NULL,
	[UserName] [varchar](100) NOT NULL,
	[Pass] [varchar](255) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[PhoneNumber] [varchar](10) NULL,
	[Email] [varchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[AvtImg] [nvarchar](200) NULL,
	[ShopID] [int] NULL,
	[Role] [int] NOT NULL,
	[code] [nvarchar](25) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VNPay_Bill]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VNPay_Bill](
	[vnpTxnRef] [varchar](255) NOT NULL,
	[vnpAmount] [decimal](10, 2) NOT NULL,
	[vnpPayDate] [varchar](255) NOT NULL,
	[vnpTransactionStatus] [varchar](50) NOT NULL,
	[OrderId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[vnpTxnRef] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[withdrawal_requests]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[withdrawal_requests](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[shop_id] [int] NOT NULL,
	[requested_amount] [decimal](10, 2) NOT NULL,
	[request_date] [datetime] NULL,
	[status] [varchar](20) NULL,
	[bank_account] [varchar](50) NOT NULL,
	[bank_name] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CartItem] ON 

INSERT [dbo].[CartItem] ([CartItemID], [UserID], [ProductID], [Quantity], [ShopID]) VALUES (1, 6511874, 10, 3, 1)
INSERT [dbo].[CartItem] ([CartItemID], [UserID], [ProductID], [Quantity], [ShopID]) VALUES (1033, 46325799, 10, 1, 1)
SET IDENTITY_INSERT [dbo].[CartItem] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [Type], [Description]) VALUES (1, N'Food', N'All kinds of dishes, snacks, and meals.')
INSERT [dbo].[Categories] ([CategoryID], [Type], [Description]) VALUES (2, N'Drink', N'A variety of beverages including soft drinks and hot drinks.')
INSERT [dbo].[Categories] ([CategoryID], [Type], [Description]) VALUES (3, N'Dessert', N'Sweet treats and baked goods.')
INSERT [dbo].[Categories] ([CategoryID], [Type], [Description]) VALUES (4, N'Snacks', N'Quick bites and light refreshments.')
INSERT [dbo].[Categories] ([CategoryID], [Type], [Description]) VALUES (5, N'Beverages', N'A wide range of cold and hot drinks, from sodas to specialty teas.')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([CommentID], [UserID], [PostID], [Content], [CreatedDate]) VALUES (2107, 46325799, 48, N'I will try', CAST(N'2024-11-15T00:25:46.560' AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [UserID], [PostID], [Content], [CreatedDate]) VALUES (2108, 98292168, 48, N'hay
', CAST(N'2024-12-05T21:14:01.987' AS DateTime))
SET IDENTITY_INSERT [dbo].[Comment] OFF
GO
SET IDENTITY_INSERT [dbo].[Discount] ON 

INSERT [dbo].[Discount] ([DiscountID], [UserID], [DiscountPercentage], [DiscountCODE], [NumberOfDiscount], [TotalUse], [Status], [ShopID], [MinimumAmount], [MaximumAmount]) VALUES (19, 17610341, CAST(20.00 AS Decimal(5, 2)), N'IV44X3CH', 1, 1, 0, 1, CAST(100000.00 AS Decimal(10, 2)), CAST(100000.00 AS Decimal(10, 2)))
INSERT [dbo].[Discount] ([DiscountID], [UserID], [DiscountPercentage], [DiscountCODE], [NumberOfDiscount], [TotalUse], [Status], [ShopID], [MinimumAmount], [MaximumAmount]) VALUES (20, 17610341, CAST(20.00 AS Decimal(5, 2)), N'MHBOO2KG', 5, 5, 0, 1, CAST(100000.00 AS Decimal(10, 2)), CAST(100000.00 AS Decimal(10, 2)))
INSERT [dbo].[Discount] ([DiscountID], [UserID], [DiscountPercentage], [DiscountCODE], [NumberOfDiscount], [TotalUse], [Status], [ShopID], [MinimumAmount], [MaximumAmount]) VALUES (21, 17610341, CAST(12.00 AS Decimal(5, 2)), N'BRJ33KCS', 10, 10, 0, 1, CAST(100000.00 AS Decimal(10, 2)), CAST(100000.00 AS Decimal(10, 2)))
INSERT [dbo].[Discount] ([DiscountID], [UserID], [DiscountPercentage], [DiscountCODE], [NumberOfDiscount], [TotalUse], [Status], [ShopID], [MinimumAmount], [MaximumAmount]) VALUES (22, 46325799, CAST(100.00 AS Decimal(5, 2)), N'IYSS8Xab', 1, 0, 1, 0, CAST(0.00 AS Decimal(10, 2)), CAST(100000.00 AS Decimal(10, 2)))
INSERT [dbo].[Discount] ([DiscountID], [UserID], [DiscountPercentage], [DiscountCODE], [NumberOfDiscount], [TotalUse], [Status], [ShopID], [MinimumAmount], [MaximumAmount]) VALUES (23, 46325799, CAST(100.00 AS Decimal(5, 2)), N'BXOezwDQ', 1, 1, 0, 0, CAST(1.00 AS Decimal(10, 2)), CAST(100000.00 AS Decimal(10, 2)))
INSERT [dbo].[Discount] ([DiscountID], [UserID], [DiscountPercentage], [DiscountCODE], [NumberOfDiscount], [TotalUse], [Status], [ShopID], [MinimumAmount], [MaximumAmount]) VALUES (24, 17610341, CAST(10.00 AS Decimal(5, 2)), N'DISBZGNM9P5', 5, 2, 1, 1, CAST(200000.00 AS Decimal(10, 2)), CAST(200000.00 AS Decimal(10, 2)))
INSERT [dbo].[Discount] ([DiscountID], [UserID], [DiscountPercentage], [DiscountCODE], [NumberOfDiscount], [TotalUse], [Status], [ShopID], [MinimumAmount], [MaximumAmount]) VALUES (1024, 46325799, CAST(100.00 AS Decimal(5, 2)), N'6k6NP9CE', 1, 0, 1, 0, CAST(0.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)))
INSERT [dbo].[Discount] ([DiscountID], [UserID], [DiscountPercentage], [DiscountCODE], [NumberOfDiscount], [TotalUse], [Status], [ShopID], [MinimumAmount], [MaximumAmount]) VALUES (1025, 46325799, CAST(100.00 AS Decimal(5, 2)), N'9gAiI2o8', 1, 1, 0, 0, CAST(0.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)))
INSERT [dbo].[Discount] ([DiscountID], [UserID], [DiscountPercentage], [DiscountCODE], [NumberOfDiscount], [TotalUse], [Status], [ShopID], [MinimumAmount], [MaximumAmount]) VALUES (1026, 98292168, CAST(100.00 AS Decimal(5, 2)), N'3nvJWCIW', 1, 1, 0, 0, CAST(0.00 AS Decimal(10, 2)), CAST(1000000.00 AS Decimal(10, 2)))
INSERT [dbo].[Discount] ([DiscountID], [UserID], [DiscountPercentage], [DiscountCODE], [NumberOfDiscount], [TotalUse], [Status], [ShopID], [MinimumAmount], [MaximumAmount]) VALUES (2026, 46325799, CAST(5.00 AS Decimal(5, 2)), N'50pUemI9', 1, 0, 1, 0, CAST(0.00 AS Decimal(10, 2)), CAST(50000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Discount] OFF
GO
SET IDENTITY_INSERT [dbo].[Feedback] ON 

INSERT [dbo].[Feedback] ([FeedbackID], [UserID], [ProductID], [Rating], [Comment], [CreatedDate]) VALUES (1, 46325799, 10, 4, N'Món ngon', CAST(N'2024-11-15T00:24:36.620' AS DateTime))
SET IDENTITY_INSERT [dbo].[Feedback] OFF
GO
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (1624539, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:48:34.493' AS DateTime), N'home_delivery', NULL, CAST(448500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'81953166', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (1669422, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-22T17:26:39.420' AS DateTime), N'home_delivery', NULL, CAST(337500.00 AS Decimal(18, 2)), NULL, N'COD', N'CANCELLED', 0, N'43419932', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (3445578, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T03:13:45.070' AS DateTime), N'home_delivery', NULL, CAST(0.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'87621055', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (3635305, 46325799, N'PAID', N'Hue', CAST(N'2024-10-26T16:07:36.397' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 0, N'92256769', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (4230121, 46325799, N'PENDING', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:33:20.603' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'52833206', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (4963519, 46325799, N'PAID', N'Hue', CAST(N'2024-10-23T01:46:08.110' AS DateTime), N'home_delivery', NULL, CAST(199500.00 AS Decimal(18, 2)), NULL, N'COD', N'CANCELLED', 0, N'19459063', N'3886188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (5549574, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T01:48:20.643' AS DateTime), N'home_delivery', NULL, CAST(199600.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'78685524', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (5733596, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-22T19:54:17.393' AS DateTime), N'home_delivery', NULL, CAST(337500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'COMPLETED', 2, N'23448003', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (9195074, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T04:05:08.603' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'COD', N'CANCELLED', 0, N'04681288', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (9924942, 46325799, N'PAID', N'Hue', CAST(N'2024-10-26T14:11:20.757' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 1, N'14228752', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (9938284, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:54:32.927' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 1, N'06826441', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (10099963, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:31:11.303' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'52833206', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (12699642, 46325799, N'PAID', N'Hue', CAST(N'2024-10-23T01:42:10.917' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'COD', N'CANCELLED', 0, N'72692921', N'3886188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (12803180, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T03:16:13.053' AS DateTime), N'home_delivery', NULL, CAST(0.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'52542688', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (13928265, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T03:11:29.353' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'78101490', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (15163698, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T19:35:30.010' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'73541521', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (15578739, 46325799, N'PENDING', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T19:10:14.970' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'37870492', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (16319741, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-26T16:22:19.723' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'COD', N'CANCELLED', 0, N'37413164', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (16445154, 46325799, N'PAID', N'Thừa Thiên Huế', CAST(N'2025-04-12T10:47:25.733' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'26494400', N'3886188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (19652830, 46325799, N'PENDING', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:25:38.067' AS DateTime), N'home_delivery', NULL, CAST(448500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'15016032', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (20599323, 46325799, N'PENDING', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-03T23:48:48.033' AS DateTime), N'home_delivery', NULL, CAST(330000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'32470351', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (21555074, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-25T16:21:16.210' AS DateTime), N'home_delivery', NULL, CAST(439120.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 1, N'54034632', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (23153242, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:48:44.833' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'81953166', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (25496445, 98292168, N'PAID', N'Tổ 6, Niêm Phò, Quảng Thọ, Quảng Điền, Thành Phố Huế', CAST(N'2024-12-05T21:08:53.253' AS DateTime), N'home_delivery', NULL, CAST(624500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'SHIPPING', 0, N'42412161', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (25724007, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-22T17:29:58.677' AS DateTime), N'pickup', CAST(N'2024-10-23T20:30:00.000' AS DateTime), CAST(337500.00 AS Decimal(18, 2)), NULL, N'COD', N'COMPLETED', 0, N'43419932', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (28146612, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-26T16:10:56.273' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 1, N'50727417', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (28262835, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T21:01:00.237' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'SHIPPING', 0, N'60019098', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (28710777, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T01:49:18.170' AS DateTime), N'home_delivery', NULL, CAST(199600.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'59374284', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (29948380, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T07:42:59.737' AS DateTime), N'home_delivery', NULL, CAST(224550.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'87219577', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (33884774, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-26T16:20:23.187' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'COD', N'CANCELLED', 0, N'74633833', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (34009934, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-02T13:09:49.917' AS DateTime), N'home_delivery', NULL, CAST(199500.00 AS Decimal(18, 2)), NULL, N'COD', N'COMPLETED', 2, N'82366722', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (34351121, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-25T15:51:59.890' AS DateTime), N'home_delivery', NULL, CAST(439120.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'COMPLETED', 2, N'74952109', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (35216773, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T19:20:05.363' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'09737359', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (35682504, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:47:58.620' AS DateTime), N'home_delivery', NULL, CAST(448500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'81953166', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (35858643, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T03:46:18.373' AS DateTime), N'home_delivery', NULL, CAST(219560.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'36497972', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (36065944, 46325799, N'PENDING', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:47:22.417' AS DateTime), N'home_delivery', NULL, CAST(448500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'52833206', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (39567904, 46325799, N'PENDING', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:43:36.247' AS DateTime), N'home_delivery', NULL, CAST(448500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'52833206', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (39972716, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T10:55:32.870' AS DateTime), N'home_delivery', NULL, CAST(0.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'40509542', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (42279531, 17610341, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-25T15:21:56.580' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 1, N'43990258', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (42471282, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T11:50:18.220' AS DateTime), N'home_delivery', NULL, CAST(400000.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 1, N'57099226', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (43345473, 46325799, N'PENDING', N'Hue', CAST(N'2024-10-22T22:20:40.957' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'01884082', N'3886188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (43382633, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T01:39:33.147' AS DateTime), N'home_delivery', NULL, CAST(199600.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 1, N'83722849', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (44384202, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T03:20:44.543' AS DateTime), N'home_delivery', NULL, CAST(0.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'48324859', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (45781750, 46325799, N'PAID', N'Hue', CAST(N'2024-10-23T13:17:30.643' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'COD', N'COMPLETED', 0, N'57166427', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (47211916, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-02T15:11:57.257' AS DateTime), N'home_delivery', NULL, CAST(199500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'COMPLETED', 1, N'17910342', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (47851768, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-26T16:20:54.753' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'COD', N'CANCELLED', 0, N'74633833', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (47993243, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T02:03:39.607' AS DateTime), N'home_delivery', NULL, CAST(199600.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'17807922', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (48065244, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-02T13:43:11.310' AS DateTime), N'home_delivery', NULL, CAST(375000.00 AS Decimal(18, 2)), NULL, N'COD', N'COMPLETED', 2, N'91490617', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (49763974, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T11:52:22.257' AS DateTime), N'home_delivery', NULL, CAST(400000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 1, N'57099226', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (52697157, 98292168, N'PENDING', N'Tổ 6, Niêm Phò, Quảng Thọ, Quảng Điền, Thành Phố Huế', CAST(N'2024-12-05T21:24:24.847' AS DateTime), N'home_delivery', NULL, CAST(925000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'79404342', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (52936691, 46325799, N'PENDING', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:26:02.927' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'15016032', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (53110431, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T03:22:52.363' AS DateTime), N'home_delivery', NULL, CAST(0.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'61552693', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (54408839, 46325799, N'PENDING', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-23T14:09:29.013' AS DateTime), N'home_delivery', NULL, CAST(199500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'86364461', NULL)
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (54591368, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:26:38.503' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'72600429', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (56283165, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:14:54.620' AS DateTime), N'home_delivery', NULL, CAST(448500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'12954767', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (56696095, 46325799, N'PAID', N'Hue', CAST(N'2024-10-22T15:26:57.983' AS DateTime), N'home_delivery', NULL, CAST(175560.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'COMPLETED', 1, N'12449957', N'3886188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (59174943, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T03:22:10.657' AS DateTime), N'home_delivery', NULL, CAST(0.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'70558467', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (60340061, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-23T13:27:23.460' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 1, N'55234538', NULL)
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (60567685, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T03:55:08.350' AS DateTime), N'home_delivery', NULL, CAST(149500.00 AS Decimal(18, 2)), NULL, N'COD', N'COMPLETED', 0, N'01766204', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (60780547, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T08:29:57.233' AS DateTime), N'home_delivery', NULL, CAST(175000.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'38934057', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (60903125, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-13T16:30:05.677' AS DateTime), N'home_delivery', NULL, CAST(352000.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'36656142', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (60904904, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-02T14:48:12.853' AS DateTime), N'home_delivery', NULL, CAST(375000.00 AS Decimal(18, 2)), NULL, N'COD', N'COMPLETED', 2, N'02892073', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (60924872, 46325799, N'PAID', N'Hue', CAST(N'2024-10-26T16:05:55.147' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 0, N'54542663', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (61138539, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T13:13:08.187' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 1, N'43935325', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (61436501, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T02:53:51.973' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'72948569', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (64549509, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:16:50.430' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'15016032', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (67097039, 46325799, N'PENDING', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-23T14:12:56.763' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 0, N'86364461', NULL)
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (67377144, 46325799, N'PENDING', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:33:30.657' AS DateTime), N'home_delivery', NULL, CAST(448500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'52833206', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (68977504, 46325799, N'PENDING', N'Hue', CAST(N'2024-10-23T14:05:02.893' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 0, N'86364461', NULL)
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (69407646, 17610341, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T04:15:10.407' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'COMPLETED', 0, N'81312281', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (69843160, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T00:33:17.433' AS DateTime), N'home_delivery', NULL, CAST(219560.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'COMPLETED', 2, N'18265147', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (70002699, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-02T10:41:57.080' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 1, N'20803011', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (70919192, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T02:09:37.357' AS DateTime), N'home_delivery', NULL, CAST(199600.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'64952717', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (71371525, 46325799, N'PENDING', N'Hue', CAST(N'2024-10-26T14:15:40.753' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 0, N'29376011', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (73506852, 46325799, N'PENDING', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:33:05.787' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'52833206', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (73540790, 46325799, N'DONE', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-23T14:06:25.670' AS DateTime), N'home_delivery', NULL, CAST(199500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 0, N'86364461', NULL)
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (75811528, 46325799, N'PAID', N'Hue', CAST(N'2024-10-23T13:26:38.813' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'DONE', 0, N'55234538', NULL)
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (76059322, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-23T13:59:08.637' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 1, N'86364461', NULL)
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (78022931, 46325799, N'PENDING', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-08T21:59:30.280' AS DateTime), N'home_delivery', NULL, CAST(375000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'18878090', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (79452270, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T19:06:47.273' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'37870492', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (79489035, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-02T11:44:07.953' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 2, N'82366722', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (81936302, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-26T16:20:11.133' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'SHIPPING', 0, N'74633833', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (82112120, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T03:10:32.773' AS DateTime), N'home_delivery', NULL, CAST(219560.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'78656148', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (82295189, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T02:19:29.087' AS DateTime), N'home_delivery', NULL, CAST(219560.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'22632666', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (85349589, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T08:24:51.583' AS DateTime), N'home_delivery', NULL, CAST(337500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'COMPLETED', 1, N'48494689', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (85890295, 17610341, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-25T15:28:54.553' AS DateTime), N'home_delivery', NULL, CAST(439120.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'COMPLETED', 1, N'21733543', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (87536102, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T21:00:24.863' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'15930948', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (87754679, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T03:45:48.997' AS DateTime), N'home_delivery', NULL, CAST(219560.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'94341984', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (88227022, 46325799, N'PENDING', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-23T14:05:50.040' AS DateTime), N'home_delivery', NULL, CAST(199500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 0, N'86364461', NULL)
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (89696913, 46325799, N'PENDING', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:49:33.277' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'81953166', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (90149536, 17610341, N'PENDING', N'Hue', CAST(N'2024-10-25T16:18:06.447' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'74952109', N'3886188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (90827937, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T03:25:44.223' AS DateTime), N'home_delivery', NULL, CAST(0.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'51015926', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (90850352, 46325799, N'PENDING', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:33:55.883' AS DateTime), N'home_delivery', NULL, CAST(448500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'52833206', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (91000802, 46325799, N'PENDING', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:25:27.917' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'15016032', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (92723503, 98292168, N'PAID', N'Tổ 6, Niêm Phò, Quảng Thọ, Quảng Điền, Thành Phố Huế', CAST(N'2024-12-05T21:24:44.610' AS DateTime), N'home_delivery', NULL, CAST(925000.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'73422378', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (92986030, 46325799, N'FAILED', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T07:48:37.803' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'FAILED', 0, N'39262225', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (93307556, 46325799, N'PENDING', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T19:35:53.323' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'25081291', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (93419154, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-22T17:27:02.060' AS DateTime), N'home_delivery', NULL, CAST(337500.00 AS Decimal(18, 2)), NULL, N'COD', N'COMPLETED', 0, N'43419932', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (93505225, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T02:41:42.687' AS DateTime), N'home_delivery', NULL, CAST(219560.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'14923182', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (93762180, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T03:39:07.040' AS DateTime), N'home_delivery', NULL, CAST(549000.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'06785441', N'0386188917')
GO
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (93786688, 46325799, N'PENDING', N'Hue', CAST(N'2024-10-22T22:24:21.870' AS DateTime), N'home_delivery', NULL, CAST(499000.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCELLED', 0, N'76980756', N'3886188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (93834453, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-14T18:56:44.040' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'PENDING', 0, N'24697176', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (94354567, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-13T16:57:34.887' AS DateTime), N'home_delivery', NULL, CAST(352000.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'24625131', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (98982191, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-10-25T15:45:01.947' AS DateTime), N'home_delivery', NULL, CAST(439120.00 AS Decimal(18, 2)), NULL, N'VNPAY', N'CANCEL', 1, N'29347954', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (99218114, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T08:23:50.193' AS DateTime), N'home_delivery', NULL, CAST(375000.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'74354446', N'0386188917')
INSERT [dbo].[Order] ([OrderID], [UserID], [PaymentStatus], [Address], [CreatedDate], [DeliveryOption], [TimePickup], [TotalAmount], [DiscountID], [PaymentOption], [DeliveryStatus], [isRefund], [PaymentID], [Phone]) VALUES (99929352, 46325799, N'PAID', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', CAST(N'2024-11-15T02:49:39.863' AS DateTime), N'home_delivery', NULL, CAST(249500.00 AS Decimal(18, 2)), NULL, N'COD', N'PENDING', 0, N'49741597', N'0386188917')
GO
SET IDENTITY_INSERT [dbo].[OrderItem] ON 

INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (167, 56696095, 12, 1, CAST(199500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (168, 1669422, 14, 1, CAST(375000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (169, 93419154, 14, 1, CAST(375000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (170, 25724007, 14, 1, CAST(375000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (171, 5733596, 14, 1, CAST(375000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (172, 43345473, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (173, 93786688, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (174, 12699642, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (175, 4963519, 12, 1, CAST(199500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (176, 45781750, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (177, 75811528, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (178, 60340061, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (179, 76059322, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (180, 68977504, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (181, 88227022, 12, 1, CAST(199500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (182, 73540790, 12, 1, CAST(199500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (183, 54408839, 12, 1, CAST(199500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (184, 67097039, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (185, 42279531, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (186, 85890295, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (187, 98982191, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (188, 34351121, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (189, 90149536, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (190, 21555074, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (191, 9924942, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (192, 71371525, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (193, 60924872, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (194, 3635305, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (195, 28146612, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (196, 81936302, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (197, 33884774, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (198, 47851768, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (199, 16319741, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (200, 70002699, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (201, 79489035, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (202, 34009934, 12, 1, CAST(199500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (203, 48065244, 14, 1, CAST(375000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (204, 60904904, 14, 1, CAST(375000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (205, 47211916, 12, 1, CAST(199500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (1200, 20599323, 14, 1, CAST(375000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (1201, 78022931, 14, 1, CAST(375000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2201, 60903125, 11, 1, CAST(275000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2202, 60903125, 17, 1, CAST(125000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2203, 94354567, 11, 1, CAST(275000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2204, 94354567, 17, 1, CAST(125000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2205, 39972716, 11, 1, CAST(275000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2206, 39972716, 17, 1, CAST(125000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2207, 42471282, 11, 1, CAST(275000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2208, 42471282, 17, 1, CAST(125000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2209, 49763974, 11, 1, CAST(275000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2210, 49763974, 17, 1, CAST(125000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2211, 61138539, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2212, 56283165, 21, 3, CAST(448500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2213, 64549509, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2214, 91000802, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2215, 19652830, 21, 3, CAST(448500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2216, 52936691, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2217, 54591368, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2218, 10099963, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2219, 73506852, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2220, 4230121, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2221, 67377144, 21, 3, CAST(448500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2222, 90850352, 21, 3, CAST(448500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2223, 39567904, 21, 3, CAST(448500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2224, 36065944, 21, 3, CAST(448500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2225, 35682504, 21, 3, CAST(448500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2226, 1624539, 21, 3, CAST(448500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2227, 23153242, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2228, 89696913, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2229, 9938284, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2230, 93834453, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2231, 79452270, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2232, 15578739, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2233, 35216773, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2234, 15163698, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2235, 93307556, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2236, 87536102, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2237, 28262835, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2238, 69843160, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2239, 43382633, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2240, 5549574, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2241, 28710777, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2242, 47993243, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2243, 70919192, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2244, 82295189, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2245, 93505225, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2246, 99929352, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2247, 61436501, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2248, 82112120, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2249, 13928265, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2250, 3445578, 13, 1, CAST(349500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2251, 3445578, 15, 1, CAST(299500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2252, 12803180, 13, 1, CAST(349500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2253, 12803180, 15, 1, CAST(299500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2254, 44384202, 13, 1, CAST(349500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2255, 44384202, 15, 1, CAST(299500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2256, 59174943, 13, 1, CAST(349500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2257, 59174943, 15, 1, CAST(299500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2258, 53110431, 13, 1, CAST(349500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2259, 53110431, 15, 1, CAST(299500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2260, 90827937, 13, 1, CAST(349500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2261, 90827937, 15, 1, CAST(299500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2262, 93762180, 13, 1, CAST(349500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2263, 93762180, 15, 1, CAST(299500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2264, 87754679, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2265, 35858643, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2266, 60567685, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2267, 9195074, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (2268, 69407646, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (3268, 29948380, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (3269, 92986030, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (3270, 99218114, 14, 1, CAST(375000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (3271, 85349589, 14, 1, CAST(375000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (3272, 60780547, 16, 1, CAST(175000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (3273, 25496445, 10, 1, CAST(249500.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (3274, 25496445, 14, 1, CAST(375000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (3275, 52697157, 11, 2, CAST(550000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (3276, 52697157, 17, 3, CAST(375000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (3277, 92723503, 11, 2, CAST(550000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (3278, 92723503, 17, 3, CAST(375000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (4273, 16445154, 10, 2, CAST(499000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[OrderItem] OFF
GO
SET IDENTITY_INSERT [dbo].[password_reset_tokens] ON 

INSERT [dbo].[password_reset_tokens] ([id], [UserID], [token], [expiration_time]) VALUES (1, 6511874, N'f47259c6-5104-40ea-b36a-05250ecc59ac', CAST(N'2024-10-04T19:35:55.447' AS DateTime))
SET IDENTITY_INSERT [dbo].[password_reset_tokens] OFF
GO
SET IDENTITY_INSERT [dbo].[Post] ON 

INSERT [dbo].[Post] ([PostID], [UserID], [ImgURL], [Heading], [Content], [CreatedDate], [status]) VALUES (48, 17610341, N'http://res.cloudinary.com/dvyu4f7lq/image/upload/v1731563340/vfwkgbsorb9w8zfws4ap.webp', N'Vietnamese food: The TOP 10 must-try dishes in 2024', N'<p dir="ltr">Vietnamese food has been highly appreciated internationally so far thanks to the global popularity of some prominent dishes, such as Pho. Meanwhile, Vietnamese cuisine is considered as one of the unique cuisines in East Asia. Read this article to know what to eat in your upcoming trip to Vietnam.</p>
<h2 dir="ltr">1. Banh mi - The Vietnamese sandwich</h2>
<p dir="ltr">Banh mi, or the Vietnamese sandwich, is one of the most popular street foods in Vietnam that many tourists want to try. It is considered one of the most prominent remnants of the French colonial period in the South, aside from architectural works, because it was first created in the 19th century and inspired by the French baguette.</p>
<p dir="ltr">Over many years, the locals have changed this Vietnamese food in many ways to adapt to Vietnamese culture. Specifically, inside banh mi, they fill it with many ingredients like pork, egg, cucumber, pickled carrot, daikon radish, scallion and cilantro, depending on the demands of food enthusiasts.</p>
<p dir="ltr">For a lot of people, banh mi is a great suggestion for breakfast, especially for those who have to go to work or school early in the mornings. It is such a cheap and tasty food that it can give people a great start to any busy day. Although banh mi is available across the country, tourists will find the best one in the southern cities, <a href="https://vinpearl.com/en/ho-chi-minh-city-the-top-tips-for-traveling-on-a-budget-in-2022">Ho Chi Minh City</a>, for instance.</p>
<p dir="ltr"><img src="https://lh7-rt.googleusercontent.com/docsz/AD_4nXfKZy4-yXBuHtHE7O90ZxPqB_jdPPUfZkkPuu8hk9HY9gepExTsBf_tDprvpzL_oNSiBv-OeDw8OCXgrokLZpm9UT77EMaQMZRzvATcdz7pRKMDT4Lm7-vR05hKXpg81jyoXNRb3fpeN3qEqHBCr8W_hZwg?key=V0TvitZdQv7I7VMigiZAXQ" alt="Vietnamese food" width="602" height="401"></p>
<p dir="ltr">Banh mi contributes to characterizing the Vietnamese food culture (Source: Collected)</p>
<h2 dir="ltr">2. Bun cha - The Vietnamese grilled meat noodles</h2>
<p dir="ltr">Bun cha is a prominent specialty of Hanoi cuisine which any tourist should enjoy once when visiting the capital of the country. Despite being a simple Vietnamese dish, it can satisfy any appetite with its memorable flavor. Rice vermicelli, grilled pork, herbs and fish sauce are all the things that create a unique taste for this dish.</p>
<p dir="ltr">When eating this Vietnamese food, you need to put all the main ingredients into a small bowl and fill it with fish sauce. In particular, the sauce is a mix of chili, garlic, carrot and green papaya. All of these will bring you a distinct sweet and sour flavor which is very suitable for this Vietnamese food and which cannot be found anywhere else.</p>
<p dir="ltr">This Vietnamese food is commonly eaten at lunchtime. Thus, when you get around in Hanoi during this time, you can smell the scent of pork which is grilled over hot charcoal wafts down the sidewalks. This will surely fill your nose and make you immediately hungry.</p>
<p dir="ltr"><img src="https://lh7-rt.googleusercontent.com/docsz/AD_4nXd4zlqSLaZLWpOjKzmKwSGzADaWXHt7AtQ-xMTNEYudaIZpK9RNhpLmNZ7jWhu7ppg3RqkslTZIu__o0n0k1t_sXWSJh3XwtviI6p4-XDKFANrOzaZDbk60qTTB0OXVU8cD4U3-EEeTSeogYppIRy-iYaTb?key=V0TvitZdQv7I7VMigiZAXQ" alt="Vietnamese food" width="602" height="451"></p>
<p dir="ltr">You should enjoy bun cha once in your trip to Hanoi (Source: Collected)</p>
<h2 dir="ltr">3. Pho - The Vietnamese rice noodle soup</h2>
<p dir="ltr">As a pride of Vietnamese cuisine, Pho is definitely not an unpopular food for many tourists because it has been famous all over the world thanks to its unique flavor. This Vietnamese food originated in Hanoi and was first served to diners in the early 20th century. Despite its apparent simplicity, a bowl of Pho can provide tourists a satisfying meal.</p>
<p dir="ltr">The main ingredient of this best food in Vietnam is a type of rice noodles called &ldquo;banh pho&rdquo;, which is larger and flatter than other kinds of rice noodles. Besides, it also consists of broth, herbs and meat, which can typically be sliced beef or chicken. When eating Pho, remember to squeeze some lime juice into the dish and add a dash of pepper or chili flakes for an extra kick of flavor.</p>
<p dir="ltr">With many outstanding features, Pho is known as a quintessential Vietnamese food that international tourists should try once. This food can be eaten at any time of day but people love enjoying it for breakfast. Therefore, in your upcoming trip to Vietnam, start your day with a bowl of Pho before visiting some famous tourist attractions.</p>
<p dir="ltr"><img src="https://lh7-rt.googleusercontent.com/docsz/AD_4nXdIJXT6yGOPP0QELrvfBWNeDaIF9Nm-wXa7_dB7IG2UQVhCb1541G4cWYpnt2JpAO-PGx4zNsTawB4Tp_CsPnog81rAFCaupsFpvMVvsMYD8uuqG4o7Z8noe6qOhva3fxFicBVdvzV39nHJ8JNRUJrcvpz3?key=V0TvitZdQv7I7VMigiZAXQ" alt="Vietnamese food" width="602" height="901"></p>
<p dir="ltr">Pho is a traditional food in Vietnam</p>', CAST(N'2024-11-14T12:49:00.377' AS DateTime), 1)
INSERT [dbo].[Post] ([PostID], [UserID], [ImgURL], [Heading], [Content], [CreatedDate], [status]) VALUES (49, 17610341, N'.\blogImg\1729523624353_123-6022-1702524694.jpg', N'Việt Nam vào top 22 nền ẩm thực ngon nhất thế giới', N'<p>Alo</p>', CAST(N'2024-10-21T22:13:44.400' AS DateTime), 0)
INSERT [dbo].[Post] ([PostID], [UserID], [ImgURL], [Heading], [Content], [CreatedDate], [status]) VALUES (50, 17610341, N'blogImg\1729654129417_R.jpg', N'Mi Quang - The Vietnamese noodle in today', N'<p dir="ltr">Vietnamese food has been highly appreciated internationally so far thanks to the global popularity of some prominent dishes, such as Pho. Meanwhile, Vietnamese cuisine is considered as one of the unique cuisines in East Asia. Read this article to know what to eat in your upcoming trip to Vietnam.</p>
<h2 dir="ltr">1. Banh mi - The Vietnamese sandwich</h2>
<p dir="ltr">Banh mi, or the Vietnamese sandwich, is one of the most popular street foods in Vietnam that many tourists want to try. It is considered one of the most prominent remnants of the French colonial period in the South, aside from architectural works, because it was first created in the 19th century and inspired by the French baguette.</p>
<p dir="ltr">Over many years, the locals have changed this Vietnamese food in many ways to adapt to Vietnamese culture. Specifically, inside banh mi, they fill it with many ingredients like pork, egg, cucumber, pickled carrot, daikon radish, scallion and cilantro, depending on the demands of food enthusiasts.</p>
<p dir="ltr">For a lot of people, banh mi is a great suggestion for breakfast, especially for those who have to go to work or school early in the mornings. It is such a cheap and tasty food that it can give people a great start to any busy day. Although banh mi is available across the country, tourists will find the best one in the southern cities, <a href="https://vinpearl.com/en/ho-chi-minh-city-the-top-tips-for-traveling-on-a-budget-in-2022">Ho Chi Minh City</a>, for instance.</p>
<p dir="ltr"><img src="https://lh7-rt.googleusercontent.com/docsz/AD_4nXcu54aL4heP0YcHyF7mz-BkEkQht67_kglVGuoETrRz4HeBA9yBiuDGyxb2VhLNyOMuNQ5JqgXuZUcFol9AkNIcUsnnrZxyByjz9EmSuEsrQXyWUpH_QBfJKWzjdTxnJbB9W3DuIlxLjY86g9MpF_YwMrLs?key=V0TvitZdQv7I7VMigiZAXQ" alt="Vietnamese food" width="602" height="401"></p>
<p dir="ltr">Banh mi contributes to characterizing the Vietnamese food culture (Source: Collected)</p>
<h2 dir="ltr">2. Bun cha - The Vietnamese grilled meat noodles</h2>
<p dir="ltr">Bun cha is a prominent specialty of Hanoi cuisine which any tourist should enjoy once when visiting the capital of the country. Despite being a simple Vietnamese dish, it can satisfy any appetite with its memorable flavor. Rice vermicelli, grilled pork, herbs and fish sauce are all the things that create a unique taste for this dish.</p>
<p dir="ltr">When eating this Vietnamese food, you need to put all the main ingredients into a small bowl and fill it with fish sauce. In particular, the sauce is a mix of chili, garlic, carrot and green papaya. All of these will bring you a distinct sweet and sour flavor which is very suitable for this Vietnamese food and which cannot be found anywhere else.</p>
<p dir="ltr">This Vietnamese food is commonly eaten at lunchtime. Thus, when you get around in Hanoi during this time, you can smell the scent of pork which is grilled over hot charcoal wafts down the sidewalks. This will surely fill your nose and make you immediately hungry.</p>
<p dir="ltr"><img src="https://lh7-rt.googleusercontent.com/docsz/AD_4nXc5Gveqa7f3TmZPC3jr8p82ZeFJwdiq02g7VlzpaqfxQN8G2BWpOn2u8n40Z1ZzfvxsA1zDzZSdHpDa23iZ3nqLfqRPxPjRSerPR4LGoL-7vfnb3LBS2v2OCVgqvRMAT5WPnmyt7lSx2DFTKm6YC_nlqieZ?key=V0TvitZdQv7I7VMigiZAXQ" alt="Vietnamese food" width="602" height="451"></p>
<p dir="ltr">You should enjoy bun cha once in your trip to Hanoi (Source: Collected)</p>
<h2 dir="ltr">3. Pho - The Vietnamese rice noodle soup</h2>
<p dir="ltr">As a pride of Vietnamese cuisine, Pho is definitely not an unpopular food for many tourists because it has been famous all over the world thanks to its unique flavor. This Vietnamese food originated in Hanoi and was first served to diners in the early 20th century. Despite its apparent simplicity, a bowl of Pho can provide tourists a satisfying meal.</p>
<p dir="ltr">The main ingredient of this best food in Vietnam is a type of rice noodles called &ldquo;banh pho&rdquo;, which is larger and flatter than other kinds of rice noodles. Besides, it also consists of broth, herbs and meat, which can typically be sliced beef or chicken. When eating Pho, remember to squeeze some lime juice into the dish and add a dash of pepper or chili flakes for an extra kick of flavor.</p>
<p dir="ltr">With many outstanding features, Pho is known as a quintessential Vietnamese food that international tourists should try once. This food can be eaten at any time of day but people love enjoying it for breakfast. Therefore, in your upcoming trip to Vietnam, start your day with a bowl of Pho before visiting some famous tourist attractions.</p>
<p dir="ltr"><img src="https://lh7-rt.googleusercontent.com/docsz/AD_4nXcgG2gf0CZWei0E_3-PBO0f771e8y3qsbnAdD4RTnZ5FeaHxoZ8y2Nn4X7iObJwagRV8T2XAUYtg94WTOdjWBabhqC7nqRtmzAjxFCh5dY7al3yPHBVB2VyQI1ThkKLFpqF3PXtPFN18WkzulCqGeAJB4yA?key=V0TvitZdQv7I7VMigiZAXQ" alt="Vietnamese food" width="602" height="901"></p>
<p dir="ltr">Pho is a traditional food in Vietnam</p>', CAST(N'2024-10-23T10:28:49.440' AS DateTime), 0)
INSERT [dbo].[Post] ([PostID], [UserID], [ImgURL], [Heading], [Content], [CreatedDate], [status]) VALUES (51, 17610341, N'.\blogImg\1729588987074_LabSWR.drawio.png', N'dfd', N'<p>fd</p>', CAST(N'2024-10-22T16:23:07.100' AS DateTime), 0)
INSERT [dbo].[Post] ([PostID], [UserID], [ImgURL], [Heading], [Content], [CreatedDate], [status]) VALUES (52, 17610341, N'http://res.cloudinary.com/dvyu4f7lq/image/upload/v1731563308/lagvtwqh9idmzm1yaavo.jpg', N'Introducing Our Exclusive Discount: 12% Off All Dishes!', N'<p>We are excited to offer you a special treat! For a limited time, enjoy <strong>12% off</strong> on all your favorite dishes with our exclusive discount code. Whether you''re craving a savory main course, a sweet dessert, or a refreshing beverage, this offer applies to everything on our menu.</p>
<p>To celebrate our customers, we''re releasing <strong>100 discount codes</strong> &mdash; so don&rsquo;t miss out! Simply apply the code at checkout to enjoy this incredible offer. The best part? It&rsquo;s super easy to use and works on <strong>every dish</strong>. But remember, with only 100 codes available, you''ll need to act fast!</p>
<p>This is the perfect opportunity to try something new or enjoy your favorite meal at a reduced price. So why wait? Grab your code and indulge in the delicious flavors we offer, all while saving 12% on your total order.</p>
<p>Hurry and get your code today before they''re all gone!</p>', CAST(N'2024-11-14T12:48:29.513' AS DateTime), 1)
INSERT [dbo].[Post] ([PostID], [UserID], [ImgURL], [Heading], [Content], [CreatedDate], [status]) VALUES (53, 17610341, N'.\blogImg\1729589421030_DISCOUNT.jpg', N'Introducing Our Exclusive Discount: 12% Off All Dishes!', N'<p>We are excited to offer you a special treat! For a limited time, enjoy <strong>12% off</strong> on all your favorite dishes with our exclusive discount code. Whether you''re craving a savory main course, a sweet dessert, or a refreshing beverage, this offer applies to everything on our menu.</p>
<p>To celebrate our customers, we''re releasing <strong>100 discount codes</strong> &mdash; so don&rsquo;t miss out! Simply apply the code at checkout to enjoy this incredible offer. The best part? It&rsquo;s super easy to use and works on <strong>every dish</strong>. But remember, with only 100 codes available, you''ll need to act fast!</p>
<p>This is the perfect opportunity to try something new or enjoy your favorite meal at a reduced price. So why wait? Grab your code and indulge in the delicious flavors we offer, all while saving 12% on your total order.</p>
<p>Hurry and get your code today before they''re all gone!</p>', CAST(N'2024-10-22T16:30:21.050' AS DateTime), 0)
INSERT [dbo].[Post] ([PostID], [UserID], [ImgURL], [Heading], [Content], [CreatedDate], [status]) VALUES (54, 17610341, N'http://res.cloudinary.com/dvyu4f7lq/image/upload/v1731563258/ecg2vttqdj5dlpxptrvu.webp', N'Starbucks channels its inner green girl with ‘Wicked’-themed drinks', N'<section class="mb7">
<div class="article-body__byline">
<div class="article-inline-byline" data-activity-map="inline-byline-article-top">By&nbsp;<span class="byline-name" data-testid="byline-name"><a href="https://www.today.com/author/drew-weisholtz-tdpn137415">Drew Weisholtz</a></span></div>
</div>
</section>
<div class="article-body__content">
<p class="">Starbucks has a &ldquo;Wicked&rdquo; good deal for customers.</p>
<p class="">The coffee chain announced that, beginning Oct. 22, people in the United States, Canada and other select international locations can purchase two new drinks in partnership with the upcoming movie &ldquo;<a href="https://www.today.com/popculture/movies/wicked-trailer-rcna152355" target="_blank" rel="noopener">Wicked</a>.&rdquo;</p>
<div id="taboolaReadMoreBelow"></div>
<p class="">The limited-time drinks are inspired by the film&rsquo;s main characters, Glinda (the Good Witch of the South) and Elphaba (the Wicked Witch of the West).</p>
<p class="">Glinda&rsquo;s Pink Potion is &ldquo;inspired by Glinda&rsquo;s bright character and of course her iconic association with all things pink,&rdquo; according to Starbucks beverage developer Natalia Vasquez, and features a Mango Dragonfruit Starbucks Refreshers Beverage shaken with coconut milk, ice and a scoop of freeze-dried dragonfruit, and topped with nondairy strawberry cold foam and colorful candy sprinkles.</p>
<figure class="styles_inlineImage__yAWZ0 styles_medium__OMa6x"><picture class="styles_image__1qciH" data-testid="picture"><source srcset="https://media-cldnry.s-nbcnews.com/image/upload/t_fit-560w,f_avif,q_auto:eco,dpr_2/rockcms/2024-10/starbucks-wicked-inline-1-cz-241021-c60ec0.jpg 2x, https://media-cldnry.s-nbcnews.com/image/upload/t_fit-560w,f_auto,q_auto:best/rockcms/2024-10/starbucks-wicked-inline-1-cz-241021-c60ec0.jpg 1x" media="(min-width: 1000px)"><source srcset="https://media-cldnry.s-nbcnews.com/image/upload/t_fit-760w,f_avif,q_auto:eco,dpr_2/rockcms/2024-10/starbucks-wicked-inline-1-cz-241021-c60ec0.jpg 2x, https://media-cldnry.s-nbcnews.com/image/upload/t_fit-760w,f_auto,q_auto:best/rockcms/2024-10/starbucks-wicked-inline-1-cz-241021-c60ec0.jpg 1x" media="(min-width: 320px)"><img src="https://media-cldnry.s-nbcnews.com/image/upload/t_fit-760w,f_auto,q_auto:best/rockcms/2024-10/starbucks-wicked-inline-1-cz-241021-c60ec0.jpg" alt="Starbuck''s Elphaba drink" width="700" height="700" loading="lazy"></picture>
<figcaption class="caption styles_caption__Pe5JC" data-testid="caption"><span class="caption__container" data-testid="caption__container">Glinda''s Pink Potion.</span><span class="caption__source" data-testid="caption__source">Starbucks</span></figcaption>
</figure>
<p class="">Meanwhile, Elphaba&rsquo;s Cold Brew is &ldquo;inspired by Elphaba&rsquo;s bold energy and stunning green skin,&rdquo; according to Starbucks beverage developer Rosalyn Batingan, and features Starbucks Cold Brew sweetened with peppermint-flavored syrup, and topped with nondairy matcha cold foam and green candy sprinkles.</p>
<figure class="styles_inlineImage__yAWZ0 styles_medium__OMa6x"><picture class="styles_image__1qciH" data-testid="picture"><source srcset="https://media-cldnry.s-nbcnews.com/image/upload/t_fit-560w,f_avif,q_auto:eco,dpr_2/rockcms/2024-10/starbucks-wicked-inline-2-cz-241021-01ce24.jpg 2x, https://media-cldnry.s-nbcnews.com/image/upload/t_fit-560w,f_auto,q_auto:best/rockcms/2024-10/starbucks-wicked-inline-2-cz-241021-01ce24.jpg 1x" media="(min-width: 1000px)"><source srcset="https://media-cldnry.s-nbcnews.com/image/upload/t_fit-760w,f_avif,q_auto:eco,dpr_2/rockcms/2024-10/starbucks-wicked-inline-2-cz-241021-01ce24.jpg 2x, https://media-cldnry.s-nbcnews.com/image/upload/t_fit-760w,f_auto,q_auto:best/rockcms/2024-10/starbucks-wicked-inline-2-cz-241021-01ce24.jpg 1x" media="(min-width: 320px)"><img src="https://media-cldnry.s-nbcnews.com/image/upload/t_fit-760w,f_auto,q_auto:best/rockcms/2024-10/starbucks-wicked-inline-2-cz-241021-01ce24.jpg" alt="Starbuck''s Glinda drink" width="700" height="700" loading="lazy"></picture>
<figcaption class="caption styles_caption__Pe5JC" data-testid="caption"><span class="caption__container" data-testid="caption__container">Elphaba''s Cold Brew.</span><span class="caption__source" data-testid="caption__source">Starbucks</span></figcaption>
</figure>
<p class="">In addition, Starbucks will also sell &ldquo;Wicked&rdquo;-inspired gift cards. Beginning Nov. 7, fans can also purchase a variety of&nbsp;<a href="https://stories.starbucks.com/press/2024/starbucks-new-wicked-inspired-merchandise-is-thrillifying/" target="_blank" rel="noopener">&ldquo;Oz&rdquo;-related tumblers</a>, with options from the Glinda, Elphaba or Emerald City collections, in addition to other general &ldquo;Wicked&rdquo; choices and a trio of mugs from the &ldquo;Wicked&rdquo; Discovery Series Collection.</p>
<p class="endmark">&ldquo;Wicked,&rdquo;&nbsp;<a href="https://www.today.com/popculture/movies/cynthia-erivo-ariana-grande-wicked-relationship-rcna22767" target="_blank" rel="noopener">starring Ariana Grande and Cynthia Erivo</a>, opens Nov. 22, while &ldquo;Wicked Part Two&rdquo; is slated to open in theaters on Nov. 21, 2025. A promotional blitz for the highly anticipated movie is already underway. &ldquo;<a href="https://www.today.com/food/news/wicked-stanley-cups-target-rcna176099" target="_blank" rel="noopener">Wicked&rdquo; Stanley cups have already been causing chaos at Target</a>, while Walmart seems to already be sold out of its microwaveable &ldquo;<a href="https://www.walmart.com/ip/GREAT-VALUE-2-05-OZ-PURPLE-AND-GREEN-MACARONI-AND-CHEESE-CUP/7972820662" target="_blank" rel="noopener">Wicked&rdquo; Mystery Color Macaroni and Cheese</a>&nbsp;that comes with color-changing pink or green cheese.</p>
</div>', CAST(N'2024-11-14T12:47:38.950' AS DateTime), 1)
INSERT [dbo].[Post] ([PostID], [UserID], [ImgURL], [Heading], [Content], [CreatedDate], [status]) VALUES (55, 17610341, N'blogImg\1729654145418_gettyimages-1235920647.jpg', N'Tostitos and Ruffles add more chips to bags following ‘shrinkflation’ accusations', N'<p class="">Good news for anyone who&rsquo;s griped about the amount of chips in a bag of Tostitos these days.</p>
<p class="">A representative for PepsiCo, the makers of chips that include Tostitos and Ruffles, confirmed to TODAY.com that the company will soon add 20% more chips to &ldquo;bonus&rdquo; bags of Ruffles and Tostitos for the same retail price.</p>
<div id="taboolaReadMoreBelow"></div>
<p class="">The company&rsquo;s decision comes as consumers online are complaining of widespread &ldquo;shrinkflation,&rdquo; that is, paying the same retail price &mdash; or more &mdash; for a product that&rsquo;s now smaller.</p>
<p class="">In 2021, the Consumer World website&nbsp;<a href="https://www.mouseprint.org/?s=tostitos" target="_blank" rel="noopener">reported</a>&nbsp;that a bag of Tostitos&rsquo; &ldquo;Hint of Guacamole&rdquo; chips had shrunk in size from 12 ounces to 11 ounces. The site, which was launched by consumer protection lawyer Edgar Dworsky, also found that a bag of Tostitos &ldquo;Hint of Lime&rdquo; chips had dropped from 13 ounces down to 11.</p>
<p class="">A quick search for #shrinkflation content on X and TikTok shows shoppers annoyed by the skimpier content sizes of everything from&nbsp;<a href="https://x.com/AWholeAmerican/status/1846961370954166302" target="_blank" rel="noopener">Chef Bombay frozen dinners</a>&nbsp;to&nbsp;<a href="https://www.tiktok.com/@realmelissasimo/video/7348183537574530347" target="_blank" rel="noopener">Glad kitchen garbage bags&nbsp;</a>to the now &ldquo;comically small&rdquo;&nbsp;<a href="https://www.tiktok.com/@neilybob/video/7295841383414271278" target="_blank" rel="noopener">McDonald&rsquo;s Filet-O-Fish.</a></p>
<p class="">One TikTok user&nbsp;<a href="https://www.tiktok.com/@someguynameavery/video/7277351645216771370?q=%23shrinkflation&amp;t=1729185353107" target="_blank" rel="noopener">filmed himself opening a snack-size bag of Doritos</a>&nbsp;only to find five chips inside. &ldquo;Five chips!&rdquo; the user yells in frustration while holding up five fingers.</p>
<p class="">The video garnered more than 670 comments from equally irritated shoppers, one of whom wrote, &ldquo;I can&rsquo;t even bring myself to buy chips anymore. To get two handfuls in a $6 bag is maddening!&rdquo;</p>
<p class="">Despite the skimpier packaging sizes, the prices of salty snacks have continued to rise in recent years. In September 2020, the average price of a 16-ounce bag of potato chips was $5.02,&nbsp;<a href="https://fred.stlouisfed.org/series/APU0000718311" target="_blank" rel="noopener">according to the Bureau of Labor Statistics.</a>&nbsp;By September 2024, the price had jumped to $6.46.</p>
<p class="">Everyday consumers aren&rsquo;t the only ones riled up about &ldquo;shrinkflation.&rdquo; Lawmakers are also getting involved.</p>
<p class="">Earlier this month, Sen. Elizabeth Warren of Massachusetts and Rep. Madeleine Dean of Pennsylvania called out PepsiCo, General Mills and Coca-Cola for using shrinkflation tactics as a means to boost their bottom line.</p>
<p class="">The two lawmakers&nbsp;<a href="https://www.nbcnews.com/news/us-news/sen-warren-rep-dean-demand-food-beverage-ceos-stop-shrinkflation-rcna174043" target="_blank" rel="noopener">sent individual letters to each of the companies&rsquo; CEO</a>s, pointing out how they have reduced product sizes while charging the same or a higher retail price.</p>
<p class="">General Mills, for example, reduced the sizes of many of its cereal boxes in 2021, &ldquo;including decreasing &lsquo;Family Size&rsquo; Cocoa Puffs from 19.3 ounces to 18.1 ounces while charging the same price,&rdquo; read their letter to General Mills Chairman and CEO Jeff Harmening.</p>
<p class="">&ldquo;Then, from mid-2021 to mid-2022, General Mills hiked prices five times, and in 2023, your Group President of North American Retail bragged that the company was &lsquo;getting smart about how we look at pricing,&rsquo;&rdquo; it added.</p>
<p class="">The lawmakers&rsquo; letters also accused each of the companies of &ldquo;dodging taxes&rdquo; as part of their &ldquo;pattern of profiteering.&rdquo;</p>
<p class="">&ldquo;People have noticed that their box of Cheerios and bag of Doritos are smaller, but prices are higher &mdash; and at the same time these giant corporations are paying lower tax rates than the average American,&rdquo; Warren said in a statement to NBC News.</p>
<p class="endmark">&ldquo;We can&rsquo;t let them get away with this price gouging and tax dodging. It&rsquo;s just plain wrong, and we&rsquo;re fighting back.&rdquo;</p>', CAST(N'2024-10-23T10:29:05.433' AS DateTime), 0)
INSERT [dbo].[Post] ([PostID], [UserID], [ImgURL], [Heading], [Content], [CreatedDate], [status]) VALUES (56, 17610341, N'http://res.cloudinary.com/dvyu4f7lq/image/upload/v1731563073/td8vfssdqpsmnxqwa9v0.jpg', N'Vietnamese food: The TOP 10 must-try dishes in 2024', N'<p>t&eacute;t</p>', CAST(N'2024-11-14T12:44:33.810' AS DateTime), 0)
INSERT [dbo].[Post] ([PostID], [UserID], [ImgURL], [Heading], [Content], [CreatedDate], [status]) VALUES (57, 17610341, N'http://res.cloudinary.com/dvyu4f7lq/image/upload/v1731618867/lcfnf6oqfu9b4wdp2uli.webp', N'Vietnamese food', N'<p dir="ltr">Vietnamese food has been highly appreciated internationally so far thanks to the global popularity of some prominent dishes, such as Pho. Meanwhile, Vietnamese cuisine is considered as one of the unique cuisines in East Asia. Read this article to know what to eat in your upcoming trip to Vietnam.</p>
<h2 dir="ltr">1. Banh mi - The Vietnamese sandwich</h2>
<p dir="ltr">Banh mi, or the Vietnamese sandwich, is one of the most popular street foods in Vietnam that many tourists want to try. It is considered one of the most prominent remnants of the French colonial period in the South, aside from architectural works, because it was first created in the 19th century and inspired by the French baguette.</p>
<p dir="ltr">Over many years, the locals have changed this Vietnamese food in many ways to adapt to Vietnamese culture. Specifically, inside banh mi, they fill it with many ingredients like pork, egg, cucumber, pickled carrot, daikon radish, scallion and cilantro, depending on the demands of food enthusiasts.</p>
<p dir="ltr">For a lot of people, banh mi is a great suggestion for breakfast, especially for those who have to go to work or school early in the mornings. It is such a cheap and tasty food that it can give people a great start to any busy day. Although banh mi is available across the country, tourists will find the best one in the southern cities, <a href="https://vinpearl.com/en/ho-chi-minh-city-the-top-tips-for-traveling-on-a-budget-in-2022">Ho Chi Minh City</a>, for instance.</p>
<p dir="ltr"><img src="https://lh7-rt.googleusercontent.com/docsz/AD_4nXcODlF7YqfmtDcQRAGzTPZrnowNNbGceu3cJ5OwlLkz2z7I-LF5Eyk0C_KN-fiqM3TQybxIo3J21U0BKfQCJWOHiuiiiMxk-dCJluEvYlnFCsb1oRfZ_gK-h5YAgemAKM-eZmgEqoLUqAWE2RFUV8xOn04H?key=V0TvitZdQv7I7VMigiZAXQ" alt="Vietnamese food" width="602" height="401"></p>
<p dir="ltr">Banh mi contributes to characterizing the Vietnamese food culture (Source: Collected)</p>
<h2 dir="ltr">2. Bun cha - The Vietnamese grilled meat noodles</h2>
<p dir="ltr">Bun cha is a prominent specialty of Hanoi cuisine which any tourist should enjoy once when visiting the capital of the country. Despite being a simple Vietnamese dish, it can satisfy any appetite with its memorable flavor. Rice vermicelli, grilled pork, herbs and fish sauce are all the things that create a unique taste for this dish.</p>
<p dir="ltr">When eating this Vietnamese food, you need to put all the main ingredients into a small bowl and fill it with fish sauce. In particular, the sauce is a mix of chili, garlic, carrot and green papaya. All of these will bring you a distinct sweet and sour flavor which is very suitable for this Vietnamese food and which cannot be found anywhere else.</p>
<p dir="ltr">This Vietnamese food is commonly eaten at lunchtime. Thus, when you get around in Hanoi during this time, you can smell the scent of pork which is grilled over hot charcoal wafts down the sidewalks. This will surely fill your nose and make you immediately hungry.</p>
<p dir="ltr"><img src="https://lh7-rt.googleusercontent.com/docsz/AD_4nXcUPwhpEpZ6CjnZq3gqZwJ1Z2OaePKP8GjgePKUdG0fsohnXtoiBi16lytVqOw8Cmim5MYaMQBBzYxpLGrmgJhZOFs86-jvBAEl2huMIHVx-sifoiwgSA-s4oGeEpmuf_saeqr5xkpPrG03o4xUGfh5WBwv?key=V0TvitZdQv7I7VMigiZAXQ" alt="Vietnamese food" width="602" height="451"></p>
<p dir="ltr">You should enjoy bun cha once in your trip to Hanoi (Source: Collected)</p>
<h2 dir="ltr">3. Pho - The Vietnamese rice noodle soup</h2>
<p dir="ltr">As a pride of Vietnamese cuisine, Pho is definitely not an unpopular food for many tourists because it has been famous all over the world thanks to its unique flavor. This Vietnamese food originated in Hanoi and was first served to diners in the early 20th century. Despite its apparent simplicity, a bowl of Pho can provide tourists a satisfying meal.</p>
<p dir="ltr">The main ingredient of this best food in Vietnam is a type of rice noodles called &ldquo;banh pho&rdquo;, which is larger and flatter than other kinds of rice noodles. Besides, it also consists of broth, herbs and meat, which can typically be sliced beef or chicken. When eating Pho, remember to squeeze some lime juice into the dish and add a dash of pepper or chili flakes for an extra kick of flavor.</p>
<p dir="ltr">With many outstanding features, Pho is known as a quintessential Vietnamese food that international tourists should try once. This food can be eaten at any time of day but people love enjoying it for breakfast. Therefore, in your upcoming trip to Vietnam, start your day with a bowl of Pho before visiting some famous tourist attractions.</p>
<p dir="ltr"><img src="https://lh7-rt.googleusercontent.com/docsz/AD_4nXe5T89LId8xG_Kz6ZXxJzAFn_u1UnlbMkVhEtT_K5rJKRADvxcaCwvD6Dgf0-kkOcXBIQir0Tf70jMYaI7FAECzh5x2UR1g6iYFaqBzevRkZZYAtCnTsos4y6ujUmCsbWrjhQfVbNDIHHkFHdoIk0--K6qx?key=V0TvitZdQv7I7VMigiZAXQ" alt="Vietnamese food" width="602" height="901"></p>
<p dir="ltr">Pho is a traditional food in Vietnam</p>', CAST(N'2024-11-15T04:14:27.880' AS DateTime), 1)
INSERT [dbo].[Post] ([PostID], [UserID], [ImgURL], [Heading], [Content], [CreatedDate], [status]) VALUES (1057, 17610341, N'http://res.cloudinary.com/dvyu4f7lq/image/upload/v1731634253/n5t3urisbgtum5rescub.jpg', N'Big Promotion ', N'<p>asada</p>', CAST(N'2024-11-15T08:30:55.573' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Post] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Status], [ShopID], [CategoryID], [PurchaseCount], [Rating], [ProductImg]) VALUES (10, N'Fresh Orange Juice', N'Made from 100% freshly squeezed oranges, this juice is naturally sweet and packed with vitamin C, giving you a perfect start to your morning.', CAST(249500.00 AS Decimal(18, 2)), 1, 1, 2, 250, CAST(4.00 AS Decimal(3, 2)), NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Status], [ShopID], [CategoryID], [PurchaseCount], [Rating], [ProductImg]) VALUES (11, N'Mocha Latte', N'Rich espresso combined with velvety steamed milk and chocolate syrup, topped with whipped cream and a drizzle of chocolate sauce for indulgence.', CAST(275000.00 AS Decimal(18, 2)), 1, 2, 2, 400, CAST(4.90 AS Decimal(3, 2)), NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Status], [ShopID], [CategoryID], [PurchaseCount], [Rating], [ProductImg]) VALUES (12, N'Lemonade', N'A refreshing homemade lemonade made with fresh lemon juice, cold water, and just a hint of honey, ideal for a hot summer day.', CAST(199500.00 AS Decimal(18, 2)), 0, 1, 2, 300, CAST(4.60 AS Decimal(3, 2)), NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Status], [ShopID], [CategoryID], [PurchaseCount], [Rating], [ProductImg]) VALUES (13, N'Tiramisu', N'This Italian classic dessert features layers of espresso-soaked ladyfingers, creamy mascarpone cheese, and is dusted with cocoa powder for a rich flavor.', CAST(349500.00 AS Decimal(18, 2)), 1, 2, 3, 220, CAST(4.80 AS Decimal(3, 2)), NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Status], [ShopID], [CategoryID], [PurchaseCount], [Rating], [ProductImg]) VALUES (14, N'Cheesecake', N'Our creamy New York-style cheesecake with a buttery graham cracker crust is topped with a sweet strawberry compote for the perfect balance of flavors.', CAST(375000.00 AS Decimal(18, 2)), 1, 1, 3, 350, CAST(4.90 AS Decimal(3, 2)), NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Status], [ShopID], [CategoryID], [PurchaseCount], [Rating], [ProductImg]) VALUES (15, N'Apple Pie', N'A deliciously spiced apple filling wrapped in a flaky golden crust, served warm and topped with a scoop of vanilla ice cream for extra indulgence.', CAST(299500.00 AS Decimal(18, 2)), 1, 2, 3, 300, CAST(4.70 AS Decimal(3, 2)), NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Status], [ShopID], [CategoryID], [PurchaseCount], [Rating], [ProductImg]) VALUES (16, N'Trail Mix', N'A delightful blend of roasted nuts, dried fruits, and a touch of chocolate, perfect for a quick, energizing snack during your busy day.', CAST(175000.00 AS Decimal(18, 2)), 1, 1, 4, 450, CAST(4.50 AS Decimal(3, 2)), NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Status], [ShopID], [CategoryID], [PurchaseCount], [Rating], [ProductImg]) VALUES (17, N'Pretzels', N'Crispy baked pretzels with a hint of salt, offering a satisfying crunch and great for snacking on their own or paired with dips.', CAST(125000.00 AS Decimal(18, 2)), 1, 2, 4, 500, CAST(4.40 AS Decimal(3, 2)), NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Status], [ShopID], [CategoryID], [PurchaseCount], [Rating], [ProductImg]) VALUES (18, N'Popcorn', N'Freshly popped popcorn seasoned lightly with salt and butter, ideal for movie nights or a quick, tasty snack at any time.', CAST(99500.00 AS Decimal(18, 2)), 1, 1, 4, 600, CAST(4.30 AS Decimal(3, 2)), NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Status], [ShopID], [CategoryID], [PurchaseCount], [Rating], [ProductImg]) VALUES (19, N'Iced Green Tea', N'Refreshing iced green tea brewed from high-quality leaves, with a hint of lemon for a balanced and naturally sweet flavor.', CAST(199500.00 AS Decimal(18, 2)), 1, 1, 5, 350, CAST(4.70 AS Decimal(3, 2)), NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Status], [ShopID], [CategoryID], [PurchaseCount], [Rating], [ProductImg]) VALUES (20, N'Sparkling Water', N'Crisp and bubbly sparkling water with a touch of natural lime essence, offering a refreshing and hydrating experience any time of day.', CAST(149500.00 AS Decimal(18, 2)), 1, 2, 5, 200, CAST(4.50 AS Decimal(3, 2)), NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Status], [ShopID], [CategoryID], [PurchaseCount], [Rating], [ProductImg]) VALUES (21, N'Herbal Chamomile Tea', N'Calming chamomile tea made from organic flowers, perfect for relaxation and soothing your senses before bedtime.', CAST(149500.00 AS Decimal(18, 2)), 1, 1, 5, 150, CAST(4.80 AS Decimal(3, 2)), NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Status], [ShopID], [CategoryID], [PurchaseCount], [Rating], [ProductImg]) VALUES (22, N'Grilled Salmon', N'Delicately grilled salmon fillet served with a variety of roasted vegetables, drizzled with a tangy lemon butter sauce for a flavorful experience.', CAST(799500.00 AS Decimal(18, 2)), 1, 1, 1, 200, CAST(4.60 AS Decimal(3, 2)), NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Status], [ShopID], [CategoryID], [PurchaseCount], [Rating], [ProductImg]) VALUES (23, N'Spaghetti Bolognese', N'Classic Italian dish with perfectly cooked spaghetti topped with a slow-cooked, savory meat sauce made from tomatoes, garlic, and ground beef.', CAST(525000.00 AS Decimal(18, 2)), 1, 2, 1, 350, CAST(4.70 AS Decimal(3, 2)), NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Status], [ShopID], [CategoryID], [PurchaseCount], [Rating], [ProductImg]) VALUES (24, N'Vegan Buddha Bowl', N'A nourishing bowl featuring quinoa, roasted sweet potatoes, avocado, chickpeas, and a creamy tahini dressing, offering a balanced and healthy meal.', CAST(600000.00 AS Decimal(18, 2)), 1, 1, 1, 180, CAST(4.50 AS Decimal(3, 2)), NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Status], [ShopID], [CategoryID], [PurchaseCount], [Rating], [ProductImg]) VALUES (25, N'đ', N'sd', CAST(12000.00 AS Decimal(18, 2)), 0, 14, 1, 0, CAST(0.00 AS Decimal(3, 2)), NULL)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductImage] ON 

INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (1, 10, 1, N'https://i.pinimg.com/564x/78/b8/a8/78b8a8068cae03ae1918c553ebb5b59f.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (2, 10, 0, N'https://i.pinimg.com/564x/50/83/f6/5083f664913f20fc6efe9e378f2a62f1.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (3, 10, 0, N'https://i.pinimg.com/564x/e8/bd/db/e8bddb0b456b9b7f8417b5dd6bc6e75b.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (4, 11, 1, N'https://i.pinimg.com/564x/8e/a1/38/8ea138d9fedca1f76cf4310b00e6c452.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (5, 11, 0, N'https://i.pinimg.com/474x/d9/b4/a7/d9b4a7273b8d7bcb0972806fe425144e.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (6, 11, 0, N'https://i.pinimg.com/474x/d1/77/d8/d177d8ae87485414cacd5b7e26792c68.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (7, 12, 1, N'https://i.pinimg.com/control/474x/4d/1e/85/4d1e856247793d122d674af58fb386ad.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (8, 12, 0, N'https://i.pinimg.com/control/474x/2f/88/6a/2f886a2c26919593cb658e76664708e0.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (9, 13, 1, N'https://i.pinimg.com/474x/21/4a/41/214a41d1c28f5f02d4439d129252281e.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (10, 13, 0, N'https://i.pinimg.com/474x/3d/7c/7d/3d7c7d47fad02baf7d903fcce0a7e5e9.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (11, 14, 1, N'https://i.pinimg.com/control/474x/70/0f/11/700f116df1ff53ecc03ca6aa75404ee8.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (12, 14, 0, N'https://i.pinimg.com/474x/02/d3/d5/02d3d53f06208bd21ebf396828a1777d.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (13, 15, 1, N'https://i.pinimg.com/control/474x/ff/02/5b/ff025bc01db3a954679604c06cd73b00.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (14, 15, 0, N'https://i.pinimg.com/control/474x/7d/c5/2a/7dc52a2e06d9c703cce83627dd8c9cc7.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (15, 16, 1, N'https://i.pinimg.com/474x/f1/44/21/f144215b5844b9265879b22952259022.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (16, 16, 0, N'https://i.pinimg.com/474x/b1/80/7f/b1807fb41b72e16edc165a5e85c4e91c.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (17, 17, 1, N'https://i.pinimg.com/control/474x/d5/7a/04/d57a041198ee755555cfd6797308051c.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (18, 17, 0, N'https://i.pinimg.com/control/474x/9d/8c/93/9d8c93ac5dfbebea6dd1ede27aeee719.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (19, 18, 1, N'https://i.pinimg.com/474x/19/73/8d/19738dbeac866d5cff287cb9d8f2822a.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (20, 18, 0, N'https://i.pinimg.com/474x/cb/5b/2f/cb5b2f828cf5c572a36e75e865d1308a.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (21, 19, 1, N'https://i.pinimg.com/474x/80/27/aa/8027aab180b25938201a60897ed17d2c.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (22, 19, 0, N'https://i.pinimg.com/474x/12/3b/10/123b1037d2654b5de3428849287df0c4.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (23, 20, 1, N'https://i.pinimg.com/control/474x/da/1e/af/da1eaff9e88f15d7d9ccd0304d4fa3ff.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (24, 20, 0, N'https://i.pinimg.com/control/474x/44/8a/d2/448ad28a830d3b73d78a31c61b0472ca.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (25, 21, 1, N'https://i.pinimg.com/474x/0b/2f/51/0b2f5103ac649178ceacc418e8f577fc.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (26, 21, 0, N'https://i.pinimg.com/control/474x/ee/38/ab/ee38ab9a3fc95be435c74f75d5adc27a.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (27, 22, 1, N'https://i.pinimg.com/474x/bf/5e/4a/bf5e4ade35d7f69d067975d06ae65bad.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (28, 22, 0, N'https://i.pinimg.com/474x/a6/99/85/a69985621f0a297d34cb8dd1822548af.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (29, 23, 1, N'https://i.pinimg.com/474x/fb/76/4f/fb764fb4308fd0fcc4bfe122a537f903.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (30, 23, 0, N'https://i.pinimg.com/474x/0a/85/75/0a8575a3726b99926282dc42b4b90ebe.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (31, 24, 1, N'https://i.pinimg.com/474x/89/74/69/89746945cde435909f8fa2719908fe4e.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (32, 24, 0, N'https://i.pinimg.com/474x/84/7c/61/847c61710be1177bb997310fdcbcf699.jpg')
INSERT [dbo].[ProductImage] ([ImageID], [ProductID], [IsAvatar], [ImgURL]) VALUES (33, 25, 1, N'http://res.cloudinary.com/dvyu4f7lq/image/upload/v1731634710/er8yads3jiyktfocoacc.jpg')
SET IDENTITY_INSERT [dbo].[ProductImage] OFF
GO
SET IDENTITY_INSERT [dbo].[Refund] ON 

INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (19, 56696095, N'The food is not good', CAST(100000.00 AS Decimal(10, 2)), N'APPROVED', CAST(N'2024-10-22T15:38:17.170' AS DateTime), N'.\refundReasonImg\1729586297123_123-6022-1702524694.jpg', NULL)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (20, 5733596, N'I want to refund', CAST(0.00 AS Decimal(10, 2)), N'REJECTED', CAST(N'2024-10-22T20:01:35.567' AS DateTime), N'.\refundReasonImg\1729602095530_123-6022-1702524694.jpg', NULL)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (21, 60340061, N'Refund Cancel Order', CAST(499000.00 AS Decimal(10, 2)), N'APPROVED', CAST(N'2024-10-23T13:33:59.463' AS DateTime), NULL, NULL)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (22, 76059322, N'Refund Cancel Order', CAST(499000.00 AS Decimal(10, 2)), N'APPROVED', CAST(N'2024-10-23T14:00:11.353' AS DateTime), NULL, NULL)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (23, 42279531, N'Refund Cancel Order', CAST(499000.00 AS Decimal(10, 2)), N'APPROVED', CAST(N'2024-10-25T15:28:01.857' AS DateTime), NULL, NULL)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (24, 85890295, N'Oke', CAST(400000.00 AS Decimal(10, 2)), N'APPROVED', CAST(N'2024-10-25T15:29:52.037' AS DateTime), N'.\refundReasonImg\1729844991992_tostitos-chips-mc-241017-ce0850.webp', NULL)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (25, 98982191, N'Refund Cancel Order', CAST(439120.00 AS Decimal(10, 2)), N'APPROVED', CAST(N'2024-10-25T15:46:17.840' AS DateTime), NULL, NULL)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (26, 34351121, N'Món ăn dỡ', CAST(0.00 AS Decimal(10, 2)), N'PENDING', CAST(N'2024-10-25T15:54:11.583' AS DateTime), N'.\refundReasonImg\1729846451543_tostitos-chips-mc-241017-ce0850.webp', NULL)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (27, 21555074, N'Refund Cancel Order', CAST(439120.00 AS Decimal(10, 2)), N'APPROVED', CAST(N'2024-10-25T16:21:54.907' AS DateTime), NULL, NULL)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (28, 9924942, N'Refund Cancel Order', CAST(499000.00 AS Decimal(10, 2)), N'APPROVED', CAST(N'2024-10-26T14:12:39.047' AS DateTime), NULL, NULL)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (29, 70002699, N'Refund Cancel Order', CAST(499000.00 AS Decimal(10, 2)), N'APPROVED', CAST(N'2024-11-02T10:42:29.230' AS DateTime), NULL, NULL)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (30, 79489035, N'Refund Cancel Order', CAST(499000.00 AS Decimal(10, 2)), N'APPROVED', CAST(N'2024-11-02T11:44:43.203' AS DateTime), NULL, NULL)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (31, 34009934, N'Test', CAST(0.00 AS Decimal(10, 2)), N'PENDING', CAST(N'2024-11-02T13:12:13.820' AS DateTime), N'.\refundReasonImg\1730527933774_R.jpg', NULL)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (32, 48065244, N'hi', CAST(0.00 AS Decimal(10, 2)), N'REJECTED', CAST(N'2024-11-02T13:49:21.447' AS DateTime), N'./refundReasonImg\1730530161422_R.jpg', 1)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (33, 60904904, N'Hello', CAST(374991.00 AS Decimal(10, 2)), N'APPROVED', CAST(N'2024-11-02T14:51:55.373' AS DateTime), N'./refundReasonImg\1730533915351_R.jpg', 1)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (34, 47211916, N'Hi', CAST(0.00 AS Decimal(10, 2)), N'PENDING', CAST(N'2024-11-02T15:13:03.073' AS DateTime), N'./refundReasonImg\1730535183049_R.jpg', 1)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (35, 47211916, N'gffgfgf', CAST(0.00 AS Decimal(10, 2)), N'PENDING', CAST(N'2024-11-02T15:16:42.763' AS DateTime), N'./refundReasonImg\1730535402726_R.jpg', 1)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (36, 47211916, N'HI434', CAST(199000.00 AS Decimal(10, 2)), N'APPROVED', CAST(N'2024-11-02T15:23:49.963' AS DateTime), N'./refundReasonImg\1730535829945_R.jpg', 2)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (1036, 69843160, N'The food is not good', CAST(219560.00 AS Decimal(10, 2)), N'APPROVED', CAST(N'2024-11-15T00:34:37.843' AS DateTime), N'http://res.cloudinary.com/dvyu4f7lq/image/upload/v1731605677/ezzstm55rqh7aiyantfg.jpg', 1)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (1037, 5733596, N'Lỗi', CAST(0.00 AS Decimal(10, 2)), N'REJECTED', CAST(N'2024-11-15T02:27:03.597' AS DateTime), N'http://res.cloudinary.com/dvyu4f7lq/image/upload/v1731612422/krqdwmcuylqzkqpwkajr.jpg', 1)
INSERT [dbo].[Refund] ([RefundID], [OrderId], [RefundReason], [RefundAmount], [RefundStatus], [created_at], [RefundReasonImg], [RefundOption]) VALUES (1038, 85349589, N'not goof', CAST(335000.00 AS Decimal(10, 2)), N'APPROVED', CAST(N'2024-11-15T08:27:40.483' AS DateTime), N'http://res.cloudinary.com/dvyu4f7lq/image/upload/v1731634058/pdyexihftlnorhtvef8b.jpg', 2)
SET IDENTITY_INSERT [dbo].[Refund] OFF
GO
SET IDENTITY_INSERT [dbo].[RewardRedemption] ON 

INSERT [dbo].[RewardRedemption] ([RedemptionID], [UserID], [NumberOfPoint]) VALUES (4, 46325799, 82670)
INSERT [dbo].[RewardRedemption] ([RedemptionID], [UserID], [NumberOfPoint]) VALUES (5, 98292168, 1850)
INSERT [dbo].[RewardRedemption] ([RedemptionID], [UserID], [NumberOfPoint]) VALUES (6, 98292168, -998140)
INSERT [dbo].[RewardRedemption] ([RedemptionID], [UserID], [NumberOfPoint]) VALUES (7, 98292168, -998140)
SET IDENTITY_INSERT [dbo].[RewardRedemption] OFF
GO
SET IDENTITY_INSERT [dbo].[Shop] ON 

INSERT [dbo].[Shop] ([ShopID], [Name], [Description], [Status], [ShopImage], [Address], [TimeOpen], [TimeClose], [ShopWallet]) VALUES (1, N'Hana Chicken', N'Fried chicken restaurants.', 1, N'https://i.pinimg.com/564x/f8/a7/01/f8a70144eb881afe78df0164e657e966.jpg', N'321 ABC, Da Nang, VietNam', CAST(N'09:00:00' AS Time), CAST(N'21:00:00' AS Time), CAST(3532424.00 AS Decimal(10, 2)))
INSERT [dbo].[Shop] ([ShopID], [Name], [Description], [Status], [ShopImage], [Address], [TimeOpen], [TimeClose], [ShopWallet]) VALUES (2, N'Viet Restaurants', N'Hemispheres Steak & Seafood Grill', 1, N'https://i.pinimg.com/564x/a9/14/a1/a914a1fd5994a1997154155256d751cc.jpg', N'321 ABC, Ha Noi, VietNam', CAST(N'10:00:00' AS Time), CAST(N'22:00:00' AS Time), CAST(1.00 AS Decimal(10, 2)))
INSERT [dbo].[Shop] ([ShopID], [Name], [Description], [Status], [ShopImage], [Address], [TimeOpen], [TimeClose], [ShopWallet]) VALUES (3, N'Starbucks', N'Famous for coffee and beverages.', 1, N'https://assets.architecturaldigest.in/photos/63ff4262a3b6ca40fb5805c3/master/w_1600%2Cc_limit/Starbucks%2520Cali%2520Colombia%25201.jpg', N'123 Main St, Ho Chi Minh City, Vietnam', CAST(N'07:00:00' AS Time), CAST(N'23:00:00' AS Time), CAST(1.00 AS Decimal(10, 2)))
INSERT [dbo].[Shop] ([ShopID], [Name], [Description], [Status], [ShopImage], [Address], [TimeOpen], [TimeClose], [ShopWallet]) VALUES (4, N'Highlands Coffee', N'Vietnamese-style coffee shop.', 1, N'https://thicongnhahang.vn/storage/app/media/uploaded-files/thiet-ke-quan-highlands-coffee-1.jpg', N'456 Le Duan, Da Nang, Vietnam', CAST(N'08:00:00' AS Time), CAST(N'22:00:00' AS Time), CAST(1.00 AS Decimal(10, 2)))
INSERT [dbo].[Shop] ([ShopID], [Name], [Description], [Status], [ShopImage], [Address], [TimeOpen], [TimeClose], [ShopWallet]) VALUES (5, N'Pizza Hut', N'Pizza chain offering various types of pizza and pasta.', 1, N'https://cdn.hanamihotel.com/wp-content/uploads/2022/08/Pizza-Hut.jpg?strip=all&lossy=1&ssl=1', N'789 Nguyen Trai, Ha Noi, Vietnam', CAST(N'10:00:00' AS Time), CAST(N'22:00:00' AS Time), CAST(1.00 AS Decimal(10, 2)))
INSERT [dbo].[Shop] ([ShopID], [Name], [Description], [Status], [ShopImage], [Address], [TimeOpen], [TimeClose], [ShopWallet]) VALUES (6, N'KFC', N'Global fast food chain known for fried chicken.', 1, N'https://locations.kfc.com/permanent-b0b701/assets/images/kfc-hero.ed57ffa2.jpg', N'10 Vo Van Kiet, Da Nang, Vietnam', CAST(N'09:00:00' AS Time), CAST(N'21:00:00' AS Time), CAST(1.00 AS Decimal(10, 2)))
INSERT [dbo].[Shop] ([ShopID], [Name], [Description], [Status], [ShopImage], [Address], [TimeOpen], [TimeClose], [ShopWallet]) VALUES (7, N'The Coffee House', N'Popular Vietnamese coffee shop.', 1, N'https://file.hstatic.net/1000075078/file/store_lhp_vt_master.jpg', N'15 Ba Trieu, Ho Chi Minh City, Vietnam', CAST(N'07:00:00' AS Time), CAST(N'23:00:00' AS Time), CAST(1.00 AS Decimal(10, 2)))
INSERT [dbo].[Shop] ([ShopID], [Name], [Description], [Status], [ShopImage], [Address], [TimeOpen], [TimeClose], [ShopWallet]) VALUES (8, N'McDonald''s', N'International fast food chain known for burgers and fries.', 1, N'https://aura.vn/uploads/files/mc.jpg', N'5 Pham Ngoc Thach, Ho Chi Minh City, Vietnam', CAST(N'08:00:00' AS Time), CAST(N'23:00:00' AS Time), CAST(1.00 AS Decimal(10, 2)))
INSERT [dbo].[Shop] ([ShopID], [Name], [Description], [Status], [ShopImage], [Address], [TimeOpen], [TimeClose], [ShopWallet]) VALUES (9, N'Lotteria', N'Popular Asian fast food chain.', 1, N'https://www.dcorp.com.vn/wp-content/uploads/2024/04/nhuong-quyen-lotteria-3.jpeg', N'110 Tran Hung Dao, Ha Noi, Vietnam', CAST(N'09:00:00' AS Time), CAST(N'21:00:00' AS Time), CAST(1.00 AS Decimal(10, 2)))
INSERT [dbo].[Shop] ([ShopID], [Name], [Description], [Status], [ShopImage], [Address], [TimeOpen], [TimeClose], [ShopWallet]) VALUES (10, N'Phuc Long', N'Tea and coffee brand, known for iced tea and milk tea.', 1, N'https://www.worldcoffeeportal.com/getattachment/a819cb30-3a92-4947-8b8c-41f5f89dade5/Phuc-Long-2-(1).jpg.aspx?lang=en-GB&width=700&height=525', N'200 Hai Ba Trung, Ho Chi Minh City, Vietnam', CAST(N'09:00:00' AS Time), CAST(N'23:00:00' AS Time), CAST(1.00 AS Decimal(10, 2)))
INSERT [dbo].[Shop] ([ShopID], [Name], [Description], [Status], [ShopImage], [Address], [TimeOpen], [TimeClose], [ShopWallet]) VALUES (11, N'Jollibee', N'Fast food chain offering fried chicken and burgers.', 1, N'https://queen.jollibee.com.ph/2022/05/8Z1R62ze-About-Jollibee-BGC-Store-min.jpg', N'15 Nguyen Hue, Da Nang, Vietnam', CAST(N'08:00:00' AS Time), CAST(N'22:00:00' AS Time), CAST(1.00 AS Decimal(10, 2)))
INSERT [dbo].[Shop] ([ShopID], [Name], [Description], [Status], [ShopImage], [Address], [TimeOpen], [TimeClose], [ShopWallet]) VALUES (12, N'Burger King', N'American global fast food chain.', 1, N'https://www.cirepartners.com/wp-content/uploads/2021/08/3-1.jpg', N'100 Bui Thi Xuan, Ho Chi Minh City, Vietnam', CAST(N'09:00:00' AS Time), CAST(N'21:00:00' AS Time), CAST(1.00 AS Decimal(10, 2)))
INSERT [dbo].[Shop] ([ShopID], [Name], [Description], [Status], [ShopImage], [Address], [TimeOpen], [TimeClose], [ShopWallet]) VALUES (13, N'Coffe House', N'Nice', 0, N'./restaurantImages/_.......... .......... .......... (1).png', N'Đà Nẵng', CAST(N'22:34:00' AS Time), CAST(N'08:36:00' AS Time), CAST(1.00 AS Decimal(10, 2)))
INSERT [dbo].[Shop] ([ShopID], [Name], [Description], [Status], [ShopImage], [Address], [TimeOpen], [TimeClose], [ShopWallet]) VALUES (14, N'Coffe House', N'ad', 1, N'./restaurantImages/_.......... .......... .......... (1).png', N'Đà Nẵng', CAST(N'22:34:00' AS Time), CAST(N'08:36:00' AS Time), CAST(1.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Shop] OFF
GO
INSERT [dbo].[Users] ([UserID], [UserName], [Pass], [FullName], [PhoneNumber], [Email], [Address], [AvtImg], [ShopID], [Role], [code], [Status]) VALUES (6511874, N'admin', N'$2a$10$VGhcMOYkGA/Sy/KRmlMZ0.B9q8mnHAFCrs797XETYPLkFn66UDlLq', N'Tran Duc Nam', N'0386188917', N'phuctienrt@gmail.com', N'Hue', N'avatarImages\1728993914698_4806755-middle.png', NULL, 2, NULL, 1)
INSERT [dbo].[Users] ([UserID], [UserName], [Pass], [FullName], [PhoneNumber], [Email], [Address], [AvtImg], [ShopID], [Role], [code], [Status]) VALUES (17610341, N'shop13', N'$2a$10$h5hODdVlj7UBiJ1rmWT5Qur5dLjtO32KzN0BFuBFj3T7sRbBh81pS', N'Hana Chicken', N'0386188917', N'phuctienrt@gmail.com', N'Ngu Hanh Son - Da Nang', N'avatarImages\1729607905051_4806755-middle.png', 1, 2, NULL, 1)
INSERT [dbo].[Users] ([UserID], [UserName], [Pass], [FullName], [PhoneNumber], [Email], [Address], [AvtImg], [ShopID], [Role], [code], [Status]) VALUES (19037638, N'hieu12345', N'$2a$10$uV7.JjblJkIn.KMIpmPWzebwIv/KQEeCh7S7r38qc8QQX5AvhGBlO', N'Tran Duc Hieu', N'0386188918', N'hieutrumgsg@gmail.com', NULL, NULL, NULL, 1, NULL, 1)
INSERT [dbo].[Users] ([UserID], [UserName], [Pass], [FullName], [PhoneNumber], [Email], [Address], [AvtImg], [ShopID], [Role], [code], [Status]) VALUES (46325799, N'trtiezph', N'$2a$10$xmuKlZb.Si5tjO.HeWuocupRRLLEeIo1emS8V5VTiaUpwsZAYWOhu', N'Tran Phuc Tien', N'0386188917', N'tientpde180866@fpt.edu.vn', N'26 Le Trung Dinh, Hoa Hai, Ngu Hanh Son', N'http://res.cloudinary.com/dvyu4f7lq/image/upload/v1731562091/acfk8qco3b3uq3zayu52.jpg', NULL, 1, NULL, 1)
INSERT [dbo].[Users] ([UserID], [UserName], [Pass], [FullName], [PhoneNumber], [Email], [Address], [AvtImg], [ShopID], [Role], [code], [Status]) VALUES (83530592, N'coffee', N'$2a$10$OljMfDUMj3Admyepkd5/heBI2wUibBNMK10ddcXqiozmLkc.vROX.', N'coffee', N'0795993433', N'nhs211306@gmail.com', N'Đà Nẵng', NULL, 14, 2, NULL, 1)
INSERT [dbo].[Users] ([UserID], [UserName], [Pass], [FullName], [PhoneNumber], [Email], [Address], [AvtImg], [ShopID], [Role], [code], [Status]) VALUES (98292168, N'hamy123', N'$2a$10$6HXXEcccgHZky7q871W7luu1JOwsvtWnxBtrTp29HFBOaq7hXgbGW', N'Tran Thi Ha My', N'0774540933', N'foodiesystem2004@gmail.com', NULL, NULL, NULL, 1, NULL, 1)
GO
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'06826441', CAST(249500.00 AS Decimal(10, 2)), N'20241114185444', N'00', 9938284)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'09737359', CAST(249500.00 AS Decimal(10, 2)), N'20241114192028', N'00', 35216773)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'12449957', CAST(175560.00 AS Decimal(10, 2)), N'20241022152725', N'00', 56696095)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'12954767', CAST(448500.00 AS Decimal(10, 2)), N'20241114181506', N'00', 56283165)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'14228752', CAST(499000.00 AS Decimal(10, 2)), N'20241026141147', N'00', 9924942)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'15016032', CAST(249500.00 AS Decimal(10, 2)), N'20241114181701', N'00', 64549509)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'15930948', CAST(249500.00 AS Decimal(10, 2)), N'20241114210035', N'00', 87536102)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'17910342', CAST(199500.00 AS Decimal(10, 2)), N'20241102151214', N'00', 47211916)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'18265147', CAST(219560.00 AS Decimal(10, 2)), N'20241115003329', N'00', 69843160)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'20803011', CAST(499000.00 AS Decimal(10, 2)), N'20241102104215', N'00', 70002699)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'21733543', CAST(439120.00 AS Decimal(10, 2)), N'20241025152919', N'00', 85890295)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'23448003', CAST(337500.00 AS Decimal(10, 2)), N'20241022195447', N'00', 5733596)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'24697176', CAST(249500.00 AS Decimal(10, 2)), N'20241114185655', N'00', 93834453)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'26494400', CAST(499000.00 AS Decimal(10, 2)), N'20250412104817', N'00', 16445154)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'29347954', CAST(439120.00 AS Decimal(10, 2)), N'20241025154527', N'00', 98982191)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'36497972', CAST(219560.00 AS Decimal(10, 2)), N'20241115034629', N'00', 35858643)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'37870492', CAST(249500.00 AS Decimal(10, 2)), N'20241114190657', N'00', 79452270)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'39262225', CAST(249500.00 AS Decimal(10, 2)), N'20241115074835', N'02', 92986030)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'42412161', CAST(624500.00 AS Decimal(10, 2)), N'20241205210858', N'00', 25496445)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'43935325', CAST(499000.00 AS Decimal(10, 2)), N'20241114131321', N'00', 61138539)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'43990258', CAST(499000.00 AS Decimal(10, 2)), N'20241025152225', N'00', 42279531)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'48494689', CAST(337500.00 AS Decimal(10, 2)), N'20241115082500', N'00', 85349589)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'50727417', CAST(499000.00 AS Decimal(10, 2)), N'20241026161202', N'00', 28146612)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'52833206', CAST(249500.00 AS Decimal(10, 2)), N'20241114183120', N'00', 10099963)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'54034632', CAST(439120.00 AS Decimal(10, 2)), N'20241025162146', N'00', 21555074)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'54542663', CAST(499000.00 AS Decimal(10, 2)), N'20241026160629', N'00', 60924872)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'55234538', CAST(499000.00 AS Decimal(10, 2)), N'20241023132753', N'00', 60340061)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'57099226', CAST(400000.00 AS Decimal(10, 2)), N'20241114115233', N'00', 42471282)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'60019098', CAST(249500.00 AS Decimal(10, 2)), N'20241114210111', N'00', 28262835)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'72600429', CAST(249500.00 AS Decimal(10, 2)), N'20241114182648', N'00', 54591368)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'73541521', CAST(249500.00 AS Decimal(10, 2)), N'20241114193539', N'00', 15163698)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'74952109', CAST(439120.00 AS Decimal(10, 2)), N'20241025155345', N'00', 34351121)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'78101490', CAST(249500.00 AS Decimal(10, 2)), N'20241115031143', N'00', 13928265)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'81312281', CAST(499000.00 AS Decimal(10, 2)), N'20241115041526', N'00', 69407646)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'81953166', CAST(249500.00 AS Decimal(10, 2)), N'20241114184856', N'00', 1624539)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'82366722', CAST(499000.00 AS Decimal(10, 2)), N'20241102114427', N'00', 79489035)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'83722849', CAST(199600.00 AS Decimal(10, 2)), N'20241115013944', N'00', 43382633)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'86364461', CAST(499000.00 AS Decimal(10, 2)), N'20241023135945', N'00', 76059322)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'87219577', CAST(224550.00 AS Decimal(10, 2)), N'20241115074309', N'00', 29948380)
INSERT [dbo].[VNPay_Bill] ([vnpTxnRef], [vnpAmount], [vnpPayDate], [vnpTransactionStatus], [OrderId]) VALUES (N'92256769', CAST(499000.00 AS Decimal(10, 2)), N'20241026160806', N'00', 3635305)
GO
SET IDENTITY_INSERT [dbo].[withdrawal_requests] ON 

INSERT [dbo].[withdrawal_requests] ([id], [shop_id], [requested_amount], [request_date], [status], [bank_account], [bank_name]) VALUES (1, 1, CAST(33000.00 AS Decimal(10, 2)), CAST(N'2024-11-14T19:46:12.840' AS DateTime), N'rejected', N'1313102004', N'VP Bank')
INSERT [dbo].[withdrawal_requests] ([id], [shop_id], [requested_amount], [request_date], [status], [bank_account], [bank_name]) VALUES (2, 1, CAST(300000.00 AS Decimal(10, 2)), CAST(N'2024-11-15T00:29:47.323' AS DateTime), N'approved', N'1313102004', N'VP Bank')
INSERT [dbo].[withdrawal_requests] ([id], [shop_id], [requested_amount], [request_date], [status], [bank_account], [bank_name]) VALUES (3, 1, CAST(200000.00 AS Decimal(10, 2)), CAST(N'2024-11-15T02:28:00.140' AS DateTime), N'approved', N'1313102004', N'VP Bank')
SET IDENTITY_INSERT [dbo].[withdrawal_requests] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_order_paymentid]    Script Date: 4/13/2025 10:22:11 AM ******/
CREATE NONCLUSTERED INDEX [idx_order_paymentid] ON [dbo].[Order]
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CartItem] ADD  DEFAULT ((1)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Comment] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Discount] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Feedback] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT ((0)) FOR [isRefund]
GO
ALTER TABLE [dbo].[Post] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Post] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [PurchaseCount]
GO
ALTER TABLE [dbo].[Refund] ADD  DEFAULT ('PENDING') FOR [RefundStatus]
GO
ALTER TABLE [dbo].[Refund] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Refund] ADD  DEFAULT ((1)) FOR [RefundOption]
GO
ALTER TABLE [dbo].[Shop] ADD  CONSTRAINT [DF__Shop__ShopWallet__73852659]  DEFAULT ((1.00)) FOR [ShopWallet]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[withdrawal_requests] ADD  DEFAULT (getdate()) FOR [request_date]
GO
ALTER TABLE [dbo].[withdrawal_requests] ADD  DEFAULT ('pending') FOR [status]
GO
ALTER TABLE [dbo].[CartItem]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[CartItem]  WITH CHECK ADD FOREIGN KEY([ShopID])
REFERENCES [dbo].[Shop] ([ShopID])
GO
ALTER TABLE [dbo].[CartItem]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([PostID])
REFERENCES [dbo].[Post] ([PostID])
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Discount]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Favourite]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Favourite]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD FOREIGN KEY([DiscountID])
REFERENCES [dbo].[Discount] ([DiscountID])
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[password_reset_tokens]  WITH CHECK ADD  CONSTRAINT [fk_user] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[password_reset_tokens] CHECK CONSTRAINT [fk_user]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([ShopID])
REFERENCES [dbo].[Shop] ([ShopID])
GO
ALTER TABLE [dbo].[ProductImage]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Refund]  WITH CHECK ADD  CONSTRAINT [FK_Order_ID_Refund] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[Refund] CHECK CONSTRAINT [FK_Order_ID_Refund]
GO
ALTER TABLE [dbo].[RewardRedemption]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[VNPay_Bill]  WITH CHECK ADD  CONSTRAINT [FK_Order_ID] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[VNPay_Bill] CHECK CONSTRAINT [FK_Order_ID]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD CHECK  (([Rating]>=(0) AND [Rating]<=(5)))
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD CHECK  (([PhoneNumber] like '0[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
/****** Object:  Trigger [dbo].[UpdateCartItemQuantity]    Script Date: 4/13/2025 10:22:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[UpdateCartItemQuantity]
ON [dbo].[CartItem]
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @ProductID INT;
    DECLARE @Quantity INT;
    DECLARE @UserID INT;
    DECLARE @ShopID INT;

    SELECT @ProductID = ProductID, @Quantity = Quantity, @UserID = UserID, @ShopID = ShopID FROM inserted;

    IF EXISTS (SELECT 1 FROM CartItem WHERE ProductID = @ProductID AND UserID = @UserID AND ShopID = @ShopID)
    BEGIN

        UPDATE CartItem
        SET Quantity = Quantity + @Quantity
        WHERE ProductID = @ProductID AND UserID = @UserID AND ShopID = @ShopID;
    END 
    ELSE 
    BEGIN

        INSERT INTO CartItem (UserID, ProductID, Quantity, ShopID) 
        VALUES (@UserID, @ProductID, @Quantity, @ShopID);
    END
END;
GO
ALTER TABLE [dbo].[CartItem] ENABLE TRIGGER [UpdateCartItemQuantity]
GO
/****** Object:  Trigger [dbo].[after_discount_use_update]    Script Date: 4/13/2025 10:22:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[after_discount_use_update]
ON [dbo].[Discount]
AFTER UPDATE
AS
BEGIN
    -- Check if the TotalUse has reached or exceeded the NumberOfDiscount
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE inserted.TotalUse >= inserted.NumberOfDiscount
    )
    BEGIN
        -- Lock the discount by setting the Status to 0
        UPDATE Discount
        SET Status = 0
        WHERE DiscountID IN (SELECT DiscountID FROM inserted WHERE inserted.TotalUse >= inserted.NumberOfDiscount);
    END
END
GO
ALTER TABLE [dbo].[Discount] ENABLE TRIGGER [after_discount_use_update]
GO
/****** Object:  Trigger [dbo].[trg_UpdateProductRating]    Script Date: 4/13/2025 10:22:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[trg_UpdateProductRating]
ON [dbo].[Feedback]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    DECLARE @ProductID INT;


    SELECT @ProductID = ProductID FROM inserted;


    UPDATE Product
    SET Rating = (
        SELECT CAST(AVG(CAST(Rating AS FLOAT)) AS DECIMAL(3, 2))
        FROM Feedback
        WHERE ProductID = @ProductID
    )
    WHERE ProductID = @ProductID;
END;
GO
ALTER TABLE [dbo].[Feedback] ENABLE TRIGGER [trg_UpdateProductRating]
GO
/****** Object:  Trigger [dbo].[trg_InsertUser]    Script Date: 4/13/2025 10:22:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[trg_InsertUser]
ON [dbo].[Users]
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @UserID INT;
    DECLARE @UserName VARCHAR(100);
    DECLARE @Pass VARCHAR(255);
    DECLARE @FullName NVARCHAR(50);
    DECLARE @PhoneNumber VARCHAR(10);
    DECLARE @Email VARCHAR(50);
    DECLARE @Address NVARCHAR(50);
    DECLARE @AvtImg NVARCHAR(200);
    DECLARE @ShopID INT;
    DECLARE @Role INT;
    DECLARE @Status BIT; -- Khai báo biến Status

    DECLARE insert_cursor CURSOR FOR
    SELECT UserName, Pass, FullName, PhoneNumber, Email, Address, AvtImg, ShopID, Role, Status
    FROM inserted; -- Thêm Status vào phần SELECT

    OPEN insert_cursor;

    FETCH NEXT FROM insert_cursor INTO @UserName, @Pass, @FullName, @PhoneNumber, @Email, @Address, @AvtImg, @ShopID, @Role, @Status;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        WHILE 1=1
        BEGIN
            SET @UserID = ABS(CHECKSUM(NEWID()) % 100000000);

            IF NOT EXISTS (SELECT 1 FROM Users WHERE UserID = @UserID)
            BEGIN
                INSERT INTO Users (UserID, UserName, Pass, FullName, PhoneNumber, Email, Address, AvtImg, ShopID, Role, Status)
                VALUES (@UserID, @UserName, @Pass, @FullName, @PhoneNumber, @Email, @Address, @AvtImg, @ShopID, @Role, @Status); -- Thêm Status 
                BREAK;
            END
        END

        FETCH NEXT FROM insert_cursor INTO @UserName, @Pass, @FullName, @PhoneNumber, @Email, @Address, @AvtImg, @ShopID, @Role, @Status;
    END

    CLOSE insert_cursor;
    DEALLOCATE insert_cursor;
END;


GO
ALTER TABLE [dbo].[Users] ENABLE TRIGGER [trg_InsertUser]
GO
USE [master]
GO
ALTER DATABASE [ordering_system] SET  READ_WRITE 
GO
