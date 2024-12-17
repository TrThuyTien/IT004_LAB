USE QUANLYGIAOVU

-- 9. Lớp trưởng của một lớp phải là học viên của lớp đó. 
CREATE TRIGGER trg_ins_lop
ON LOP
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS (SELECT *
			   FROM inserted, HOCVIEN
			   WHERE inserted.TRGLOP = HOCVIEN.MAHV
			   AND inserted.MALOP != HOCVIEN.MALOP)
		BEGIN
			-- Thong bao loi
			RAISERROR('LOI: MA LOP CUA TRUONG LOP KHONG DUNG', 16, 1)
			-- Khoi phuc lai du lieu
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			-- Thong bao them thanh cong
			PRINT 'Them moi lop thanh cong'
		END
END

-- 10. Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS”.
CREATE TRIGGER trg_ins_truongkhoa
ON KHOA
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS ( SELECT *
				FROM inserted, GIAOVIEN
				WHERE inserted.TRGKHOA = GIAOVIEN.MAGV
				AND (inserted.MAKHOA != GIAOVIEN.MAKHOA 
					 OR (GIAOVIEN.HOCVI NOT IN('TS', 'PTS'))))
		BEGIN
			-- Thong bao loi
			RAISERROR('LOI: MA TRUONG KHOA KHONG DUNG', 16, 1)
			-- Khoi phuc lai du lieu
			ROLLBACK TRANSACTION
		END
	ELSE 
		BEGIN
			-- Thong bao them thanh cong
			PRINT 'Them moi lop thanh cong'
		END
END

-- 15. Học viên chỉ được thi một môn học nào đó khi lớp của học viên đã học xong môn học này.
CREATE TRIGGER trg_ins_kqt
ON KETQUATHI
FOR INSERT
AS
BEGIN
	IF EXISTS ( SELECT *
				FROM inserted, HOCVIEN, GIANGDAY
				WHERE inserted.MAHV = HOCVIEN.MAHV
				AND HOCVIEN.MALOP = GIANGDAY.MALOP
				AND inserted.MAMH = GIANGDAY.MAMH
				AND inserted.NGTHI > GIANGDAY.DENNGAY)
		BEGIN
			-- Thong bao them thanh cong
			PRINT 'Them moi lop thanh cong'
		END
	ELSE
		BEGIN
			-- Thong bao loi
			RAISERROR('LOI: MON THI CUA HOC VIEN CHUA KET THUC', 16, 1)
			-- Khoi phuc lai du lieu
			ROLLBACK TRANSACTION
		END
END

-- 16. Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn. 
CREATE TRIGGER trg_ins_giangday
ON GIANGDAY
FOR INSERT, UPDATE
AS 
BEGIN
	IF EXISTS ( SELECT *
				FROM inserted
				GROUP BY inserted.MALOP, inserted.HOCKY, inserted.NAM
				HAVING COUNT(DISTINCT inserted.MAMH) > 3)
		BEGIN
			-- Thong bao loi
			RAISERROR('LOI: LOP HOC DA DANG KI TOI DA 3 MON', 16, 1)
			-- Khoi phuc lai du lieu
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			-- Thong bao them thanh cong
			PRINT 'Them moi lop thanh cong'
		END
END

-- 17. Sỉ số của một lớp bằng với số lượng học viên thuộc lớp đó.
CREATE TRIGGER trg_ins_hocvien
ON HOCVIEN
AFTER INSERT
AS
BEGIN
	UPDATE LOP
	SET SISO = (SELECT COUNT(inserted.MAHV)
				FROM inserted
				WHERE LOP.MALOP = inserted.MALOP
				GROUP BY inserted.MALOP)
	FROM inserted i
	WHERE i.MALOP = LOP.MALOP
END

-- 18. Trong quan hệ DIEUKIEN giá trị của thuộc tính MAMH và MAMH_TRUOC trong cùng một bộ không được giống nhau (“A”,”A”) và cũng không tồn tại hai bộ (“A”,”B”) và (“B”,”A”).
CREATE TRIGGER trg_ins_dieukien
ON DIEUKIEN
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS ( SELECT *
				FROM inserted i, DIEUKIEN
				WHERE i.MAMH = DIEUKIEN.MAMH
				OR (i.MAMH_TRUOC = DIEUKIEN.MAMH AND i.MAMH = DIEUKIEN.MAMH_TRUOC))
		BEGIN
			-- Thong bao loi
			RAISERROR('LOI: MAMH_TRUOC BANG MAMH HOAC DA TON TAI', 16, 1)
			-- Khoi phuc lai du lieu
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			-- Thong bao them thanh cong
			PRINT 'Them moi lop thanh cong'
		END
