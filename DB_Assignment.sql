USE [master]
GO
CREATE DATABASE [PRJ_Assignment]

USE [PRJ_Assignment]

CREATE TABLE [dbo].[account](
	[username] [nvarchar](50) NOT NULL,
	[fullname] [nvarchar](50) NOT NULL,
	[mail] [varchar](200) NULL,
	[password] [nvarchar](50) NOT NULL,
	[roleID] [bit] NOT NULL,
 CONSTRAINT [PK_account] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cart]    Script Date: 2/23/2024 12:33:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart](
	[username] [nvarchar](50) NOT NULL,
	[productID] [nvarchar](50) NOT NULL,
	[quantity] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orderdetail]    Script Date: 2/23/2024 12:33:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderdetail](
	[orderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[productID] [nvarchar](50) NOT NULL,
	[orderID] [int] NULL,
	[price] [decimal](18, 0) NULL,
	[quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[orderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orderuser]    Script Date: 2/23/2024 12:33:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderuser](
	[orderID] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[date] [date] NULL,
	[total] [decimal](18, 0) NULL,
	[phone] [nvarchar](15) NOT NULL,
	[address] [nvarchar](max) NOT NULL,
	[status] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product]    Script Date: 2/23/2024 12:33:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[productID] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[price] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[productdetail]    Script Date: 2/23/2024 12:33:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[productdetail](
	[productID] [nvarchar](50) NOT NULL,
	[size] [nvarchar](50) NOT NULL,
	[color] [nvarchar](50) NOT NULL,
	[description] [nvarchar](max) NOT NULL,
	[stock] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[productimg]    Script Date: 2/23/2024 12:33:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[productimg](
	[productID] [nvarchar](50) NOT NULL,
	[img] [nvarchar](50) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD  CONSTRAINT [FK_cart_account] FOREIGN KEY([username])
REFERENCES [dbo].[account] ([username])
GO
ALTER TABLE [dbo].[cart] CHECK CONSTRAINT [FK_cart_account]
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD  CONSTRAINT [FK_cart_productdetail] FOREIGN KEY([productID])
REFERENCES [dbo].[product] ([productID])
GO
ALTER TABLE [dbo].[cart] CHECK CONSTRAINT [FK_cart_productdetail]
GO
ALTER TABLE [dbo].[orderdetail]  WITH CHECK ADD FOREIGN KEY([orderID])
REFERENCES [dbo].[orderuser] ([orderID])
GO
ALTER TABLE [dbo].[orderdetail]  WITH CHECK ADD FOREIGN KEY([productID])
REFERENCES [dbo].[product] ([productID])
GO
ALTER TABLE [dbo].[orderuser]  WITH CHECK ADD FOREIGN KEY([username])
REFERENCES [dbo].[account] ([username])
GO
ALTER TABLE [dbo].[productdetail]  WITH CHECK ADD  CONSTRAINT [FK_productdetail_product] FOREIGN KEY([productID])
REFERENCES [dbo].[product] ([productID])
GO
ALTER TABLE [dbo].[productdetail] CHECK CONSTRAINT [FK_productdetail_product]
GO
ALTER TABLE [dbo].[productimg]  WITH CHECK ADD  CONSTRAINT [FK_productimg_productdetail] FOREIGN KEY([productID])
REFERENCES [dbo].[product] ([productID])
GO
ALTER TABLE [dbo].[productimg] CHECK CONSTRAINT [FK_productimg_productdetail]
GO
USE [master]
GO
ALTER DATABASE [PRJ_Assignment] SET  READ_WRITE 
GO

/*** INSERT DATA ***/
INSERT INTO [account] ([username], [fullname], [mail], [password], [roleID])
VALUES
    ('admin', 'Admin', 'admin@gmail.com', '1234', 1),
    ('user1', 'Minh Duc', 'user1@example.com', '123', 0),
    ('user2', 'Dang To', 'user2@example.com', '123', 0),
	('user3', 'Tsan', 'user3@example.com', '123', 0),
	('user4', 'Yen Vy', 'user4@example.com', '123', 0);

INSERT INTO [product] ([productID], [name], [price])
VALUES
    ('PROD1A', 'Samsung Galaxy S24 5G', 931),
	('PROD1B', 'Samsung Galaxy S24 5G', 1074),
    ('PROD1C', 'Samsung Galaxy S24 5G', 931),
    ('PROD1D', 'Samsung Galaxy S24 5G', 1074),
	('PROD2A', 'Samsung Galaxy A14', 118),
	('PROD2B', 'Samsung Galaxy A14', 143),
	('PROD2C', 'Samsung Galaxy A14', 118),
	('PROD2D', 'Samsung Galaxy A14', 143),
	('PROD3A', 'Samsung Galaxy Z Flip5 5G', 1063),
	('PROD3B', 'Samsung Galaxy Z Flip5 5G', 1063),
	('PROD4A', 'iPhone 14 Pro Max', 1117),
	('PROD4B', 'iPhone 14 Pro Max', 1182),
	('PROD4C', 'iPhone 14 Pro Max', 1117),
	('PROD4D', 'iPhone 14 Pro Max', 1182),
	('PROD5A', 'iPhone 13', 611),
	('PROD5B', 'iPhone 13', 732),
	('PROD5C', 'iPhone 13', 611),
	('PROD5D', 'iPhone 13', 732),
	('PROD6A', 'iPhone 15 Pro', 1120),
	('PROD6B', 'iPhone 15 Pro', 1222),
	('PROD6C', 'iPhone 15 Pro', 1120),
	('PROD6D', 'iPhone 15 Pro', 1222),
	('PROD7A', 'OPPO Reno11 5G', 434),
	('PROD7B', 'OPPO Reno11 5G', 434),
	('PROD8A', 'OPPO A57', 178),
	('PROD8B', 'OPPO A57', 178),
	('PROD9A', 'OPPO Find N2 Flip 5G', 773),
	('PROD9B', 'OPPO Find N2 Flip 5G', 773),
	('PROD10A', 'Xiaomi Redmi Note 12 Pro', 236),
	('PROD10B', 'Xiaomi Redmi Note 12 Pro', 236),
	('PROD11A', 'Xiaomi 13T 5G', 427),
	('PROD11B', 'Xiaomi 13T 5G', 468),
	('PROD11C', 'Xiaomi 13T 5G', 427),
	('PROD11D', 'Xiaomi 13T 5G', 468),
	('PROD12A', 'Xiaomi Redmi 12', 142),
	('PROD12B', 'Xiaomi Redmi 12', 154),
	('PROD12C', 'Xiaomi Redmi 12', 142),
	('PROD12D', 'Xiaomi Redmi 12', 154);

INSERT INTO [productdetail] ([productID], [size], [color], [description], [quantity])
VALUES
    ('PROD1A', '256GB', 'Yellow', 'Screen: Dynamic AMOLED 2X6.2"Full HD+; Operating system: Android 14; Rear camera: Main 50 MP & Secondary 12 MP, 10 MP; Front camera: 12 MP; Chip: Exynos 2400; RAM: 8GB', 10),
	('PROD1B', '512GB', 'Yellow', 'Screen: Dynamic AMOLED 2X6.2"Full HD+; Operating system: Android 14; Rear camera: Main 50 MP & Secondary 12 MP, 10 MP; Front camera: 12 MP; Chip: Exynos 2400; RAM: 8GB', 8),
    ('PROD1C', '256GB', 'Black', 'Screen: Dynamic AMOLED 2X6.2"Full HD+; Operating system: Android 14; Rear camera: Main 50 MP & Secondary 12 MP, 10 MP; Front camera: 12 MP; Chip: Exynos 2400; RAM: 8GB', 6),
    ('PROD1D', '512GB', 'Black', 'Screen: Dynamic AMOLED 2X6.2"Full HD+; Operating system: Android 14; Rear camera: Main 50 MP & Secondary 12 MP, 10 MP; Front camera: 12 MP; Chip: Exynos 2400; RAM: 8GB', 4),
    ('PROD2A', '4GB', 'Red', 'Screen: PLS LCD6.6"Full HD+; Operating system: Android 13; Rear camera: Main 50 MP & Secondary 5 MP, 2 MP; Front camera: 13 MP; Chip: Exynos 850', 11),
    ('PROD2B', '6GB', 'Red', 'Screen: PLS LCD6.6"Full HD+; Operating system: Android 13; Rear camera: Main 50 MP & Secondary 5 MP, 2 MP; Front camera: 13 MP; Chip: Exynos 850', 9),
    ('PROD2C', '4GB', 'Black', 'Screen: PLS LCD6.6"Full HD+; Operating system: Android 13; Rear camera: Main 50 MP & Secondary 5 MP, 2 MP; Front camera: 13 MP; Chip: Exynos 850', 5),
    ('PROD2D', '6GB', 'Black', 'Screen: PLS LCD6.6"Full HD+; Operating system: Android 13; Rear camera: Main 50 MP & Secondary 5 MP, 2 MP; Front camera: 13 MP; Chip: Exynos 850', 7),
	('PROD3A', '256GB', 'Purple', 'Screen: Main: Dynamic AMOLED 2X, Secondary: Super AMOLED Main 6.7" & Secondary 3.4" Full HD+; Operating system: Android 13; Rear camera: 2 12 MP cameras; Front camera: 10 MP; Chip: Snapdragon 8 Gen 2 for Galaxy; RAM: 8 GB', 4),
	('PROD3B', '256GB', 'Grey', 'Screen: Main: Dynamic AMOLED 2X, Secondary: Super AMOLED Main 6.7" & Secondary 3.4" Full HD+; Operating system: Android 13; Rear camera: 2 12 MP cameras; Front camera: 10 MP; Chip: Snapdragon 8 Gen 2 for Galaxy; RAM: 8 GB', 3),
	('PROD4A', '128GB', 'Purple', 'Screen: OLED 6.7" Super Retina XDR; Operating system: iOS 16; Rear camera: Main 48 MP & Secondary 12 MP, 12 MP; Front camera: 12 MP; Chip: Apple A16 Bionic; RAM: 6 GB', 6),
	('PROD4B', '256GB', 'Purple', 'Screen: OLED 6.7" Super Retina XDR; Operating system: iOS 16; Rear camera: Main 48 MP & Secondary 12 MP, 12 MP; Front camera: 12 MP; Chip: Apple A16 Bionic; RAM: 6 GB', 3),
	('PROD4C', '128GB', 'Black', 'Screen: OLED 6.7" Super Retina XDR; Operating system: iOS 16; Rear camera: Main 48 MP & Secondary 12 MP, 12 MP; Front camera: 12 MP; Chip: Apple A16 Bionic; RAM: 6 GB', 2),
	('PROD4D', '256GB', 'Black', 'Screen: OLED 6.7" Super Retina XDR; Operating system: iOS 16; Rear camera: Main 48 MP & Secondary 12 MP, 12 MP; Front camera: 12 MP; Chip: Apple A16 Bionic; RAM: 6 GB', 5),
	('PROD5A', '128GB', 'Pink', 'Screen: OLED 6.1" Super Retina XDR; Operating system: iOS 15; Rear camera: 2 12 MP cameras; Front camera: 12 MP; Chip: Apple A15 Bionic; RAM: 4 GB', 8),
	('PROD5B', '256GB', 'Pink', 'Screen: OLED 6.1" Super Retina XDR; Operating system: iOS 15; Rear camera: 2 12 MP cameras; Front camera: 12 MP; Chip: Apple A15 Bionic; RAM: 4 GB', 10),
	('PROD5C', '128GB', 'Blue', 'Screen: OLED 6.1" Super Retina XDR; Operating system: iOS 15; Rear camera: 2 12 MP cameras; Front camera: 12 MP; Chip: Apple A15 Bionic; RAM: 4 GB', 6),
	('PROD5D', '256GB', 'Blue', 'Screen: OLED 6.1" Super Retina XDR; Operating system: iOS 15; Rear camera: 2 12 MP cameras; Front camera: 12 MP; Chip: Apple A15 Bionic; RAM: 4 GB', 4),
	('PROD6A', '128GB', 'Black Titanium', 'Screen: OLED 6.1" Super Retina XDR; Operating system: iOS 17; Rear camera: Main 48 MP & Secondary 12 MP, 12 MP; Front camera: 12 MP; Chip: Apple A17 Pro 6 core', 3),
	('PROD6B', '256GB', 'Black Titanium', 'Screen: OLED 6.1" Super Retina XDR; Operating system: iOS 17; Rear camera: Main 48 MP & Secondary 12 MP, 12 MP; Front camera: 12 MP; Chip: Apple A17 Pro 6 core', 2),
	('PROD6C', '128GB', 'White Titanium', 'Screen: OLED 6.1" Super Retina XDR; Operating system: iOS 17; Rear camera: Main 48 MP & Secondary 12 MP, 12 MP; Front camera: 12 MP; Chip: Apple A17 Pro 6 core', 5),
	('PROD6D', '256GB', 'White Titanium', 'Screen: OLED 6.1" Super Retina XDR; Operating system: iOS 17; Rear camera: Main 48 MP & Secondary 12 MP, 12 MP; Front camera: 12 MP; Chip: Apple A17 Pro 6 core', 2),
	('PROD7A', '256GB', 'Green', 'Screen: AMOLED6.7"Full HD+; Operating system: Android 14; Rear camera: Main 50 MP & Secondary 32 MP, 8 MP; Front camera: 32 MP; Chip: MediaTek Dimensity 7050 5G 8 core; RAM: 8 GB', 11),
	('PROD7B', '256GB', 'Grey', 'Screen: AMOLED6.7"Full HD+; Operating system: Android 14; Rear camera: Main 50 MP & Secondary 32 MP, 8 MP; Front camera: 32 MP; Chip: MediaTek Dimensity 7050 5G 8 core; RAM: 8 GB', 9),
	('PROD8A', '128GB', 'Yellow', 'Screen: IPS LCD6.56"HD+; Operating system: Android 12; Rear camera: Main 13 MP & Secondary 2 MP; Front camera: 8 MP; Chip: MediaTek Helio G35; RAM: 4 GB', 8),
	('PROD8B', '128GB', 'Green', 'Screen: IPS LCD6.56"HD+; Operating system: Android 12; Rear camera: Main 13 MP & Secondary 2 MP; Front camera: 8 MP; Chip: MediaTek Helio G35; RAM: 4 GB', 6),
	('PROD9A', '256GB', 'Black', 'Screen: AMOLED Main 6.8" & Secondary 3.26" Full HD+; Operating system: Android 13; Rear camera: Main 50 MP & Secondary 8 MP; Front camera: 32 MP; Chip: MediaTek Dimensity 9000+ 8 cores; RAM: 8 GB', 3),
	('PROD9B', '256GB', 'Purple', 'Screen: AMOLED Main 6.8" & Secondary 3.26" Full HD+; Operating system: Android 13; Rear camera: Main 50 MP & Secondary 8 MP; Front camera: 32 MP; Chip: MediaTek Dimensity 9000+ 8 cores; RAM: 8 GB', 2),
	('PROD10A', '128GB', 'Blue', 'Screen: AMOLED 6.67" Full HD+; Operating system: Android 11; Rear camera: Main 108 MP & Secondary 8 MP, 2 MP, 2 MP; Front camera: 16 MP; Chip: Snapdragon 732G; RAM: 8 GB', 8),
	('PROD10B', '128GB', 'Grey', 'Screen: AMOLED 6.67" Full HD+; Operating system: Android 11; Rear camera: Main 108 MP & Secondary 8 MP, 2 MP, 2 MP; Front camera: 16 MP; Chip: Snapdragon 732G; RAM: 8 GB', 6),
	('PROD11A', '8GB', 'Blue', 'Screen: AMOLED6.67" 1.5K; Operating system: Android 13; Rear camera: Main 50 MP & Secondary 50 MP, 12 MP; Front camera: 20 MP; Chip: MediaTek Dimensity 8200-Ultra; RAM: 8 GB', 7),
	('PROD11B', '12GB', 'Blue', 'Screen: AMOLED6.67" 1.5K; Operating system: Android 13; Rear camera: Main 50 MP & Secondary 50 MP, 12 MP; Front camera: 20 MP; Chip: MediaTek Dimensity 8200-Ultra; RAM: 8 GB', 5),
	('PROD11C', '8GB', 'Black', 'Screen: AMOLED6.67" 1.5K; Operating system: Android 13; Rear camera: Main 50 MP & Secondary 50 MP, 12 MP; Front camera: 20 MP; Chip: MediaTek Dimensity 8200-Ultra; RAM: 8 GB', 3),
	('PROD11D', '12GB', 'Black', 'Screen: AMOLED6.67" 1.5K; Operating system: Android 13; Rear camera: Main 50 MP & Secondary 50 MP, 12 MP; Front camera: 20 MP; Chip: MediaTek Dimensity 8200-Ultra; RAM: 8 GB', 6),
	('PROD12A', '4GB', 'Silver', 'Screen: IPS LCD6.79"Full HD+; Operating system: Android 13; Rear camera: Main 50 MP & Secondary 8 MP, 2 MP; Front camera: 8 MP; Chip: MediaTek Helio G88; RAM: 4 GB', 11),
	('PROD12B', '8GB', 'Silver', 'Screen: IPS LCD6.79"Full HD+; Operating system: Android 13; Rear camera: Main 50 MP & Secondary 8 MP, 2 MP; Front camera: 8 MP; Chip: MediaTek Helio G88; RAM: 8 GB', 9),
	('PROD12C', '4GB', 'Blue', 'Screen: IPS LCD6.79"Full HD+; Operating system: Android 13; Rear camera: Main 50 MP & Secondary 8 MP, 2 MP; Front camera: 8 MP; Chip: MediaTek Helio G88; RAM: 4 GB', 8),
	('PROD12D', '8GB', 'Blue', 'Screen: IPS LCD6.79"Full HD+; Operating system: Android 13; Rear camera: Main 50 MP & Secondary 8 MP, 2 MP; Front camera: 8 MP; Chip: MediaTek Helio G88; RAM: 8 GB', 12);




INSERT INTO [productimg] ([productID], [img])
VALUES
    ('PROD1A', 'images/samsung-galaxy-s24-vang-1.jpg'),
    ('PROD1A', 'images/samsung-galaxy-s24-vang-2.jpg'),
    ('PROD1A', 'images/samsung-galaxy-s24-vang-3.jpg'),
    ('PROD1A', 'images/samsung-galaxy-s24-vang-4.jpg'),
    ('PROD1B', 'images/samsung-galaxy-s24-vang-1.jpg'),
    ('PROD1B', 'images/samsung-galaxy-s24-vang-2.jpg'),
    ('PROD1B', 'images/samsung-galaxy-s24-vang-3.jpg'),
    ('PROD1B', 'images/samsung-galaxy-s24-vang-4.jpg'),
    ('PROD1C', 'images/samsung-galaxy-s24-den-1.jpg'),
    ('PROD1C', 'images/samsung-galaxy-s24-den-2.jpg'),
	('PROD1C', 'images/samsung-galaxy-s24-den-3.jpg'),
    ('PROD1D', 'images/samsung-galaxy-s24-den-1.jpg'),
	('PROD1D', 'images/samsung-galaxy-s24-den-2.jpg'),
	('PROD1D', 'images/samsung-galaxy-s24-den-3.jpg'),
	('PROD2A', 'images/samsung-galaxy-a14-4g-do-1.jpg'),
	('PROD2A', 'images/samsung-galaxy-a14-4g-do-2.jpg'),
	('PROD2A', 'images/samsung-galaxy-a14-4g-do-3.jpg'),
	('PROD2A', 'images/samsung-galaxy-a14-4g-do-4.jpg'),
	('PROD2B', 'images/samsung-galaxy-a14-4g-do-1.jpg'),
	('PROD2B', 'images/samsung-galaxy-a14-4g-do-2.jpg'),
	('PROD2B', 'images/samsung-galaxy-a14-4g-do-3.jpg'),
	('PROD2B', 'images/samsung-galaxy-a14-4g-do-4.jpg'),
	('PROD2C', 'images/samsung-galaxy-a14-4g-den-1.jpg'),
	('PROD2C', 'images/samsung-galaxy-a14-4g-den-2.jpg'),
	('PROD2C', 'images/samsung-galaxy-a14-4g-den-3.jpg'),
	('PROD2C', 'images/samsung-galaxy-a14-4g-den-4.jpg'),
	('PROD2D', 'images/samsung-galaxy-a14-4g-den-1.jpg'),
	('PROD2D', 'images/samsung-galaxy-a14-4g-den-2.jpg'),
	('PROD2D', 'images/samsung-galaxy-a14-4g-den-3.jpg'),
	('PROD2D', 'images/samsung-galaxy-a14-4g-den-4.jpg'),
	('PROD3A', 'images/samsung-galaxy-zflip-5-tim-1.jpg'),
	('PROD3A', 'images/samsung-galaxy-zflip-5-tim-2.jpg'),
	('PROD3A', 'images/samsung-galaxy-zflip-5-tim-3.jpg'),
	('PROD3A', 'images/samsung-galaxy-zflip-5-tim-4.jpg'),
	('PROD3B', 'images/samsung-galaxy-zflip-5-xam-1.jpg'),
	('PROD3B', 'images/samsung-galaxy-zflip-5-xam-2.jpg'),
	('PROD3B', 'images/samsung-galaxy-zflip-5-xam-3.jpg'),
	('PROD3B', 'images/samsung-galaxy-zflip-5-xam-4.jpg'),
	('PROD4A', 'images/iphone-14-pro-max-purple-1.jpg'),
	('PROD4A', 'images/iphone-14-pro-max-purple-2.jpg'),
	('PROD4A', 'images/iphone-14-pro-max-purple-3.jpg'),
	('PROD4A', 'images/iphone-14-pro-max-purple-4.jpg'),
	('PROD4B', 'images/iphone-14-pro-max-purple-1.jpg'),
	('PROD4B', 'images/iphone-14-pro-max-purple-2.jpg'),
	('PROD4B', 'images/iphone-14-pro-max-purple-3.jpg'),
	('PROD4B', 'images/iphone-14-pro-max-purple-4.jpg'),
	('PROD4C', 'images/iphone-14-pro-den-1.jpg'),
	('PROD4C', 'images/iphone-14-pro-den-2.jpg'),
	('PROD4C', 'images/iphone-14-pro-den-3.jpg'),
	('PROD4C', 'images/iphone-14-pro-den-4.jpg'),
	('PROD4D', 'images/iphone-14-pro-den-1.jpg'),
	('PROD4D', 'images/iphone-14-pro-den-2.jpg'),
	('PROD4D', 'images/iphone-14-pro-den-3.jpg'),
	('PROD4D', 'images/iphone-14-pro-den-4.jpg'),
	('PROD5A', 'images/iphone-13-hong-1.jpg'),
	('PROD5A', 'images/iphone-13-hong-2.jpg'),
	('PROD5A', 'images/iphone-13-hong-3.jpg'),
	('PROD5A', 'images/iphone-13-hong-4.jpg'),
	('PROD5B', 'images/iphone-13-hong-1.jpg'),
	('PROD5B', 'images/iphone-13-hong-2.jpg'),
	('PROD5B', 'images/iphone-13-hong-3.jpg'),
	('PROD5B', 'images/iphone-13-hong-4.jpg'),
	('PROD5C', 'images/iphone-13-xanh-1.jpg'),
	('PROD5C', 'images/iphone-13-xanh-2.jpg'),
	('PROD5C', 'images/iphone-13-xanh-3.jpg'),
	('PROD5C', 'images/iphone-13-xanh-4.jpg'),
	('PROD5D', 'images/iphone-13-xanh-1.jpg'),
	('PROD5D', 'images/iphone-13-xanh-2.jpg'),
	('PROD5D', 'images/iphone-13-xanh-3.jpg'),
	('PROD5D', 'images/iphone-13-xanh-4.jpg'),
	('PROD6A', 'images/iphone-15-pro-black-1.jpg'),
	('PROD6A', 'images/iphone-15-pro-black-2.jpg'),
	('PROD6A', 'images/iphone-15-pro-black-3.jpg'),
	('PROD6A', 'images/iphone-15-pro-black-4.jpg'),
	('PROD6B', 'images/iphone-15-pro-black-1.jpg'),
	('PROD6B', 'images/iphone-15-pro-black-2.jpg'),
	('PROD6B', 'images/iphone-15-pro-black-3.jpg'),
	('PROD6B', 'images/iphone-15-pro-black-4.jpg'),
	('PROD6C', 'images/iphone-15-pro-white-1.jpg'),
	('PROD6C', 'images/iphone-15-pro-white-2.jpg'),
	('PROD6C', 'images/iphone-15-pro-white-3.jpg'),
	('PROD6C', 'images/iphone-15-pro-white-4.jpg'),
	('PROD6D', 'images/iphone-15-pro-white-1.jpg'),
	('PROD6D', 'images/iphone-15-pro-white-2.jpg'),
	('PROD6D', 'images/iphone-15-pro-white-3.jpg'),
	('PROD6D', 'images/iphone-15-pro-white-4.jpg'),
	('PROD7A', 'images/oppo-reno-11-xanh-1.jpg'),
	('PROD7A', 'images/oppo-reno-11-xanh-2.jpg'),
	('PROD7A', 'images/oppo-reno-11-xanh-3.jpg'),
	('PROD7A', 'images/oppo-reno-11-xanh-4.jpg'),
	('PROD7B', 'images/oppo-reno-11-xam-1.jpg'),
	('PROD7B', 'images/oppo-reno-11-xam-2.jpg'),
	('PROD7B', 'images/oppo-reno-11-xam-3.jpg'),
	('PROD7B', 'images/oppo-reno-11-xam-4.jpg'),
	('PROD8A', 'images/oppo-a57-vang-1.jpg'),
	('PROD8A', 'images/oppo-a57-vang-2.jpg'),
	('PROD8A', 'images/oppo-a57-vang-3.jpg'),
	('PROD8A', 'images/oppo-a57-vang-4.jpg'),
	('PROD8B', 'images/oppo-a57-xanh-1.jpg'),
	('PROD8B', 'images/oppo-a57-xanh-2.jpg'),
	('PROD8B', 'images/oppo-a57-xanh-3.jpg'),
	('PROD8B', 'images/oppo-a57-xanh-4.jpg'),
	('PROD9A', 'images/oppo-n2-flip-den-1.jpg'),
	('PROD9A', 'images/oppo-n2-flip-den-2.jpg'),
	('PROD9A', 'images/oppo-n2-flip-den-3.jpg'),
	('PROD9A', 'images/oppo-n2-flip-den-4.jpg'),
	('PROD9B', 'images/oppo-n2-flip-tim-1.jpg'),
	('PROD9B', 'images/oppo-n2-flip-tim-2.jpg'),
	('PROD9B', 'images/oppo-n2-flip-tim-3.jpg'),
	('PROD9B', 'images/oppo-n2-flip-tim-4.jpg'),
	('PROD10A', 'images/xiaomi-redmi-12-pro-4g-xanh-duong-1.jpg'),
	('PROD10A', 'images/xiaomi-redmi-12-pro-4g-xanh-duong-2.jpg'),
	('PROD10A', 'images/xiaomi-redmi-12-pro-4g-xanh-duong-3.jpg'),
	('PROD10A', 'images/xiaomi-redmi-12-pro-4g-xanh-duong-4.jpg'),
	('PROD10B', 'images/xiami-redmi-12-pro-xam-1.jpg'),
	('PROD10B', 'images/xiami-redmi-12-pro-xam-2.jpg'),
	('PROD10B', 'images/xiami-redmi-12-pro-xam-3.jpg'),
	('PROD10B', 'images/xiami-redmi-12-pro-xam-4.jpg'),
	('PROD11A', 'images/xiaomi-13t-xanh-duong-1.jpg'),
	('PROD11A', 'images/xiaomi-13t-xanh-duong-2.jpg'),
	('PROD11A', 'images/xiaomi-13t-xanh-duong-3.jpg'),
	('PROD11A', 'images/xiaomi-13t-xanh-duong-4.jpg'),
	('PROD11B', 'images/xiaomi-13t-xanh-duong-1.jpg'),
	('PROD11B', 'images/xiaomi-13t-xanh-duong-2.jpg'),
	('PROD11B', 'images/xiaomi-13t-xanh-duong-3.jpg'),
	('PROD11B', 'images/xiaomi-13t-xanh-duong-4.jpg'),
	('PROD11C', 'images/xiaomi-13t-den-1.jpg'),
	('PROD11C', 'images/xiaomi-13t-den-2.jpg'),
	('PROD11C', 'images/xiaomi-13t-den-3.jpg'),
	('PROD11C', 'images/xiaomi-13t-den-4.jpg'),
	('PROD11D', 'images/xiaomi-13t-den-1.jpg'),
	('PROD11D', 'images/xiaomi-13t-den-2.jpg'),
	('PROD11D', 'images/xiaomi-13t-den-3.jpg'),
	('PROD11D', 'images/xiaomi-13t-den-4.jpg'),
	('PROD12A', 'images/xiaomi-redmi-12-bac-1.jpg'),
	('PROD12A', 'images/xiaomi-redmi-12-bac-2.jpg'),
	('PROD12A', 'images/xiaomi-redmi-12-bac-3.jpg'),
	('PROD12A', 'images/xiaomi-redmi-12-bac-4.jpg'),
	('PROD12B', 'images/xiaomi-redmi-12-bac-1.jpg'),
	('PROD12B', 'images/xiaomi-redmi-12-bac-2.jpg'),
	('PROD12B', 'images/xiaomi-redmi-12-bac-3.jpg'),
	('PROD12B', 'images/xiaomi-redmi-12-bac-4.jpg'),
	('PROD12C', 'images/xiaomi-redmi-12-xanh-1.jpg'),
	('PROD12C', 'images/xiaomi-redmi-12-xanh-2.jpg'),
	('PROD12C', 'images/xiaomi-redmi-12-xanh-3.jpg'),
	('PROD12C', 'images/xiaomi-redmi-12-xanh-4.jpg'),
	('PROD12D', 'images/xiaomi-redmi-12-xanh-1.jpg'),
	('PROD12D', 'images/xiaomi-redmi-12-xanh-2.jpg'),
	('PROD12D', 'images/xiaomi-redmi-12-xanh-3.jpg'),
	('PROD12D', 'images/xiaomi-redmi-12-xanh-4.jpg');






