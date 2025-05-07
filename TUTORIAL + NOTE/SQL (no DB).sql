-- CODE CHỈ PHỤC VỤ LÀM WORD

-- Create database
CREATE DATABASE DeAnNhomDatabase;
GO

USE DeAnNhomDatabase5;
GO

-- Create database
CREATE DATABASE DeAnNhomDatabase;
GO

USE DeAnNhomDatabase4;
GO

-- Create tables
CREATE TABLE [dbo].[Category] (
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [CategoryID] [nchar](20) NOT NULL,
    [CategoryImage] [nvarchar](max) NULL,
    [CategoryName] [nvarchar](max) NOT NULL,
    PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);

CREATE TABLE [dbo].[User] (
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
    CONSTRAINT [PK_dbo.User] PRIMARY KEY CLUSTERED ([UserID] ASC)
);

CREATE TABLE [dbo].[Customer] (
    [CustomerID] [nvarchar](128) NOT NULL,
    [Name] [nvarchar](max) NULL,
    [Address] [nvarchar](max) NULL,
    [BirthDay] [datetime] NULL,
    PRIMARY KEY CLUSTERED ([CustomerID] ASC)
);

CREATE TABLE [dbo].[Seller] (
    [SellerID] [nvarchar](128) NOT NULL,
    [ShopName] [nvarchar](max) NULL,
    PRIMARY KEY CLUSTERED ([SellerID] ASC)
);

CREATE TABLE [dbo].[Product] (
    [ProductID] [int] IDENTITY(1,1) NOT NULL,
    [ProductName] [nvarchar](max) NOT NULL,
    [Decription] [nvarchar](max) NOT NULL,
    [Price] [decimal](18, 2) NOT NULL,
    [Sizes] [nvarchar](max) NOT NULL,
    [Quantity] [int] NOT NULL,
    [ProductImage] [nvarchar](max) NOT NULL,
    [Sold] [int] NOT NULL DEFAULT 0,
    [CreatedAt] [datetime] NOT NULL,
    [CategoryID] [nchar](20) NOT NULL,
    [SellerID] [nvarchar](128) NOT NULL,
    PRIMARY KEY CLUSTERED ([ProductID] ASC)
);

CREATE TABLE [dbo].[OrderPro] (
    [OrderID] [int] IDENTITY(1,1) NOT NULL,
    [DateOrder] [date] NOT NULL,
    [CustomerID] [nvarchar](128) NOT NULL,
    PRIMARY KEY CLUSTERED ([OrderID] ASC)
);

CREATE TABLE [dbo].[OrderDetail] (
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [ProductID] [int] NOT NULL,
    [OrderID] [int] NOT NULL,
    [Quantity] [int] NOT NULL,
    [UnitPrice] [float] NOT NULL,
    [Sizes] [nvarchar](max) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE [dbo].[Roles] (
    [Id] [nvarchar](128) NOT NULL,
    [Name] [nvarchar](256) NOT NULL,
    CONSTRAINT [PK_dbo.Roles] PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [dbo].[UserClaims] (
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [UserId] [nvarchar](max) NULL,
    [ClaimType] [nvarchar](max) NULL,
    [ClaimValue] [nvarchar](max) NULL,
    [IdentityUser_Id] [nvarchar](128) NULL,
    CONSTRAINT [PK_dbo.UserClaims] PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [dbo].[UserLogins] (
    [LoginProvider] [nvarchar](128) NOT NULL,
    [ProviderKey] [nvarchar](128) NOT NULL,
    [UserId] [nvarchar](128) NOT NULL,
    [IdentityUser_Id] [nvarchar](128) NULL,
    CONSTRAINT [PK_dbo.UserLogins] PRIMARY KEY CLUSTERED ([LoginProvider] ASC, [ProviderKey] ASC, [UserId] ASC)
);

CREATE TABLE [dbo].[UserRoles] (
    [UserId] [nvarchar](128) NOT NULL,
    [RoleId] [nvarchar](128) NOT NULL,
    [IdentityUser_Id] [nvarchar](128) NULL,
    CONSTRAINT [PK_dbo.UserRoles] PRIMARY KEY CLUSTERED ([UserId] ASC, [RoleId] ASC)
);

-- Create indexes
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[Roles] ([Name] ASC);
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[User] ([UserName] ASC);
CREATE NONCLUSTERED INDEX [IX_IdentityUser_Id] ON [dbo].[UserClaims] ([IdentityUser_Id] ASC);
CREATE NONCLUSTERED INDEX [IX_IdentityUser_Id] ON [dbo].[UserLogins] ([IdentityUser_Id] ASC);
CREATE NONCLUSTERED INDEX [IX_IdentityUser_Id] ON [dbo].[UserRoles] ([IdentityUser_Id] ASC);
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[UserRoles] ([RoleId] ASC);

-- Add foreign key constraints
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [FK_User_Customer] FOREIGN KEY([CustomerID]) REFERENCES [dbo].[User] ([UserID]);
ALTER TABLE [dbo].[Seller] ADD CONSTRAINT [FK_Seller_User] FOREIGN KEY([SellerID]) REFERENCES [dbo].[User] ([UserID]);
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [FK_Pro_Category] FOREIGN KEY([CategoryID]) REFERENCES [dbo].[Category] ([CategoryID]);
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [FK_Pro_User] FOREIGN KEY([SellerID]) REFERENCES [dbo].[Seller] ([SellerID]);
ALTER TABLE [dbo].[OrderPro] ADD CONSTRAINT [FK_OrderPro_Customer] FOREIGN KEY([CustomerID]) REFERENCES [dbo].[Customer] ([CustomerID]);
ALTER TABLE [dbo].[OrderDetail] ADD CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([ProductID]) REFERENCES [dbo].[Product] ([ProductID]);
ALTER TABLE [dbo].[OrderDetail] ADD CONSTRAINT [FK_OrderDetail_OrderPro] FOREIGN KEY([OrderID]) REFERENCES [dbo].[OrderPro] ([OrderID]);
ALTER TABLE [dbo].[UserClaims] ADD CONSTRAINT [FK_dbo.UserClaims_dbo.User_IdentityUser_Id] FOREIGN KEY([IdentityUser_Id]) REFERENCES [dbo].[User] ([UserID]);
ALTER TABLE [dbo].[UserLogins] ADD CONSTRAINT [FK_dbo.UserLogins_dbo.User_IdentityUser_Id] FOREIGN KEY([IdentityUser_Id]) REFERENCES [dbo].[User] ([UserID]);
ALTER TABLE [dbo].[UserRoles] ADD CONSTRAINT [FK_dbo.UserRoles_dbo.Roles_RoleId] FOREIGN KEY([RoleId]) REFERENCES [dbo].[Roles] ([Id]) ON DELETE CASCADE;
ALTER TABLE [dbo].[UserRoles] ADD CONSTRAINT [FK_dbo.UserRoles_dbo.User_IdentityUser_Id] FOREIGN KEY([IdentityUser_Id]) REFERENCES [dbo].[User] ([UserID]);
