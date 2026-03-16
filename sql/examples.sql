-- EXEC usp_GetAuthors;
-- EXEC usp_UpsertAuthor @id = NULL, @name = N'New Author';
-- EXEC usp_DeleteAuthor @id = 1;

-- EXEC usp_GetBookAuthors @book_id = 1;
-- EXEC usp_UpsertBookAuthor @book_id = 1, @author_id = 1, @is_primary = 0;

-- EXEC usp_GetPublishers;
-- EXEC usp_UpsertPublisher @id = NULL, @name = N'New Publisher';
-- EXEC usp_DeletePublisher @id = 1;

-- EXEC usp_GetCategories;
-- EXEC usp_UpsertCategory @id = NULL, @name = N'Cosmic Horror';
-- EXEC usp_DeleteCategory @id = 1;

-- EXEC usp_GetBooks;
-- EXEC usp_InsertBook @ISBN = '', @title = N'', @category_id = 1, @description = N'', @language = '', @publisher_id = 1;
-- EXEC usp_UpdateBook @id = 1, @ISBN = NULL, @title = NULL, @category_id = NULL, @description = NULL, @language = NULL, @publisher_id = NULL;
-- EXEC usp_DeleteBook @id = 1;

-- EXEC usp_CheckOutBook @member_id = 1, @barcode = '', @staff_id = 1, @due_date = '2026-01-01';
-- EXEC usp_ReturnBook @barcode = '';

-- SELECT * FROM vw_BooksSummary;
-- SELECT * FROM vw_BookWithAuthors;
