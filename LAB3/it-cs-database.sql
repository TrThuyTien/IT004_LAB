CREATE DATABASE QUANLYDUAN
USE QUANLYDUAN

-- Tạo bảng Chuyên gia
CREATE TABLE ChuyenGia (
    MaChuyenGia INT PRIMARY KEY,
    HoTen NVARCHAR(100),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    Email NVARCHAR(100),
    SoDienThoai NVARCHAR(20),
    ChuyenNganh NVARCHAR(50),
    NamKinhNghiem INT
);

-- Tạo bảng Công ty
CREATE TABLE CongTy (
    MaCongTy INT PRIMARY KEY,
    TenCongTy NVARCHAR(100),
    DiaChi NVARCHAR(200),
    LinhVuc NVARCHAR(50),
    SoNhanVien INT
);

-- Tạo bảng Dự án
CREATE TABLE DuAn (
    MaDuAn INT PRIMARY KEY,
    TenDuAn NVARCHAR(200),
    MaCongTy INT,
    NgayBatDau DATE,
    NgayKetThuc DATE,
    TrangThai NVARCHAR(50),
    FOREIGN KEY (MaCongTy) REFERENCES CongTy(MaCongTy)
);

-- Tạo bảng Kỹ năng
CREATE TABLE KyNang (
    MaKyNang INT PRIMARY KEY,
    TenKyNang NVARCHAR(100),
    LoaiKyNang NVARCHAR(50)
);

-- Tạo bảng Chuyên gia - Kỹ năng
CREATE TABLE ChuyenGia_KyNang (
    MaChuyenGia INT,
    MaKyNang INT,
    CapDo INT,
    PRIMARY KEY (MaChuyenGia, MaKyNang),
    FOREIGN KEY (MaChuyenGia) REFERENCES ChuyenGia(MaChuyenGia),
    FOREIGN KEY (MaKyNang) REFERENCES KyNang(MaKyNang)
);

-- Tạo bảng Chuyên gia - Dự án
CREATE TABLE ChuyenGia_DuAn (
    MaChuyenGia INT,
    MaDuAn INT,
    VaiTro NVARCHAR(50),
    NgayThamGia DATE,
    PRIMARY KEY (MaChuyenGia, MaDuAn),
    FOREIGN KEY (MaChuyenGia) REFERENCES ChuyenGia(MaChuyenGia),
    FOREIGN KEY (MaDuAn) REFERENCES DuAn(MaDuAn)
);

-- Chèn dữ liệu mẫu vào bảng Chuyên gia
INSERT INTO ChuyenGia (MaChuyenGia, HoTen, NgaySinh, GioiTinh, Email, SoDienThoai, ChuyenNganh, NamKinhNghiem)
VALUES 
(1, N'Nguyễn Văn An', '1985-05-10', N'Nam', 'nguyenvanan@email.com', '0901234567', N'Phát triển phần mềm', 10),
(2, N'Trần Thị Bình', '1990-08-15', N'Nữ', 'tranthiminh@email.com', '0912345678', N'An ninh mạng', 7),
(3, N'Lê Hoàng Cường', '1988-03-20', N'Nam', 'lehoangcuong@email.com', '0923456789', N'Trí tuệ nhân tạo', 9),
(4, N'Phạm Thị Dung', '1992-11-25', N'Nữ', 'phamthidung@email.com', '0934567890', N'Khoa học dữ liệu', 6),
(5, N'Hoàng Văn Em', '1987-07-30', N'Nam', 'hoangvanem@email.com', '0945678901', N'Điện toán đám mây', 8),
(6, N'Ngô Thị Phượng', '1993-02-14', N'Nữ', 'ngothiphuong@email.com', '0956789012', N'Phân tích dữ liệu', 5),
(7, N'Đặng Văn Giang', '1986-09-05', N'Nam', 'dangvangiang@email.com', '0967890123', N'IoT', 11),
(8, N'Vũ Thị Hương', '1991-12-20', N'Nữ', 'vuthihuong@email.com', '0978901234', N'UX/UI Design', 7),
(9, N'Bùi Văn Inh', '1989-04-15', N'Nam', 'buivaninch@email.com', '0989012345', N'DevOps', 8),
(10, N'Lý Thị Khánh', '1994-06-30', N'Nữ', 'lythikhanh@email.com', '0990123456', N'Blockchain', 4);

