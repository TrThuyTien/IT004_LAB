﻿CREATE DATABASE QUANLYBANHANG
USE QUANLYBANHANG

CREATE TABLE KHACHHANG(
	MAKH CHAR(4) PRIMARY KEY,
	HOTEN VARCHAR(40),
	DCHI VARCHAR(50),
	SODT VARCHAR(20),
	NGSING SMALLDATETIME,
	NGDK SMALLDATETIME,
	DOANHSO MONEY,
)
GO

CREATE TABLE NHANHVIEN(
	MANV CHAR(4) PRIMARY KEY,
	HOTEN VARCHAR(40),
	SODT VARCHAR(20),
	NGVL SMALLDATETIME,
)
GO

CREATE TABLE SANPHAM(
	MASP CHAR(4) PRIMARY KEY,
	TENSP VARCHAR(40),
	DVT VARCHAR(20),
	NUOCSX VARCHAR(40),
	GIA MONEY,
)
GO

CREATE TABLE HOADON(
	SOHD INT PRIMARY KEY,
	NGHD SMALLDATETIME,
	MAKH CHAR(4),
	MANV CHAR(4),
	TRIGIA MONEY,
)
GO

CREATE TABLE CTHD(
	SOHD INT,
	MASP CHAR(4),
	SL INT,
	PRIMARY KEY(SOHD, MASP),
)
GO

-- CAU 2
ALTER TABLE SANPHAM
ADD GHICHU VARCHAR(20)
GO

-- CAU 3
ALTER TABLE KHACHHANG
ADD LOAIKH TINYINT
GO

-- CAU 4
ALTER TABLE SANPHAM
ALTER COLUMN GHICHU VARCHAR(100)
GO

-- CAU 5
ALTER TABLE SANPHAM
DROP COLUMN GHICHU
GO

-- CAU 6 --> Thay doi kieu du lieu tu tinyint sang varchar
ALTER TABLE KHACHHANG
ALTER COLUMN LOAIKH VARCHAR(20)

ALTER TABLE KHACHHANG
ADD CONSTRAINT CK_LOAIKH CHECK(LOAIKH IN('Vang lai', 'Thuong xuyen', 'Vip'))
GO

-- CAU 7
ALTER TABLE SANPHAM
ADD CONSTRAINT CK_DVT CHECK (DVT IN('cay', 'hop', 'cai', 'quyen', 'chuc'))
GO

-- CAU 8
ALTER TABLE SANPHAM
ADD CONSTRAINT CK_GIA CHECK (GIA >= 500)
GO

-- CAU 9
ALTER TABLE CTHD
ADD CONSTRAINT CK_SL CHECK (SL >= 1)
GO

-- CAU 10
EXEC SP_RENAME 'KHACHHANG.NGSING', 'NGSINH', 'COLUMN'

ALTER TABLE KHACHHANG
ADD CONSTRAINT CK_NGSINH_NGDK CHECK (NGDK > NGSINH) -- Tìm cách khác
GO

-- CAU 11
CREATE TRIGGER TR_CHECK_NGAYMUAHANG
ON HOADON
FOR INSERT, UPDATE
AS 
BEGIN
	IF EXISTS (SELECT * FROM inserted i
				JOIN KHACHHANG k ON i.MAKH = k.MAKH
				WHERE i.NGHD < k.NGDK)
	BEGIN
		RAISERROR ('Ngay mua hang phai lon hon hoac bang ngay dang ki thanh vien', 16, 1)
		ROLLBACK TRANSACTION
	END
END
GO

-- CAU 12
CREATE TRIGGER TR_CHECK_NGAMUAHANG
ON HOADON
FOR INSERT, UPDATE
AS BEGIN
	IF EXISTS (SELECT * FROM inserted i
				JOIN NHANHVIEN k ON i.MANV = k.MANV
				WHERE i.NGHD < k.NGVL)
	BEGIN
		RAISERROR ('Ngay ban hoang cua mot nhan vien phai lon hon hoac bang ngay nhan vien do vao lam', 16, 1)
		ROLLBACK TRANSACTION
	END
END
GO

-- CAU 13
UPDATE HOADON
SET TRIGIA = (
	SELECT SUM(CTHD.SL * SANPHAM.GIA)
	FROM CTHD
	JOIN SANPHAM ON CTHD.MASP = SANPHAM.MASP
	WHERE CTHD.SOHD = HOADON.SOHD
)
GO

