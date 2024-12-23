USE [master]
GO
/****** Object:  Database [EmployeeManagementSystemTaskDec24]    Script Date: 12/21/2024 5:58:18 PM ******/
CREATE DATABASE [EmployeeManagementSystemTaskDec24]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EmployeeManagementSystemTaskDec24', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\EmployeeManagementSystemTaskDec24.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EmployeeManagementSystemTaskDec24_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\EmployeeManagementSystemTaskDec24_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EmployeeManagementSystemTaskDec24].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET ARITHABORT OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET RECOVERY FULL 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET  MULTI_USER 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'EmployeeManagementSystemTaskDec24', N'ON'
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET QUERY_STORE = OFF
GO
USE [EmployeeManagementSystemTaskDec24]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [EmployeeManagementSystemTaskDec24]
GO
/****** Object:  UserDefinedFunction [dbo].[GetAveragePerformanceScoreByDepartment]    Script Date: 12/21/2024 5:58:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetAveragePerformanceScoreByDepartment](@DepartmentID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @AverageScore DECIMAL(10, 2);

    SELECT 
        @AverageScore = (
            SELECT AVG(pr.ReviewScore)
            FROM PerformanceReview pr
            WHERE pr.EmployeeID IN (
                SELECT e.EmployeeID
                FROM Employee e
                WHERE e.DepartmentID = @DepartmentID
            )
        );

    RETURN @AverageScore;
END;
GO
/****** Object:  Table [dbo].[Department]    Script Date: 12/21/2024 5:58:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [varchar](100) NOT NULL,
	[ManagerID] [int] NULL,
	[Budget] [decimal](15, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 12/21/2024 5:58:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Phone] [varchar](15) NOT NULL,
	[Position] [varchar](50) NULL,
	[JoiningDate] [date] NOT NULL,
	[DepartmentID] [int] NULL,
	[Status] [varchar](15) NULL,
	[Deleted] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PerformanceReview]    Script Date: 12/21/2024 5:58:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PerformanceReview](
	[ReviewID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[ReviewDate] [date] NOT NULL,
	[ReviewScore] [int] NULL,
	[ReviewNotes] [varchar](500) NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [ManagerID], [Budget]) VALUES (1, N'HR', 1, CAST(100000.00 AS Decimal(15, 2)))
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [ManagerID], [Budget]) VALUES (2, N'Engineering', 2, CAST(500000.00 AS Decimal(15, 2)))
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [ManagerID], [Budget]) VALUES (3, N'Sales', 24, CAST(300000.00 AS Decimal(15, 2)))
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [ManagerID], [Budget]) VALUES (4, N'Marketing', 4, CAST(1000000.00 AS Decimal(15, 2)))
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [ManagerID], [Budget]) VALUES (6, N'Operations', 18, CAST(50000000.00 AS Decimal(15, 2)))
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [ManagerID], [Budget]) VALUES (7, N'new', 22, CAST(0.00 AS Decimal(15, 2)))
SET IDENTITY_INSERT [dbo].[Department] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([EmployeeID], [Name], [Email], [Phone], [Position], [JoiningDate], [DepartmentID], [Status], [Deleted]) VALUES (1, N'Labir', N'labir@example.com', N'01842724386', N'HR Manager', CAST(N'2024-12-21' AS Date), 1, N'active', NULL)
INSERT [dbo].[Employee] ([EmployeeID], [Name], [Email], [Phone], [Position], [JoiningDate], [DepartmentID], [Status], [Deleted]) VALUES (2, N'Abir', N'abir@example.com', N'9876543210', N'Software Engineer', CAST(N'2022-05-20' AS Date), 2, N'active', NULL)
INSERT [dbo].[Employee] ([EmployeeID], [Name], [Email], [Phone], [Position], [JoiningDate], [DepartmentID], [Status], [Deleted]) VALUES (3, N'Kabir', N'kabir@example.com', N'5678901234', N'Sales Associate', CAST(N'2023-03-10' AS Date), 3, N'active', NULL)
INSERT [dbo].[Employee] ([EmployeeID], [Name], [Email], [Phone], [Position], [JoiningDate], [DepartmentID], [Status], [Deleted]) VALUES (4, N'sagir', N'sagir@gmail.com', N'151515', N'Ser software engineer', CAST(N'2024-12-20' AS Date), 4, N'active', N'Deleted')
INSERT [dbo].[Employee] ([EmployeeID], [Name], [Email], [Phone], [Position], [JoiningDate], [DepartmentID], [Status], [Deleted]) VALUES (18, N'Tanvir Anjum Labir', N'tanvir.labir@gmail.com', N'01842724386', N'SubarnaGramResortMobileApp', CAST(N'2024-12-21' AS Date), 6, N'active', N'Deleted')
INSERT [dbo].[Employee] ([EmployeeID], [Name], [Email], [Phone], [Position], [JoiningDate], [DepartmentID], [Status], [Deleted]) VALUES (19, N'Tanvir Anjum Labir', N'tanvir.labir@gmail.com', N'01842724386', N'SubarnaGramResortMobileApp', CAST(N'2024-12-21' AS Date), 3, N'active', N'Deleted')
INSERT [dbo].[Employee] ([EmployeeID], [Name], [Email], [Phone], [Position], [JoiningDate], [DepartmentID], [Status], [Deleted]) VALUES (20, N'TANVIR ANJUM LABIR IDRIS ALI', N'tanvir.labir@gmail.com', N'01842724386', N'adfasdf', CAST(N'2024-12-21' AS Date), 2, N'active', N'Deleted')
INSERT [dbo].[Employee] ([EmployeeID], [Name], [Email], [Phone], [Position], [JoiningDate], [DepartmentID], [Status], [Deleted]) VALUES (21, N'TANVIR ANJUM LABIR IDRIS ALI', N'tanvir.labir@gmail.com', N'01842724386', N'adfasdf', CAST(N'2024-12-21' AS Date), 2, N'active', N'Deleted')
INSERT [dbo].[Employee] ([EmployeeID], [Name], [Email], [Phone], [Position], [JoiningDate], [DepartmentID], [Status], [Deleted]) VALUES (22, N'akash', N'ask@gmai.com', N'01842724386', N'daf', CAST(N'2024-12-21' AS Date), 7, N'active', NULL)
INSERT [dbo].[Employee] ([EmployeeID], [Name], [Email], [Phone], [Position], [JoiningDate], [DepartmentID], [Status], [Deleted]) VALUES (23, N'akash', N'ask@gmai.com', N'01842724386', N'daf', CAST(N'2024-12-21' AS Date), 7, N'active', NULL)
INSERT [dbo].[Employee] ([EmployeeID], [Name], [Email], [Phone], [Position], [JoiningDate], [DepartmentID], [Status], [Deleted]) VALUES (24, N'suba', N'selimsarkar11@gmail.com', N'01717244761', N'afds', CAST(N'2024-12-21' AS Date), 3, N'active', NULL)
INSERT [dbo].[Employee] ([EmployeeID], [Name], [Email], [Phone], [Position], [JoiningDate], [DepartmentID], [Status], [Deleted]) VALUES (25, N'suba', N'selimsarkar11@gmail.com', N'01717244761', N'afds', CAST(N'2024-12-21' AS Date), 3, N'active', NULL)
INSERT [dbo].[Employee] ([EmployeeID], [Name], [Email], [Phone], [Position], [JoiningDate], [DepartmentID], [Status], [Deleted]) VALUES (26, N'suba', N'selimsarkar11@gmail.com', N'01717244761', N'software engineer', CAST(N'2024-12-21' AS Date), 2, N'active', NULL)
INSERT [dbo].[Employee] ([EmployeeID], [Name], [Email], [Phone], [Position], [JoiningDate], [DepartmentID], [Status], [Deleted]) VALUES (27, N'suba', N'selimsarkar11@gmail.com', N'01717244761', N'software engineer', CAST(N'2024-12-21' AS Date), 2, N'active', NULL)
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[PerformanceReview] ON 

INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (1, 1, CAST(N'2024-12-21' AS Date), 9, N'SubarnaGramResortMobileApp')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (2, 1, CAST(N'2024-12-21' AS Date), 9, N'SubarnaGramResortMobileApp')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (3, 3, CAST(N'2024-12-21' AS Date), 67, N'afds')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (4, 3, CAST(N'2024-12-21' AS Date), 67, N'afds')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (5, 2, CAST(N'2024-12-21' AS Date), 99, N'SubarnaGramResortMobileApp')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (9, 3, CAST(N'2024-12-21' AS Date), 2, N'SubarnaGramResortMobileApp')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (10, 3, CAST(N'2024-12-21' AS Date), 2, N'SubarnaGramResortMobileApp')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (15, 1, CAST(N'2024-12-21' AS Date), 4533, N'afdscheck')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (16, 1, CAST(N'2024-12-21' AS Date), 4533, N'afdscheck')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (6, 2, CAST(N'2024-12-21' AS Date), 99, N'SubarnaGramResortMobileApp')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (7, 25, CAST(N'2024-12-21' AS Date), 234, N'SubarnaGramResortMobileApp')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (8, 25, CAST(N'2024-12-21' AS Date), 234, N'SubarnaGramResortMobileApp')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (11, 23, CAST(N'2024-12-21' AS Date), 23, N'check')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (12, 23, CAST(N'2024-12-21' AS Date), 23, N'check')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (13, 1, CAST(N'2024-12-21' AS Date), 45, N'afds')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (14, 1, CAST(N'2024-12-21' AS Date), 45, N'afds')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (17, 2, CAST(N'2024-12-21' AS Date), 99, N'SubarnaGramResortMobileAppdgfffgfdsgsdfgfd')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (18, 2, CAST(N'2024-12-21' AS Date), 99, N'SubarnaGramResortMobileAppdgfffgfdsgsdfgfd')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (19, 3, CAST(N'2024-12-21' AS Date), 99, N'new')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (20, 3, CAST(N'2024-12-21' AS Date), 99, N'new')
INSERT [dbo].[PerformanceReview] ([ReviewID], [EmployeeID], [ReviewDate], [ReviewScore], [ReviewNotes]) VALUES (21, 1, CAST(N'2024-12-21' AS Date), 45, N'afdsnow')
SET IDENTITY_INSERT [dbo].[PerformanceReview] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Departme__D949CC3439DE3CC4]    Script Date: 12/21/2024 5:58:18 PM ******/
ALTER TABLE [dbo].[Department] ADD  CONSTRAINT [UQ__Departme__D949CC3439DE3CC4] UNIQUE NONCLUSTERED 
(
	[DepartmentName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_department_name]    Script Date: 12/21/2024 5:58:18 PM ******/
CREATE NONCLUSTERED INDEX [idx_department_name] ON [dbo].[Department]
(
	[DepartmentName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_employee_name]    Script Date: 12/21/2024 5:58:18 PM ******/
CREATE NONCLUSTERED INDEX [idx_employee_name] ON [dbo].[Employee]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_Employee] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [FK_Department_Employee]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Department] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Department]
GO
/****** Object:  StoredProcedure [dbo].[AddDepartment]    Script Date: 12/21/2024 5:58:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddDepartment]
@DepartmentName varchar(100),
@Budget Decimal
AS
BEGIN
    SET NOCOUNT ON;
    
	BEGIN TRY
        INSERT INTO Department (DepartmentName,Budget)
        VALUES ( @DepartmentName, @Budget);
        SELECT 'Department added successfully.' AS Message;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS Message;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[AddEmployee]    Script Date: 12/21/2024 5:58:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddEmployee]
    @Name Varchar(100),
    @Email Varchar(100),
	@Phone Varchar(15),
	@Department INT,
	@Position Varchar(50),
	@JoiningDate date,
	@Status varchar(15)
AS
BEGIN
    SET NOCOUNT ON;
    
	BEGIN TRY
        INSERT INTO Employee (Name, Email, Phone, DepartmentId, Position, JoiningDate, Status)
        VALUES (@Name, @Email, @Phone, @Department, @Position, @JoiningDate, @Status);

        SELECT 'Employee added successfully.' AS Message;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS Message;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[AddManager]    Script Date: 12/21/2024 5:58:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddManager]
@DepartmentId INT,
@ManagerId INT
AS
BEGIN
    SET NOCOUNT ON;
    Update Department set
		ManagerID = @ManagerId
		--Select *
		from 
		(
			Select DepartmentID as dID from Department d
			where d.DepartmentID = @DepartmentId
		) em where DepartmentID = em.dID 

        SELECT 'Manager Added successfully.' AS Message;
END;
GO
/****** Object:  StoredProcedure [dbo].[AddPerformanceReview]    Script Date: 12/21/2024 5:58:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddPerformanceReview]
    @EmployeeId INT,
    @ReviewDate date,
	@ReviewScore int,
	@ReviewNotes VARCHAR(100)
AS
BEGIN
    
	BEGIN TRY
        INSERT INTO PerformanceReview(EmployeeID, ReviewScore, ReviewDate, ReviewNotes)
        VALUES (@EmployeeId,@ReviewScore,@ReviewDate,@ReviewNotes);

        SELECT 'Review added successfully.' AS Message;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS Message;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteEmployee]    Script Date: 12/21/2024 5:58:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteEmployee]
	@Id INT
AS
BEGIN
    SET NOCOUNT ON;
    
	BEGIN TRY
        Update Employee Set Deleted = 'Deleted'
		--Select *
		from 
		(
			Select EmployeeId as empID from Employee c
			where c.EmployeeID = @Id
		) em where EmployeeID = em.empID 

        SELECT 'Employee Deleted successfully.' AS Message;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS Message;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllDepartments]    Script Date: 12/21/2024 5:58:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllDepartments]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT d.DepartmentID, DepartmentName, ISNULL(ManagerID,0) as ManagerID ,ISNULL(e.name,'') as ManagerName,Budget, ISNULL([dbo].[GetAveragePerformanceScoreByDepartment](d.DepartmentID), 0) as avgscore 
	FROM Department d
	left join Employee e on e.EmployeeID = d.ManagerID
    ORDER BY DepartmentID
END;
GO
/****** Object:  StoredProcedure [dbo].[GetAllEmployees]    Script Date: 12/21/2024 5:58:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllEmployees]
    @Page INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT EmployeeID, Name,Email,Phone,Position,JoiningDate,Status,e.DepartmentID,d.DepartmentName
    FROM Employee e
	left join Department d on e.DepartmentID = d.DepartmentID
	where e.Deleted is NULL or e.Deleted != 'Deleted'
    ORDER BY EmployeeId
    OFFSET (@Page - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetEmployeeByDept]    Script Date: 12/21/2024 5:58:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetEmployeeByDept]
@id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT EmployeeID, Name,Email,Phone,Position,JoiningDate,Status,e.DepartmentID,d.DepartmentName
    FROM Employee e
	left join Department d on e.DepartmentID = d.DepartmentID
	where e.DepartmentID = @id and e.Deleted is NULL or e.Deleted != 'Deleted'
    ORDER BY EmployeeId
END;
GO
/****** Object:  StoredProcedure [dbo].[GetEmployeeById]    Script Date: 12/21/2024 5:58:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetEmployeeById]
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT EmployeeID, Name,Email,Phone,Position,JoiningDate,Status,e.DepartmentID,d.DepartmentName
	from Employee e
	left join Department d on e.DepartmentID = d.DepartmentID
    where e.EmployeeID = @Id and e.Deleted is NULL and e.Deleted != 'Deleted'
END;
GO
/****** Object:  StoredProcedure [dbo].[GetPerformanceReviewList]    Script Date: 12/21/2024 5:58:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPerformanceReviewList]
AS
BEGIN
    SET NOCOUNT ON;
	Select ReviewID,e.Name as EmployeeName,ReviewDate,ReviewScore,ReviewNotes
	from PerformanceReview pr
	left join Employee e on e.EmployeeID = pr.EmployeeID
END;
GO
/****** Object:  StoredProcedure [dbo].[SearchEmployees]    Script Date: 12/21/2024 5:58:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SearchEmployees]
    @SearchQuery NVARCHAR(100) = NULL,
    @DepartmentID INT = NULL,
    @Position NVARCHAR(50) = NULL,
    @Page INT = 1,
    @PageSize INT = 10
AS
BEGIN
    SET NOCOUNT ON;

    -- Calculate the number of rows to skip
    DECLARE @Skip INT = (@Page - 1) * @PageSize;

    -- Fetch employees with filters and pagination
    SELECT 
        e.EmployeeID as Id,
        e.Name ,
        e.Position,
        d.DepartmentName,
        p.ReviewScore,
		e.JoiningDate,
		e.Email,
		e.Phone
    FROM 
        Employee e
    LEFT JOIN 
        Department d ON e.DepartmentID = d.DepartmentID
    LEFT JOIN 
        PerformanceReview p ON e.EmployeeID = p.EmployeeID
    WHERE 
        (@SearchQuery IS NULL OR e.Name LIKE '%' + @SearchQuery + '%')
        AND (@DepartmentID IS NULL OR e.DepartmentID = @DepartmentID)
        AND (@Position IS NULL OR e.Position = @Position)
		AND e.Deleted is NULL or e.Deleted != 'Deleted'
    ORDER BY 
        e.EmployeeID
    OFFSET @Skip ROWS FETCH NEXT @PageSize ROWS ONLY;
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateEmployee]    Script Date: 12/21/2024 5:58:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateEmployee]
	@Id INT,
    @Name Varchar(100),
    @Email Varchar(100),
	@Phone Varchar(15),
	@Department INT,
	@Position Varchar(50),
	@JoiningDate date,
	@Status varchar(15)
AS
BEGIN
    SET NOCOUNT ON;
    
	BEGIN TRY
        Update Employee set
		Name = @Name,
		Email = @Email,
		Phone = @Phone,
		DepartmentID = @Department,
		Position = @Position,
		JoiningDate = @JoiningDate,
		Status = @Status
		--Select *
		from 
		(
			Select EmployeeId as empID from Employee c
			where c.EmployeeID = @Id
		) em where EmployeeID = em.empID 

        SELECT 'Employee Updated successfully.' AS Message;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS Message;
    END CATCH
END
GO
USE [master]
GO
ALTER DATABASE [EmployeeManagementSystemTaskDec24] SET  READ_WRITE 
GO
