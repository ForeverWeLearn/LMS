USE [LMS]
GO

INSERT INTO Category(name) VALUES
(N'Thiếu nhi'),
(N'Truyện ngắn'),
(N'Văn học'),
(N'Lịch sử'),
(N'Triết học'),
(N'Tiểu thuyết'),
(N'Văn hóa')
GO

INSERT INTO Publisher(name) VALUES
(N'NXB Trẻ'),
(N'NXB Chính trị Quốc gia - Sự thật'),
(N'NXB Giáo dục'),
(N'NXB Văn học'),
(N'NXB Khoa học Xã hội')
GO

INSERT INTO Author(name) VALUES
(N'Nguyễn Nhật Ánh'),
(N'Ngô Bảo Châu'),
(N'Trần Đức Thảo'),
(N'Lê Văn Lan'),
(N'Nguyễn Khải')
GO

INSERT INTO Book(ISBN, title, category_id, description, language, publisher_id) VALUES
('9786042088765', N'Mắt Biếc', 6, N'Mắt Biếc kể về câu chuyện tình yêu đơn phương của Ngạn dành cho Hà Lan từ thuở nhỏ đến khi trưởng thành.', 'vi_VN', 1),
('9786042088758', N'Cho Tôi Xin Một Vé Đi Tuổi Thơ', 1, N'Tác phẩm đưa người đọc trở về ký ức tuổi thơ hồn nhiên.', 'vi_VN', 1),
('9786049449490', N'Người Cùng Thời', 7, N'Tập hợp các bài viết, suy ngẫm về giáo dục và văn hóa.', 'vi_VN', 1),
('9786042088826', N'Tổ Quốc Ăn Năn', 4, N'Những suy tư về lịch sử và ký ức tập thể.', 'vi_VN', 1),
('9786049449537', N'Tìm hiểu nguồn gốc ngôn ngữ và ý thức', 5, N'Công trình nghiên cứu về sự hình thành ngôn ngữ.', 'vi_VN', 5),
('9786049449520', N'Hiện tượng học và chủ nghĩa duy vật biện chứng', 5, N'Bản dịch tiếng Việt của tác phẩm kinh điển.', 'vi_VN', 2),
('9786049449643', N'Lịch Sử Việt Nam – Những Vấn Đề Cơ Bản', 4, N'Tài liệu nghiên cứu về lịch sử Việt Nam.', 'vi_VN', 3),
('9786049449636', N'Văn Hóa Việt Nam – Truyền Thống và Hiện Đại', 7, N'Phân tích sự biến đổi của văn hóa Việt Nam.', 'vi_VN', 5),
('9786049449803', N'Mùa Lạc', 3, N'Tác phẩm phản ánh công cuộc xây dựng kinh tế mới.', 'vi_VN', 4),
('9786049449805', N'Gặp Gỡ Cuối Năm', 6, N'Tiểu thuyết phản ánh đời sống xã hội thời kỳ đổi mới.', 'vi_VN', 4)
GO

INSERT INTO BookAuthor(book_id, author_id, is_primary) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 2, 1),
(4, 4, 1),
(5, 3, 1),
(6, 3, 1),
(7, 4, 1),
(8, 2, 1),
(9, 5, 1),
(10, 5, 1)
GO

INSERT INTO BookItem(book_id, barcode, status, shelf_position) VALUES
(1, 'BC001', 'Available', 'A01'),
(2, 'BC002', 'Available', 'A02'),
(3, 'BC003', 'Available', 'A03'),
(4, 'BC004', 'Available', 'A04'),
(5, 'BC005', 'Available', 'A05'),
(6, 'BC006', 'Available', 'A06'),
(7, 'BC007', 'Available', 'A07'),
(8, 'BC008', 'Available', 'A08'),
(9, 'BC009', 'Available', 'A09'),
(10, 'BC010', 'Available', 'A10')
GO

INSERT INTO Staff(name, phone) VALUES
(N'Nguyễn Thế Anh', '0900000001'),
(N'Châm Duy Khoát', '0900000002'),
(N'Đinh Duy Khương', '0900000003'),
(N'Hoàng Minh Nhất', '0900000004')
GO

INSERT INTO MemberCard(card_number, expiry, status) VALUES
('000-0000-00001', '2027-12-31', 'Active'),
('000-0000-00002', '2027-12-31', 'Active'),
('000-0000-00003', '2027-12-31', 'Active'),
('000-0000-00004', '2027-12-31', 'Active')
GO

INSERT INTO Member(phone, name, email, address, card_number) VALUES
('0912345601', N'Sơn Tùng M-TP', 'sontung@mpt.com', N'Saigon Trade Center, phường Bến Nghé, Quận 1, TP. Hồ Chí Minh', '000-0000-00001'),
('0912345602', N'Taylor Swift', 'swift@gmail.com', N'American', '000-0000-00002'),
('0912345603', N'Leo Messi', 'messi@gmail.com', N'South Florida', '000-0000-00003'),
('0912345604', N'MrBeast', 'beast@vip.com', N'Greenville, North Carolina', '000-0000-00004')
GO

