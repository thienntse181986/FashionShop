USE [master]
GO
/****** Object:  Database [fashion_store]    Script Date: 3/14/2025 7:44:46 AM ******/
CREATE DATABASE [fashion_store]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'fashion_store', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\fashion_store.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'fashion_store_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\fashion_store_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [fashion_store] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [fashion_store].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [fashion_store] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [fashion_store] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [fashion_store] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [fashion_store] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [fashion_store] SET ARITHABORT OFF 
GO
ALTER DATABASE [fashion_store] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [fashion_store] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [fashion_store] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [fashion_store] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [fashion_store] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [fashion_store] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [fashion_store] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [fashion_store] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [fashion_store] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [fashion_store] SET  ENABLE_BROKER 
GO
ALTER DATABASE [fashion_store] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [fashion_store] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [fashion_store] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [fashion_store] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [fashion_store] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [fashion_store] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [fashion_store] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [fashion_store] SET RECOVERY FULL 
GO
ALTER DATABASE [fashion_store] SET  MULTI_USER 
GO
ALTER DATABASE [fashion_store] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [fashion_store] SET DB_CHAINING OFF 
GO
ALTER DATABASE [fashion_store] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [fashion_store] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [fashion_store] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'fashion_store', N'ON'
GO
ALTER DATABASE [fashion_store] SET QUERY_STORE = OFF
GO
USE [fashion_store]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [fashion_store]
GO
/****** Object:  Table [dbo].[category]    Script Date: 3/14/2025 7:44:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[categoryID] [int] IDENTITY(1,1) NOT NULL,
	[categoryName] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[discount]    Script Date: 3/14/2025 7:44:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[discount](
	[discountID] [int] IDENTITY(1,1) NOT NULL,
	[code] [nvarchar](50) NULL,
	[discountValue] [decimal](10, 2) NULL,
	[status] [nvarchar](20) NULL,
	[used] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[discountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[order_detail]    Script Date: 3/14/2025 7:44:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_detail](
	[orderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[quantity] [int] NULL,
	[price] [decimal](10, 2) NULL,
	[subtotal]  AS ([quantity]*[price]) PERSISTED,
	[orderID] [int] NULL,
	[productID] [int] NULL,
	[sizeID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[orderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[orders]    Script Date: 3/14/2025 7:44:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[orderID] [int] IDENTITY(1,1) NOT NULL,
	[orderDate] [date] NULL,
	[totalPrice] [decimal](10, 2) NULL,
	[address] [nvarchar](100) NULL,
	[status] [nvarchar](20) NULL,
	[userID] [int] NULL,
	[discountID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[product_sizes]    Script Date: 3/14/2025 7:44:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_sizes](
	[productID] [int] NOT NULL,
	[sizeID] [int] NOT NULL,
	[quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[productID] ASC,
	[sizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[products]    Script Date: 3/14/2025 7:45:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[productID] [int] IDENTITY(1,1) NOT NULL,
	[productName] [nvarchar](50) NULL,
	[price] [decimal](10, 2) NULL,
	[color] [nvarchar](15) NULL,
	[img] [nvarchar](255) NULL,
	[description] [nvarchar](500) NULL,
	[categoryID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sizes]    Script Date: 3/14/2025 7:45:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sizes](
	[sizeID] [int] IDENTITY(1,1) NOT NULL,
	[sizeName] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[sizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users]    Script Date: 3/14/2025 7:45:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](60) NULL,
	[password] [nvarchar](60) NULL,
	[email] [nvarchar](60) NULL,
	[fullName] [nvarchar](60) NULL,
	[phone] [nvarchar](15) NULL,
	[address] [nvarchar](100) NULL,
	[role] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([categoryID], [categoryName]) VALUES (2, N'Shorts')
INSERT [dbo].[category] ([categoryID], [categoryName]) VALUES (1, N'T-Shirt')
SET IDENTITY_INSERT [dbo].[category] OFF
SET IDENTITY_INSERT [dbo].[discount] ON 

INSERT [dbo].[discount] ([discountID], [code], [discountValue], [status], [used]) VALUES (1, N'SALE10', CAST(10.00 AS Decimal(10, 2)), NULL, 1)
INSERT [dbo].[discount] ([discountID], [code], [discountValue], [status], [used]) VALUES (2, N'SUMMER20', CAST(20.00 AS Decimal(10, 2)), NULL, 1)
INSERT [dbo].[discount] ([discountID], [code], [discountValue], [status], [used]) VALUES (3, N'VIP30', CAST(30.00 AS Decimal(10, 2)), NULL, 0)
SET IDENTITY_INSERT [dbo].[discount] OFF
SET IDENTITY_INSERT [dbo].[order_detail] ON 

INSERT [dbo].[order_detail] ([orderDetailID], [quantity], [price], [orderID], [productID], [sizeID]) VALUES (58, 1, CAST(550000.00 AS Decimal(10, 2)), 79, 10, 3)
INSERT [dbo].[order_detail] ([orderDetailID], [quantity], [price], [orderID], [productID], [sizeID]) VALUES (59, 1, CAST(300000.00 AS Decimal(10, 2)), 80, 18, 3)
INSERT [dbo].[order_detail] ([orderDetailID], [quantity], [price], [orderID], [productID], [sizeID]) VALUES (60, 1, CAST(550000.00 AS Decimal(10, 2)), 81, 9, 3)
INSERT [dbo].[order_detail] ([orderDetailID], [quantity], [price], [orderID], [productID], [sizeID]) VALUES (61, 1, CAST(550000.00 AS Decimal(10, 2)), 82, 13, 3)
INSERT [dbo].[order_detail] ([orderDetailID], [quantity], [price], [orderID], [productID], [sizeID]) VALUES (62, 1, CAST(300000.00 AS Decimal(10, 2)), 82, 16, 3)
INSERT [dbo].[order_detail] ([orderDetailID], [quantity], [price], [orderID], [productID], [sizeID]) VALUES (63, 1, CAST(550000.00 AS Decimal(10, 2)), 83, 8, 3)
INSERT [dbo].[order_detail] ([orderDetailID], [quantity], [price], [orderID], [productID], [sizeID]) VALUES (64, 1, CAST(550000.00 AS Decimal(10, 2)), 84, 8, 2)
INSERT [dbo].[order_detail] ([orderDetailID], [quantity], [price], [orderID], [productID], [sizeID]) VALUES (65, 1, CAST(550000.00 AS Decimal(10, 2)), 85, 9, 3)
INSERT [dbo].[order_detail] ([orderDetailID], [quantity], [price], [orderID], [productID], [sizeID]) VALUES (66, 1, CAST(550000.00 AS Decimal(10, 2)), 86, 12, 3)
SET IDENTITY_INSERT [dbo].[order_detail] OFF
SET IDENTITY_INSERT [dbo].[orders] ON 

INSERT [dbo].[orders] ([orderID], [orderDate], [totalPrice], [address], [status], [userID], [discountID]) VALUES (79, CAST(N'2025-03-13' AS Date), CAST(550000.00 AS Decimal(10, 2)), N'297 Chu Van An', N'Processing', 2, NULL)
INSERT [dbo].[orders] ([orderID], [orderDate], [totalPrice], [address], [status], [userID], [discountID]) VALUES (80, CAST(N'2025-03-13' AS Date), CAST(300000.00 AS Decimal(10, 2)), N'297 Chu Van An', N'Processing', 2, NULL)
INSERT [dbo].[orders] ([orderID], [orderDate], [totalPrice], [address], [status], [userID], [discountID]) VALUES (81, CAST(N'2025-03-14' AS Date), CAST(550000.00 AS Decimal(10, 2)), N'297 Chu Van An', N'Processing', 2, NULL)
INSERT [dbo].[orders] ([orderID], [orderDate], [totalPrice], [address], [status], [userID], [discountID]) VALUES (82, CAST(N'2025-03-14' AS Date), CAST(850000.00 AS Decimal(10, 2)), N'297 Chu Van An', N'Processing', 4, NULL)
INSERT [dbo].[orders] ([orderID], [orderDate], [totalPrice], [address], [status], [userID], [discountID]) VALUES (83, CAST(N'2025-03-14' AS Date), CAST(550000.00 AS Decimal(10, 2)), N'297 Chu Van An', N'Processing', 4, NULL)
INSERT [dbo].[orders] ([orderID], [orderDate], [totalPrice], [address], [status], [userID], [discountID]) VALUES (84, CAST(N'2025-03-14' AS Date), CAST(550000.00 AS Decimal(10, 2)), N'', N'Processing', 2, NULL)
INSERT [dbo].[orders] ([orderID], [orderDate], [totalPrice], [address], [status], [userID], [discountID]) VALUES (85, CAST(N'2025-03-14' AS Date), CAST(550000.00 AS Decimal(10, 2)), N'297 Chu Van An', N'Processing', 2, NULL)
INSERT [dbo].[orders] ([orderID], [orderDate], [totalPrice], [address], [status], [userID], [discountID]) VALUES (86, CAST(N'2025-03-14' AS Date), CAST(550000.00 AS Decimal(10, 2)), N'297 Chu Van An', N'Processing', 2, NULL)
SET IDENTITY_INSERT [dbo].[orders] OFF
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (1, 1, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (1, 2, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (1, 3, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (8, 1, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (8, 2, 9)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (8, 3, 9)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (9, 1, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (9, 2, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (9, 3, 8)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (10, 1, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (10, 2, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (10, 3, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (11, 1, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (11, 2, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (11, 3, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (12, 1, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (12, 2, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (12, 3, 9)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (13, 1, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (13, 2, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (13, 3, 9)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (14, 1, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (14, 2, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (14, 3, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (15, 1, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (15, 2, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (15, 3, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (16, 1, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (16, 2, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (16, 3, 9)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (17, 1, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (17, 2, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (17, 3, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (18, 1, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (18, 2, 10)
INSERT [dbo].[product_sizes] ([productID], [sizeID], [quantity]) VALUES (18, 3, 10)
SET IDENTITY_INSERT [dbo].[products] ON 

INSERT [dbo].[products] ([productID], [productName], [price], [color], [img], [description], [categoryID]) VALUES (1, N'AT POLO YOURS', CAST(550000.00 AS Decimal(10, 2)), N'Navy', N'img/product1.jpg', N'Áo thun cotton 100%', 1)
INSERT [dbo].[products] ([productID], [productName], [price], [color], [img], [description], [categoryID]) VALUES (8, N'AT THUN GREY YOURS', CAST(550000.00 AS Decimal(10, 2)), N'Grey', N'img/product2.webp', N'Áo thun cotton 100%', 1)
INSERT [dbo].[products] ([productID], [productName], [price], [color], [img], [description], [categoryID]) VALUES (9, N'AO SOMI WHITE YOURS', CAST(550000.00 AS Decimal(10, 2)), N'White', N'img/product3.webp', N'Áo thun cotton 100%', 1)
INSERT [dbo].[products] ([productID], [productName], [price], [color], [img], [description], [categoryID]) VALUES (10, N'AO SOMI NAVY YOURS', CAST(550000.00 AS Decimal(10, 2)), N'Navy', N'img/product4.webp', N'Áo thun cotton 100%', 1)
INSERT [dbo].[products] ([productID], [productName], [price], [color], [img], [description], [categoryID]) VALUES (11, N'AT BASIC LONG', CAST(550000.00 AS Decimal(10, 2)), N'Black', N'img/product5.webp', N'Áo thun cotton 100%', 1)
INSERT [dbo].[products] ([productID], [productName], [price], [color], [img], [description], [categoryID]) VALUES (12, N'AT BASIC LINEN LONG', CAST(550000.00 AS Decimal(10, 2)), N'Brown', N'img/product6.webp', N'Áo thun cotton 100%', 1)
INSERT [dbo].[products] ([productID], [productName], [price], [color], [img], [description], [categoryID]) VALUES (13, N'AT THUN POLO YOURS', CAST(550000.00 AS Decimal(10, 2)), N'Black', N'img/product7.webp', N'Áo thun cotton 100%', 1)
INSERT [dbo].[products] ([productID], [productName], [price], [color], [img], [description], [categoryID]) VALUES (14, N'SHORTS BASIC YOURS', CAST(300000.00 AS Decimal(10, 2)), N'Black', N'img/shorts1.webp', N'Cotton 100%', 2)
INSERT [dbo].[products] ([productID], [productName], [price], [color], [img], [description], [categoryID]) VALUES (15, N'SHORTS CAMOU YOURS', CAST(300000.00 AS Decimal(10, 2)), N'Black', N'img/shorts2.webp', N'Cotton 100%', 2)
INSERT [dbo].[products] ([productID], [productName], [price], [color], [img], [description], [categoryID]) VALUES (16, N'SHORTS ACTIVE YOURS', CAST(300000.00 AS Decimal(10, 2)), N'Black', N'img/shorts3.webp', N'Cotton 100%', 2)
INSERT [dbo].[products] ([productID], [productName], [price], [color], [img], [description], [categoryID]) VALUES (17, N'SHORTS DUST YOURS', CAST(300000.00 AS Decimal(10, 2)), N'Black', N'img/shorts4.webp', N'Cotton 100%', 2)
INSERT [dbo].[products] ([productID], [productName], [price], [color], [img], [description], [categoryID]) VALUES (18, N'SHORTS FLEX YOURS', CAST(300000.00 AS Decimal(10, 2)), N'Black', N'img/shorts5.webp', N'Cotton 100%', 2)
INSERT [dbo].[products] ([productID], [productName], [price], [color], [img], [description], [categoryID]) VALUES (23, N'SHORTS WARIOR YOURS	', CAST(300000.00 AS Decimal(10, 2)), N'Black', N'img/shorts6.webp', N'Cotton 100%', 2)
SET IDENTITY_INSERT [dbo].[products] OFF
SET IDENTITY_INSERT [dbo].[sizes] ON 

INSERT [dbo].[sizes] ([sizeID], [sizeName]) VALUES (3, N'L')
INSERT [dbo].[sizes] ([sizeID], [sizeName]) VALUES (2, N'M')
INSERT [dbo].[sizes] ([sizeID], [sizeName]) VALUES (1, N'S')
SET IDENTITY_INSERT [dbo].[sizes] OFF
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([userID], [username], [password], [email], [fullName], [phone], [address], [role]) VALUES (1, N'admin', N'admin', N'admin@example.com', N'Quản Trị Viên', N'0987654321', N'Hà N?i', N'admin')
INSERT [dbo].[users] ([userID], [username], [password], [email], [fullName], [phone], [address], [role]) VALUES (2, N'thinh', N'thinh', N'thinhbo17032004@gmail.com', N'sss', N'9396661123', N'297 Chu Van An', N'customer')
INSERT [dbo].[users] ([userID], [username], [password], [email], [fullName], [phone], [address], [role]) VALUES (3, N'jane_smith', N'pass456', N'jane@example.com', N'Jane Smith', N'0345678912', N'Ðà N?ng', N'customer')
INSERT [dbo].[users] ([userID], [username], [password], [email], [fullName], [phone], [address], [role]) VALUES (4, N'huysidu', N'123', N'thinh', N'thinh', N'9999', N'HCM', N'customer')
INSERT [dbo].[users] ([userID], [username], [password], [email], [fullName], [phone], [address], [role]) VALUES (6, N'1', N'1', NULL, NULL, NULL, NULL, N'admin')
SET IDENTITY_INSERT [dbo].[users] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__category__37077ABD6763C1AD]    Script Date: 3/14/2025 7:45:08 AM ******/
ALTER TABLE [dbo].[category] ADD UNIQUE NONCLUSTERED 
(
	[categoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__discount__357D4CF9682FFBC9]    Script Date: 3/14/2025 7:45:08 AM ******/
ALTER TABLE [dbo].[discount] ADD UNIQUE NONCLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__products__0A9CBBE00C182897]    Script Date: 3/14/2025 7:45:08 AM ******/
ALTER TABLE [dbo].[products] ADD UNIQUE NONCLUSTERED 
(
	[productName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__sizes__DE4E1556D6F72372]    Script Date: 3/14/2025 7:45:08 AM ******/
ALTER TABLE [dbo].[sizes] ADD UNIQUE NONCLUSTERED 
(
	[sizeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__users__AB6E61643755EEE6]    Script Date: 3/14/2025 7:45:08 AM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__users__F3DBC572820261CF]    Script Date: 3/14/2025 7:45:08 AM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[discount] ADD  DEFAULT ('active') FOR [status]
GO
ALTER TABLE [dbo].[discount] ADD  DEFAULT ((0)) FOR [used]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT (getdate()) FOR [orderDate]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT ('processing') FOR [status]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ('customer') FOR [role]
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD FOREIGN KEY([orderID])
REFERENCES [dbo].[orders] ([orderID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD FOREIGN KEY([productID])
REFERENCES [dbo].[products] ([productID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD  CONSTRAINT [fk_order_detail_size] FOREIGN KEY([sizeID])
REFERENCES [dbo].[sizes] ([sizeID])
GO
ALTER TABLE [dbo].[order_detail] CHECK CONSTRAINT [fk_order_detail_size]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([userID])
REFERENCES [dbo].[users] ([userID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD  CONSTRAINT [FK_orders_discount] FOREIGN KEY([discountID])
REFERENCES [dbo].[discount] ([discountID])
GO
ALTER TABLE [dbo].[orders] CHECK CONSTRAINT [FK_orders_discount]
GO
ALTER TABLE [dbo].[product_sizes]  WITH CHECK ADD FOREIGN KEY([productID])
REFERENCES [dbo].[products] ([productID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[product_sizes]  WITH CHECK ADD FOREIGN KEY([sizeID])
REFERENCES [dbo].[sizes] ([sizeID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD FOREIGN KEY([categoryID])
REFERENCES [dbo].[category] ([categoryID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[discount]  WITH CHECK ADD CHECK  (([discountValue]>(0)))
GO
ALTER TABLE [dbo].[discount]  WITH CHECK ADD CHECK  (([status]='used' OR [status]='active'))
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD CHECK  (([price]>(0)))
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD CHECK  (([quantity]>(0)))
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD CHECK  (([status]='canceled' OR [status]='successful' OR [status]='delivering' OR [status]='processing'))
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD CHECK  (([totalPrice]>(0)))
GO
ALTER TABLE [dbo].[product_sizes]  WITH CHECK ADD CHECK  (([quantity]>=(0)))
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD CHECK  (([price]>(0)))
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD CHECK  (([role]='admin' OR [role]='customer'))
GO
USE [master]
GO
ALTER DATABASE [fashion_store] SET  READ_WRITE 
GO
