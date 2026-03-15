USE [LMS]
GO

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
    @ISBN VARCHAR(13),
    @title NVARCHAR(255),
    @category_id INT,
    @description NVARCHAR(MAX) = NULL,
    @language NVARCHAR(255),
    @publisher_id INT
AS
BEGIN
    INSERT INTO [Book] (ISBN, title, category_id, [description], [language], publisher_id)
    VALUES (@ISBN, @title, @category_id, @description, @language, @publisher_id);
    
    SELECT SCOPE_IDENTITY() AS NewBookId;
END
GO

CREATE OR ALTER PROCEDURE usp_UpdateBook
    @id INT,
    @ISBN VARCHAR(13) = NULL,
    @title NVARCHAR(255) = NULL,
    @category_id INT = NULL,
    @description NVARCHAR(MAX) = NULL,
    @language NVARCHAR(255) = NULL,
    @publisher_id INT = NULL
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
    @id INT
AS
BEGIN
    DELETE FROM [BookAuthor] WHERE book_id = @id;
    DELETE FROM [Book] WHERE id = @id;
END
GO