
CREATE DATABASE QUANLYGIAOVU
USE QUANLYGIAOVU

-- TAO BANG THUOC TINH
CREATE TABLE KHOA (
	MAKHOA VARCHAR(4) PRIMARY KEY,
	TENKHOA VARCHAR(40),
	NGTLAP SMALLDATETIME,
	TRGKHOA CHAR(4),
)
GO

CREATE TABLE MONHOC (
	MAMH VARCHAR(10) PRIMARY KEY,
	TENMH VARCHAR(40),
	TCLT TINYINT,
	TCTH TINYINT,
	MAKHOA VARCHAR(4),
)
GO

CREATE TABLE DIEUKIEN (
	MAMH CHAR(10),
	MAMH_TRUOC VARCHAR(10),
	PRIMARY KEY (MAMH, MAMH_TRUOC),
)
GO

CREATE TABLE GIAOVIEN (
	MAGV CHAR(4) PRIMARY KEY,
	HOTEN VARCHAR(40),
	HOCVI VARCHAR(10),
	HOCHAM VARCHAR(10),
	GIOITINH VARCHAR(3),
	NGSINH SMALLDATETIME,
	NGVL SMALLDATETIME,
	HESO NUMERIC(4,2),
	MUCLUONG MONEY,
	MAKHOA VARCHAR(4),
)
GO

CREATE TABLE LOP (
	MALOP CHAR(3) PRIMARY KEY,
	TENLOP VARCHAR(40),
	TRGLOP VARCHAR(5),
	SISO TINYINT,
	MAGVCN CHAR(4),
)
GO

CREATE TABLE HOCVIEN (
	MAHV CHAR(5) PRIMARY KEY,
	HO VARCHAR(40),
	TEN VARCHAR(10),
	NGSINH SMALLDATETIME,
	GIOITINH VARCHAR(3),
	NOISINH VARCHAR(40),
	MALOP CHAR(3),
)
GO

CREATE TABLE GIANGDAY (
	MALOP CHAR(3),
	MAMH VARCHAR(10),
	PRIMARY KEY(MALOP, MAMH),
	MAGV CHAR(4),
	HOCKY TINYINT,
	NAM SMALLINT,
	TUNGAY SMALLDATETIME,
	DENNGAY SMALLDATETIME,
)
GO

CREATE TABLE KETQUATHI (
	MAHV char(5),
	MAMH varchar(10),
	LANTHI TINYINT,
	PRIMARY KEY(MAHV, MAMH, LANTHI),
	NGTHI SMALLDATETIME,
	DIEM NUMERIC(4,2),
	KQUA VARCHAR(10),
)
GO


-- CAU 1
ALTER TABLE KETQUATHI
ADD CONSTRAINT FK_KETQUATHI_HOCVIEN FOREIGN KEY (MAHV)
REFERENCES HOCVIEN(MAHV)
GO

ALTER TABLE LOP
ALTER COLUMN TRGLOP CHAR(5)
GO

ALTER TABLE LOP
ADD CONSTRAINT FK_LOP_HOCVIEN FOREIGN KEY (TRGLOP)
REFERENCES HOCVIEN(MAHV)
GO

ALTER TABLE LOP
ADD CONSTRAINT FK_LOP_GIAOVIEN FOREIGN KEY(MAGVCN)
REFERENCES GIAOVIEN(MAGV)
GO

ALTER TABLE KHOA
ADD CONSTRAINT FK_KHOA_GIAOVIEN FOREIGN KEY(TRGKHOA)
REFERENCES GIAOVIEN(MAGV)
GO

ALTER TABLE MONHOC
ADD CONSTRAINT FK_MONHOC_KHOA FOREIGN KEY(MAKHOA)
REFERENCES KHOA(MAKHOA)
GO

ALTER TABLE DIEUKIEN
ALTER COLUMN MAMH VARCHAR(10)
GO

ALTER TABLE DIEUKIEN
ADD CONSTRAINT FK_DIEUKIEN_MONHOC FOREIGN KEY(MAMH)
REFERENCES MONHOC(MAMH)
GO

SP_FKEYS 'DIEUKIEN'

DROP TABLE DIEUKIEN

CREATE TABLE DIEUKIEN (
	MAMH VARCHAR(10),
	MAMH_TRUOC VARCHAR(10),
	PRIMARY KEY (MAMH, MAMH_TRUOC),
)
GO

ALTER TABLE DIEUKIEN
ADD CONSTRAINT FK_DIEUKIEN_MONHOC FOREIGN KEY(MAMH)
REFERENCES MONHOC(MAMH)
GO

ALTER TABLE DIEUKIEN
ADD CONSTRAINT FK_DIEUKIEN_MONHOC_2 FOREIGN KEY(MAMH_TRUOC)
REFERENCES MONHOC(MAMH)
GO

ALTER TABLE GIAOVIEN
ADD CONSTRAINT FK_GIAOVIEN_KHOA FOREIGN KEY(MAKHOA)
REFERENCES KHOA(MAKHOA)
GO

ALTER TABLE HOCVIEN
ADD CONSTRAINT FK_HOCVIEN_LOP FOREIGN KEY(MALOP)
REFERENCES LOP(MALOP)
GO

ALTER TABLE GIANGDAY
ADD CONSTRAINT FK_GIANGDAY_LOP FOREIGN KEY(MALOP)
REFERENCES LOP(MALOP)
GO

ALTER TABLE GIANGDAY
ADD CONSTRAINT FK_GIANGDAY_MONHOC FOREIGN KEY(MAMH)
REFERENCES MONHOC(MAMH)
GO