-- Chèn dữ liệu mẫu vào bảng Công ty
INSERT INTO CongTy (MaCongTy, TenCongTy, DiaChi, LinhVuc, SoNhanVien)
VALUES 
(1, N'TechViet Solutions', N'123 Đường Lê Lợi, TP.HCM', N'Phát triển phần mềm', 200),
(2, N'DataSmart Analytics', N'456 Đường Nguyễn Huệ, Hà Nội', N'Phân tích dữ liệu', 150),
(3, N'CloudNine Systems', N'789 Đường Trần Hưng Đạo, Đà Nẵng', N'Điện toán đám mây', 100),
(4, N'SecureNet Vietnam', N'101 Đường Võ Văn Tần, TP.HCM', N'An ninh mạng', 80),
(5, N'AI Innovate', N'202 Đường Lý Tự Trọng, Hà Nội', N'Trí tuệ nhân tạo', 120);

-- Chèn dữ liệu mẫu vào bảng Dự án
INSERT INTO DuAn (MaDuAn, TenDuAn, MaCongTy, NgayBatDau, NgayKetThuc, TrangThai)
VALUES 
(1, N'Phát triển ứng dụng di động cho ngân hàng', 1, '2023-01-01', '2023-06-30', N'Hoàn thành'),
(2, N'Xây dựng hệ thống phân tích dữ liệu khách hàng', 2, '2023-03-15', '2023-09-15', N'Đang thực hiện'),
(3, N'Triển khai giải pháp đám mây cho doanh nghiệp', 3, '2023-02-01', '2023-08-31', N'Đang thực hiện'),
(4, N'Nâng cấp hệ thống bảo mật cho tập đoàn viễn thông', 4, '2023-04-01', '2023-10-31', N'Đang thực hiện'),
(5, N'Phát triển chatbot AI cho dịch vụ khách hàng', 5, '2023-05-01', '2023-11-30', N'Đang thực hiện');

-- Chèn dữ liệu mẫu vào bảng Kỹ năng
INSERT INTO KyNang (MaKyNang, TenKyNang, LoaiKyNang)
VALUES 
(1, 'Java', N'Ngôn ngữ lập trình'),
(2, 'Python', N'Ngôn ngữ lập trình'),
(3, 'Machine Learning', N'Công nghệ'),
(4, 'AWS', N'Nền tảng đám mây'),
(5, 'Docker', N'Công cụ'),
(6, 'Kubernetes', N'Công cụ'),
(7, 'SQL', N'Cơ sở dữ liệu'),
(8, 'NoSQL', N'Cơ sở dữ liệu'),
(9, 'React', N'Framework'),
(10, 'Angular', N'Framework');

-- Chèn dữ liệu mẫu vào bảng Chuyên gia - Kỹ năng
INSERT INTO ChuyenGia_KyNang (MaChuyenGia, MaKyNang, CapDo)
VALUES 
(1, 1, 5), (1, 7, 4), (1, 9, 3),
(2, 2, 4), (2, 3, 3), (2, 8, 4),
(3, 2, 5), (3, 3, 5), (3, 4, 3),
(4, 2, 4), (4, 7, 5), (4, 8, 4),
(5, 4, 5), (5, 5, 4), (5, 6, 4),
(6, 2, 4), (6, 3, 3), (6, 7, 5),
(7, 1, 3), (7, 2, 4), (7, 5, 3),
(8, 9, 5), (8, 10, 4),
(9, 5, 5), (9, 6, 5), (9, 4, 4),
(10, 2, 3), (10, 3, 3), (10, 8, 4);

-- Chèn dữ liệu mẫu vào bảng Chuyên gia - Dự án
INSERT INTO ChuyenGia_DuAn (MaChuyenGia, MaDuAn, VaiTro, NgayThamGia)
VALUES 
(1, 1, N'Trưởng nhóm phát triển', '2023-01-01'),
(2, 4, N'Chuyên gia bảo mật', '2023-04-01'),
(3, 5, N'Kỹ sư AI', '2023-05-01'),
(4, 2, N'Chuyên gia phân tích dữ liệu', '2023-03-15'),
(5, 3, N'Kiến trúc sư đám mây', '2023-02-01'),
(6, 2, N'Chuyên gia phân tích dữ liệu', '2023-03-15'),
(7, 3, N'Kỹ sư IoT', '2023-02-01'),
(8, 1, N'Nhà thiết kế UX/UI', '2023-01-01'),
(9, 3, N'Kỹ sư DevOps', '2023-02-01'),
(10, 5, N'Kỹ sư Blockchain', '2023-05-01');

