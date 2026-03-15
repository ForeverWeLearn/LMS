USE [LMS]
GO


CREATE TRIGGER trg_AfterInsertLoan_UpdateStatus
ON [Loan]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE [BookItem]
    SET [status] = 'Loaned'
    FROM [BookItem] bi
    INNER JOIN inserted i ON bi.[id] = i.[book_item_id];
    
    PRINT 'Trigger: BookItem status updated to [Loaned].';
END
GO


CREATE TRIGGER trg_AfterUpdateReturn_UpdateStatus
ON [Loan]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF UPDATE([return_date])
    BEGIN
        UPDATE [BookItem]
        SET [status] = 'Available'
        FROM [BookItem] bi
        INNER JOIN inserted i ON bi.[id] = i.[book_item_id]
        WHERE i.[return_date] IS NOT NULL;

        PRINT 'Trigger: BookItem status updated to [Available].';
    END
END
GO


CREATE TRIGGER trg_AfterUpdateLoan_AutoCreateFine
ON [Loan]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE([return_date])
    BEGIN
        INSERT INTO [Fine] ([loan_id], [amount])
        SELECT 
            i.[id], 
            DATEDIFF(DAY, i.[due_date], i.[return_date]) * 3600
        FROM inserted i
        WHERE i.[return_date] > i.[due_date];

        IF @@ROWCOUNT > 0
            PRINT 'Trigger: Late return detected. Fine record created.';
    END
END
GO