-- CAU 14
UPDATE KHACHHANG
SET DOANHSO = (
	SELECT SUM(HOADON.TRIGIA)
	FROM HOADON
	WHERE HOADON.MAKH = KHACHHANG.MAKH
)

------------------------------ LAB02 - BÀI TẬP 1 VÀ BÀI TẬP 3
-- II. Ngon ngu thao tac du lieu
-- Cau 1
-- Nhập dữ liệu cho bảng NHANVIEN
INSERT INTO NHANHVIEN (MANV, HOTEN, SODT, NGVL)
VALUES 
	('NV01', 'Nguyen Nhu Nhut', '0927345678', '2006-04-13'),
    ('NV02', 'Le Thi Phi Yen', '0987567390', '2006-04-21'),
    ('NV03', 'Nguyen Van B', '0997047382', '2006-04-27'),
    ('NV04', 'Ngo Thanh Tuan', '0913758498', '2006-06-24'),
    ('NV05', 'Nguyen Thi Truc Thanh', '0918590387', '2006-07-20');
GO

SELECT * FROM NHANHVIEN
GO

-- Nhập dữ liệu cho bảng KHACHHANG
INSERT INTO KHACHHANG (MAKH, HOTEN, DCHI, SODT, NGSINH, DOANHSO, NGDK)
VALUES 
    /*('KH01', 'Nguyen Van A', '731 Tran Hung Dao, Q5, TPHCM', '08823451', '1960-10-22', 13060000, '2006-07-22'),*/
    ('KH02', 'Tran Ngoc Han', '23/5 Nguyen Trai, Q5, TPHCM', '0908256478', '1974-04-03', 280000, '2006-07-30'),
    ('KH03', 'Tran Ngoc Linh', '45 Nguyen Canh Chan, Q1, TPHCM', '098776266', '1980-06-12', 3860000, '2006-08-05'),
    ('KH04', 'Tran Minh Long', '50/34 Le Dai Hanh, Q10, TPHCM', '0917253476', '1965-03-09', 250000, '2006-10-02'),
    ('KH05', 'Le Nhat Minh', '34 Truong Dinh, Q3, TPHCM', '08246108', '1950-03-10', 21000, '2006-10-28'),
    ('KH06', 'Le Hoai Thuong', '227 Nguyen Van Cu, Q5, TPHCM', '08633738', '1981-12-31', 915000, '2006-11-24'),
    ('KH07', 'Nguyen Van Tam', '323/3 Tran Binh Trong, Q5, TPHCM', '0916783565', '1971-04-06', 12500, '2006-01-12'),
    ('KH08', 'Phan Thi Thanh', '45/2 An Duong Vuong, Q5, TPHCM', '0938435756', '1971-01-10', 365000, '2006-12-13'),
    ('KH09', 'Le Ha Vinh', '873 Le Hong Phong, Q5, TPHCM', '08654763', '1979-03-09', 70000, '2007-01-14'),
    ('KH10', 'Ha Duy Lap', '34/34B Nguyen Trai, Q1, TPHCM', '08768904', '1983-05-02', 67500, '2007-01-16');
GO

SELECT * FROM KHACHHANG
GO