ALTER TABLE GIANGDAY
ADD CONSTRAINT FK_GIANGDAY_GIAOVIEN FOREIGN KEY(MAGV)
REFERENCES GIAOVIEN(MAGV)
GO

ALTER TABLE KETQUATHI
ADD CONSTRAINT FK_KETQUATHI_MONHOC FOREIGN KEY(MAMH)
REFERENCES MONHOC(MAMH)
GO

-- CAU 1 
ALTER TABLE HOCVIEN
ADD GHICHU VARCHAR(100),
	DIEMTB NUMERIC(4, 2),
	XEPLOAI VARCHAR(20)
GO

-- CAU 2
ALTER TABLE HOCVIEN
ADD CONSTRAINT CK_MAHV
CHECK(MAHV LIKE '%%%[0-9][0-9]')
GO

-- CAU 3
ALTER TABLE HOCVIEN
ADD CONSTRAINT CK_GIOITINH
CHECK (GIOITINH IN('Nam', 'Nu'))
GO

-- CAU 4
ALTER TABLE KETQUATHI
ALTER COLUMN DIEM NUMERIC(5,2)

ALTER TABLE KETQUATHI
ADD CONSTRAINT CK_DIEM
CHECK (DIEM BETWEEN 0 AND 10)
GO

-- CAU 5
CREATE TRIGGER TG_UPDATEKQUA
ON KETQUATHI
AFTER UPDATE
AS
BEGIN
	UPDATE KETQUATHI
	SET KQUA = CASE WHEN DIEM >= 5 THEN 'Dat' ELSE 'Khong dat' END
	WHERE MAHV = (SELECT MAHV FROM INSERTED)
END
GO

-- CAU 6
ALTER TABLE KETQUATHI
ADD CONSTRAINT CK_LANTHI
CHECK (LANTHI <= 3)
GO

-- CAU 7
ALTER TABLE GIANGDAY
ADD CONSTRAINT CK_HOCKY
CHECK (HOCKY BETWEEN 1 AND 3)
GO

-- CAU 8
ALTER TABLE GIAOVIEN
ADD CONSTRAINT CK_HOCVI
CHECK (HOCVI IN('CN', 'KS', 'Ths', 'TS', 'PTS'))
GO

-----------------------------------------LAB 2 -------------------------------------------------------------------------

------------------- LAB 2 - Bài tập 2

-- Nhập dữ liệu cho bảng KHOA

ALTER TABLE KHOA NOCHECK CONSTRAINT ALL;
INSERT INTO KHOA (MAKHOA, TENKHOA, NGTLAP, TRGKHOA)
VALUES
    ('KHMT', 'Khoa hoc may tinh', '2005-06-07', 'GV01'),
    ('HTTT', 'He thong thong tin', '2005-06-07', 'GV02'),
    ('CNPM', 'Cong nghe phan mem', '2005-06-07', 'GV04'),
    ('MTT', 'Mang va truyen thong', '2005-10-20', 'GV03'),
    ('KTMT', 'Ky thuat may tinh', '2005-12-20', NULL);

GO
ALTER TABLE KHOA CHECK CONSTRAINT ALL;

-- Nhập dữ liệu cho GIAOVIEN
ALTER TABLE GIAOVIEN NOCHECK CONSTRAINT ALL;

INSERT INTO GIAOVIEN (MAGV, HOTEN, HOCVI, HOCHAM, GIOITINH, NGSINH, NGVL, HESO, MUCLUONG, MAKHOA)
VALUES
('GV01', 'Ho Thanh Son', 'PTS', 'GS', 'Nam', '1950-02-05', '2004-11-01', 5.00, 2250000, 'KHMT'),
('GV02', 'Tran Tam Thanh', 'TS', 'PGS', 'Nam', '1965-12-17', '2004-04-20', 4.50, 2025000, 'HTTT'),
('GV03', 'Do Nghiem Phung', 'TS', 'GS', 'Nu', '1950-01-18', '2004-09-23', 4.00, 1800000, 'CNPM'),
('GV04', 'Tran Nam Son', 'TS', 'PGS', 'Nam', '1961-12-22', '2005-12-11', 4.50, 2025000, 'KTMT'),
('GV05', 'Mai Thanh Danh', 'ThS', 'GV', 'Nam', '1958-12-03', '2005-12-11', 3.00, 1350000, 'HTTT'),
('GV06', 'Tran Doan Hung', 'TS', 'GV', 'Nam', '1953-11-03', '2005-12-11', 4.50, 2025000, 'KHMT'),
('GV07', 'Nguyen Minh Tien', 'ThS', 'GV', 'Nam', '1971-11-23', '2005-03-01', 4.00, 1800000, 'KHMT'),
('GV08', 'Le Thi Tran', 'KS', NULL, 'Nu', '1974-03-26', '2005-03-01', 1.69, 760500, 'KHMT'),
('GV09', 'Nguyen To Lan', 'ThS', 'GV', 'Nu', '1966-12-31', '2005-03-01', 4.00, 1800000, 'HTTT'),
('GV10', 'Le Tran Anh Loan', 'KS', NULL, 'Nu', '1972-11-17', '2005-03-01', 1.86, 837000, 'CNPM'),
('GV11', 'Ho Thanh Tung', 'CN', 'GV', 'Nam', '1980-12-17', '2005-05-15', 2.67, 1201500, 'KHMT'),
('GV12', 'Tran Van Anh', 'CN', NULL, 'Nam', '1981-03-29', '2005-05-15', 1.69, 760500, 'CNPM'),
('GV13', 'Nguyen Linh Dan', 'CN', NULL, 'Nu', '1980-05-23', '2005-05-15', 1.69, 760500, 'KTMT'),
('GV14', 'Truong Minh Chau', 'ThS', 'GV', 'Nu', '1976-11-30', '2005-05-15', 3.00, 1350000, 'MTT'),
('GV15', 'Le Ha Thanh', 'ThS', 'GV', 'Nam', '1978-05-04', '2005-05-15', 3.00, 1350000, 'KHMT');
go
ALTER TABLE GIAOVIEN CHECK CONSTRAINT ALL;

