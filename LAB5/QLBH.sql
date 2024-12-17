USE QLBH
-- 11. Ngày mua hàng (NGHD) của một khách hàng thành viên sẽ lớn hơn hoặc bằng ngày khách hàng đó đăng ký thành viên (NGDK).
CREATE TRIGGER trg_ins_hd_kh
ON HOADON
FOR INSERT
AS
BEGIN
	-- So sanh
	IF EXISTS (SELECT * FROM inserted, KHACHHANG
						WHERE inserted.MAKH = KHACHHANG.MAKH
						AND inserted.NGHD < KHACHHANG.NGDK)
		BEGIN 
			-- Thong bao co loi
			RAISERROR('LOI: NGAY HOA DON KHONG HOP LE!', 16, 1);
			-- Khoi phuc lai trang thai truoc do
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			-- Thong bao them thanh cong
			PRINT 'THEM MOI HOA DON THANH CONG!'
		END
END

-- 12. Ngày bán hàng (NGHD) của một nhân viên phải lớn hơn hoặc bằng ngày nhân viên đó vào làm.
CREATE TRIGGER trg_ins_hd_nv
ON HOADON
FOR INSERT
AS 
BEGIN
	IF EXISTS (SELECT * FROM inserted, NHANVIEN
						WHERE inserted.MANV = NHANVIEN.MANV
						AND inserted.NGHD < NHANVIEN.NGVL)
		BEGIN
			-- Thong bao loi
			RAISERROR('LOI: NGAY HOA DON KHONG HOP LE!', 16, 1)
			-- Khoi phuc lai trang thai du lieu
			ROLLBACK
		END
	ELSE
		BEGIN
			-- Thong bao thanh cong
			PRINT 'Them moi hoa don thanh cong!'
		END
END

-- 13. Trị giá của một hóa đơn là tổng thành tiền (số lượng*đơn giá) của các chi tiết thuộc hóa đơn đó.
CREATE TRIGGER trg_ins_tg_hd
ON HOADON
AFTER INSERT
AS
BEGIN
	UPDATE HOADON
	SET TRIGIA = ( SELECT SUM(CTHD.SL * SP.GIA)
				   FROM CTHD
				   JOIN SANPHAM SP
				   ON SP.MASP = CTHD.MASP
				   WHERE CTHD.SOHD = i.SOHD)
	FROM inserted i
	WHERE HOADON.SOHD = i.SOHD
END

-- 14. Doanh số của một khách hàng là tổng trị giá các hóa đơn mà khách hàng thành viên đó đã mua. 
CREATE TRIGGER trg_ins_ds_kh
ON KHACHHANG
AFTER INSERT
AS
BEGIN 
	UPDATE KHACHHANG
	SET DOANHSO = ( SELECT SUM(HOADON.TRIGIA)
					FROM HOADON, inserted
					WHERE inserted.MAKH = HOADON.MAKH
					GROUP BY HOADON.MAKH )
	FROM inserted i
	WHERE i.MAKH = KHACHHANG.MAKH
END
