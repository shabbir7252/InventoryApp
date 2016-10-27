USE [master]
GO
/****** Object:  Database [InventoryApp]    Script Date: 27-Oct-16 4:43:43 PM ******/
CREATE DATABASE [InventoryApp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'InventoryApp', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\InventoryApp.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'InventoryApp_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\InventoryApp_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [InventoryApp] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [InventoryApp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [InventoryApp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [InventoryApp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [InventoryApp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [InventoryApp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [InventoryApp] SET ARITHABORT OFF 
GO
ALTER DATABASE [InventoryApp] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [InventoryApp] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [InventoryApp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [InventoryApp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [InventoryApp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [InventoryApp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [InventoryApp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [InventoryApp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [InventoryApp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [InventoryApp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [InventoryApp] SET  DISABLE_BROKER 
GO
ALTER DATABASE [InventoryApp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [InventoryApp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [InventoryApp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [InventoryApp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [InventoryApp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [InventoryApp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [InventoryApp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [InventoryApp] SET RECOVERY FULL 
GO
ALTER DATABASE [InventoryApp] SET  MULTI_USER 
GO
ALTER DATABASE [InventoryApp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [InventoryApp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [InventoryApp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [InventoryApp] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'InventoryApp', N'ON'
GO
USE [InventoryApp]
GO
/****** Object:  Table [dbo].[AddInktoStore]    Script Date: 27-Oct-16 4:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AddInktoStore](
	[InkId] [int] IDENTITY(1,1) NOT NULL,
	[Model_Id] [int] NOT NULL,
	[Store_Id] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[YearID] [int] NOT NULL,
	[Attachment_Path] [varchar](max) NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_AddInk] PRIMARY KEY CLUSTERED 
(
	[InkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Brand]    Script Date: 27-Oct-16 4:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brand](
	[Brand_Id] [int] IDENTITY(1,1) NOT NULL,
	[Brand_Name] [nvarchar](25) NOT NULL,
	[YearID] [int] NOT NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_Brand] PRIMARY KEY CLUSTERED 
(
	[Brand_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Color]    Script Date: 27-Oct-16 4:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Color](
	[Color_Id] [int] IDENTITY(1,1) NOT NULL,
	[Color_Name] [nvarchar](20) NOT NULL,
	[Date] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Color] PRIMARY KEY CLUSTERED 
(
	[Color_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Countries]    Script Date: 27-Oct-16 4:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryID] [int] NOT NULL,
	[CountryName] [varchar](80) NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IssueInk]    Script Date: 27-Oct-16 4:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IssueInk](
	[IssueInkId] [int] IDENTITY(1,1) NOT NULL,
	[Employee] [nvarchar](100) NOT NULL,
	[InkId] [int] NOT NULL,
	[date] [datetime] NOT NULL,
	[YearID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Attachment] [varchar](max) NULL,
 CONSTRAINT [PK_IssueInk] PRIMARY KEY CLUSTERED 
(
	[IssueInkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Model]    Script Date: 27-Oct-16 4:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Model](
	[Model_Id] [int] IDENTITY(1,1) NOT NULL,
	[Model_Name] [nvarchar](50) NOT NULL,
	[Brand_Id] [int] NOT NULL,
	[Color_Id] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Model] PRIMARY KEY CLUSTERED 
(
	[Model_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[status]    Script Date: 27-Oct-16 4:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[status](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [varchar](20) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_status] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Store]    Script Date: 27-Oct-16 4:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store](
	[Store_Id] [int] IDENTITY(1,1) NOT NULL,
	[CountryID] [int] NOT NULL,
	[Store] [nvarchar](50) NOT NULL,
	[YearID] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED 
(
	[Store_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StoreUsers]    Script Date: 27-Oct-16 4:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StoreUsers](
	[StoreUserID] [int] IDENTITY(1,1) NOT NULL,
	[Store_Id] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_StoreUsers] PRIMARY KEY CLUSTERED 
(
	[StoreUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 27-Oct-16 4:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[IsSuperAdmin] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Years]    Script Date: 27-Oct-16 4:43:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Years](
	[YearID] [int] IDENTITY(1,1) NOT NULL,
	[Year] [nvarchar](10) NULL,
 CONSTRAINT [PK_Years] PRIMARY KEY CLUSTERED 
(
	[YearID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[AddInktoStore] ON 

INSERT [dbo].[AddInktoStore] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (6, 7, 2, CAST(N'2016-10-24 18:07:01.050' AS DateTime), 2, NULL, 0)
INSERT [dbo].[AddInktoStore] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (7, 6, 2, CAST(N'2016-10-25 08:54:46.957' AS DateTime), 2, NULL, 14)
INSERT [dbo].[AddInktoStore] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (11, 5, 4, CAST(N'2016-10-27 12:49:41.360' AS DateTime), 2, NULL, 1)
INSERT [dbo].[AddInktoStore] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (12, 1013, 3, CAST(N'2016-10-27 13:10:06.720' AS DateTime), 2, NULL, 1)
INSERT [dbo].[AddInktoStore] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (13, 1014, 3, CAST(N'2016-10-27 13:10:17.423' AS DateTime), 1, NULL, 1)
INSERT [dbo].[AddInktoStore] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (14, 1012, 3, CAST(N'2016-10-27 13:10:30.777' AS DateTime), 1, NULL, 2)
INSERT [dbo].[AddInktoStore] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (20, 5, 2, CAST(N'2016-10-27 14:32:54.573' AS DateTime), 1, NULL, 2)
INSERT [dbo].[AddInktoStore] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (32, 1013, 4, CAST(N'2016-10-27 15:00:23.997' AS DateTime), 1, NULL, 1)
INSERT [dbo].[AddInktoStore] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (33, 1012, 4, CAST(N'2016-10-27 16:02:10.450' AS DateTime), 2, NULL, 1)
INSERT [dbo].[AddInktoStore] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (35, 8, 2, CAST(N'2016-10-27 16:14:56.263' AS DateTime), 2, NULL, 1)
SET IDENTITY_INSERT [dbo].[AddInktoStore] OFF
SET IDENTITY_INSERT [dbo].[Brand] ON 

INSERT [dbo].[Brand] ([Brand_Id], [Brand_Name], [YearID], [IsDeleted]) VALUES (5, N'HP', 1, 0)
INSERT [dbo].[Brand] ([Brand_Id], [Brand_Name], [YearID], [IsDeleted]) VALUES (6, N'Dell', 1, 0)
INSERT [dbo].[Brand] ([Brand_Id], [Brand_Name], [YearID], [IsDeleted]) VALUES (7, N'Asus', 1, 0)
INSERT [dbo].[Brand] ([Brand_Id], [Brand_Name], [YearID], [IsDeleted]) VALUES (8, N'Lenovo', 2, 0)
INSERT [dbo].[Brand] ([Brand_Id], [Brand_Name], [YearID], [IsDeleted]) VALUES (9, N'Samsung', 2, 0)
INSERT [dbo].[Brand] ([Brand_Id], [Brand_Name], [YearID], [IsDeleted]) VALUES (11, N'Canon', 1, 0)
SET IDENTITY_INSERT [dbo].[Brand] OFF
SET IDENTITY_INSERT [dbo].[Color] ON 

INSERT [dbo].[Color] ([Color_Id], [Color_Name], [Date], [IsDeleted]) VALUES (5, N'Magenta', CAST(N'2016-08-09 13:52:18.367' AS DateTime), 0)
INSERT [dbo].[Color] ([Color_Id], [Color_Name], [Date], [IsDeleted]) VALUES (6, N'Yellow', CAST(N'2016-08-08 09:14:53.407' AS DateTime), 0)
INSERT [dbo].[Color] ([Color_Id], [Color_Name], [Date], [IsDeleted]) VALUES (7, N'Black', CAST(N'2016-08-10 13:01:17.707' AS DateTime), 0)
INSERT [dbo].[Color] ([Color_Id], [Color_Name], [Date], [IsDeleted]) VALUES (8, N'Cyan', CAST(N'2016-08-09 14:53:26.473' AS DateTime), 0)
INSERT [dbo].[Color] ([Color_Id], [Color_Name], [Date], [IsDeleted]) VALUES (35, N'Light Yellow', CAST(N'2016-08-23 12:07:01.970' AS DateTime), 0)
INSERT [dbo].[Color] ([Color_Id], [Color_Name], [Date], [IsDeleted]) VALUES (36, N'Light Cyan', CAST(N'2016-08-23 12:07:07.190' AS DateTime), 0)
INSERT [dbo].[Color] ([Color_Id], [Color_Name], [Date], [IsDeleted]) VALUES (37, N'Light Magenta', CAST(N'2016-08-23 12:07:13.380' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Color] OFF
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (1, N'Afghanistan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (2, N'Aland Islands')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (3, N'Albania')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (4, N'Algeria')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (5, N'American Samoa')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (6, N'Andorra')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (7, N'Angola')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (8, N'Anguilla')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (9, N'Antarctica')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (10, N'Antigua and Barbuda')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (11, N'Argentina')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (12, N'Armenia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (13, N'Aruba')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (14, N'Australia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (15, N'Austria')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (16, N'Azerbaijan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (17, N'Bahamas')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (18, N'Bahrain')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (19, N'Bangladesh')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (20, N'Barbados')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (21, N'Belarus')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (22, N'Belgium')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (23, N'Belize')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (24, N'Benin')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (25, N'Bermuda')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (26, N'Bhutan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (27, N'Bolivia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (28, N'Bonaire, Sint Eustatius and Saba')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (29, N'Bosnia and Herzegovina')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (30, N'Botswana')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (31, N'Bouvet Island')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (32, N'Brazil')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (33, N'British Indian Ocean Territory')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (34, N'Brunei')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (35, N'Bulgaria')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (36, N'Burkina Faso')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (37, N'Burundi')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (38, N'Cambodia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (39, N'Cameroon')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (40, N'Canada')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (41, N'Cape Verde')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (42, N'Cayman Islands')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (43, N'Central African Republic')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (44, N'Chad')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (45, N'Chile')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (46, N'China')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (47, N'Christmas Island')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (48, N'Cocos (Keeling) Islands')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (49, N'Colombia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (50, N'Comoros')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (51, N'Congo')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (52, N'Cook Islands')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (53, N'Costa Rica')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (54, N'Cote d''ivoire (Ivory Coast)')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (55, N'Croatia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (56, N'Cuba')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (57, N'Curacao')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (58, N'Cyprus')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (59, N'Czech Republic')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (60, N'Democratic Republic of the Congo')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (61, N'Denmark')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (62, N'Djibouti')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (63, N'Dominica')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (64, N'Dominican Republic')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (65, N'Ecuador')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (66, N'Egypt')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (67, N'El Salvador')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (68, N'Equatorial Guinea')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (69, N'Eritrea')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (70, N'Estonia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (71, N'Ethiopia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (72, N'Falkland Islands (Malvinas)')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (73, N'Faroe Islands')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (74, N'Fiji')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (75, N'Finland')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (76, N'France')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (77, N'French Guiana')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (78, N'French Polynesia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (79, N'French Southern Territories')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (80, N'Gabon')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (81, N'Gambia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (82, N'Georgia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (83, N'Germany')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (84, N'Ghana')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (85, N'Gibraltar')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (86, N'Greece')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (87, N'Greenland')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (88, N'Grenada')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (89, N'Guadeloupe')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (90, N'Guam')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (91, N'Guatemala')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (92, N'Guernsey')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (93, N'Guinea')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (94, N'Guinea-Bissau')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (95, N'Guyana')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (96, N'Haiti')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (97, N'Heard Island and McDonald Islands')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (98, N'Honduras')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (99, N'Hong Kong')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (100, N'Hungary')
GO
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (101, N'Iceland')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (102, N'India')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (103, N'Indonesia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (104, N'Iran')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (105, N'Iraq')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (106, N'Ireland')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (107, N'Isle of Man')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (108, N'Israel')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (109, N'Italy')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (110, N'Jamaica')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (111, N'Japan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (112, N'Jersey')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (113, N'Jordan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (114, N'Kazakhstan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (115, N'Kenya')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (116, N'Kiribati')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (117, N'Kosovo')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (118, N'Kuwait')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (119, N'Kyrgyzstan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (120, N'Laos')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (121, N'Latvia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (122, N'Lebanon')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (123, N'Lesotho')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (124, N'Liberia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (125, N'Libya')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (126, N'Liechtenstein')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (127, N'Lithuania')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (128, N'Luxembourg')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (129, N'Macao')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (130, N'Macedonia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (131, N'Madagascar')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (132, N'Malawi')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (133, N'Malaysia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (134, N'Maldives')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (135, N'Mali')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (136, N'Malta')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (137, N'Marshall Islands')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (138, N'Martinique')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (139, N'Mauritania')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (140, N'Mauritius')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (141, N'Mayotte')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (142, N'Mexico')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (143, N'Micronesia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (144, N'Moldova')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (145, N'Monaco')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (146, N'Mongolia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (147, N'Montenegro')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (148, N'Montserrat')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (149, N'Morocco')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (150, N'Mozambique')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (151, N'Myanmar (Burma)')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (152, N'Namibia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (153, N'Nauru')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (154, N'Nepal')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (155, N'Netherlands')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (156, N'New Caledonia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (157, N'New Zealand')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (158, N'Nicaragua')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (159, N'Niger')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (160, N'Nigeria')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (161, N'Niue')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (162, N'Norfolk Island')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (163, N'North Korea')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (164, N'Northern Mariana Islands')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (165, N'Norway')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (166, N'Oman')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (167, N'Pakistan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (168, N'Palau')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (169, N'Palestine')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (170, N'Panama')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (171, N'Papua New Guinea')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (172, N'Paraguay')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (173, N'Peru')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (174, N'Phillipines')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (175, N'Pitcairn')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (176, N'Poland')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (177, N'Portugal')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (178, N'Puerto Rico')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (179, N'Qatar')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (180, N'Reunion')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (181, N'Romania')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (182, N'Russia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (183, N'Rwanda')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (184, N'Saint Barthelemy')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (185, N'Saint Helena')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (186, N'Saint Kitts and Nevis')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (187, N'Saint Lucia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (188, N'Saint Martin')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (189, N'Saint Pierre and Miquelon')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (190, N'Saint Vincent and the Grenadines')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (191, N'Samoa')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (192, N'San Marino')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (193, N'Sao Tome and Principe')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (194, N'Saudi Arabia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (195, N'Senegal')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (196, N'Serbia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (197, N'Seychelles')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (198, N'Sierra Leone')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (199, N'Singapore')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (200, N'Sint Maarten')
GO
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (201, N'Slovakia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (202, N'Slovenia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (203, N'Solomon Islands')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (204, N'Somalia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (205, N'South Africa')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (206, N'South Georgia and the South Sandwich Islands')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (207, N'South Korea')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (208, N'South Sudan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (209, N'Spain')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (210, N'Sri Lanka')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (211, N'Sudan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (212, N'Suriname')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (213, N'Svalbard and Jan Mayen')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (214, N'Swaziland')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (215, N'Sweden')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (216, N'Switzerland')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (217, N'Syria')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (218, N'Taiwan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (219, N'Tajikistan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (220, N'Tanzania')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (221, N'Thailand')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (222, N'Timor-Leste (East Timor)')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (223, N'Togo')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (224, N'Tokelau')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (225, N'Tonga')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (226, N'Trinidad and Tobago')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (227, N'Tunisia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (228, N'Turkey')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (229, N'Turkmenistan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (230, N'Turks and Caicos Islands')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (231, N'Tuvalu')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (232, N'Uganda')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (233, N'Ukraine')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (234, N'United Arab Emirates')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (235, N'United Kingdom')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (236, N'United States')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (237, N'United States Minor Outlying Islands')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (238, N'Uruguay')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (239, N'Uzbekistan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (240, N'Vanuatu')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (241, N'Vatican City')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (242, N'Venezuela')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (243, N'Vietnam')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (244, N'Virgin Islands, British')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (245, N'Virgin Islands, US')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (246, N'Wallis and Futuna')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (247, N'Western Sahara')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (248, N'Yemen')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (249, N'Zambia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (250, N'Zimbabwe')
SET IDENTITY_INSERT [dbo].[IssueInk] ON 

INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (40, N'Kamal I. Fahim', 6, CAST(N'2016-10-27 16:00:54.930' AS DateTime), 2, 2, NULL)
SET IDENTITY_INSERT [dbo].[IssueInk] OFF
SET IDENTITY_INSERT [dbo].[Model] ON 

INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [Color_Id], [Date], [IsDeleted]) VALUES (5, N'CE273A', 5, 5, CAST(N'2016-08-23 12:55:43.247' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [Color_Id], [Date], [IsDeleted]) VALUES (6, N'CE271A', 5, 8, CAST(N'2016-08-23 13:05:01.993' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [Color_Id], [Date], [IsDeleted]) VALUES (7, N'CE270A', 5, 7, CAST(N'2016-08-23 13:05:27.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [Color_Id], [Date], [IsDeleted]) VALUES (8, N'CE272A', 5, 6, CAST(N'2016-08-25 10:44:05.273' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [Color_Id], [Date], [IsDeleted]) VALUES (1012, N'CA8888', 6, 35, CAST(N'2016-10-27 12:39:30.990' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [Color_Id], [Date], [IsDeleted]) VALUES (1013, N'GH555', 6, 36, CAST(N'2016-10-27 12:48:13.037' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [Color_Id], [Date], [IsDeleted]) VALUES (1014, N'HJ555', 9, 37, CAST(N'2016-10-27 12:48:21.657' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Model] OFF
SET IDENTITY_INSERT [dbo].[status] ON 

INSERT [dbo].[status] ([StatusId], [StatusName], [IsDeleted]) VALUES (1, N'New', 0)
INSERT [dbo].[status] ([StatusId], [StatusName], [IsDeleted]) VALUES (2, N'Used', 0)
SET IDENTITY_INSERT [dbo].[status] OFF
SET IDENTITY_INSERT [dbo].[Store] ON 

INSERT [dbo].[Store] ([Store_Id], [CountryID], [Store], [YearID], [IsDeleted]) VALUES (2, 118, N'PSC-Surra', 1, 0)
INSERT [dbo].[Store] ([Store_Id], [CountryID], [Store], [YearID], [IsDeleted]) VALUES (3, 118, N'Farwaniya', 2, 0)
INSERT [dbo].[Store] ([Store_Id], [CountryID], [Store], [YearID], [IsDeleted]) VALUES (4, 102, N'PSC-Mumbai', 1, 0)
SET IDENTITY_INSERT [dbo].[Store] OFF
SET IDENTITY_INSERT [dbo].[StoreUsers] ON 

INSERT [dbo].[StoreUsers] ([StoreUserID], [Store_Id], [UserId], [IsDeleted]) VALUES (1, 2, 1, 0)
INSERT [dbo].[StoreUsers] ([StoreUserID], [Store_Id], [UserId], [IsDeleted]) VALUES (2, 3, 1, 0)
INSERT [dbo].[StoreUsers] ([StoreUserID], [Store_Id], [UserId], [IsDeleted]) VALUES (3, 4, 1, 0)
SET IDENTITY_INSERT [dbo].[StoreUsers] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [UserName], [IsDeleted], [IsSuperAdmin]) VALUES (1, N'ssalumberwala', 0, 1)
SET IDENTITY_INSERT [dbo].[User] OFF
SET IDENTITY_INSERT [dbo].[Years] ON 

INSERT [dbo].[Years] ([YearID], [Year]) VALUES (1, N'2015')
INSERT [dbo].[Years] ([YearID], [Year]) VALUES (2, N'2016')
SET IDENTITY_INSERT [dbo].[Years] OFF
ALTER TABLE [dbo].[AddInktoStore]  WITH CHECK ADD  CONSTRAINT [FK_AddInk_Model] FOREIGN KEY([Model_Id])
REFERENCES [dbo].[Model] ([Model_Id])
GO
ALTER TABLE [dbo].[AddInktoStore] CHECK CONSTRAINT [FK_AddInk_Model]
GO
ALTER TABLE [dbo].[AddInktoStore]  WITH CHECK ADD  CONSTRAINT [FK_AddInk_Store] FOREIGN KEY([Store_Id])
REFERENCES [dbo].[Store] ([Store_Id])
GO
ALTER TABLE [dbo].[AddInktoStore] CHECK CONSTRAINT [FK_AddInk_Store]
GO
ALTER TABLE [dbo].[AddInktoStore]  WITH CHECK ADD  CONSTRAINT [FK_AddInk_Years] FOREIGN KEY([YearID])
REFERENCES [dbo].[Years] ([YearID])
GO
ALTER TABLE [dbo].[AddInktoStore] CHECK CONSTRAINT [FK_AddInk_Years]
GO
ALTER TABLE [dbo].[Brand]  WITH CHECK ADD  CONSTRAINT [FK_Brand_Years] FOREIGN KEY([YearID])
REFERENCES [dbo].[Years] ([YearID])
GO
ALTER TABLE [dbo].[Brand] CHECK CONSTRAINT [FK_Brand_Years]
GO
ALTER TABLE [dbo].[IssueInk]  WITH CHECK ADD  CONSTRAINT [FK_IssueInk_AddInktoStore] FOREIGN KEY([InkId])
REFERENCES [dbo].[AddInktoStore] ([InkId])
GO
ALTER TABLE [dbo].[IssueInk] CHECK CONSTRAINT [FK_IssueInk_AddInktoStore]
GO
ALTER TABLE [dbo].[IssueInk]  WITH CHECK ADD  CONSTRAINT [FK_IssueInk_Years] FOREIGN KEY([YearID])
REFERENCES [dbo].[Years] ([YearID])
GO
ALTER TABLE [dbo].[IssueInk] CHECK CONSTRAINT [FK_IssueInk_Years]
GO
ALTER TABLE [dbo].[Model]  WITH CHECK ADD  CONSTRAINT [FK_Model_Brand] FOREIGN KEY([Brand_Id])
REFERENCES [dbo].[Brand] ([Brand_Id])
GO
ALTER TABLE [dbo].[Model] CHECK CONSTRAINT [FK_Model_Brand]
GO
ALTER TABLE [dbo].[Model]  WITH CHECK ADD  CONSTRAINT [FK_Model_Color] FOREIGN KEY([Color_Id])
REFERENCES [dbo].[Color] ([Color_Id])
GO
ALTER TABLE [dbo].[Model] CHECK CONSTRAINT [FK_Model_Color]
GO
ALTER TABLE [dbo].[Store]  WITH CHECK ADD  CONSTRAINT [FK_Store_Countries] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Countries] ([CountryID])
GO
ALTER TABLE [dbo].[Store] CHECK CONSTRAINT [FK_Store_Countries]
GO
ALTER TABLE [dbo].[Store]  WITH CHECK ADD  CONSTRAINT [FK_Store_Years] FOREIGN KEY([YearID])
REFERENCES [dbo].[Years] ([YearID])
GO
ALTER TABLE [dbo].[Store] CHECK CONSTRAINT [FK_Store_Years]
GO
ALTER TABLE [dbo].[StoreUsers]  WITH CHECK ADD  CONSTRAINT [FK_StoreUsers_Store] FOREIGN KEY([Store_Id])
REFERENCES [dbo].[Store] ([Store_Id])
GO
ALTER TABLE [dbo].[StoreUsers] CHECK CONSTRAINT [FK_StoreUsers_Store]
GO
ALTER TABLE [dbo].[StoreUsers]  WITH CHECK ADD  CONSTRAINT [FK_StoreUsers_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[StoreUsers] CHECK CONSTRAINT [FK_StoreUsers_User]
GO
USE [master]
GO
ALTER DATABASE [InventoryApp] SET  READ_WRITE 
GO