------------------------------///--------- LAB 3--------------///----------------------------------------------
--1. Hiển thị tên và cấp độ của tất cả các kỹ năng của chuyên gia có MaChuyenGia là 1, đồng thời lọc ra những kỹ năng có cấp độ thấp hơn 3.
select KN.TenKyNang, CGKN.CapDo
from KyNang KN
inner join ChuyenGia_KyNang CGKN
on KN.MaKyNang = CGKN.MaKyNang
where CGKN.MaChuyenGia = 1 and CGKN.CapDo < 3
go


--2. Liệt kê tên các chuyên gia tham gia dự án có MaDuAn là 2 và có ít nhất 2 kỹ năng khác nhau.
select CG.HoTen
from ChuyenGia CG
inner join ChuyenGia_KyNang CGKN
on CG.MaChuyenGia = CGKN.MaChuyenGia
inner join ChuyenGia_DuAn CGDA
on CG.MaChuyenGia = CGDA.MaChuyenGia
where CGDA.MaDuAn = 2 
group by CG.HoTen, CG.MaChuyenGia
having count(CGKN.MaKyNang) >= 2
go


--3. Hiển thị tên công ty và tên dự án của tất cả các dự án, sắp xếp theo tên công ty và số lượng chuyên gia tham gia dự án.
select CT.TenCongTy, DA.TenDuAn, count(CGDA.MaChuyenGia) as SoLuongChuyenGia
from DuAn DA
inner join ChuyenGia_DuAn CGDA
on DA.MaDuAn = CGDA.MaDuAn
inner join CongTy CT
on CT.MaCongTy = DA.MaCongTy
group by CT.TenCongTy, DA.TenDuAn
order by CT.TenCongTy, count(CGDA.MaChuyenGia) ASC 
go


--4. Đếm số lượng chuyên gia trong mỗi chuyên ngành và hiển thị chỉ những chuyên ngành có hơn 5 chuyên gia.
select ChuyenNganh, count(MaChuyenGia) as SoLuongChuyenGia
from ChuyenGia
group by ChuyenNganh
having count(MaChuyenGia) > 5
go 


--5. Tìm chuyên gia có số năm kinh nghiệm cao nhất và hiển thị cả danh sách kỹ năng của họ.
select CG.HoTen, KN.TenKyNang
from ChuyenGia CG
inner join ChuyenGia_KyNang CGKN
on CG.MaChuyenGia = CGKN.MaChuyenGia
inner join KyNang KN
on CGKN.MaKyNang = KN.MaKyNang
where CG.NamKinhNghiem >= ALL (select CG1.NamKinhNghiem
							   from ChuyenGia CG1
							   )
go
							   
--6. Liệt kê tên các chuyên gia và số lượng dự án họ tham gia, đồng thời tính toán tỷ lệ phần trăm so với tổng số dự án trong hệ thống.
WITH TongSoDuAn AS
(SELECT COUNT(MaDuAn) AS TongSoDA FROM DuAn)
SELECT CG.HoTen, COUNT(CGDA.MaDuAn) AS SoLuongDuA, ROUND(COUNT(CGDA.MaDuAn) * 100 / (SELECT TongSoDA FROM TongSoDuAn), 2) AS TyLe
FROM ChuyenGia CG
INNER JOIN ChuyenGia_DuAn CGDA
ON CG.MaChuyenGia = CGDA.MaChuyenGia
GROUP BY CG.HoTen, cg.MaChuyenGia

--7. Hiển thị tên công ty và số lượng dự án của mỗi công ty, bao gồm cả những công ty không có dự án nào.
SELECT CT.TenCongTy, COUNT(DA.MaDuAn) AS SoLuongDuAn
FROM CongTy CT
LEFT JOIN DuAn DA
ON CT.MaCongTy = DA.MaCongTy
GROUP BY CT.TenCongTy
GO
--8. Tìm kỹ năng được sở hữu bởi nhiều chuyên gia nhất, đồng thời hiển thị số lượng chuyên gia sở hữu kỹ năng đó.

