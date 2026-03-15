USE [LMS]
GO

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