-- Nhập dữ liệu cho SANPHAM 
INSERT INTO SANPHAM (MASP, TENSP, DVT, NUOCSX, GIA)
VALUES
    ('BC01', 'But chi', 'cay', 'Singapore', 3000),
    ('BC02', 'But chi', 'cay', 'Singapore', 5000),
    ('BC03', 'But chi', 'cay', 'Viet Nam', 3500),
    ('BC04', 'But chi', 'hop', 'Viet Nam', 3000),
    ('BB01', 'But bi', 'cay', 'Viet Nam', 5000),
    ('BB02', 'But bi', 'hop', 'Trung Quoc', 7000),
    ('BB03', 'But bi', 'cay', 'Thai Lan', 10000),
    ('TV01', 'Tap 200 giay mong', 'quyen', 'Trung Quoc', 2500),
    ('TV02', 'Tap 100 giay mong', 'quyen', 'Trung Quoc', 4500),
    ('TV03', 'Tap 100 giay tot', 'quyen', 'Viet Nam', 3000),
    ('TV04', 'Tap 200 giay tot', 'quyen', 'Viet Nam', 5500),
    ('TV05', 'Tap 100 trang', 'chuc', 'Viet Nam', 23000),
    ('TV06', 'Tap 200 trang', 'chuc', 'Viet Nam', 53000),
    ('TV07', 'Tap 100 trang', 'chuc', 'Trung Quoc', 34000),
    ('ST01', 'So tay 500 trang', 'quyen', 'Trung Quoc', 40000),
    ('ST02', 'So tay loai 1', 'quyen', 'Viet Nam', 55000),
    ('ST03', 'So tay loai 2', 'quyen', 'Viet Nam', 51000),
    ('ST04', 'So tay', 'quyen', 'Thai Lan', 55000),
    ('ST05', 'So tay mong', 'quyen', 'Thai Lan', 20000),
    ('ST06', 'Phan viet bang', 'hop', 'Viet Nam', 5000),
    ('ST07', 'Phan khong bui', 'hop', 'Viet Nam', 7000),
    ('ST08', 'Bong bang', 'cai', 'Viet Nam', 1000),
    ('ST09', 'But long', 'cay', 'Viet Nam', 5000),
    ('ST10', 'But long', 'cay', 'Trung Quoc', 7000)
;
GO

SELECT * FROM SANPHAM
GO

-- Nhập dữ liệu cho HOADON
INSERT INTO HOADON (SOHD, NGHD, MAKH, MANV, TRIGIA)
VALUES
    (1001, '2006-07-23', 'KH01', 'NV01', 320000),
    (1002, '2006-08-12', 'KH01', 'NV02', 840000),
    (1003, '2006-08-23', 'KH02', 'NV01', 180000),
    (1004, '2006-09-01', 'KH02', 'NV01', 100000),
    (1005, '2006-10-20', 'KH01', 'NV02', 3800000),
    (1006, '2006-10-16', 'KH01', 'NV03', 2430000),
    (1007, '2006-10-28', 'KH03', 'NV03', 510000),
    (1008, '2006-10-28', 'KH01', 'NV03', 440000),
    (1009, '2006-10-28', 'KH03', 'NV04', 200000),
    (1010, '2006-11-01', 'KH01', 'NV01', 5200000),
    (1011, '2006-11-04', 'KH04', 'NV03', 250000),
    (1012, '2006-11-30', 'KH05', 'NV03', 21000),
    (1013, '2006-12-12', 'KH06', 'NV01', 5000),
    (1014, '2006-12-31', 'KH03', 'NV02', 3150000),
    (1015, '2007-01-01', 'KH06', 'NV01', 910000),
    (1016, '2007-01-02', 'KH07', 'NV02', 12500),
    (1017, '2007-01-02', 'KH08', 'NV03', 35000),
    (1018, '2007-01-13', 'KH08', 'NV03', 330000),
    (1019, '2007-01-13', 'KH01', 'NV03', 30000),
    (1020, '2007-01-14', 'KH09', 'NV04', 70000),
    (1021, '2007-01-16', 'KH10', 'NV03', 67500),
    (1022, '2007-01-16', NULL, 'NV03', 7000),
    (1023, '2007-01-17', NULL, 'NV01', 330000);
GO

SELECT * FROM HOADON
GO

-- Nhập dữ liệu cho bảng CTHD
INSERT INTO CTHD (SOHD, MASP, SL)
VALUES
    (1001, 'TV02', 10),
    (1001, 'ST01', 5),
    (1001, 'BC01', 5),
    (1001, 'BC02', 10),
    (1001, 'ST08', 10),
    (1002, 'BC04', 20),
    (1002, 'BB01', 20),
    (1002, 'BB02', 20),
    (1003, 'BB03', 10),
    (1004, 'TV01', 20),
    (1004, 'TV02', 10),
    (1004, 'TV03', 10),
    (1004, 'TV04', 10),
    (1005, 'TV05', 50),
    (1005, 'TV06', 50),
    (1006, 'TV07', 20),
    (1006, 'ST01', 30),
    (1006, 'ST02', 10),
    (1007, 'ST03', 10),
    (1008, 'ST04', 8),
    (1009, 'ST05', 10),
    (1010, 'TV07', 50),
    (1010, 'ST07', 50),
    (1010, 'ST08', 100),
    (1010, 'ST04', 50),
    (1010, 'TV03', 100),
    (1011, 'ST06', 50),
    (1012, 'ST07', 3),
    (1013, 'ST08', 5),
    (1014, 'BC02', 80),
    (1014, 'BB02', 100),
    (1014, 'BC04', 60),
    (1014, 'BB01', 50),
    (1015, 'BB02', 30),
    (1015, 'BB03', 7),
    (1016, 'TV01', 5),
    (1017, 'TV02', 1),
    (1017, 'TV03', 1),
    (1017, 'TV04', 5),
    (1018, 'ST04', 6),
    (1019, 'ST05', 1),
    (1019, 'ST06', 2),
    (1020, 'ST07', 10),
    (1021, 'ST08', 5),
    (1021, 'TV01', 7),
    (1021, 'TV02', 10),
    (1022, 'ST07', 1),
    (1023, 'ST04', 6);
