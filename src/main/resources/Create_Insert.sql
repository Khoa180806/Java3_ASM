USE PS45143_ASM;

-- Bảng CATEGORIES
CREATE TABLE Categories (
    Id NVARCHAR(50) PRIMARY KEY,   -- Mã loại tin
    Name NVARCHAR(200) NOT NULL    -- Tên loại tin
);

-- Bảng USERS
CREATE TABLE Users (
    Id NVARCHAR(50) PRIMARY KEY,   -- Mã đăng nhập
    Password NVARCHAR(255) NOT NULL,  -- Mật khẩu
    Fullname NVARCHAR(200) NOT NULL,  -- Họ và tên
    Birthday DATE NULL,               -- Ngày sinh
    Gender BIT NULL,                  -- Giới tính (0 = Nữ, 1 = Nam)
    Mobile NVARCHAR(20) NULL,         -- Điện thoại
    Email NVARCHAR(100) NULL,         -- Email
    Role BIT NOT NULL                 -- Vai trò (1 = Quản trị, 0 = Phóng viên)
);

-- Bảng NEWS
CREATE TABLE News (
    Id NVARCHAR(50) PRIMARY KEY,    -- Mã bản tin
    Title NVARCHAR(500) NOT NULL,   -- Tiêu đề
    Content NVARCHAR(MAX) NOT NULL, -- Nội dung
    Image NVARCHAR(500) NULL,       -- Hình ảnh/video
    PostedDate DATE NOT NULL,       -- Ngày đăng
    Author NVARCHAR(100) NOT NULL,  -- Tác giả
    ViewCount INT DEFAULT 0,        -- Số lượt xem
    CategoryId NVARCHAR(50) NOT NULL,  -- Mã loại tin
    Home BIT DEFAULT 0,             -- Trạng nhất
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);

-- Bảng NEWSLETTERS
CREATE TABLE Newsletters (
    Email NVARCHAR(100) PRIMARY KEY, -- Email nhận tin
    Enabled BIT NOT NULL             -- Trạng thái (1 = hiệu lực, 0 = hủy)
);


-- Dữ liệu mẫu cho CATEGORIES
INSERT INTO Categories (Id, Name)
VALUES
    ('TT', N'Thời sự'),
    ('KD', N'Kinh doanh'),
    ('TG', N'Thế giới'),
    ('VH', N'Văn hóa'),
    ('TTD', N'Thể thao');

-- Dữ liệu mẫu cho USERS
INSERT INTO Users (Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role)
VALUES
    ('admin01', '123456', N'Nguyễn Văn A', '1985-05-12', 1, '0912345678', 'admin01@example.com', 1),
    ('pv01', '123456', N'Trần Thị B', '1990-08-20', 0, '0987654321', 'pv01@example.com', 0),
    ('pv02', '123456', N'Lê Văn C', '1995-03-10', 1, '0909090909', 'pv02@example.com', 0);

-- Dữ liệu mẫu cho NEWS
INSERT INTO News (Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home)
VALUES
    ('N001', N'Thời tiết hôm nay', N'Hôm nay miền Bắc có mưa rào và dông rải rác.', 'weather.jpg', '2025-10-01', 'pv01', 120, 'TT', 1),
    ('N002', N'Giá vàng tăng mạnh', N'Trong phiên giao dịch sáng nay, giá vàng trong nước tăng 500.000 đồng/lượng.', 'gold.png', '2025-09-30', 'pv02', 85, 'KD', 0),
    ('N003', N'Bóng đá Việt Nam thắng Thái Lan', N'Tuyển Việt Nam đã giành chiến thắng 2-1 trước Thái Lan trong trận giao hữu.', 'football.jpg', '2025-09-29', 'pv01', 500, 'TTD', 1),
    ('N004', N'Lễ hội văn hóa Huế', N'Hàng nghìn du khách đổ về Huế tham dự lễ hội văn hóa đặc sắc.', 'festival.jpg', '2025-09-25', 'pv02', 200, 'VH', 0);

-- Dữ liệu mẫu cho NEWSLETTERS
INSERT INTO Newsletters (Email, Enabled)
VALUES
    ('user1@gmail.com', 1),
    ('user2@gmail.com', 1),
    ('user3@gmail.com', 0);