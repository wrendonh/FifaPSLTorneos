USE [master]
GO

DECLARE @TargetDatabaseName VARCHAR(100) = 'FifaPSL'

IF (EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = @TargetDatabaseName))
BEGIN
 EXEC ('ALTER DATABASE ' + @TargetDatabaseName + ' set single_user with rollback immediate')
 EXEC ('DROP DATABASE ' + @TargetDatabaseName )
END

EXEC ( 'CREATE DATABASE ' + @TargetDatabaseName )

IF EXISTS (SELECT loginname FROM master.dbo.syslogins WHERE name = 'FifaPSLUser')
BEGIN 
	DROP LOGIN PetricoreMudUser; 
END

CREATE LOGIN FifaPSLUser WITH PASSWORD = 'FifaPSLUser123',   
DEFAULT_LANGUAGE=[us_english], 
CHECK_EXPIRATION = OFF,  
CHECK_POLICY = OFF,
DEFAULT_DATABASE = FifaPSL;
GO

GO
USE [FifaPSL]
GO

/****** Object:  User [PetricoreMudUser]    Script Date: 21/03/2017 11:00:54 a. m. ******/
CREATE USER [FifaPSLUser] FOR LOGIN [FifaPSLUser] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [FifaPSLUser]
GO

/****** Object:  Table [dbo].[Group]    Script Date: 07/04/2017 4:39:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](10) NOT NULL,
 CONSTRAINT [PK_TournamentGroup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Match]    Script Date: 07/04/2017 4:39:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Match](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdLocalTeam] [int] NOT NULL,
	[IdVisitorTeam] [int] NOT NULL,
	[LocalTeamScore] [int] NULL,
	[VisitorTeamScore] [int] NULL,
	[PlayingDay] [int] NOT NULL,
	[Played] [bit] NOT NULL,
 CONSTRAINT [PK_Match] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Player]    Script Date: 07/04/2017 4:39:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Player](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Player] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role]    Script Date: 07/04/2017 4:39:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Rol] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[System]    Script Date: 07/04/2017 4:39:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[System](
	[Id] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_System] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Team]    Script Date: 07/04/2017 4:39:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Team] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TeamPlayer]    Script Date: 07/04/2017 4:39:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamPlayer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTeam] [int] NOT NULL,
	[IdPlayer] [int] NOT NULL,
 CONSTRAINT [PK_TournamentTeam] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tournament]    Script Date: 07/04/2017 4:39:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tournament](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[Rules] [nvarchar](max) NULL,
	[NumberPlayers] [int] NOT NULL,
	[NumberGroups] [int] NOT NULL,
	[IdSystem] [int] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Tournament] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TournamentPositionTable]    Script Date: 07/04/2017 4:39:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TournamentPositionTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTournamentTeamGroup] [int] NOT NULL,
	[PlayedMatches] [int] NOT NULL,
	[WonMatches] [int] NOT NULL,
	[TiedMatches] [int] NOT NULL,
	[LostMatches] [int] NOT NULL,
	[GoalsScored] [int] NOT NULL,
	[GoalsReceived] [int] NOT NULL,
	[GoalsDifference] [int] NOT NULL,
	[Points] [int] NOT NULL,
	[Position] [int] NULL,
 CONSTRAINT [PK_PositionTable] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TournamentTeamGroup]    Script Date: 07/04/2017 4:39:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TournamentTeamGroup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTournament] [int] NOT NULL,
	[IdTeamPlayer] [int] NOT NULL,
	[IdGroup] [int] NOT NULL,
 CONSTRAINT [PK_TournamentTeamGroup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 07/04/2017 4:39:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdRol] [int] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](500) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserPool]    Script Date: 07/04/2017 4:39:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPool](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [int] NOT NULL,
	[IdMatch] [int] NOT NULL,
	[LocalTeamScore] [int] NULL,
	[VisitorTeamScore] [int] NULL,
	[Points] [int] NOT NULL,
 CONSTRAINT [PK_UserPool] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserPoolPosition]    Script Date: 07/04/2017 4:39:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPoolPosition](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [int] NOT NULL,
	[IdTournament] [int] NOT NULL,
	[Points] [int] NOT NULL,
	[Position] [int] NOT NULL,
 CONSTRAINT [PK_UserPoolPosition] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Group] ON 

GO
INSERT [dbo].[Group] ([Id], [Name]) VALUES (1, N'Grupo A   ')
GO
INSERT [dbo].[Group] ([Id], [Name]) VALUES (2, N'Grupo B   ')
GO
INSERT [dbo].[Group] ([Id], [Name]) VALUES (3, N'Grupo C   ')
GO
INSERT [dbo].[Group] ([Id], [Name]) VALUES (4, N'Grupo D   ')
GO
INSERT [dbo].[Group] ([Id], [Name]) VALUES (5, N'Grupo E   ')
GO
INSERT [dbo].[Group] ([Id], [Name]) VALUES (6, N'Grupo F   ')
GO
INSERT [dbo].[Group] ([Id], [Name]) VALUES (7, N'Grupo G   ')
GO
INSERT [dbo].[Group] ([Id], [Name]) VALUES (8, N'Grupo H   ')
GO
SET IDENTITY_INSERT [dbo].[Group] OFF
GO
SET IDENTITY_INSERT [dbo].[Match] ON 

GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (1, 23, 19, NULL, NULL, 1, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (5, 41, 25, NULL, NULL, 1, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (6, 28, 8, NULL, NULL, 1, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (7, 19, 25, NULL, NULL, 2, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (8, 8, 23, NULL, NULL, 2, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (9, 28, 41, NULL, NULL, 2, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (10, 8, 19, NULL, NULL, 3, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (11, 25, 28, NULL, NULL, 3, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (12, 23, 41, NULL, NULL, 3, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (13, 19, 28, NULL, NULL, 4, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (14, 41, 8, NULL, NULL, 4, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (15, 23, 25, NULL, NULL, 4, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (17, 41, 19, NULL, NULL, 5, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (18, 28, 23, NULL, NULL, 5, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (19, 8, 25, NULL, NULL, 5, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (21, 19, 41, NULL, NULL, 6, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (22, 23, 28, NULL, NULL, 6, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (23, 25, 8, NULL, NULL, 6, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (24, 28, 19, NULL, NULL, 7, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (25, 8, 41, NULL, NULL, 7, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (26, 25, 23, NULL, NULL, 7, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (27, 19, 8, NULL, NULL, 8, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (28, 28, 25, NULL, NULL, 8, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (30, 41, 23, NULL, NULL, 8, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (32, 25, 19, NULL, NULL, 9, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (33, 23, 8, NULL, NULL, 9, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (34, 41, 28, NULL, NULL, 9, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (35, 19, 23, NULL, NULL, 10, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (36, 25, 41, NULL, NULL, 10, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (37, 8, 28, NULL, NULL, 10, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (38, 2, 1, NULL, NULL, 1, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (39, 5, 42, NULL, NULL, 1, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (40, 34, 29, NULL, NULL, 1, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (41, 1, 42, NULL, NULL, 2, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (42, 29, 2, NULL, NULL, 2, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (43, 34, 5, NULL, NULL, 2, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (44, 29, 1, NULL, NULL, 3, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (45, 42, 34, NULL, NULL, 3, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (46, 2, 5, NULL, NULL, 3, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (47, 1, 34, NULL, NULL, 4, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (48, 5, 29, NULL, NULL, 4, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (49, 2, 42, NULL, NULL, 4, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (51, 5, 1, NULL, NULL, 5, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (52, 34, 2, NULL, NULL, 5, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (53, 29, 42, NULL, NULL, 5, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (54, 1, 5, NULL, NULL, 6, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (55, 2, 34, NULL, NULL, 6, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (56, 42, 29, NULL, NULL, 6, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (57, 34, 1, NULL, NULL, 7, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (58, 29, 5, NULL, NULL, 7, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (59, 42, 2, NULL, NULL, 7, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (60, 1, 29, NULL, NULL, 8, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (61, 34, 42, NULL, NULL, 8, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (62, 5, 2, NULL, NULL, 8, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (63, 42, 1, NULL, NULL, 9, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (64, 2, 29, NULL, NULL, 9, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (65, 5, 34, NULL, NULL, 9, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (67, 1, 2, NULL, NULL, 10, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (68, 42, 5, NULL, NULL, 10, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (69, 29, 34, NULL, NULL, 10, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (70, 32, 16, NULL, NULL, 1, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (72, 43, 18, NULL, NULL, 1, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (73, 12, 35, NULL, NULL, 1, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (74, 16, 18, NULL, NULL, 2, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (75, 35, 32, NULL, NULL, 2, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (76, 12, 43, NULL, NULL, 2, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (77, 35, 16, NULL, NULL, 3, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (78, 18, 12, NULL, NULL, 3, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (79, 32, 43, NULL, NULL, 3, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (80, 16, 12, NULL, NULL, 4, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (81, 43, 35, NULL, NULL, 4, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (82, 32, 18, NULL, NULL, 4, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (83, 43, 16, NULL, NULL, 5, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (85, 12, 32, NULL, NULL, 5, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (86, 35, 18, NULL, NULL, 5, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (87, 16, 43, NULL, NULL, 6, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (88, 32, 12, NULL, NULL, 6, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (89, 18, 35, NULL, NULL, 6, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (90, 12, 16, NULL, NULL, 7, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (91, 35, 43, NULL, NULL, 7, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (92, 18, 32, NULL, NULL, 7, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (94, 16, 35, NULL, NULL, 8, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (95, 12, 18, NULL, NULL, 8, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (96, 43, 32, NULL, NULL, 8, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (97, 18, 16, NULL, NULL, 9, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (98, 32, 35, NULL, NULL, 9, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (99, 43, 12, NULL, NULL, 9, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (100, 16, 32, NULL, NULL, 10, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (101, 18, 43, NULL, NULL, 10, 0)
GO
INSERT [dbo].[Match] ([Id], [IdLocalTeam], [IdVisitorTeam], [LocalTeamScore], [VisitorTeamScore], [PlayingDay], [Played]) VALUES (102, 35, 12, NULL, NULL, 10, 0)
GO
SET IDENTITY_INSERT [dbo].[Match] OFF
GO
SET IDENTITY_INSERT [dbo].[Player] ON 

GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (1, N'Alejandro Trejos', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (2, N'Alexander Botero', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (3, N'Andrés Gonzalez', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (4, N'Andrés Holguín', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (5, N'Cristian Molina', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (6, N'Daniel Castaño', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (7, N'Daniel Restrepo', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (8, N'David Escobar', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (9, N'Diego Patiño', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (10, N'Edison Castro', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (11, N'Eduardo Cardona', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (12, N'Edwin Escudero', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (13, N'Ever Echeverri', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (14, N'Jackson Palacios', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (15, N'Jhonathan Olaya', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (16, N'Juan Dueñas', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (17, N'Juan Naffah', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (18, N'Juan Peña', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (19, N'Juan Valencia', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (20, N'Juan Velásquez', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (21, N'Julián Garzón', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (22, N'Julián Loaiza', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (23, N'Luis Hernandez', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (24, N'Luis Ramirez', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (25, N'Marcos Manrique', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (26, N'Mauricio Urrego', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (27, N'Miguel Montes', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (28, N'Nicolás Giraldo', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (29, N'Raul Zuluaga', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (30, N'Santiago Salamanca', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (31, N'Santiago Tobón', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (32, N'Wilson Rendón', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (33, N'Wilfrank Montalvo', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (34, N'Yamir Asprilla', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (35, N'Otro1', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (36, N'Otro2', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (37, N'Otro3', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (38, N'Otro4', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (39, N'Otro5', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (40, N'Otro6', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (41, N'Otro7', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (42, N'Otro8', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (43, N'Otro9', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (44, N'Otro10', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (45, N'Otro11', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (46, N'Otro12', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (47, N'Otro13', 1)
GO
INSERT [dbo].[Player] ([Id], [Name], [Active]) VALUES (48, N'Otro14', 1)
GO
SET IDENTITY_INSERT [dbo].[Player] OFF
GO
INSERT [dbo].[Role] ([Id], [Name]) VALUES (1, N'Administrator')
GO
INSERT [dbo].[Role] ([Id], [Name]) VALUES (2, N'Bettor')
GO
INSERT [dbo].[System] ([Id], [Name]) VALUES (1, N'League')
GO
INSERT [dbo].[System] ([Id], [Name]) VALUES (2, N'Groups + Qualifying round')
GO
SET IDENTITY_INSERT [dbo].[Team] ON 

GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (1, N'América de México')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (2, N'Atlético Junior')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (3, N'Atlético Nacional')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (4, N'Boca Juniors')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (5, N'Colo Colo')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (6, N'Cruz Azul')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (7, N'Deportivo Cali')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (8, N'Estudiantes')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (9, N'FC Dallas')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (10, N'Guadalajara')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (11, N'Independiente de Avellaneda')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (12, N'Independiente Medellín')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (13, N'Independiente Santafe ')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (14, N'Jaguares de Chiapas')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (15, N'Lanús')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (16, N'León')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (17, N'Monterrey')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (18, N'Morelia')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (19, N'New York City')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (20, N'Pachuca')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (21, N'Portland Timbers')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (22, N'Racing Club')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (23, N'River Plate')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (24, N'Rosario Central')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (25, N'San Lorenzo')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (26, N'Santos Laguna')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (27, N'Tigres')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (28, N'Tijuana')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (29, N'Toluca')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (30, N'Toronto FC')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (31, N'UNAM')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (32, N'Universidad Católica')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (33, N'Universidad de Chile')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (34, N'Vancouver Whitecaps')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (35, N'Equipo1')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (36, N'Equipo2')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (37, N'Equipo3')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (38, N'Equipo4')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (39, N'Equipo5')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (40, N'Equipo6')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (41, N'Equipo7')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (42, N'Equipo8')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (43, N'Equipo9')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (44, N'Equipo10')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (45, N'Equipo11')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (46, N'Equipo12')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (47, N'Equipo13')
GO
INSERT [dbo].[Team] ([Id], [Name]) VALUES (48, N'Equipo14')
GO
SET IDENTITY_INSERT [dbo].[Team] OFF
GO
SET IDENTITY_INSERT [dbo].[TeamPlayer] ON 

GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (1, 1, 11)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (2, 2, 2)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (3, 3, 34)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (4, 4, 5)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (5, 5, 27)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (6, 6, 1)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (7, 7, 21)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (8, 8, 4)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (9, 9, 33)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (10, 10, 31)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (11, 11, 30)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (12, 12, 32)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (13, 13, 13)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (14, 14, 14)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (15, 15, 29)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (16, 16, 20)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (17, 17, 6)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (18, 18, 24)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (19, 19, 16)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (20, 20, 7)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (21, 21, 25)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (22, 22, 28)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (23, 23, 12)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (24, 24, 3)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (25, 25, 22)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (26, 26, 9)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (27, 27, 23)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (28, 28, 19)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (29, 29, 10)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (30, 30, 17)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (31, 31, 18)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (32, 32, 8)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (33, 33, 26)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (34, 34, 15)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (35, 35, 35)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (36, 36, 36)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (37, 37, 37)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (38, 38, 38)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (39, 39, 39)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (40, 40, 40)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (41, 41, 41)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (42, 42, 42)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (43, 43, 43)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (44, 44, 44)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (45, 45, 45)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (46, 46, 46)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (47, 47, 47)
GO
INSERT [dbo].[TeamPlayer] ([Id], [IdTeam], [IdPlayer]) VALUES (48, 48, 48)
GO
SET IDENTITY_INSERT [dbo].[TeamPlayer] OFF
GO
SET IDENTITY_INSERT [dbo].[Tournament] ON 

GO
INSERT [dbo].[Tournament] ([Id], [Name], [Rules], [NumberPlayers], [NumberGroups], [IdSystem], [Active]) VALUES (2, N'Copa Libertadores', N'REGLAS COPA LIBERTADORES

PREMIOS <br>(ESTO PUEDE CAMBIAR DEPENDIENDO DEL PREMIO)<br>
A los 32 eliminados de primera ronda se les pagarán $5.000<br>
A los 8 eliminados de 8vos de final se les pagarán $15.000<br>
A los 4 eliminados de 4tos de final se les pagarán $20.000
<br>A los 2 eliminados de semifinales se les pagarán $50.000
<br>
Para el premio total quedarán $ (70% al primero - 30% al segundo)

<br>CONDICIONES PREMIOS<br>
Para poder acceder a los premios no puede haber perdido ni un solo partido por W, excepto para el de campeón y subcampeón<br>

SELECCIÓN DE EQUIPOS
<br>
Los mejores equipos de américa por sorteo
<br>Se hará la selección de equipo por sorteo, con 3 oportunidades de selección pero si se pide una siguiente opción no se puede volver a una anterior
<br>
El sorteo lo hará Wilson Rendón<br>
VALOR DE LA INSCRIPCIÓN
<br>
Gratis

<br>
SANCIONES
<br>
1. Amarilla $1.000 Roja $2.000
<br>
2. Persona que no avise que no puede jugar hasta las 11:00 a.m. del día del partido, pierde por W. (5 minutos)
3. Persona que llegue tarde al partido paga 500 (1 minuto)
4. La plata de las sanciones se pagará a su rival de turno
5. Partido definido por W, quedará con resultado 3-0, sin posibilidad de jugarse

SISTEMA
8 grupos de 6 jugadores cada uno y pasan los dos primeros de cada grupo
Todo el torneo se jugará a ida y vuelta
Los emparejamientos de octavos de final se harán de la siguiente manera. Clasificacion de los 8 primeros ubicados del 1 al 8 y otra del 9 al 16 con los segundos; emparejándose así: A (1vs16), B (2vs15), C (3vs14) y así  sucesivamente 
Los emparejamientos de cuartos de final se haran 1 (AvsC), 2 (EvsG), 3 (BvsD) y 4 (FvsH)
Las semifinales se harán 1vs2 y 3vs4', 48, 8, 2, 1)
GO
SET IDENTITY_INSERT [dbo].[Tournament] OFF
GO
SET IDENTITY_INSERT [dbo].[TournamentPositionTable] ON 

GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (1, 1, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (2, 2, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (3, 3, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (4, 4, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (5, 5, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (6, 6, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (7, 7, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (8, 8, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (9, 9, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (10, 10, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (11, 11, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (12, 12, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (13, 13, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (14, 14, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (15, 15, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (16, 16, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (17, 17, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (18, 18, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (19, 19, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (20, 20, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (21, 21, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (22, 22, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (23, 23, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (24, 24, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (25, 25, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (26, 26, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (27, 27, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (28, 28, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (29, 29, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (30, 30, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (31, 31, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (32, 32, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (33, 33, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (34, 34, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (35, 35, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (36, 36, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (37, 37, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (38, 38, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (39, 39, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (40, 40, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (41, 41, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (42, 42, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (43, 43, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (44, 44, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (45, 45, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (46, 46, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (47, 47, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
INSERT [dbo].[TournamentPositionTable] ([Id], [IdTournamentTeamGroup], [PlayedMatches], [WonMatches], [TiedMatches], [LostMatches], [GoalsScored], [GoalsReceived], [GoalsDifference], [Points], [Position]) VALUES (48, 48, 0, 0, 0, 0, 0, 0, 0, 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[TournamentPositionTable] OFF
GO
SET IDENTITY_INSERT [dbo].[TournamentTeamGroup] ON 

GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (1, 2, 1, 2)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (2, 2, 2, 2)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (3, 2, 3, 7)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (4, 2, 4, 6)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (5, 2, 5, 2)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (6, 2, 6, 5)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (7, 2, 7, 7)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (8, 2, 8, 1)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (9, 2, 9, 6)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (10, 2, 10, 7)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (11, 2, 11, 8)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (12, 2, 12, 3)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (13, 2, 13, 7)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (14, 2, 14, 8)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (15, 2, 15, 5)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (16, 2, 16, 3)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (17, 2, 17, 4)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (18, 2, 18, 3)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (19, 2, 19, 1)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (20, 2, 20, 4)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (21, 2, 21, 5)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (22, 2, 22, 8)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (23, 2, 23, 1)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (24, 2, 24, 5)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (25, 2, 25, 1)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (26, 2, 26, 6)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (27, 2, 27, 6)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (28, 2, 28, 1)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (29, 2, 29, 2)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (30, 2, 30, 8)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (31, 2, 31, 4)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (32, 2, 32, 3)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (33, 2, 33, 4)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (34, 2, 34, 2)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (35, 2, 35, 3)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (36, 2, 36, 4)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (37, 2, 37, 5)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (38, 2, 38, 6)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (39, 2, 39, 7)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (40, 2, 40, 8)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (41, 2, 41, 1)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (42, 2, 42, 2)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (43, 2, 43, 3)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (44, 2, 44, 4)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (45, 2, 45, 5)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (46, 2, 46, 6)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (47, 2, 47, 7)
GO
INSERT [dbo].[TournamentTeamGroup] ([Id], [IdTournament], [IdTeamPlayer], [IdGroup]) VALUES (48, 2, 48, 8)
GO
SET IDENTITY_INSERT [dbo].[TournamentTeamGroup] OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Tournament]    Script Date: 07/04/2017 4:39:59 p. m. ******/
ALTER TABLE [dbo].[Tournament] ADD  CONSTRAINT [IX_Tournament] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Match] ADD  CONSTRAINT [DF_Match_PlayingDay]  DEFAULT ((0)) FOR [PlayingDay]
GO
ALTER TABLE [dbo].[TournamentPositionTable] ADD  CONSTRAINT [DF_PositionTable_PlayedMatches]  DEFAULT ((0)) FOR [PlayedMatches]
GO
ALTER TABLE [dbo].[TournamentPositionTable] ADD  CONSTRAINT [DF_PositionTable_WonMatches]  DEFAULT ((0)) FOR [WonMatches]
GO
ALTER TABLE [dbo].[TournamentPositionTable] ADD  CONSTRAINT [DF_PositionTable_TiedMatches]  DEFAULT ((0)) FOR [TiedMatches]
GO
ALTER TABLE [dbo].[TournamentPositionTable] ADD  CONSTRAINT [DF_PositionTable_LostMatches]  DEFAULT ((0)) FOR [LostMatches]
GO
ALTER TABLE [dbo].[TournamentPositionTable] ADD  CONSTRAINT [DF_PositionTable_GoalsScored]  DEFAULT ((0)) FOR [GoalsScored]
GO
ALTER TABLE [dbo].[TournamentPositionTable] ADD  CONSTRAINT [DF_PositionTable_GoalsReceived]  DEFAULT ((0)) FOR [GoalsReceived]
GO
ALTER TABLE [dbo].[TournamentPositionTable] ADD  CONSTRAINT [DF_PositionTable_GoalsDifference]  DEFAULT ((0)) FOR [GoalsDifference]
GO
ALTER TABLE [dbo].[TournamentPositionTable] ADD  CONSTRAINT [DF_PositionTable_Points]  DEFAULT ((0)) FOR [Points]
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD  CONSTRAINT [FK_Match_TournamentTeamGroup] FOREIGN KEY([IdLocalTeam])
REFERENCES [dbo].[TournamentTeamGroup] ([Id])
GO
ALTER TABLE [dbo].[Match] CHECK CONSTRAINT [FK_Match_TournamentTeamGroup]
GO
ALTER TABLE [dbo].[Match]  WITH CHECK ADD  CONSTRAINT [FK_Match_TournamentTeamGroup1] FOREIGN KEY([IdVisitorTeam])
REFERENCES [dbo].[TournamentTeamGroup] ([Id])
GO
ALTER TABLE [dbo].[Match] CHECK CONSTRAINT [FK_Match_TournamentTeamGroup1]
GO
ALTER TABLE [dbo].[TeamPlayer]  WITH CHECK ADD  CONSTRAINT [FK_TournamentTeam_Player] FOREIGN KEY([IdPlayer])
REFERENCES [dbo].[Player] ([Id])
GO
ALTER TABLE [dbo].[TeamPlayer] CHECK CONSTRAINT [FK_TournamentTeam_Player]
GO
ALTER TABLE [dbo].[TeamPlayer]  WITH CHECK ADD  CONSTRAINT [FK_TournamentTeam_Team] FOREIGN KEY([IdTeam])
REFERENCES [dbo].[Team] ([Id])
GO
ALTER TABLE [dbo].[TeamPlayer] CHECK CONSTRAINT [FK_TournamentTeam_Team]
GO
ALTER TABLE [dbo].[Tournament]  WITH CHECK ADD  CONSTRAINT [FK_Tournament_System] FOREIGN KEY([IdSystem])
REFERENCES [dbo].[System] ([Id])
GO
ALTER TABLE [dbo].[Tournament] CHECK CONSTRAINT [FK_Tournament_System]
GO
ALTER TABLE [dbo].[TournamentPositionTable]  WITH CHECK ADD  CONSTRAINT [FK_PositionTable_TournamentTeamGroup] FOREIGN KEY([IdTournamentTeamGroup])
REFERENCES [dbo].[TournamentTeamGroup] ([Id])
GO
ALTER TABLE [dbo].[TournamentPositionTable] CHECK CONSTRAINT [FK_PositionTable_TournamentTeamGroup]
GO
ALTER TABLE [dbo].[TournamentTeamGroup]  WITH CHECK ADD  CONSTRAINT [FK_TournamentTeamGroup_Group] FOREIGN KEY([IdGroup])
REFERENCES [dbo].[Group] ([Id])
GO
ALTER TABLE [dbo].[TournamentTeamGroup] CHECK CONSTRAINT [FK_TournamentTeamGroup_Group]
GO
ALTER TABLE [dbo].[TournamentTeamGroup]  WITH CHECK ADD  CONSTRAINT [FK_TournamentTeamGroup_TeamPlayer] FOREIGN KEY([IdTeamPlayer])
REFERENCES [dbo].[TeamPlayer] ([Id])
GO
ALTER TABLE [dbo].[TournamentTeamGroup] CHECK CONSTRAINT [FK_TournamentTeamGroup_TeamPlayer]
GO
ALTER TABLE [dbo].[TournamentTeamGroup]  WITH CHECK ADD  CONSTRAINT [FK_TournamentTeamGroup_Tournament] FOREIGN KEY([IdTournament])
REFERENCES [dbo].[Tournament] ([Id])
GO
ALTER TABLE [dbo].[TournamentTeamGroup] CHECK CONSTRAINT [FK_TournamentTeamGroup_Tournament]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_Table_1_Rol] FOREIGN KEY([IdRol])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_Table_1_Rol]
GO
ALTER TABLE [dbo].[UserPool]  WITH CHECK ADD  CONSTRAINT [FK_UserPool_Match] FOREIGN KEY([IdMatch])
REFERENCES [dbo].[Match] ([Id])
GO
ALTER TABLE [dbo].[UserPool] CHECK CONSTRAINT [FK_UserPool_Match]
GO
ALTER TABLE [dbo].[UserPool]  WITH CHECK ADD  CONSTRAINT [FK_UserPool_User] FOREIGN KEY([IdUser])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[UserPool] CHECK CONSTRAINT [FK_UserPool_User]
GO
ALTER TABLE [dbo].[UserPoolPosition]  WITH CHECK ADD  CONSTRAINT [FK_UserPoolPosition_Tournament] FOREIGN KEY([IdTournament])
REFERENCES [dbo].[Tournament] ([Id])
GO
ALTER TABLE [dbo].[UserPoolPosition] CHECK CONSTRAINT [FK_UserPoolPosition_Tournament]
GO
ALTER TABLE [dbo].[UserPoolPosition]  WITH CHECK ADD  CONSTRAINT [FK_UserPoolPosition_User] FOREIGN KEY([IdUser])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[UserPoolPosition] CHECK CONSTRAINT [FK_UserPoolPosition_User]
GO
