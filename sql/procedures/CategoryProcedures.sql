USE [LMS]
GO

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