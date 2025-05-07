CREATE DATABASE DeAnNhomDatabase;
GO

-- Sử dụng cơ sở dữ liệu EPL
USE DeAnNhomDatabase;
GO

CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [nchar](20) NOT NULL,
	[CategoryImage] [nvarchar](max) NULL,
	[CategoryName] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 10/6/2023 1:13:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Address] [nvarchar](max) NULL,
	[BirthDay] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 10/6/2023 1:13:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [float] NOT NULL,
	[Sizes] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderPro]    Script Date: 10/6/2023 1:13:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderPro](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[DateOrder] [date] NOT NULL,
	[CustomerID] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 10/6/2023 1:13:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](max) NOT NULL,
	[Decription] [nvarchar](max) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Sizes] [nvarchar](max) NOT NULL,
	[Quantity] [int] NOT NULL,
	[ProductImage] [nvarchar](max) NOT NULL,
	[Sold] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[CategoryID] [nchar](20) NOT NULL,
	[SellerID] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 10/6/2023 1:13:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seller]    Script Date: 10/6/2023 1:13:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seller](
	[SellerID] [nvarchar](128) NOT NULL,
	[ShopName] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[SellerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 10/6/2023 1:13:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [nvarchar](128) NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[ProfileImg] [nvarchar](max) NULL,
	[Genders] [bit] NULL,
	[JoinedDate] [datetime] NULL,
	[Email] [nvarchar](256) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[Discriminator] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserClaims]    Script Date: 10/6/2023 1:13:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](max) NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
	[IdentityUser_Id] [nvarchar](128) NULL,
 CONSTRAINT [PK_dbo.UserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLogins]    Script Date: 10/6/2023 1:13:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[IdentityUser_Id] [nvarchar](128) NULL,
 CONSTRAINT [PK_dbo.UserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 10/6/2023 1:13:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
	[IdentityUser_Id] [nvarchar](128) NULL,
 CONSTRAINT [PK_dbo.UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [CategoryID], [CategoryImage], [CategoryName]) VALUES (3, N'1                   ', N'~/Content/Images/Category/anime.jpg', N'Anime')
INSERT [dbo].[Category] ([Id], [CategoryID], [CategoryImage], [CategoryName]) VALUES (12, N'10                  ', N'~/Content/Images/Category/washing_machine.jpg', N'Máy giặt')
INSERT [dbo].[Category] ([Id], [CategoryID], [CategoryImage], [CategoryName]) VALUES (4, N'2                   ', N'~/Content/Images/Category/manga.jpg', N'Manga')
INSERT [dbo].[Category] ([Id], [CategoryID], [CategoryImage], [CategoryName]) VALUES (5, N'3                   ', N'~/Content/Images/Category/light_novel.jpg', N'Light Novel')
INSERT [dbo].[Category] ([Id], [CategoryID], [CategoryImage], [CategoryName]) VALUES (6, N'4                   ', N'~/Content/Images/Category/phone.jpg', N'Điện Thoại')
INSERT [dbo].[Category] ([Id], [CategoryID], [CategoryImage], [CategoryName]) VALUES (7, N'5                   ', N'~/Content/Images/Category/tablet.jpg', N'Máy Tính Bảng')
INSERT [dbo].[Category] ([Id], [CategoryID], [CategoryImage], [CategoryName]) VALUES (8, N'6                   ', N'~/Content/Images/Category/pc.jpg', N'PC')
INSERT [dbo].[Category] ([Id], [CategoryID], [CategoryImage], [CategoryName]) VALUES (9, N'7                   ', N'~/Content/Images/Category/laptop_work.jpg', N'Laptop Làm Việc')
INSERT [dbo].[Category] ([Id], [CategoryID], [CategoryImage], [CategoryName]) VALUES (10, N'8                   ', N'~/Content/Images/Category/laptop_gaming.jpg', N'Laptop Gaming')
INSERT [dbo].[Category] ([Id], [CategoryID], [CategoryImage], [CategoryName]) VALUES (11, N'9                   ', N'~/Content/Images/Category/air_conditioner.jpg', N'Máy lạnh')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
INSERT [dbo].[Customer] ([CustomerID], [Name], [Address], [BirthDay]) VALUES (N'28e3bd95-e186-45f5-a9c1-dcd736d4360d', N'admin69@admin.com', NULL, NULL)
INSERT [dbo].[Customer] ([CustomerID], [Name], [Address], [BirthDay]) VALUES (N'6ab61599-5ded-4e84-b5ce-d4d843401bdd', N'admin6969@admin.com', NULL, NULL)
INSERT [dbo].[Customer] ([CustomerID], [Name], [Address], [BirthDay]) VALUES (N'84523507-a2c0-4247-bc41-24f13b267210', N'beater@gmail.com', NULL, NULL)
INSERT [dbo].[Customer] ([CustomerID], [Name], [Address], [BirthDay]) VALUES (N'c6a15dfa-9051-41da-bf69-233018d7db87', N'adminmakoto@gmail.com', NULL, CAST(N'2023-10-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([CustomerID], [Name], [Address], [BirthDay]) VALUES (N'eb340ea9-434e-46f2-a143-0c52dd602734', N'admin@admin.com', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([ID], [ProductID], [OrderID], [Quantity], [UnitPrice], [Sizes]) VALUES (1, 3, 1, 2, 15000000, N'6.6"')
INSERT [dbo].[OrderDetail] ([ID], [ProductID], [OrderID], [Quantity], [UnitPrice], [Sizes]) VALUES (2, 23, 2, 2, 120000, N'Vừa')
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderPro] ON 

INSERT [dbo].[OrderPro] ([OrderID], [DateOrder], [CustomerID]) VALUES (1, CAST(N'2022-11-20' AS Date), N'eb340ea9-434e-46f2-a143-0c52dd602734')
INSERT [dbo].[OrderPro] ([OrderID], [DateOrder], [CustomerID]) VALUES (2, CAST(N'2022-11-20' AS Date), N'eb340ea9-434e-46f2-a143-0c52dd602734')
SET IDENTITY_INSERT [dbo].[OrderPro] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [ProductName], [Decription], [Price], [Sizes], [Quantity], [ProductImage], [Sold], [CreatedAt], [CategoryID], [SellerID]) VALUES (3, N'Samsung Galaxy A13', N'Chip Exynos 850 | RAM: 6 GB | ROM: 128GB | PIN: 5000 mAH ', CAST(15000000.00 AS Decimal(18, 2)), N'6.6"', 98, N'https://cdn.tgdd.vn/Products/Images/42/234315/samsung-galaxy-a32-4g-thumb-xanh-600x600-600x600.jpg', 3, CAST(N'2015-10-25T00:00:00.000' AS DateTime), N'4                   ', N'eb340ea9-434e-46f2-a143-0c52dd602734')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Decription], [Price], [Sizes], [Quantity], [ProductImage], [Sold], [CreatedAt], [CategoryID], [SellerID]) VALUES (15, N'Móc khóa kim loại Nguyên Tố Vision GENSHIN IMPACT', N'Mốc khóa dành cho mấy bạn fan Genshin Impact', CAST(65000.00 AS Decimal(18, 2)), N'Nhỏ', 69, N'https://salt.tikicdn.com/cache/750x750/ts/product/41/6a/07/7023e723b88449f0c2853dbb6727e343.png.webp', 10, CAST(N'2015-10-25T00:00:00.000' AS DateTime), N'2                   ', N'eb340ea9-434e-46f2-a143-0c52dd602734')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Decription], [Price], [Sizes], [Quantity], [ProductImage], [Sold], [CreatedAt], [CategoryID], [SellerID]) VALUES (17, N'GVN VIPER Plus i3060 - White Edition', N'RAM: Corsair Vengeance Pro RGB 16GB (2x8GB) 3200 White', CAST(28999000.00 AS Decimal(18, 2)), N'To', 131, N'https://product.hstatic.net/200000722513/product/post-06_221c2e5761d340c29693d189a94369b7_master.jpg', 69, CAST(N'2022-10-30T00:00:00.000' AS DateTime), N'6                   ', N'eb340ea9-434e-46f2-a143-0c52dd602734')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Decription], [Price], [Sizes], [Quantity], [ProductImage], [Sold], [CreatedAt], [CategoryID], [SellerID]) VALUES (18, N'Casper Inverter 1 HP IC-09TL32', N'Máy lạnh siêu mát', CAST(50000000.00 AS Decimal(18, 2)), N'To', 213, N'https://cdn.tgdd.vn/Products/Images/2002/268972/casper-ic-09tl32-1.-550x160.jpg', 10, CAST(N'2015-10-10T00:00:00.000' AS DateTime), N'9                   ', N'eb340ea9-434e-46f2-a143-0c52dd602734')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Decription], [Price], [Sizes], [Quantity], [ProductImage], [Sold], [CreatedAt], [CategoryID], [SellerID]) VALUES (19, N'Doraemon - Bộ Truyện Ngắn 45 Tập (lẻ cuốn tùy chọn)', N'Tập 1 đến 45 đều có', CAST(17100.00 AS Decimal(18, 2)), N'Vừa', 15602, N'https://product.hstatic.net/200000343865/product/1_d942c5b5a1ec43a6b8cc1b8b23e48cae_master.jpg', 123, CAST(N'2015-10-16T00:00:00.000' AS DateTime), N'2                   ', N'eb340ea9-434e-46f2-a143-0c52dd602734')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Decription], [Price], [Sizes], [Quantity], [ProductImage], [Sold], [CreatedAt], [CategoryID], [SellerID]) VALUES (23, N'86-EIGHTY SIX- Ep.6 - Tặng Kèm Phong Bì + Postcard Giấy Có Đế Dựng', N'Kiêu hãnh chiến đấu, rồi hi sinh. Số phận của Tám Sáu là vậy. Lòng ham sống đã bị họ bỏ lại ở quá khứ rất xa...', CAST(120000.00 AS Decimal(18, 2)), N'Vừa', 498, N'https://cdn0.fahasa.com/media/catalog/product/8/6/86-vol-6_bia-1_1.jpg', 102, CAST(N'2022-05-05T00:00:00.000' AS DateTime), N'3                   ', N'eb340ea9-434e-46f2-a143-0c52dd602734')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Decription], [Price], [Sizes], [Quantity], [ProductImage], [Sold], [CreatedAt], [CategoryID], [SellerID]) VALUES (24, N'Samsung Galaxy S23 Ultra ', N'THÔNG TIN SẢN PHẨM:
Samsung Galaxy S23 Ultra là chiếc smartphone cao cấp nhất của nhà Samsung, sở hữu cấu hình không tưởng với con chip khủng được Qualcomm tối ưu riêng cho dòng Galaxy và camera lên đến 200 MP, xứng danh là chiếc flagship Android được mong đợi nhất trong năm 2023.

Tuy nhiên kiểu bo cong này sẽ hơi thiên hướng phẳng một chút so với S22 Ultra, điều này mang đến cho mình trải nghiệm cầm nắm chắc tay hơn, song cũng mang lại cảm giác dễ chịu cho những lúc sử dụng liên tục trong thời gian dài.

Về màu sắc, năm nay Samsung cũng đã cho ra các phiên bản màu như: Tím, kem, xanh và đen. Nhìn chung thì đây là những màu sắc cực kỳ sang trọng và lịch lãm, phù hợp cho các bạn trẻ năng động, mạnh mẽ và đặc biệt là những khách hàng đang là doanh nhân bởi ngoại hình đẳng cấp và thanh lịch.

Hiện trên tay mình là bản màu xanh đặc trưng của Samsung, màu này vừa đem đến sự trẻ trung tươi mới và cũng vừa mang trên mình một gam màu tối để có thể giữ được vẻ huyền bí đầy mê hoặc.

THÔNG SỐ SẢN PHẨM:
Kích thước: 163.4 x 78.1 x 8.9 mm
Trọng lượng: 233g
Màn hình: Dynamic AMOLED 2X 6.8 inch
Tần số quét: 120Hz
Camera trước: 12MP
Camera sau: 200MP + 10MP +12MP
Chip xử lý: Snapdragon 8 Gen 2
RAM: 8GB/16GB
Bộ nhớ trong: 1TB/512GB/256GB
Dung lượng pin: 5000 mAh
Công nghệ sạc: Có dây 45W, không dây 15W, không dây ngược 4.5W', CAST(24000000.00 AS Decimal(18, 2)), N'TIÊU CHUẨN;VỪA', 100069, N'~/Content/Images/Product/638321511143681889_aa00d4d7-a4f6-43d7-a752-14fa728e6014.jpg', 0, CAST(N'2023-10-06T01:05:14.347' AS DateTime), N'4                   ', N'c6a15dfa-9051-41da-bf69-233018d7db87')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
INSERT [dbo].[Roles] ([Id], [Name]) VALUES (N'29ff95d1-0fad-4062-936c-982c1884edc6', N'Admin')
INSERT [dbo].[Roles] ([Id], [Name]) VALUES (N'a9afbe54-24e2-4665-98e1-5cd114232ed8', N'Customer')
INSERT [dbo].[Roles] ([Id], [Name]) VALUES (N'd9f5a16e-bed4-4f66-836c-381011b97f89', N'Seller')
GO
INSERT [dbo].[Seller] ([SellerID], [ShopName]) VALUES (N'6ab61599-5ded-4e84-b5ce-d4d843401bdd', N'Anime')
INSERT [dbo].[Seller] ([SellerID], [ShopName]) VALUES (N'c6a15dfa-9051-41da-bf69-233018d7db87', N'Anime shop 2')
INSERT [dbo].[Seller] ([SellerID], [ShopName]) VALUES (N'eb340ea9-434e-46f2-a143-0c52dd602734', N'Makoto-kun')
GO
INSERT [dbo].[User] ([UserID], [UserName], [ProfileImg], [Genders], [JoinedDate], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [EmailConfirmed], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [Discriminator]) VALUES (N'28e3bd95-e186-45f5-a9c1-dcd736d4360d', N'admin69@admin.com', N'https://www.bsn.eu/wp-content/uploads/2016/12/user-icon-image-placeholder-300-grey.jpg', NULL, CAST(N'2023-10-05T09:47:26.600' AS DateTime), N'admin69@admin.com', NULL, N'ANbyyh+pLPJOEkMuN+HP18+T1xKInv8gHqRA7Omq/G4111WBqifJtPVevfDZYmCUGg==', N'b80dcaf6-d2ea-41d4-93b0-9090ff619016', 0, 0, 0, NULL, 1, 0, N'ApplicationUser')
INSERT [dbo].[User] ([UserID], [UserName], [ProfileImg], [Genders], [JoinedDate], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [EmailConfirmed], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [Discriminator]) VALUES (N'6ab61599-5ded-4e84-b5ce-d4d843401bdd', N'admin6969@admin.com', N'https://www.bsn.eu/wp-content/uploads/2016/12/user-icon-image-placeholder-300-grey.jpg', NULL, CAST(N'2023-10-05T10:18:29.967' AS DateTime), N'admin6969@admin.com', NULL, N'AHJJHpf6trSyKKhw8QBgIY8ACJ8voyd07v7bxPHza8u3leHidatTbr4kKLEhXtN1cg==', N'4420ccf2-c5b6-46ec-80cc-7c14082a6797', 0, 0, 0, NULL, 1, 0, N'ApplicationUser')
INSERT [dbo].[User] ([UserID], [UserName], [ProfileImg], [Genders], [JoinedDate], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [EmailConfirmed], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [Discriminator]) VALUES (N'84523507-a2c0-4247-bc41-24f13b267210', N'beater@gmail.com', N'https://www.bsn.eu/wp-content/uploads/2016/12/user-icon-image-placeholder-300-grey.jpg', NULL, CAST(N'2023-10-05T10:49:15.477' AS DateTime), N'beater@gmail.com', NULL, N'AGei1GP7xCenitMnrR9xJcdb4ooVcron6c9ptgAfx27lpEIa13okahMlqknCHo3WBg==', N'02519c65-1a4e-4df9-abc8-c3b8415e1360', 0, 0, 0, NULL, 1, 0, N'ApplicationUser')
INSERT [dbo].[User] ([UserID], [UserName], [ProfileImg], [Genders], [JoinedDate], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [EmailConfirmed], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [Discriminator]) VALUES (N'c6a15dfa-9051-41da-bf69-233018d7db87', N'adminmakoto@gmail.com', N'~/Content/Images/User/c6a15dfa-9051-41da-bf69-233018d7db87.jpg', NULL, CAST(N'2023-10-05T10:47:52.393' AS DateTime), N'adminmakoto@gmail.com', NULL, N'ACItDLcNx1W5mb9brINMFi8d3FPMYQbZ+JbKAVodtf5KAmOvLD9M0qBHoYxDFXcPoA==', N'c2570c41-f86c-4b7d-b8bf-135f9cac25f8', 0, 0, 0, NULL, 1, 0, N'ApplicationUser')
INSERT [dbo].[User] ([UserID], [UserName], [ProfileImg], [Genders], [JoinedDate], [Email], [PhoneNumber], [PasswordHash], [SecurityStamp], [EmailConfirmed], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [Discriminator]) VALUES (N'eb340ea9-434e-46f2-a143-0c52dd602734', N'admin@admin.com', N'https://www.bsn.eu/wp-content/uploads/2016/12/user-icon-image-placeholder-300-grey.jpg', NULL, CAST(N'2022-11-20T03:07:59.350' AS DateTime), N'admin@admin.com', NULL, N'APQqXENGR3lOyuFSdWgvB9W72YmS91nB8iI9JFLLM8s4QQZjifAf/ubojwx63j7Lvg==', N'c38adfe2-c0dd-4a49-b45f-2f623faabc28', 0, 0, 0, NULL, 1, 0, N'ApplicationUser')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'28e3bd95-e186-45f5-a9c1-dcd736d4360d', N'a9afbe54-24e2-4665-98e1-5cd114232ed8', NULL)
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'6ab61599-5ded-4e84-b5ce-d4d843401bdd', N'a9afbe54-24e2-4665-98e1-5cd114232ed8', NULL)
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'6ab61599-5ded-4e84-b5ce-d4d843401bdd', N'd9f5a16e-bed4-4f66-836c-381011b97f89', NULL)
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'84523507-a2c0-4247-bc41-24f13b267210', N'a9afbe54-24e2-4665-98e1-5cd114232ed8', NULL)
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'c6a15dfa-9051-41da-bf69-233018d7db87', N'29ff95d1-0fad-4062-936c-982c1884edc6', NULL)
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'c6a15dfa-9051-41da-bf69-233018d7db87', N'a9afbe54-24e2-4665-98e1-5cd114232ed8', NULL)
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'c6a15dfa-9051-41da-bf69-233018d7db87', N'd9f5a16e-bed4-4f66-836c-381011b97f89', NULL)
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'eb340ea9-434e-46f2-a143-0c52dd602734', N'a9afbe54-24e2-4665-98e1-5cd114232ed8', NULL)
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'eb340ea9-434e-46f2-a143-0c52dd602734', N'd9f5a16e-bed4-4f66-836c-381011b97f89', NULL)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 10/6/2023 1:13:19 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[Roles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 10/6/2023 1:13:19 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[User]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_IdentityUser_Id]    Script Date: 10/6/2023 1:13:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_IdentityUser_Id] ON [dbo].[UserClaims]
(
	[IdentityUser_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_IdentityUser_Id]    Script Date: 10/6/2023 1:13:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_IdentityUser_Id] ON [dbo].[UserLogins]
