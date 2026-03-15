USE [LMS]
GO

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