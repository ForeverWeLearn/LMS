USE [master];
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'LMS')
BEGIN
  ALTER DATABASE [LMS] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE [LMS];
END
GO

CREATE DATABASE [LMS] CONTAINMENT = NONE
GO

USE [LMS]
GO

CREATE TABLE [Book] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [ISBN] varchar(13) UNIQUE NOT NULL,
  [title] nvarchar(255) NOT NULL,
  [category_id] int NOT NULL,
  [description] nvarchar(max),
  [language] nvarchar(255) NOT NULL CHECK ([language] IN ('vi_VN', 'en_US')),
  [publisher_id] int NOT NULL
)
GO

CREATE TABLE [Category] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL
)
GO

CREATE TABLE [Author] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [Publisher] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [BookAuthor] (
  [book_id] int NOT NULL,
  [author_id] int NOT NULL,
  [is_primary] bit,
  PRIMARY KEY ([book_id], [author_id])
)
GO

CREATE TABLE [BookItem] (
  [id] integer PRIMARY KEY IDENTITY(1, 1),
  [book_id] int NOT NULL,
  [barcode] varchar(18) UNIQUE NOT NULL,
  [status] nvarchar(255) NOT NULL CHECK ([status] IN ('Available', 'Loaned', 'Broken', 'Lost')),
  [shelf_position] varchar(6)
)
GO

CREATE TABLE [Member] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [phone] varchar(15) NOT NULL,
  [name] nvarchar(255),
  [email] varchar(255),
  [address] nvarchar(255),
  [card_number] varchar(14) NOT NULL
)
GO

CREATE TABLE [MemberCard] (
  [card_number] varchar(14) PRIMARY KEY,
  [created_at] date NOT NULL DEFAULT (GETDATE()),
  [updated_at] date NOT NULL DEFAULT (GETDATE()),
  [expiry] date NOT NULL,
  [status] nvarchar(255) NOT NULL CHECK ([status] IN ('Active', 'Ban')) DEFAULT 'Active'
)
GO

CREATE TABLE [Loan] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [created_at] date NOT NULL DEFAULT (GETDATE()),
  [updated_at] date NOT NULL DEFAULT (GETDATE()),
  [member_id] int NOT NULL,
  [book_item_id] int NOT NULL,
  [staff_id] int NOT NULL,
  [borrow_date] date NOT NULL,
  [due_date] date NOT NULL,
  [return_date] date
)
GO

CREATE TABLE [Fine] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [loan_id] int NOT NULL,
  [amount] decimal(10,2) NOT NULL
)
GO

CREATE TABLE [Staff] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) NOT NULL,
  [phone] varchar(15) NOT NULL
)
GO

ALTER TABLE [Book] ADD FOREIGN KEY ([category_id]) REFERENCES [Category] ([id])
GO

ALTER TABLE [Book] ADD FOREIGN KEY ([publisher_id]) REFERENCES [Publisher] ([id])
GO

ALTER TABLE [BookAuthor] ADD FOREIGN KEY ([book_id]) REFERENCES [Book] ([id])
GO

ALTER TABLE [BookAuthor] ADD FOREIGN KEY ([author_id]) REFERENCES [Author] ([id])
GO

ALTER TABLE [BookItem] ADD FOREIGN KEY ([book_id]) REFERENCES [Book] ([id])
GO

ALTER TABLE [Member] ADD FOREIGN KEY ([card_number]) REFERENCES [MemberCard] ([card_number])
GO

ALTER TABLE [Loan] ADD FOREIGN KEY ([member_id]) REFERENCES [Member] ([id])
GO

ALTER TABLE [Loan] ADD FOREIGN KEY ([book_item_id]) REFERENCES [BookItem] ([id])
GO

ALTER TABLE [Loan] ADD FOREIGN KEY ([staff_id]) REFERENCES [Staff] ([id])
GO

ALTER TABLE [Fine] ADD FOREIGN KEY ([loan_id]) REFERENCES [Loan] ([id])
GO
