CREATE OR ALTER VIEW [vw_BooksSummary] AS
SELECT
    b.title,
    c.name AS category_name,
    b.[description]
FROM [Book] b
    JOIN [Category] c ON c.id = b.category_id
GO


CREATE OR ALTER VIEW [vw_BookWithAuthors] AS
SELECT 
    b.[title] AS [BookTitle],
    STRING_AGG(a.[name], ', ') WITHIN GROUP (ORDER BY ba.[is_primary] DESC, a.[name] ASC) AS [Authors]
FROM [Book] b
LEFT JOIN [BookAuthor] ba ON b.[id] = ba.[book_id]
LEFT JOIN [Author] a ON ba.[author_id] = a.[id]
GROUP BY 
    b.[title]
GO