END


-- 19. Các giáo viên có cùng học vị, học hàm, hệ số lương thì mức lương bằng nhau. 
CREATE TRIGGER trg_ins_giaovien
ON GIAOVIEN
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS ( SELECT *
				FROM inserted i, GIAOVIEN
				WHERE i.MAGV != GIAOVIEN.MAGV
				AND i.HOCVI = GIAOVIEN.HOCVI
				AND i.HOCHAM = GIAOVIEN.HOCHAM
				AND i.MUCLUONG != GIAOVIEN.MUCLUONG)
		BEGIN
			-- Thong bao loi
			RAISERROR('LOI: MUC LUONG CUA GIAO VIEN KHONG DUNG', 16, 1)
			-- Khoi phuc lai du lieu
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			-- Thong bao them thanh cong
			PRINT 'Them moi lop thanh cong'
		END
END
-- 20. Học viên chỉ được thi lại (lần thi >1) khi điểm của lần thi trước đó dưới 5.
CREATE TRIGGER trg_ins_thilai
ON KETQUATHI
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS ( SELECT *
				FROM inserted, KETQUATHI
				WHERE inserted.MAHV = KETQUATHI.MAHV
				AND inserted.MAMH = KETQUATHI.MAMH
				AND inserted.LANTHI = KETQUATHI.LANTHI + 1
				AND KETQUATHI.KQUA < 5)
		
		BEGIN
			-- Thong bao loi
			RAISERROR('LOI: HOC VIEN KHONG THE THI LAI MON NAY', 16, 1)
			-- Khoi phuc lai du lieu
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			-- Thong bao them thanh cong
			PRINT 'Them moi lop thanh cong'
		END
END

-- 21. Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước (cùng học viên, cùng môn học).
CREATE TRIGGER trg_ins_ngaythi
ON KETQUATHI
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS ( SELECT *
				FROM inserted, KETQUATHI
				WHERE KETQUATHI.MAHV = inserted.MAHV
				AND KETQUATHI.MAMH = inserted.MAMH
				AND KETQUATHI.LANTHI + 1 = inserted.LANTHI
				AND inserted.NGTHI < KETQUATHI.NGTHI)
		BEGIN
			-- Thong bao loi
			RAISERROR('LOI: NGAY THI LAN SAU BE HON NGAY THI LAN TRUOC', 16, 1)
			-- Khoi phuc lai du lieu
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			-- Thong bao them thanh cong
			PRINT 'Them moi lop thanh cong'
		END
END

-- 22. Khi phân công giảng dạy một môn học, phải xét đến thứ tự trước sau giữa các môn học (sau khi học xong những môn học phải học trước mới được học những môn liền sau). 
CREATE TRIGGER trg_ins_phanconggiangday
ON GIANGDAY
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS ( SELECT *
				FROM inserted, DIEUKIEN, GIANGDAY
				WHERE inserted.MAMH = DIEUKIEN.MAMH
				AND (DIEUKIEN.MAMH_TRUOC = NULL
					 OR (inserted.MALOP = GIANGDAY.MALOP 
					     AND GIANGDAY.MAMH = DIEUKIEN.MAMH_TRUOC 
						 AND inserted.TUNGAY > GIANGDAY.DENNGAY)))
		BEGIN
			-- Thong bao them thanh cong
			PRINT 'Them moi lop thanh cong'
		END
	ELSE
		BEGIN
			-- Thong bao loi
			RAISERROR('LOI: SAI THU TU MON HOC TRUOC SAU', 16, 1)
			-- Khoi phuc lai du lieu
			ROLLBACK TRANSACTION
		END
END

-- 23. Giáo viên chỉ được phân công dạy những môn thuộc khoa giáo viên đó phụ trách.
CREATE TRIGGER trg_ins_phanmongiangday
ON GIANGDAY
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS ( SELECT *
				FROM inserted, MONHOC, GIAOVIEN
				WHERE inserted.MAMH = MONHOC.MAMH
				AND inserted.MAGV = GIAOVIEN.MAGV
				AND MONHOC.MAKHOA = GIAOVIEN.MAKHOA)
		
		BEGIN
			-- Thong bao them thanh cong
			PRINT 'Them moi lop thanh cong'
		END
	ELSE
		BEGIN
			-- Thong bao loi
			RAISERROR('LOI: GIAO VIEN KHONG THE GIANG DAY MON HOC KHONG THUOC KHOA', 16, 1)
			-- Khoi phuc lai du lieu
			ROLLBACK TRANSACTION
		END
END