SELECT TOP 1 WITH TIES KN.TenKyNang, COUNT(CGKN.MaChuyenGia) AS SoLuongChuyenGia
FROM KyNang KN
INNER JOIN ChuyenGia_KyNang CGKN
ON KN.MaKyNang = CGKN.MaKyNang
GROUP BY KN.TenKyNang
ORDER BY COUNT(CGKN.MaChuyenGia) DESC
GO

--9. Liệt kê tên các chuyên gia có kỹ năng 'Python' với cấp độ từ 4 trở lên, đồng thời tìm kiếm những người cũng có kỹ năng 'Java'.
(SELECT CG.HoTen
FROM ChuyenGia CG
INNER JOIN ChuyenGia_KyNang CGKN
ON CG.MaChuyenGia = CGKN.MaChuyenGia
INNER JOIN KyNang KN
ON KN.MaKyNang = CGKN.MaKyNang
WHERE KN.TenKyNang = 'Python' AND CGKN.CapDo >=4)
UNION 
(SELECT CG.HoTen
FROM ChuyenGia CG
INNER JOIN ChuyenGia_KyNang CGKN
ON CG.MaChuyenGia = CGKN.MaChuyenGia
INNER JOIN KyNang KN
ON KN.MaKyNang = CGKN.MaKyNang
WHERE KN.TenKyNang = 'Java'
)
--10. Tìm dự án có nhiều chuyên gia tham gia nhất và hiển thị danh sách tên các chuyên gia tham gia vào dự án 
-- Tạo 1 bảng tạm thời DemSLChuyenGia_DuAn để đếm số lượng chuyên gia trong mỗi dự án
-- Tạo 1 bảng tạm thời tìm dự án có nhiều chuyên gia nhất DuAnCoNhieuChuyenGia
WITH DemSLChuyenGia_DuAn AS 
(SELECT DA.MaDuAn, DA.TenDuAn, COUNT(CG.MaChuyenGia) AS SLChuyenGia
    FROM DuAn DA
    JOIN ChuyenGia_DuAn CGDA ON DA.MaDuAn = CGDA.MaDuAn
    JOIN ChuyenGia CG ON CG.MaChuyenGia = CGDA.MaChuyenGia
    GROUP BY DA.MaDuAn, DA.TenDuAn
),
DuAnCoNhieuChuyenGia AS 
(SELECT MaDuAn, TenDuAn, SLChuyenGia
    FROM DemSLChuyenGia_DuAn
    WHERE SLChuyenGia = (SELECT MAX(SLChuyenGia) FROM DemSLChuyenGia_DuAn)
)
-- Hiển thị danh sách các chuyên gia
select cg.HoTen
from ChuyenGia CG
join ChuyenGia_DuAn CGDA 
on CG.MaChuyenGia = CGDA.MaChuyenGia
join DuAnCoNhieuChuyenGia DAM
on CGDA.MaDuAn = DAM.MaDuAn;

--11. Hiển thị tên và số lượng kỹ năng của mỗi chuyên gia, đồng thời lọc ra những người có ít nhất 5 kỹ năng.
with 
	DemSLKyNang_ChuyenGia as 
	(select CG.MaChuyenGia, CG.HoTen, count(CGKN.MaKyNang) as SLKyNang
	from ChuyenGia CG
	join ChuyenGia_KyNang CGKN
	on CG.MaChuyenGia = CGKN.MaChuyenGia
	group by CG.HoTen, CG.MaChuyenGia
	)
select CG.HoTen, CKC.SLKyNang
from ChuyenGia CG
join DemSLKyNang_ChuyenGia CKC
on CG.MaChuyenGia = CKC.MaChuyenGia
where CKC.SLKyNang >= 5
go

--12. Tìm các cặp chuyên gia làm việc cùng dự án và hiển thị thông tin về số năm kinh nghiệm của từng cặp.
with 
	CG_DA_1 as (
		select CGDA.MaDuAn, CG.MaChuyenGia, CG.HoTen, CG.NamKinhNghiem
		from ChuyenGia CG
		join ChuyenGia_DuAn CGDA
		on CG.MaChuyenGia = CGDA.MaChuyenGia
	),
	CG_DA_2 as (
		select CGDA.MaDuAn, CG.MaChuyenGia, CG.HoTen, CG.NamKinhNghiem
		from ChuyenGia CG
		join ChuyenGia_DuAn CGDA
		on CG.MaChuyenGia = CGDA.MaChuyenGia
	)