GO

-------------------LAB2 - Bài tập 5 - Phần III từ câu 1 đến câu 11

-- CÂU 1
SELECT MASP, TENSP FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'
GO 

-- CÂU 2
SELECT MASP, TENSP FROM SANPHAM
WHERE (DVT IN('cay', 'quyen'))
GO

-- CÂU 3
SELECT MASP, TENSP FROM SANPHAM
WHERE MASP LIKE 'B%01'
GO

-- CAU 4
SELECT MASP, TENSP FROM SANPHAM
WHERE (NUOCSX = 'Trung Quoc') AND (GIA >= 30000 AND GIA <= 40000)
GO

-- CAU 5
SELECT MASP, TENSP FROM SANPHAM
WHERE (NUOCSX IN ('Trung Quoc', 'Thai Lan')) AND (GIA >= 30000 AND GIA <= 40000)
GO

-- CÂU 6
SELECT SOHD, TRIGIA FROM HOADON
WHERE (NGHD >= '2007-01-01' AND NGHD <= '2007-01-02')
GO

-- CÂU 7
SELECT SOHD, TRIGIA FROM HOADON
WHERE (YEAR(NGHD) = 2007 AND MONTH(NGHD) = 1)
ORDER BY NGHD ASC, TRIGIA DESC
GO

-- CÂU 8
SELECT KH.MAKH, KH.HOTEN FROM KHACHHANG KH
INNER JOIN HOADON HD
ON KH.MAKH = HD.MAKH
WHERE HD.NGHD = '2007-01-01'
GO

-- CÂU 9
SELECT HD.SOHD, HD.TRIGIA FROM HOADON HD
INNER JOIN NHANHVIEN NV
ON HD.MANV = NV.MANV
WHERE (NV.HOTEN = 'Nguyen Van B' AND HD.NGHD = '2006-10-28')
GO 

-- CÂU 10
SELECT SP.MASP, SP.TENSP FROM SANPHAM SP
INNER JOIN CTHD ON CTHD.MASP = SP.MASP
INNER JOIN HOADON HD ON HD.SOHD = CTHD.SOHD
INNER JOIN KHACHHANG KH ON KH.MAKH = HD.MAKH
WHERE (KH.HOTEN = 'Nguyen Van A' AND YEAR(HD.NGHD) = 2006 AND MONTH(HD.NGHD) = 11)
GO


-- CÂU 11
SELECT HD.SOHD FROM HOADON HD
INNER JOIN CTHD ON CTHD.SOHD = HD.SOHD
WHERE CTHD.MASP = 'BB01' OR CTHD.MASP = 'BB02'
GO



-----------------------LAB 2 - Bài tập 3 - Phần II từ câu 2 tới câu 5
-- CÂU 2
SELECT * INTO KHACHHANG1 FROM KHACHHANG
GO
SELECT *INTO SANPHAM1 FROM SANPHAM
GO

-- CÂU 3
UPDATE SANPHAM1
SET GIA = GIA * 1.05
WHERE NUOCSX = 'Thai Lan';

-- CÂU 4
UPDATE SANPHAM1
SET GIA = GIA * 0.95
WHERE NUOCSX = 'Trung Quoc' AND GIA <= 10000;

-- CÂU 5
UPDATE KHACHHANG1
SET LOAIKH = 'VIP'
WHERE (NGDK < '2007-01-01' AND DOANHSO >= 10000000)
   OR (NGDK >= '2007-01-01' AND DOANHSO >= 2000000);
