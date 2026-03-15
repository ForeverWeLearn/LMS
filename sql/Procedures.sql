USE [LMS]
GO

-- Author ---------------------------------------------------------------------
CREATE OR ALTER PROCEDURE usp_GetAuthors
AS
BEGIN
    SELECT id, name FROM [Author];
END
GO

CREATE OR ALTER PROCEDURE usp_UpsertAuthor
    @id int = NULL,
    @name nvarchar(255)
AS
BEGIN
    MERGE INTO Author a
    USING (VALUES (@id, @name)) AS args (id, name)
    ON a.id = args.id
    WHEN MATCHED THEN UPDATE SET a.name = args.name
    WHEN NOT MATCHED THEN INSERT (id, name) VALUES (args.id, args.name);
END
GO

CREATE OR ALTER PROCEDURE usp_DeleteAuthor
    @id int
AS
BEGIN
    DELETE FROM [Author] WHERE id = @id;
END
GO


-- BookAuthor -----------------------------------------------------------------
CREATE OR ALTER PROCEDURE usp_GetBookAuthors
    @book_id int
AS
BEGIN
    SELECT 
        a.id AS author_id, 
        a.name, 
        ba.is_primary
    FROM [BookAuthor] ba
    JOIN [Author] a ON ba.author_id = a.id
    WHERE ba.book_id = @book_id;
END
GO

CREATE OR ALTER PROCEDURE usp_UpsertBookAuthor
    @book_id int,
    @author_id int,
    @is_primary bit = 0
AS
BEGIN
    MERGE INTO BookAuthor ba
    USING (VALUES (@book_id, @author_id, @is_primary)) AS args (book_id, author_id, is_primary)
    ON ba.book_id = args.book_id AND ba.author_id = args.author_id
    WHEN MATCHED THEN UPDATE SET ba.is_primary = args.is_primary
    WHEN NOT MATCHED THEN
        INSERT (book_id, author_id, is_primary)
        VALUES (@book_id, @author_id, @is_primary);
END
GO


-- Publisher ------------------------------------------------------------------
CREATE OR ALTER PROCEDURE usp_GetPublishers
AS
BEGIN
    SELECT id, name FROM [Publisher];
END
GO

CREATE OR ALTER PROCEDURE usp_UpsertPublisher
    @id int = NULL,
    @name nvarchar(255)
AS
BEGIN
    MERGE INTO Publisher p
    USING (VALUES (@id, @name)) AS args (id, name)
    ON p.id = args.id
    WHEN MATCHED THEN UPDATE SET p.name = args.name
    WHEN NOT MATCHED THEN INSERT (id, name) VALUES (args.id, args.name);
END
GO

CREATE OR ALTER PROCEDURE usp_DeletePublisher
    @id int
AS
BEGIN
    DELETE FROM [Publisher] WHERE id = @id;
END
GO


-- Category -------------------------------------------------------------------
CREATE OR ALTER PROCEDURE usp_GetCategories
AS
BEGIN
    SELECT id, name FROM [Category];
END
GO

CREATE OR ALTER PROCEDURE usp_UpsertCategory
	@id varchar(255),
	@name nvarchar(255)
AS
BEGIN
	MERGE INTO Category c
	USING (VALUES (@id, @name)) AS args (id, name)
	ON c.id = args.id
	WHEN MATCHED THEN UPDATE SET c.name = args.name
	WHEN NOT MATCHED THEN INSERT (id, name) VALUES (args.id, args.name);
END
GO

CREATE OR ALTER PROCEDURE usp_DeleteCategory
    @id varchar(255)
AS
BEGIN
    DELETE FROM [Category] WHERE id = @id;
END
GO


-- Book -----------------------------------------------------------------------
CREATE OR ALTER PROCEDURE usp_GetBooks
AS
BEGIN
    SELECT 
        b.id, 
        b.ISBN, 
        b.title, 
        c.name AS category_name, 
        p.name AS publisher_name, 
        b.[language], 
        b.[description]
    FROM [Book] b
    JOIN [Category] c ON c.id = b.category_id
    JOIN [Publisher] p ON p.id = b.publisher_id;
END
GO

CREATE OR ALTER PROCEDURE usp_InsertBook
    @ISBN varchar(13),
    @title nvarchar(255),
    @category_id int,
    @description nvarchar(MAX) = NULL,
    @language nvarchar(255),
    @publisher_id int
AS
BEGIN
    INSERT INTO [Book] (ISBN, title, category_id, [description], [language], publisher_id)
    VALUES (@ISBN, @title, @category_id, @description, @language, @publisher_id);
    
    SELECT SCOPE_IDENTITY() AS NewBookId;
END
GO

CREATE OR ALTER PROCEDURE usp_UpdateBook
    @id int,
    @ISBN varchar(13) = NULL,
    @title nvarchar(255) = NULL,
    @category_id int = NULL,
    @description nvarchar(MAX) = NULL,
    @language nvarchar(255) = NULL,
    @publisher_id int = NULL
AS
BEGIN
    UPDATE [Book]
    SET ISBN = ISNULL(@ISBN, ISBN),
        title = ISNULL(@title, title),
        category_id = ISNULL(@category_id, category_id),
        [description] = ISNULL(@description, [description]),
        [language] = ISNULL(@language, [language]),
        publisher_id = ISNULL(@publisher_id, publisher_id)
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE usp_DeleteBook
    @id int
AS
BEGIN
    DELETE FROM [BookAuthor] WHERE book_id = @id;
    DELETE FROM [Book] WHERE id = @id;
END
GO
