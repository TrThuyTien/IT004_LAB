CREATE DATABASE QUANLYBANHANG
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

-- CAU 6
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
ADD CONSTRAINT CK_NGSINH_NGDK CHECK (NGDK > NGSINH)
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
