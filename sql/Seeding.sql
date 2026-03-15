USE [LMS]
GO

INSERT INTO Category(id, name) VALUES
('thieu-nhi', N'Thiếu nhi'),
('truyen-ngan', N'Truyện ngắn'),
('van-hoc', N'Văn học'),
('lich-su', N'Lịch sử'),
('triet-hoc', N'Triết học'),
('tieu-thuyet', N'Tiểu thuyết'),
('van-hoa', N'Văn hóa')
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
('9786042088765', N'Mắt Biếc', 1, N'Mắt Biếc kể về câu chuyện tình yêu đơn phương của Ngạn dành cho Hà Lan từ thuở nhỏ đến khi trưởng thành đồng thời khắc họa sự trong sáng, day dứt và nỗi buồn của tình yêu không được đáp lại.', 'vi_VN', 1),
('9786042088758', N'Cho Tôi Xin Một Vé Đi Tuổi Thơ', 1, N'Tác phẩm đưa người đọc trở về ký ức tuổi thơ hồn nhiên, trong sáng, với những trò chơi và suy nghĩ ngây ngô nhưng đầy ý nghĩa.', 'vi_VN', 1),
('9786049449490', N'Người Cùng Thời', 7, N'Tập hợp các bài viết, suy ngẫm về giáo dục, văn hóa, xã hội và trách nhiệm công dân.', 'vi_VN', 1),
('9786042088826', N'Tổ Quốc Ăn Năn', 4, N'Những suy tự về lịch sử, ký ức tập thể và trách nhiệm của mỗi người với đất nước.', 'vi_VN', 1),
('9786049449537', N'Tìm hiểu nguồn gốc ngôn ngữ và ý thức', 5, N'Công trình nghiên cứu về sự hình thành ngôn ngữ và ý thức, gắn với quan điểm duy vật biện chứng.', 'vi_VN', 5),
('9786049449520', N'Hiện tượng học và chủ nghĩa duy vật biện chứng', 5, N'Bản dịch tiếng Việt của tác phẩm kinh điển năm 1951, giúp độc giả Việt Nam tiếp cận trực tiếp tư tưởng của ông.', 'vi_VN', 2),
('9786049449643', N'Lịch Sử Việt Nam – Những Vấn Đề Cơ Bản', 4, N'Tài liệu nghiên cứu và giảng dạy về lịch sử Việt Nam, tập trung vào các vấn đề nền tảng.', 'vi_VN', 3),
('9786049449636', N'Văn Hóa Việt Nam – Truyền Thống và Hiện Đại', 7, N'Phân tích sự tiếp nối và biến đổi của văn hóa Việt Nam qua các giai đoạn lịch sử.', 'vi_VN', 5),
('9786049449803', N'Mùa Lạc', 3, N'Xuất bản năm 1960, phản ánh công cuộc xây dựng kinh tế mới ở miền núi, ca ngợi tinh thần lao động.', 'vi_VN', 4),
('9786049449805', N'Gặp Gỡ Cuối Năm', 6, N'Tiểu thuyết nổi tiếng, phản ánh đời sống xã hội và những suy tự về con người trong thời kỳ đổi mới.', 'vi_VN', 4)
GO

INSERT INTO BookAuthor VALUES (1,1,1)
INSERT INTO BookAuthor VALUES (2,2,1)
INSERT INTO BookAuthor VALUES (3,3,1)
INSERT INTO BookAuthor VALUES (4,4,1)
INSERT INTO BookAuthor VALUES (5,5,1)

INSERT INTO BookItem(book_id, barcode, status, shelf_position) VALUES
(1,'BC001','Available','A01'),
(2,'BC002','Available','A02'),
(3,'BC003','Available','A03'),
(4,'BC004','Available','A04'),
(5,'BC005','Available','A05'),
(6,'BC006','Available','A06'),
(7,'BC007','Available','A07'),
(8,'BC008','Available','A08'),
(9,'BC009','Available','A09'),
(10,'BC010','Available','A10')
GO

INSERT INTO Staff(name, phone) VALUES
(N'Thủ thư Lan','0900000001'),
(N'Thủ thư Mai','0900000002'),
(N'Thủ thư Hương','0900000003'),
(N'Thủ thư Phương','0900000004'),
(N'Thủ thư Dũng','0900000005'),
(N'Thủ thư Hùng','0900000006'),
(N'Thủ thư Trang','0900000007')
GO

INSERT INTO MemberCard(card_number, expiry) VALUES
('LMS-0000-00001','2027-12-31'),
('LMS-0000-00002','2027-12-31'),
('LMS-0000-00003','2027-12-31'),
('LMS-0000-00004','2027-12-31'),
('LMS-0000-00005','2027-12-31'),
('LMS-0000-00006','2027-12-31'),
('LMS-0000-00007','2027-12-31'),
('LMS-0000-00008','2027-12-31'),
('LMS-0000-00009','2027-12-31'),
('LMS-0000-00010','2027-12-31')
GO

INSERT INTO Member(phone, name, email, address, card_number) VALUES
('0912345601',N'Nguyễn Văn An','an@gmail.com',N'Hà Nội','LMS-0000-00001'),
('0912345602',N'Trần Văn Bình','binh@gmail.com',N'Hà Nội','LMS-0000-00002'),
('0912345603',N'Lê Văn Công','cong@gmail.com',N'Hà Nội','LMS-0000-00003'),
('0912345604',N'Phạm Văn Đông','dong@gmail.com',N'Hà Nội','LMS-0000-00004'),
('0912345605',N'Hoàng Văn Hiệp','hiep@gmail.com',N'Hà Nội','LMS-0000-00005'),
('0912345606',N'Ngô Văn Sơn','son@gmail.com',N'Hà Nội','LMS-0000-00006'),
('0912345607',N'Đặng Văn Giang','giang@gmail.com',N'Hà Nội','LMS-0000-00007'),
('0912345608',N'Bùi Văn Hoàng','hoang@gmail.com',N'Hà Nội','LMS-0000-00008'),
('0912345609',N'Đỗ Văn Đạt','dat@gmail.com',N'Hà Nội','LMS-0000-00009'),
('0912345610',N'Phan Văn Cường','cuong@gmail.com',N'Hà Nội','LMS-0000-00010')
GO
