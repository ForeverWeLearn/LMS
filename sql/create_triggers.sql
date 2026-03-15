USE [LMS]
GO

-- 1. tu dong cap nhat tinh trang sach khi cho muon
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
-- 2. tu dong cap nhat tinh trang sach khi tra
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

-- 3. tu dong tao phieu phat khi tra qua han (gia 3.600)
CREATE TRIGGER trg_AutoCreateFine
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

-- 4. kiem tra tinh trang sach truoc khi cho muon
CREATE TRIGGER trg_CheckAvailabilityBeforeLoan
ON [Loan]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1 
        FROM [BookItem] bi
        JOIN inserted i ON bi.[id] = i.[book_item_id]
        WHERE bi.[status] <> 'Available'
    )
    BEGIN
        RAISERROR('Lỗi: Sách hiện không khả dụng (Đang mượn, hỏng hoặc mất).', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO [Loan] ([member_id], [book_item_id], [staff_id], [borrow_date], [due_date], [return_date])
        SELECT [member_id], [book_item_id], [staff_id], [borrow_date], [due_date], [return_date] 
        FROM inserted;
    END
END
GO