select 
	Distinct DA.TenDuAn, 
	CG_DA_1.HoTen ChuyenGia1,
	CG_DA_1.NamKinhNghiem as ChuyenGia_KinhNghiem1,
	CG_DA_2.HoTen as ChuyenGia2,
	CG_DA_2.NamKinhNghiem as ChuyenGia_KinhNghiem2
from CG_DA_1 
join CG_DA_2
on CG_DA_1.MaDuAn = CG_DA_2.MaDuAn
join DuAn DA
on DA.MaDuAn = CG_DA_1.MaDuAn
where CG_DA_1.MaChuyenGia != CG_DA_2.MaChuyenGia and CG_DA_1.MaChuyenGia < CG_DA_2.MaChuyenGia

--13. Liệt kê tên các chuyên gia và số lượng kỹ năng cấp độ 5 của họ, đồng thời tính toán tỷ lệ phần trăm so với tổng số kỹ năng mà họ sở hữu.
with 
	CG_TongKN as (
		select CGKN.MaChuyenGia, count(CGKN.MaKyNang) as TongSoKyNang
		from ChuyenGia_KyNang CGKN
		group by CGKN.MaChuyenGia
	),
	CG_TongKNCapDo5 as (
		select CGKN.MaChuyenGia, count(CGKN.MaKyNang) as TongSoKyNang
		from ChuyenGia_KyNang CGKN
		where CGKN.CapDo = 5
		group by CGKN.MaChuyenGia
	)
select 
	CG.MaChuyenGia, 
	CG.HoTen,
	CG_TongKNCapDo5.TongSoKyNang as TongSoCapDo5 , 
	CG_TongKN.TongSoKyNang as TongSoCapDo, 
	round(CG_TongKNCapDo5.TongSoKyNang *100 / CG_TongKN.TongSoKyNang, 2) as TyLe
from CG_TongKN
join CG_TongKNCapDo5
on CG_TongKN.MaChuyenGia = CG_TongKNCapDo5.MaChuyenGia
join ChuyenGia CG
on CG.MaChuyenGia = CG_TongKN.MaChuyenGia

--14. Tìm các công ty không có dự án nào và hiển thị cả thông tin về số lượng nhân viên trong mỗi công ty đó.
select CT1.MaCongTy, CT1.TenCongTy, CT1.SoNhanVien
from CongTy CT1
where not exists (
	select CT2.MaCongTy
	from CongTy CT2
	join DuAn DA
	on CT2.MaCongTy = DA.MaCongTy
)
--15. Hiển thị tên chuyên gia và tên dự án họ tham gia, bao gồm cả những chuyên gia không tham gia dự án nào, sắp xếp theo tên chuyên gia.

--16. Tìm các chuyên gia có ít nhất 3 kỹ năng, đồng thời lọc ra những người không có bất kỳ kỹ năng nào ở cấp độ cao hơn 3.

--17. Hiển thị tên công ty và tổng số năm kinh nghiệm của tất cả chuyên gia trong các dự án của công ty đó, chỉ hiển thị những công ty có tổng số năm kinh nghiệm lớn hơn 10 năm.

--18. Tìm các chuyên gia có kỹ năng 'Java' nhưng không có kỹ năng 'Python', đồng thời hiển thị danh sách các dự án mà họ đã tham gia.

--19. Tìm chuyên gia có số lượng kỹ năng nhiều nhất và hiển thị cả danh sách các dự án mà họ đã tham gia.

--20. Liệt kê các cặp chuyên gia có cùng chuyên ngành và hiển thị thông tin về số năm kinh nghiệm của từng người trong cặp đó.

--21. Tìm công ty có tổng số năm kinh nghiệm của các chuyên gia trong dự án cao nhất và hiển thị danh sách tất 
--cả các dự án mà công ty đó đã thực hiện.

--22. Tìm kỹ năng được sở hữu bởi tất cả các chuyên gia và hiển thị danh sách chi tiết về từng chuyên gia sở hữu kỹ năng đó cùng với cấp độ của họ.