-- Nhập dữ liệu cho bảng MONHOC
ALTER TABLE MONHOC NOCHECK CONSTRAINT ALL
INSERT INTO MONHOC (MAMH, TENMH, TCLT, TCTH, MAKHOA)
VALUES
    ('THDC', N'Tin học đại cương', 4, 1, 'KHMT'),
    ('CTRR', 'Cau truc roi rac', 5, 2, 'KHMT'),
    ('CSDL', 'Co so du lieu', 3, 1, 'HTTT'),
    ('CTDLGT', 'Cau truc du lieu va giai thuat', 3, 1, 'KHMT'),
    ('PTTKTT', 'Phan tich thiet ke thuat toan', 3, 0, 'KHMT'),
    ('DHMT', 'Do hoa may tinh', 3, 1, 'KHMT'),
    ('KTMT', 'Kien truc may tinh', 3, 0, 'KHMT'),
    ('TKCSDL', 'Thiet ke co so du lieu', 3, 1, 'HTTT'),
    ('PTTKHTT', 'Phan tich thiet ke he thong thong tin', 4, 1, 'HTTT'),
    ('HDH', 'He dieu hanh', 4, 0, 'CNPM'),
    ('NMCNPM', 'Nhap mon cong nghe phan mem', 3, 1, 'CNPM'),
    ('LTCFW', 'Lap trinh C for win', 3, 0, 'CNPM'),
    ('LTHDT', 'Lap trinh huong doi tuong', 3, 1, 'CNPM');
GO
ALTER TABLE MONHOC CHECK CONSTRAINT ALL

-- Nhập dữ liệu cho LOP
ALTER TABLE LOP NOCHECK CONSTRAINT ALL
INSERT INTO LOP (MALOP, TENLOP, TRGLOP, SISO, MAGVCN)
VALUES
    ('K11', 'Lop 1 khoa 1', 'K1108', 11, 'GV07'),
    ('K12', 'Lop 2 khoa 1', 'K1205', 12, 'GV09'),
    ('K13', 'Lop 3 khoa 1', 'K1305', 12, 'GV14');
GO

ALTER TABLE LOP CHECK CONSTRAINT ALL

-- Nhập dữ liệ cho GIANGDAY
ALTER TABLE GIANGDAY NOCHECK CONSTRAINT ALL

