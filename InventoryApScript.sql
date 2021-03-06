USE [master]
GO
/****** Object:  Database [InventoryApp]    Script Date: 3/29/2017 10:35:15 AM ******/
CREATE DATABASE [InventoryApp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'InventoryApp', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\InventoryApp.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'InventoryApp_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\InventoryApp_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
USE [InventoryApp]
GO
/****** Object:  Table [dbo].[Brand]    Script Date: 3/29/2017 10:35:15 AM ******/
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
/****** Object:  Table [dbo].[Countries]    Script Date: 3/29/2017 10:35:16 AM ******/
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
/****** Object:  Table [dbo].[Damage]    Script Date: 3/29/2017 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Damage](
	[DamageId] [int] IDENTITY(1,1) NOT NULL,
	[InkId] [int] NOT NULL,
	[Datetime] [datetime] NOT NULL,
	[Serial] [varchar](50) NULL,
	[IsDisposed] [bit] NOT NULL,
	[DisposedDateTime] [datetime] NULL,
	[IsReplaced] [bit] NOT NULL,
	[ReplacedDateTime] [datetime] NULL,
	[Attachment] [varchar](50) NULL,
 CONSTRAINT [PK_Damage] PRIMARY KEY CLUSTERED 
(
	[DamageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InkInventory]    Script Date: 3/29/2017 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InkInventory](
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
/****** Object:  Table [dbo].[IssueInk]    Script Date: 3/29/2017 10:35:16 AM ******/
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
/****** Object:  Table [dbo].[Model]    Script Date: 3/29/2017 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Model](
	[Model_Id] [int] IDENTITY(1,1) NOT NULL,
	[Model_Name] [nvarchar](50) NOT NULL,
	[Brand_Id] [int] NOT NULL,
	[ColorName] [varchar](20) NOT NULL,
	[Date] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Model] PRIMARY KEY CLUSTERED 
(
	[Model_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Store]    Script Date: 3/29/2017 10:35:16 AM ******/
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
/****** Object:  Table [dbo].[StoreUsers]    Script Date: 3/29/2017 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StoreUsers](
	[StoreUserID] [int] IDENTITY(1,1) NOT NULL,
	[Store_Id] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[IsPermitted] [bit] NOT NULL,
 CONSTRAINT [PK_StoreUsers] PRIMARY KEY CLUSTERED 
(
	[StoreUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 3/29/2017 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[IsSuperAdmin] [bit] NULL,
	[date] [datetime] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Years]    Script Date: 3/29/2017 10:35:16 AM ******/
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
SET IDENTITY_INSERT [dbo].[Brand] ON 

INSERT [dbo].[Brand] ([Brand_Id], [Brand_Name], [YearID], [IsDeleted]) VALUES (13, N'HP', 3, 0)
INSERT [dbo].[Brand] ([Brand_Id], [Brand_Name], [YearID], [IsDeleted]) VALUES (14, N'Canon', 3, 0)
INSERT [dbo].[Brand] ([Brand_Id], [Brand_Name], [YearID], [IsDeleted]) VALUES (15, N'Xerox', 3, 0)
SET IDENTITY_INSERT [dbo].[Brand] OFF
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
SET IDENTITY_INSERT [dbo].[InkInventory] ON 

INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (1, 1, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 5)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (2, 2, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 2)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (3, 3, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 5)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (4, 4, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 6)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (5, 5, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 7)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (6, 6, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 2)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (7, 7, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 1)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (8, 8, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 2)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (9, 9, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 2)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (10, 10, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 3)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (11, 11, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 4)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (12, 12, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 4)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (13, 13, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 4)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (14, 14, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 6)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (15, 15, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 5)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (16, 16, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 5)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (17, 17, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 5)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (18, 18, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 0)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (19, 19, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 1)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (20, 20, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 2)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (21, 21, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 0)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (22, 22, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 2)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (23, 23, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 1)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (24, 24, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 3)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (25, 25, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 5)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (26, 26, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 4)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (27, 27, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 3)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (28, 28, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 4)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (29, 29, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 3)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (30, 30, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 8)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (31, 31, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 2)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (32, 32, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 5)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (33, 33, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 3)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (34, 34, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 5)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (35, 35, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 3)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (36, 36, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 15)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (37, 37, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 5)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (38, 38, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 7)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (39, 39, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 6)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (40, 40, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 7)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (41, 41, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 7)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (42, 42, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 12)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (43, 43, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 6)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (44, 44, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 8)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (45, 45, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 6)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (46, 46, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 3)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (47, 47, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 9)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (48, 48, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 8)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (49, 49, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 7)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (50, 50, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 6)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (51, 51, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 2)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (52, 52, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 4)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (53, 53, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 3)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (54, 54, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 3)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (55, 55, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 2)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (56, 56, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 7)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (57, 57, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 4)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (58, 58, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 2)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (59, 59, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 10)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (60, 60, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 8)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (61, 61, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 10)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (62, 62, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 4)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (63, 63, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 9)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (64, 64, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 6)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (65, 65, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 5)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (66, 66, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 5)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (67, 67, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 1)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (68, 68, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 1)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (69, 69, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 2)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (70, 70, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 4)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (71, 71, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 5)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (72, 72, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 3)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (73, 73, 2, CAST(N'2017-02-19 00:00:00.000' AS DateTime), 3, N'', 3)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (74, 74, 2, CAST(N'2017-03-15 09:45:50.667' AS DateTime), 3, NULL, 3)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (75, 75, 2, CAST(N'2017-03-15 09:48:46.833' AS DateTime), 3, NULL, 4)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (76, 76, 2, CAST(N'2017-03-15 09:49:04.410' AS DateTime), 3, NULL, 4)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (77, 77, 2, CAST(N'2017-03-15 09:49:23.770' AS DateTime), 3, NULL, 4)
INSERT [dbo].[InkInventory] ([InkId], [Model_Id], [Store_Id], [Date], [YearID], [Attachment_Path], [Quantity]) VALUES (78, 78, 2, CAST(N'2017-03-15 09:49:42.180' AS DateTime), 3, NULL, 4)
SET IDENTITY_INSERT [dbo].[InkInventory] OFF
SET IDENTITY_INSERT [dbo].[IssueInk] ON 

INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1066, N'Mishary Hussain', 64, CAST(N'2017-03-15 10:08:56.047' AS DateTime), 3, 1, N'Mishary Hassan - 12-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1067, N'Mohsen Ghazi Al-Hathal', 4, CAST(N'2017-03-15 10:14:05.480' AS DateTime), 3, 1, N'Mohsen Ghazi - 08-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1068, N'Mohammed H. Ibrahim', 75, CAST(N'2017-03-15 10:17:55.883' AS DateTime), 3, 1, N'Mohammed Hassan Ibrahim - 08-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1069, N'Mohammed H. Ibrahim', 76, CAST(N'2017-03-15 10:19:04.557' AS DateTime), 3, 1, N'Mohammed Hassan Ibrahim - 08-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1070, N'Mohammed H. Ibrahim', 77, CAST(N'2017-03-15 10:19:27.310' AS DateTime), 3, 1, N'Mohammed Hassan Ibrahim - 08-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1071, N'Mohammed H. Ibrahim', 78, CAST(N'2017-03-15 10:19:45.137' AS DateTime), 3, 1, N'Mohammed Hassan Ibrahim - 08-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1072, N'Jamal Mal Allah', 58, CAST(N'2017-03-15 12:29:53.190' AS DateTime), 3, 1, N'Jamal Mallallah - 15-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1073, N'Jamal Mal Allah', 59, CAST(N'2017-03-15 12:40:19.157' AS DateTime), 3, 1, N'Jamal Mallallah - 15-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1074, N'Mossaed Azzab', 21, CAST(N'2017-03-16 13:44:23.727' AS DateTime), 3, 1, N'Mosaaed Azab Dhari - 16-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1075, N'Mohamed H. Eissa', 2, CAST(N'2017-03-19 12:16:39.487' AS DateTime), 3, 1, N'Mohammed Eissa - 19-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1076, N'Mohamed H. Eissa', 3, CAST(N'2017-03-19 12:17:18.380' AS DateTime), 3, 1, N'Mohammed Eissa - 19-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1077, N'Mohamed H. Eissa', 4, CAST(N'2017-03-19 12:17:45.100' AS DateTime), 3, 1, N'Mohammed Eissa - 19-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1078, N'Mohamed H. Eissa', 5, CAST(N'2017-03-19 12:18:08.617' AS DateTime), 3, 1, N'Mohammed Eissa - 19-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1079, N'Abdullah M. Abd', 20, CAST(N'2017-03-22 10:43:24.680' AS DateTime), 3, 1, N'Abdullah Mateeb - 22-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1080, N'Abdullah M. Abd', 21, CAST(N'2017-03-22 10:44:00.880' AS DateTime), 3, 1, N'Abdullah Mateeb - 22-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1081, N'Abdullah M. Abd', 22, CAST(N'2017-03-22 10:44:29.100' AS DateTime), 3, 1, N'Abdullah Mateeb - 22-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1082, N'Abdullah M. Abd', 23, CAST(N'2017-03-22 10:44:54.187' AS DateTime), 3, 1, N'Abdullah Mateeb - 22-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1085, N'Faisal Al Ibrahim', 51, CAST(N'2017-03-22 12:54:20.017' AS DateTime), 3, 1, N'Faisal AlIbrahim - 22-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1086, N'Bader Al-Enezi', 65, CAST(N'2017-03-23 14:40:28.600' AS DateTime), 3, 1, N'Bader AlEnezi - 23-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1087, N'Hassan Saleh', 4, CAST(N'2017-03-27 11:59:54.987' AS DateTime), 3, 1, N'Hassan Saleh - 27-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1088, N'Hassan Saleh', 5, CAST(N'2017-03-27 12:00:13.337' AS DateTime), 3, 1, N'Hassan Saleh - 27-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1089, N'Mohammed Abdel Hameed', 2, CAST(N'2017-03-27 13:17:32.177' AS DateTime), 3, 1, N'Mohammed AbdelHameed - 27-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1090, N'Mohammed Abdel Hameed', 3, CAST(N'2017-03-27 13:17:56.033' AS DateTime), 3, 1, N'Mohammed AbdelHameed - 27-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1091, N'Maha Mamdouh', 5, CAST(N'2017-03-28 12:56:31.393' AS DateTime), 3, 1, N'Maha Mamdouh - 28-03-2017.pdf')
INSERT [dbo].[IssueInk] ([IssueInkId], [Employee], [InkId], [date], [YearID], [Quantity], [Attachment]) VALUES (1092, N'Mohamed H. Eissa', 3, CAST(N'2017-03-29 10:13:29.803' AS DateTime), 3, 1, N'Mohammed Eissa - 29-03-2017.pdf')
SET IDENTITY_INSERT [dbo].[IssueInk] OFF
SET IDENTITY_INSERT [dbo].[Model] ON 

INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (1, N'C7115A-15A', 13, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (2, N'CE410A-305A ', 13, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (3, N'CE411A-305A', 13, N'Cyan', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (4, N'CE412A-305A', 13, N'Yellow', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (5, N'CE413A-305A', 13, N'Magenta', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (6, N'CE270A-650A', 13, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (7, N'CE271A-650A', 13, N'Cyan', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (8, N'CE272A-650A', 13, N'Yellow', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (9, N'CE273A-650A', 13, N'Magenta', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (10, N'CF350A-130A', 13, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (11, N'CF351A-130A', 13, N'Cyan', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (12, N'CF352A-130A', 13, N'Yellow', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (13, N'CF353A-130A', 13, N'Magenta', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (14, N'CF400A-201A', 13, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (15, N'CF401A-201A', 13, N'Cyan', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (16, N'CF402A-201A', 13, N'Yellow', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (17, N'CF403A-201A', 13, N'Magenta', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (18, N'C4127A-27A', 13, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (19, N'27 X', 13, N'Black', CAST(N'2016-02-12 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (20, N'CE320A-128A', 13, N'Black', CAST(N'2016-03-12 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (21, N'CE321A-128A', 13, N'Cyan', CAST(N'2016-04-12 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (22, N'CE322A-128A', 13, N'Yellow', CAST(N'2016-05-12 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (23, N'CE323A-128A', 13, N'Magenta', CAST(N'2016-06-12 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (24, N'Q3960A', 13, N'Black', CAST(N'2016-07-12 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (25, N'Q3961A', 13, N'Cyan', CAST(N'2016-08-12 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (26, N'Q3962A', 13, N'Yellow', CAST(N'2016-09-12 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (27, N'Q3963A', 13, N'Magenta', CAST(N'2016-10-12 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (28, N'Q3964A ', 13, N'Black', CAST(N'2016-11-12 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (29, N'Q7553A-53A', 13, N'Black', CAST(N'2016-12-12 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (30, N'Q5949A-49A', 13, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (31, N'42A', 13, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (32, N'56', 13, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (33, N'CB540A-125A', 13, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (34, N'CB541A-125A', 13, N'Cyan', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (35, N'CB542A-125A', 13, N'Yellow', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (36, N'CB543A-125A', 13, N'Magenta', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (37, N'C3903-03A', 13, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (38, N'Q6000A', 13, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (39, N'Q6001A', 13, N'Cyan', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (40, N'Q6002A', 13, N'Yellow', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (41, N'Q6003A', 13, N'Magenta', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (42, N'21', 13, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (43, N'45A', 13, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (44, N'134', 13, N'MultiColor', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (45, N'131', 13, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (46, N'27', 13, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (47, N'27A', 13, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (48, N'57', 13, N'MultiColor', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (49, N'135', 13, N'MultiColor', CAST(N'2017-01-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (50, N'129', 13, N'Black', CAST(N'2017-02-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (51, N'CE260A-647A', 13, N'Black', CAST(N'2017-03-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (52, N'CE261A-647A', 13, N'cyan', CAST(N'2017-04-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (53, N'CE262A-647A', 13, N'yellow', CAST(N'2017-05-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (54, N'CE263A-647A', 13, N'magenta', CAST(N'2017-06-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (55, N'35A', 13, N'Black', CAST(N'2017-07-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (56, N'PGBK5-8', 14, N'Black', CAST(N'2017-08-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (57, N'CLI-8C', 14, N'Cyan', CAST(N'2017-09-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (58, N'PGBK-425B', 14, N'Black', CAST(N'2017-10-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (59, N'426Y', 14, N'Yellow', CAST(N'2017-11-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (60, N'426M', 14, N'Magenta', CAST(N'2017-12-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (61, N'426B', 14, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (62, N'426C', 14, N'Cyan', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (63, N'440', 14, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (64, N'441', 14, N'MultiColor', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (65, N'CLI-8M', 14, N'Magenta', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (66, N'CLI-8Y', 14, N'Yellow', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (67, N'8500-8550', 15, N'Yellow', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (68, N'8500-8550', 15, N'Cyan', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (69, N'8500-8550', 15, N'Magenta', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (70, N'8560W', 15, N'Cyan', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (71, N'8560W', 15, N'Black', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (72, N'8560W', 15, N'Yellow', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (73, N'8560W', 15, N'Magenta', CAST(N'2017-02-19 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (74, N'CF280A-80A', 13, N'Black', CAST(N'2017-03-15 09:42:19.643' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (75, N'CE310A-126A', 13, N'Black', CAST(N'2017-03-15 09:43:04.270' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (76, N'CE311A-126A', 13, N'Cyan', CAST(N'2017-03-15 09:43:28.583' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (77, N'CE312A-126A', 13, N'Yellow', CAST(N'2017-03-15 09:43:46.520' AS DateTime), 0)
INSERT [dbo].[Model] ([Model_Id], [Model_Name], [Brand_Id], [ColorName], [Date], [IsDeleted]) VALUES (78, N'CE313A-126A', 13, N'Magenta', CAST(N'2017-03-15 09:43:59.413' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Model] OFF
SET IDENTITY_INSERT [dbo].[Store] ON 

INSERT [dbo].[Store] ([Store_Id], [CountryID], [Store], [YearID], [IsDeleted]) VALUES (2, 118, N'PSC-Surra', 1, 0)
INSERT [dbo].[Store] ([Store_Id], [CountryID], [Store], [YearID], [IsDeleted]) VALUES (3, 118, N'Farwaniya', 2, 0)
INSERT [dbo].[Store] ([Store_Id], [CountryID], [Store], [YearID], [IsDeleted]) VALUES (4, 102, N'PSC-Mumbai', 1, 0)
SET IDENTITY_INSERT [dbo].[Store] OFF
SET IDENTITY_INSERT [dbo].[StoreUsers] ON 

INSERT [dbo].[StoreUsers] ([StoreUserID], [Store_Id], [UserId], [IsPermitted]) VALUES (1, 2, 1, 1)
INSERT [dbo].[StoreUsers] ([StoreUserID], [Store_Id], [UserId], [IsPermitted]) VALUES (2, 3, 1, 1)
INSERT [dbo].[StoreUsers] ([StoreUserID], [Store_Id], [UserId], [IsPermitted]) VALUES (3, 4, 1, 1)
INSERT [dbo].[StoreUsers] ([StoreUserID], [Store_Id], [UserId], [IsPermitted]) VALUES (8, 2, 8, 1)
INSERT [dbo].[StoreUsers] ([StoreUserID], [Store_Id], [UserId], [IsPermitted]) VALUES (9, 3, 8, 1)
INSERT [dbo].[StoreUsers] ([StoreUserID], [Store_Id], [UserId], [IsPermitted]) VALUES (10, 4, 8, 1)
INSERT [dbo].[StoreUsers] ([StoreUserID], [Store_Id], [UserId], [IsPermitted]) VALUES (11, 2, 10, 1)
INSERT [dbo].[StoreUsers] ([StoreUserID], [Store_Id], [UserId], [IsPermitted]) VALUES (12, 3, 10, 1)
INSERT [dbo].[StoreUsers] ([StoreUserID], [Store_Id], [UserId], [IsPermitted]) VALUES (13, 4, 10, 0)
SET IDENTITY_INSERT [dbo].[StoreUsers] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [UserName], [IsAdmin], [IsSuperAdmin], [date]) VALUES (1, N'ssalumberwala', 1, 1, CAST(N'2016-11-14 10:07:00.507' AS DateTime))
INSERT [dbo].[User] ([UserId], [UserName], [IsAdmin], [IsSuperAdmin], [date]) VALUES (8, N'dkumar', 1, 1, CAST(N'2016-11-29 14:47:16.420' AS DateTime))
INSERT [dbo].[User] ([UserId], [UserName], [IsAdmin], [IsSuperAdmin], [date]) VALUES (10, N'halhefnawy', 1, 1, CAST(N'2016-12-04 10:55:37.100' AS DateTime))
INSERT [dbo].[User] ([UserId], [UserName], [IsAdmin], [IsSuperAdmin], [date]) VALUES (13, N'kfahim', 1, 1, CAST(N'2016-12-04 10:10:33.100' AS DateTime))
SET IDENTITY_INSERT [dbo].[User] OFF
SET IDENTITY_INSERT [dbo].[Years] ON 

INSERT [dbo].[Years] ([YearID], [Year]) VALUES (1, N'2015')
INSERT [dbo].[Years] ([YearID], [Year]) VALUES (2, N'2016')
INSERT [dbo].[Years] ([YearID], [Year]) VALUES (3, N'2017')
SET IDENTITY_INSERT [dbo].[Years] OFF
ALTER TABLE [dbo].[Brand]  WITH CHECK ADD  CONSTRAINT [FK_Brand_Years] FOREIGN KEY([YearID])
REFERENCES [dbo].[Years] ([YearID])
GO
ALTER TABLE [dbo].[Brand] CHECK CONSTRAINT [FK_Brand_Years]
GO
ALTER TABLE [dbo].[Damage]  WITH CHECK ADD  CONSTRAINT [FK_Damage_AddInktoStore] FOREIGN KEY([InkId])
REFERENCES [dbo].[InkInventory] ([InkId])
GO
ALTER TABLE [dbo].[Damage] CHECK CONSTRAINT [FK_Damage_AddInktoStore]
GO
ALTER TABLE [dbo].[InkInventory]  WITH CHECK ADD  CONSTRAINT [FK_AddInk_Model] FOREIGN KEY([Model_Id])
REFERENCES [dbo].[Model] ([Model_Id])
GO
ALTER TABLE [dbo].[InkInventory] CHECK CONSTRAINT [FK_AddInk_Model]
GO
ALTER TABLE [dbo].[InkInventory]  WITH CHECK ADD  CONSTRAINT [FK_AddInk_Store] FOREIGN KEY([Store_Id])
REFERENCES [dbo].[Store] ([Store_Id])
GO
ALTER TABLE [dbo].[InkInventory] CHECK CONSTRAINT [FK_AddInk_Store]
GO
ALTER TABLE [dbo].[InkInventory]  WITH CHECK ADD  CONSTRAINT [FK_AddInk_Years] FOREIGN KEY([YearID])
REFERENCES [dbo].[Years] ([YearID])
GO
ALTER TABLE [dbo].[InkInventory] CHECK CONSTRAINT [FK_AddInk_Years]
GO
ALTER TABLE [dbo].[IssueInk]  WITH CHECK ADD  CONSTRAINT [FK_IssueInk_AddInktoStore] FOREIGN KEY([InkId])
REFERENCES [dbo].[InkInventory] ([InkId])
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
