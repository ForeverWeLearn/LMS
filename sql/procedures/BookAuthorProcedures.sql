USE [LMS]
GO

CREATE OR ALTER PROCEDURE usp_GetBookAuthors
    @book_id INT
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
    @book_id INT,
    @author_id INT,
    @is_primary BIT = 0
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