(
	[IdentityUser_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_IdentityUser_Id]    Script Date: 10/6/2023 1:13:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_IdentityUser_Id] ON [dbo].[UserRoles]
(
	[IdentityUser_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_RoleId]    Script Date: 10/6/2023 1:13:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[UserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [Sold]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_User_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_User_Customer]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[OrderPro] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[OrderPro]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Pro_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Pro_Category]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Pro_User] FOREIGN KEY([SellerID])
REFERENCES [dbo].[Seller] ([SellerID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Pro_User]
GO
ALTER TABLE [dbo].[Seller]  WITH CHECK ADD  CONSTRAINT [FK_Seller_User] FOREIGN KEY([SellerID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Seller] CHECK CONSTRAINT [FK_Seller_User]
GO
ALTER TABLE [dbo].[UserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserClaims_dbo.User_IdentityUser_Id] FOREIGN KEY([IdentityUser_Id])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[UserClaims] CHECK CONSTRAINT [FK_dbo.UserClaims_dbo.User_IdentityUser_Id]
GO
ALTER TABLE [dbo].[UserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserLogins_dbo.User_IdentityUser_Id] FOREIGN KEY([IdentityUser_Id])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[UserLogins] CHECK CONSTRAINT [FK_dbo.UserLogins_dbo.User_IdentityUser_Id]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserRoles_dbo.Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_dbo.UserRoles_dbo.Roles_RoleId]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserRoles_dbo.User_IdentityUser_Id] FOREIGN KEY([IdentityUser_Id])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_dbo.UserRoles_dbo.User_IdentityUser_Id]
GO
USE [master]
GO
ALTER DATABASE [DeAnNhomDatabase] SET  READ_WRITE 
GO