INSERT INTO GIANGDAY (MALOP, MAMH, MAGV, HOCKY, NAM, TUNGAY, DENNGAY)
VALUES
    ('K11', 'THDC', 'GV07', 1, 2006, '2006-01-21', '2006-05-12'),
    ('K12', 'THDC', 'GV06', 1, 2006, '2006-01-21', '2006-05-12'),
    ('K13', 'THDC', 'GV15', 1, 2006, '2006-01-21', '2006-05-12'),
    ('K11', 'CTRR', 'GV02', 1, 2006, '2006-01-09', '2006-05-17'),
    ('K12', 'CTRR', 'GV02', 1, 2006, '2006-01-09', '2006-05-17'),
    ('K13', 'CTRR', 'GV08', 1, 2006, '2006-01-09', '2006-05-17'),
    ('K11', 'CSDL', 'GV05', 2, 2006, '2006-06-01', '2006-07-15'),
    ('K12', 'CSDL', 'GV09', 2, 2006, '2006-06-01', '2006-07-15'),
    ('K13', 'CTDLGT', 'GV15', 2, 2006, '2006-06-01', '2006-07-15'),
    ('K13', 'CSDL', 'GV05', 3, 2006, '2006-08-01', '2006-12-15'),
    ('K13', 'DHMT', 'GV07', 3, 2006, '2006-08-01', '2006-12-15'),
    ('K11', 'CTDLGT', 'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
    ('K12', 'CTDLGT', 'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
    ('K11', 'HDH', 'GV04', 1, 2007, '2007-01-02', '2007-02-18'),
    ('K12', 'HDH', 'GV04', 1, 2007, '2007-01-02', '2007-03-20'),
    ('K11', 'DHMT', 'GV07', 1, 2007, '2007-02-18', '2007-03-20');
GO
ALTER TABLE GIANGDAY CHECK CONSTRAINT ALL

-- Nhập dữ liệu cho DIEUKIEN
ALTER TABLE DIEUKIEN NOCHECK CONSTRAINT ALL
INSERT INTO DIEUKIEN (MAMH, MAMH_TRUOC)
VALUES
    ('CSDL', 'CTRR'),
    ('CSDL', 'CTDLGT'),
    ('CTDLGT', 'THDC'),
    ('PTTKTT', 'THDC'),
    ('PTTKTT', 'CTDLGT'),
    ('DHMT', 'THDC'),
    ('LTHDT', 'THDC'),
    ('PTTKHTTT', 'CSDL');
GO
ALTER TABLE DIEUKIEN CHECK CONSTRAINT ALL

-- Nhập dữ liệu cho KETQUATHI
ALTER TABLE KETQUATHI NOCHECK CONSTRAINT ALL

INSERT INTO KETQUATHI (MAHV, MAMH, LANTHI, NGTHI, DIEM, KQUA)
VALUES
    ('K1101', 'CSDL', 1, '2006-07-20', 10.0, 'Dat'),
    ('K1101', 'CTDLGT', 1, '2006-12-28', 9.00, 'Dat'),
    ('K1101', 'THDC', 1, '2006-05-20', 9.00, 'Dat'),
    ('K1101', 'CTRR', 1, '2006-05-13', 9.50, 'Dat'),
    ('K1102', 'CSDL', 1, '2006-07-20', 4.00, 'Khong Dat'),
    ('K1102', 'CSDL', 2, '2006-07-27', 4.25, 'Khong Dat'),
    ('K1102', 'CSDL', 3, '2006-08-10', 4.50, 'Khong Dat'),
    ('K1102', 'CTDLGT', 1, '2006-12-28', 4.50, 'Khong Dat'),
    ('K1102', 'CTDLGT', 2, '2007-01-05', 4.00, 'Khong Dat'),
    ('K1102', 'CTDLGT', 3, '2007-01-15', 6.00, 'Dat'),
    ('K1102', 'THDC', 1, '2006-05-20', 5.00, 'Dat'),
    ('K1102', 'CTRR', 1, '2006-05-13', 7.00, 'Dat'),
    ('K1103', 'CSDL', 1, '2006-07-20', 3.50, 'Khong Dat'),
    ('K1103', 'CSDL', 2, '2006-07-27', 8.25, 'Dat'),
    ('K1103', 'CTDLGT', 1, '2006-12-28', 7.00, 'Dat'),
    ('K1103', 'THDC', 1, '2006-05-20', 8.00, 'Dat'),
    ('K1103', 'CTRR', 1, '2006-05-13', 6.50, 'Dat'),
    ('K1104', 'CSDL', 1, '2006-07-20', 3.75, 'Khong Dat'),
    ('K1104', 'CTDLGT', 1, '2006-12-28', 4.00, 'Khong Dat'),
    ('K1104', 'THDC', 1, '2006-05-20', 4.00, 'Khong Dat'),
    ('K1104', 'CTRR', 1, '2006-05-13', 4.00, 'Khong Dat'),
    ('K1104', 'CTRR', 2, '2006-05-20', 3.50, 'Khong Dat'),
    ('K1104', 'CTRR', 3, '2006-06-30', 4.00, 'Khong Dat'),
    ('K1201', 'CSDL', 1, '2006-07-20', 6.00, 'Dat'),
    ('K1201', 'CTDLGT', 1, '2006-12-28', 5.00, 'Dat'),
    ('K1201', 'THDC', 1, '2006-05-20', 8.50, 'Dat'),
    ('K1201', 'CTRR', 1, '2006-05-13', 9.00, 'Dat'),
    ('K1202', 'CSDL', 1, '2006-07-20', 8.00, 'Dat'),
    ('K1202', 'CTDLGT', 1, '2006-12-28', 4.00, 'Khong Dat'),
    ('K1202', 'CTDLGT', 2, '2007-01-05', 5.00, 'Dat'),
    ('K1202', 'THDC', 1, '2006-05-20', 4.00, 'Khong Dat'),
    ('K1202', 'THDC', 2, '2006-05-27', 4.00, 'Khong Dat'),
    ('K1202', 'CTRR', 1, '2006-05-13', 3.00, 'Khong Dat'),
	('K1202', 'CTRR', 2, '2006-05-20', 4.00, 'Khong Dat'),
    ('K1202', 'CTRR', 3, '2006-06-30', 6.25, 'Dat'),
    ('K1203', 'CSDL', 1, '2006-07-20', 9.25, 'Dat'),
    ('K1203', 'CTDLGT', 1, '2006-12-28', 9.50, 'Dat'),
    ('K1203', 'THDC', 1, '2006-05-20', 10.0, 'Dat'),
    ('K1203', 'CTRR', 1, '2006-05-13', 10.0, 'Dat'),
    ('K1204', 'CSDL', 1, '2006-07-20', 8.50, 'Dat'),
    ('K1204', 'CTDLGT', 1, '2006-12-28', 6.75, 'Dat'),
    ('K1204', 'THDC', 1, '2006-05-20', 4.00, 'Khong Dat'),
    ('K1204', 'CTRR', 1, '2006-05-13', 6.00, 'Dat'),
    ('K1301', 'CSDL', 1, '2006-12-20', 4.25, 'Khong Dat'),
    ('K1301', 'CTDLGT', 1, '2006-07-25', 8.00, 'Dat'),
    ('K1301', 'THDC', 1, '2006-05-20', 7.75, 'Dat'),
    ('K1301', 'CTRR', 1, '2006-05-13', 8.00, 'Dat'),
    ('K1302', 'CSDL', 1, '2006-12-20', 6.75, 'Dat'),
    ('K1302', 'CTDLGT', 1, '2006-07-25', 5.00, 'Dat'),
    ('K1302', 'THDC', 1, '2006-05-20', 8.00, 'Dat'),
    ('K1302', 'CTRR', 1, '2006-05-13', 8.50, 'Dat'),
    ('K1303', 'CSDL', 1, '2006-12-20', 4.00, 'Khong Dat'),
    ('K1303', 'CTDLGT', 1, '2006-07-25', 4.50, 'Khong Dat'),
    ('K1303', 'CTDLGT', 2, '2006-08-07', 4.00, 'Khong Dat'),
    ('K1303', 'CTDLGT', 3, '2006-08-15', 4.25, 'Khong Dat'),
    ('K1303', 'THDC', 1, '2006-05-20', 4.50, 'Khong Dat'),
    ('K1303', 'CTRR', 1, '2006-05-13', 3.25, 'Khong Dat'),
    ('K1303', 'CTRR', 2, '2006-05-20', 5.00, 'Dat'),
    ('K1304', 'CSDL', 1, '2006-12-20', 7.75, 'Dat'),
    ('K1304', 'CTDLGT', 1, '2006-07-25', 9.75, 'Dat'),
    ('K1304', 'THDC', 1, '2006-05-20', 5.50, 'Dat'),
    ('K1304', 'CTRR', 1, '2006-05-13', 5.00, 'Dat'),
    ('K1305', 'CSDL', 1, '2006-12-20', 9.25, 'Dat'),
    ('K1305', 'CTDLGT', 1, '2006-07-25', 10.0, 'Dat'),
    ('K1305', 'THDC', 1, '2006-05-20', 8.00, 'Dat'),
    ('K1305', 'CTRR', 1, '2006-05-13', 10.0, 'Dat');
GO


ALTER TABLE KETQUATHI CHECK CONSTRAINT ALL

-- Them du lieu cho HOCVIEN
ALTER TABLE HOCVIEN NOCHECK CONSTRAINT ALL
INSERT INTO HOCVIEN (MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES
('K1101', 'Nguyen Van', 'A', '1986-01-27', 'Nam', 'TpHCM', 'K11'),
('K1102', 'Tran Ngoc', 'Han', '1986-03-14', 'Nu', 'Kien Giang', 'K11'),
('K1103', 'Ha Duy', 'Lap', '1986-04-18', 'Nam', 'Nghe An', 'K11'),
('K1104', 'Tran Ngoc', 'Linh', '1986-03-30', 'Nu', 'Tay Ninh', 'K11'),
('K1105', 'Tran Minh', 'Long', '1986-02-27', 'Nam', 'TpHCM', 'K11'),
('K1106', 'Le Nhat', 'Minh', '1986-01-24', 'Nam', 'TpHCM', 'K11'),
('K1107', 'Nguyen Nhu', 'Nhut', '1986-01-27', 'Nam', 'Ha Noi', 'K11'),
('K1108', 'Nguyen Manh', 'Tam', '1986-02-27', 'Nam', 'Kien Giang', 'K11'),
('K1109', 'Phan Thi Thanh', 'Tam', '1986-01-27', 'Nu', 'Vinh Long', 'K11'),
('K1110', 'Le Hoai', 'Thuong', '1986-02-05', 'Nu', 'Can Tho', 'K11'),
('K1111', 'Le Ha', 'Vinh', '1986-12-25', 'Nam', 'Vinh Long', 'K11'),
('K1201', 'Nguyen Van', 'B', '1986-02-11', 'Nam', 'TpHCM', 'K12'),
('K1202', 'Nguyen Thi Kim', 'Duyen', '1986-01-18', 'Nu', 'TpHCM', 'K12'),
('K1203', 'Tran Thi Kim', 'Duyen', '1986-09-17', 'Nu', 'TpHCM', 'K12'),
('K1204', 'Truong My', 'Hanh', '1986-05-19', 'Nu', 'Dong Nai', 'K12'),
('K1205', 'Nguyen Thanh', 'Nam', '1986-04-17', 'Nam', 'TpHCM', 'K12'),
('K1206', 'Nguyen Thi Truc', 'Thanh', '1986-03-04', 'Nu', 'Kien Giang', 'K12'),
('K1207', 'Tran Thi Bich', 'Thuy', '1986-02-08', 'Nu', 'Nghe An', 'K12'),
('K1208', 'Huynh Thi Kim', 'Trieu', '1986-04-08', 'Nu', 'Tay Ninh', 'K12'),
('K1209', 'Pham Thanh', 'Trieu', '1986-02-23', 'Nam', 'TpHCM', 'K12'),
('K1210', 'Ngo Thanh', 'Tuan', '1986-02-14', 'Nam', 'TpHCM', 'K12'),
('K1211', 'Do Thi', 'Xuan', '1986-03-09', 'Nu', 'Ha Noi', 'K12'),
('K1212', 'Le Thi Phi', 'Yen', '1986-03-12', 'Nu', 'TpHCM', 'K12'),
('K1301', 'Nguyen Thi Kim', 'Cuc', '1986-06-09', 'Nu', 'Kien Giang', 'K13'),
('K1302', 'Truong Thi My', 'Hien', '1986-03-18', 'Nu', 'Nghe An', 'K13'),
('K1303', 'Le Duc', 'Hien', '1986-03-21', 'Nam', 'Tay Ninh', 'K13'),
('K1304', 'Le Quang', 'Hien', '1986-04-18', 'Nam', 'TpHCM', 'K13'),
('K1305', 'Le Thi', 'Huong', '1986-03-27', 'Nu', 'TpHCM', 'K13'),
('K1306', 'Nguyen Thai', 'Huu', '1986-03-30', 'Nam', 'Ha Noi', 'K13'),
('K1307', 'Tran Minh', 'Man', '1986-05-28', 'Nam', 'TpHCM', 'K13'),
('K1308', 'Nguyen Hieu', 'Nghia', '1986-04-08', 'Nam', 'Kien Giang', 'K13'),
('K1309', 'Nguyen Trung', 'Nghia', '1987-01-18', 'Nam', 'Nghe An', 'K13'),
('K1310', 'Tran Thi Hong', 'Tham', '1986-04-22', 'Nu', 'Tay Ninh', 'K13'),
('K1311', 'Tran Minh', 'Thuc', '1986-04-04', 'Nam', 'TpHCM', 'K13'),
('K1312', 'Nguyen Thi Kim', 'Yen', '1986-09-07', 'Nu', 'TpHCM', 'K13');

ALTER TABLE HOCVIEN CHECK CONSTRAINT ALL
----------------------- LAB 3 ---------------------------------------------------------------
--1. Tìm danh sách các giáo viên có mức lương cao nhất trong mỗi khoa, kèm theo tên khoa và hệ số lương. 
select GV.MAGV, GV.HOTEN, KHOA.TENKHOA, GV.HESO
from GIAOVIEN GV
join KHOA 
on KHOA.MAKHOA = GV.MAKHOA
where  GV.MUCLUONG >=  (select max(GV1.MUCLUONG)
					from GIAOVIEN GV1
					where KHOA.MAKHOA = GV1.MAKHOA
					)

--2. Liệt kê danh sách các học viên có điểm trung bình cao nhất trong mỗi lớp, kèm theo tên lớp và mã lớp. 
with 
	DTBLop as (
		select l.MALOP, l.TENLOP, max(hv.DIEMTB) as DTB
		from LOP l
		join HOCVIEN hv
		on hv.MALOP = l.MALOP
		group by l.MALOP, l.TENLOP
	)
select DTBLop.MALOP, DTBLop.TENLOP, concat(hv.HO,' ',hv.TEN) as HoTen, DTBLop.DTB
from DTBLop
join HOCVIEN hv
on hv.MALOP = DTBLop.MALOP
where hv.DIEMTB = DTBLop.DTB
--3. Tính tổng số tiết lý thuyết (TCLT) và thực hành (TCTH) mà mỗi giáo viên đã giảng dạy trong năm học 2023, sắp xếp theo tổng số tiết từ cao xuống thấp. 
select gv.MAGV, gv.HOTEN , sum(mh.TCLT) as TongTCLT, sum(mh.TCTH) as TongTCTH
from GIAOVIEN gv
join GIANGDAY gd
on gv.MAGV = gd.MAGV
join MONHOC mh
on mh.MAMH = gd.MAMH
where gd.NAM = 2023
group by gv.MAGV, gv.HOTEN
order by sum(mh.TCLT), sum(mh.TCTH) desc
--4. Tìm những học viên thi cùng một môn học nhiều hơn 2 lần nhưng chưa bao giờ đạt điểm trên 7, kèm theo mã học viên và mã môn học. 
select hv.MAHV, 
	   concat(HV.HO,' ',HV.TEN) as HoTen,
       mh.MAMH
from HOCVIEN hv
join KETQUATHI kqt
on kqt.MAHV = hv.MAHV
join MONHOC mh
on mh.MAMH = kqt.MAMH
where kqt.DIEM <= 7 
group by hv.MAHV, hv.HO, hv.TEN, mh.MAMH
having count(kqt.LANTHI) > 2
--5. Xác định những giáo viên đã giảng dạy ít nhất 3 môn học khác nhau trong cùng một năm học, kèm theo năm học và số lượng môn giảng dạy. 
select gv.MAGV, 
	   gv.HOTEN, 
	   gd.NAM, 
	   count(distinct gd.MAMH) as SLMonHoc
from GIAOVIEN gv
join GIANGDAY gd
on gv.MAGV = gd.MAGV
join MONHOC mh
on mh.MAMH = gd.MAMH
group by gv.MAGV, gv.HOTEN, gd.NAM
having count(distinct gd.MAMH) >= 3

--6. Tìm những học viên có sinh nhật trùng với ngày thành lập của khoa mà họ đang theo học, kèm theo tên khoa và ngày sinh của học viên. 
select HV.MAHV, 
	   concat(HV.HO,' ',HV.TEN) as HoTen,
	   HV.NGSINH,
	   K.TENKHOA
from HOCVIEN HV
join LOP L
on L.MALOP = HV.MALOP
join GIAOVIEN GV
on GV.MAGV = L.MAGVCN
join KHOA K
on K.MAKHOA = GV.MAKHOA
where day(HV.NGSINH) = day(K.NGTLAP) 
and month(HV.NGSINH) = month(K.NGTLAP)
--7. Liệt kê các môn học không có điều kiện tiên quyết (không yêu cầu môn học trước), kèm theo 
--mã môn và tên môn học. 
SELECT MONHOC.MAMH,TENMH
FROM MONHOC LEFT JOIN DIEUKIEN ON MONHOC.MAMH=DIEUKIEN.MAMH 
WHERE MAMH_TRUOC=NULL
--8. Tìm danh sách các giáo viên dạy nhiều môn học nhất trong học kỳ 1 năm 2006, kèm theo số 
--lượng môn học mà họ đã dạy. 
SELECT TOP 1 WITH TIES HOTEN,COUNT(MAMH)'SO LUONG MON HOC'
FROM GIAOVIEN JOIN GIANGDAY ON GIAOVIEN.MAGV=GIANGDAY.MAGV
GROUP BY HOTEN
ORDER BY COUNT(MAMH) DESC
--9. Tìm những giáo viên đã dạy cả môn “Co So Du Lieu” và “Cau Truc Roi Rac” trong cùng một 
--học kỳ, kèm theo học kỳ và năm học. 
WITH A AS
(
SELECT HOTEN,HOCKY,NAM
FROM GIAOVIEN JOIN GIANGDAY ON GIAOVIEN.MAGV=GIANGDAY.MAGV JOIN MONHOC ON GIANGDAY.MAMH=MONHOC.MAMH
WHERE TENMH=N'Co So Du Lieu'
),
B AS
(
SELECT HOTEN,HOCKY,NAM
FROM GIAOVIEN JOIN GIANGDAY ON GIAOVIEN.MAGV=GIANGDAY.MAGV JOIN MONHOC ON GIANGDAY.MAMH=MONHOC.MAMH
WHERE TENMH=N'Cau Truc Roi Rac'
)
SELECT DISTINCT A.HOTEN,A.HOCKY,A.NAM
FROM A JOIN B ON A.HOTEN=B.HOTEN AND A.HOCKY=B.HOCKY AND A.NAM=B.NAM
--10. Liệt kê danh sách các môn học mà tất cả các giáo viên trong khoa “CNTT” đều đã giảng dạy ít nhất một lần trong năm 2006.
SELECT TENMH
FROM MONHOC
WHERE NOT EXISTS (  SELECT *
					FROM GIAOVIEN
					WHERE MAKHOA='CNTT' AND NOT EXISTS (SELECT *
														FROM GIANGDAY
														WHERE GIANGDAY.MAGV=GIAOVIEN.MAGV
														AND	GIANGDAY.MAMH=MONHOC.MAMH
														AND	GIANGDAY.NAM=2006)
				  )
--11. Tìm những giáo viên có hệ số lương cao hơn mức lương trung bình của tất cả giáo viên trong khoa của họ, kèm theo tên khoa và hệ số lương của giáo viên đó.
SELECT HOTEN,TENKHOA,HESO
FROM GIAOVIEN JOIN KHOA ON GIAOVIEN.MAKHOA=KHOA.MAKHOA
WHERE HESO > (SELECT AVG(HESO) FROM GIAOVIEN) 
--12. Xác định những lớp có sĩ số lớn hơn 40 nhưng không có giáo viên nào dạy quá 2 môn trong học kỳ 1 năm 2006, kèm theo tên lớp và sĩ số.
SELECT DISTINCT LOP.MALOP,TENLOP,SISO
FROM LOP JOIN GIANGDAY ON LOP.MALOP=GIANGDAY.MALOP
WHERE SISO >40 AND LOP.MALOP NOT IN  (SELECT MALOP
									  FROM GIANGDAY
									  WHERE HOCKY=1 AND NAM=2006
									  GROUP BY MALOP,MAGV
									  HAVING COUNT(MAMH)>2)
--13. Tìm những môn học mà tất cả các học viên của lớp “K11” đều đạt điểm trên 7 trong lần thi cuối cùng của họ, kèm theo mã môn và tên môn học.
SELECT TENMH
FROM MONHOC
WHERE NOT EXISTS (SELECT * 
				  FROM HOCVIEN
				  WHERE MALOP='K11' AND NOT EXISTS(SELECT * 
												   FROM KETQUATHI
												   WHERE KETQUATHI.MAHV=HOCVIEN.MAHV
												   AND   KETQUATHI.MAMH=MONHOC.MAMH
												   AND   KETQUATHI.DIEM>=7))
--14. Liệt kê danh sách các giáo viên đã dạy ít nhất một môn học trong mỗi học kỳ của năm 2006, kèm theo mã giáo viên và số lượng học kỳ mà họ đã giảng dạy.
SELECT GIAOVIEN.MAGV,HOTEN,COUNT(MAMH)'SO MON DAY'
FROM GIAOVIEN JOIN GIANGDAY ON GIAOVIEN.MAGV=GIANGDAY.MAGV
WHERE NAM=2006
GROUP BY GIAOVIEN.MAGV,HOTEN,HOCKY
HAVING COUNT(MAMH)>=1
--15. Tìm những giáo viên vừa là trưởng khoa vừa giảng dạy ít nhất 2 môn khác nhau trong năm 2006, kèm theo tên khoa và mã giáo viên.
SELECT HOTEN 
FROM GIAOVIEN JOIN KHOA ON KHOA.TRGKHOA=GIAOVIEN.MAGV JOIN GIANGDAY ON GIANGDAY.MAGV = GIAOVIEN.MAGV
WHERE NAM=2006
GROUP BY HOTEN
HAVING COUNT(MAMH)>=2

--16. Xác định những môn học mà tất cả các lớp do giáo viên chủ nhiệm “Nguyen To Lan” đều phải học trong năm 2006, kèm theo mã lớp và tên lớp.
SELECT LOP.MALOP,TENLOP,TENMH
FROM LOP JOIN GIANGDAY ON LOP.MALOP=GIANGDAY.MALOP JOIN GIAOVIEN ON GIAOVIEN.MAGV=LOP.MAGVCN JOIN MONHOC ON MONHOC.MAMH=GIANGDAY.MAMH
WHERE GIAOVIEN.HOTEN=N'Nguyen To Lan' AND NAM=2006
--17. Liệt kê danh sách các môn học mà không có điều kiện tiên quyết (không cần phải học trước bất kỳ môn nào), nhưng lại là điều kiện tiên quyết cho ít nhất 2 môn khác nhau, kèm theo mã môn và tên môn học.
SELECT DISTINCT DK1.MAMH'MA MON HOC TRUOC',MH1.TENMH'TEN MON HOC TRUOC',DK2.MAMH 'MA MON HOC SAU',MH2.TENMH'TEN MON HOC SAU'
FROM DIEUKIEN DK1 JOIN DIEUKIEN DK2 ON DK1.MAMH_TRUOC=DK2.MAMH JOIN MONHOC MH1 ON MH1.MAMH=DK1.MAMH JOIN MONHOC MH2 ON MH2.MAMH=DK2.MAMH
--18. Tìm những học viên (mã học viên, họ tên) thi không đạt môn CSDL ở lần thi thứ 1 nhưng chưa thi lại môn này và cũng chưa thi bất kỳ môn nào khác sau lần đó.
SELECT HOCVIEN.MAHV,HO,TEN 
FROM HOCVIEN JOIN KETQUATHI ON HOCVIEN.MAHV=KETQUATHI.MAHV JOIN MONHOC ON MONHOC.MAMH=KETQUATHI.MAMH
WHERE TENMH='Co so du lieu' AND KQUA = 'KHONG DAT' AND LANTHI=1 AND NGTHI=(SELECT MAX(NGTHI) FROM KETQUATHI WHERE KETQUATHI.MAHV=HOCVIEN.MAHV)
--19. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào trong năm 2006, nhưng đã từng giảng dạy trước đó.
SELECT GIAOVIEN.MAGV,HOTEN
FROM GIAOVIEN JOIN GIANGDAY ON GIAOVIEN.MAGV=GIANGDAY.MAGV
GROUP BY GIAOVIEN.MAGV,HOTEN
HAVING COUNT(MAMH)>=1
EXCEPT
SELECT GIAOVIEN.MAGV,HOTEN
FROM GIAOVIEN JOIN GIANGDAY ON GIAOVIEN.MAGV=GIANGDAY.MAGV
WHERE NAM=2006
GROUP BY GIAOVIEN.MAGV,HOTEN
HAVING COUNT(MAMH)=0
--20. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào thuộc khoa giáo viên đó phụ trách trong năm 2006, nhưng đã từng giảng dạy các môn khác của khoa khác.
SELECT MAGV,HOTEN
FROM GIAOVIEN
EXCEPT
SELECT GIAOVIEN.MAGV,HOTEN
FROM GIAOVIEN LEFT JOIN GIANGDAY ON GIAOVIEN.MAGV=GIANGDAY.MAGV JOIN MONHOC ON GIANGDAY.MAMH=MONHOC.MAMH
WHERE NAM=2006 AND GIAOVIEN.MAKHOA=MONHOC.MAKHOA
GROUP BY GIAOVIEN.MAGV,HOTEN
--21. Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn "Khong dat", nhưng có điểm trung bình tất cả các môn khác trên 7.
SELECT HO,TEN
FROM HOCVIEN JOIN KETQUATHI ON KETQUATHI.MAHV=HOCVIEN.MAHV
GROUP BY HO,TEN,MAMH
HAVING AVG(DIEM)>=7
INTERSECT
SELECT HO,TEN 
FROM HOCVIEN JOIN KETQUATHI ON KETQUATHI.MAHV=HOCVIEN.MAHV
WHERE KQUA='Khong dat'
GROUP BY HO,TEN,MAMH
HAVING COUNT(LANTHI)>=3
--22. Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn "Khong dat" và thi lần thứ 2 của môn CTRR đạt đúng 5 điểm, nhưng điểm trung bình của tất cả các môn khác đều dưới 6.
SELECT HO,TEN
FROM HOCVIEN JOIN KETQUATHI ON HOCVIEN.MAHV=KETQUATHI.MAHV JOIN MONHOC ON MONHOC.MAMH=KETQUATHI.MAMH
WHERE LANTHI=2 AND TENMH='CAU TRUC ROI RAC' AND DIEM = 5 AND (SELECT AVG(DIEM) FROM KETQUATHI) <6
INTERSECT
SELECT HO,TEN
FROM HOCVIEN JOIN KETQUATHI ON HOCVIEN.MAHV=KETQUATHI.MAHV
WHERE KQUA='Khong dat' 
GROUP BY HO,TEN,MAMH
HAVING COUNT(LANTHI)>=3
--23. Tìm họ tên giáo viên dạy môn CTRR cho ít nhất hai lớp trong cùng một học kỳ của một năm học và có tổng số tiết giảng dạy (TCLT + TCTH) lớn hơn 30 tiết.
SELECT HOTEN 
FROM GIAOVIEN JOIN GIANGDAY ON GIANGDAY.MAGV=GIAOVIEN.MAGV JOIN MONHOC ON MONHOC.MAMH=GIANGDAY.MAMH
WHERE TENMH='CAU TRUC ROI RAC'
GROUP BY HOTEN,TENMH
HAVING COUNT(MALOP)>=2
--24. Danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng), kèm theo số lần thi của mỗi học viên cho môn này.
SELECT HO,TEN,DIEM,LANTHI
FROM HOCVIEN JOIN KETQUATHI ON HOCVIEN.MAHV=KETQUATHI.MAHV
WHERE MAMH='CSDL' AND NGTHI=(SELECT MAX(NGTHI) FROM KETQUATHI WHERE KETQUATHI.MAHV=HOCVIEN.MAHV AND MAMH='CSDL')

--25. Danh sách học viên và điểm trung bình tất cả các môn (chỉ lấy điểm của lần thi sau cùng), kèm theo số lần thi trung bình cho tất cả các môn mà mỗi học viên đã tham gia
WITH LastExam AS (
    SELECT MAHV, MAMH, MAX(LANTHI) AS MAX_LANTHI
    FROM KETQUATHI
    GROUP BY MAHV, MAMH
)
SELECT HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN, AVG(KETQUATHI.DIEM) AS DIEM_TRUNG_BINH,
       AVG(LANTHI_COUNT.TONG_SO_LANTHI) AS SO_LAN_THI_TRUNG_BINH
FROM HOCVIEN
JOIN LastExam ON HOCVIEN.MAHV = LastExam.MAHV
JOIN KETQUATHI ON LastExam.MAHV = KETQUATHI.MAHV AND LastExam.MAMH = KETQUATHI.MAMH AND LastExam.MAX_LANTHI = KETQUATHI.LANTHI
JOIN (
    SELECT MAHV, COUNT(DISTINCT LANTHI) AS TONG_SO_LANTHI
    FROM KETQUATHI
    GROUP BY MAHV
) AS LANTHI_COUNT ON HOCVIEN.MAHV = LANTHI_COUNT.MAHV
GROUP BY HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN;
