USE QUANLYDUAN
-- 76. Liệt kê top 3 chuyên gia có nhiều kỹ năng nhất và số lượng kỹ năng của họ.
SELECT TOP 3 CG.MaChuyenGia, CG.HoTen, COUNT(CGKN.MaKyNang) AS SLKyNang
FROM ChuyenGia CG
JOIN ChuyenGia_KyNang CGKN
ON CG.MaChuyenGia = CGKN.MaChuyenGia
GROUP BY CG.MaChuyenGia, CG.HoTen
ORDER BY COUNT(CGKN.MaKyNang) DESC

-- 77. Tìm các cặp chuyên gia có cùng chuyên ngành và số năm kinh nghiệm chênh lệch không quá 2 năm.
SELECT CG1.HoTen AS ChuyenGia1, CG2.HoTen AS ChuyenGia2
FROM ChuyenGia CG1
JOIN ChuyenGia CG2
ON CG1.ChuyenNganh = CG2.ChuyenNganh AND CG1.MaChuyenGia < CG2.MaChuyenGia
WHERE ABS(CG1.NamKinhNghiem - CG2.NamKinhNghiem) <= 2
-- 78. Hiển thị tên công ty, số lượng dự án và tổng số năm kinh nghiệm của các chuyên gia tham gia dự án của công ty đó.
SELECT CT.TenCongTy, COUNT(DA.MaDuAn) AS SLDuAn, SUM(CG.NamKinhNghiem) AS TongSoNamKinhNghiem
FROM CongTy CT
JOIN DuAn DA
ON CT.MaCongTy = DA.MaCongTy
JOIN ChuyenGia_DuAn CGDA
ON CGDA.MaDuAn = DA.MaDuAn
JOIN ChuyenGia CG
ON CG.MaChuyenGia = CGDA.MaChuyenGia
GROUP BY CT.MaCongTy, CT.TenCongTy
-- 79. Tìm các chuyên gia có ít nhất một kỹ năng cấp độ 5 nhưng không có kỹ năng nào dưới cấp độ 3.
SELECT CG.HoTen
FROM ChuyenGia CG
JOIN ChuyenGia_KyNang CGKN
ON CG.MaChuyenGia = CGKN.MaChuyenGia
GROUP BY CG.MaChuyenGia, CG.HoTen
HAVING MAX(CGKN.CapDo) >= 5 AND MIN(CGKN.CapDo) >= 3
ORDER BY CG.MaChuyenGia
-- 80. Liệt kê các chuyên gia và số lượng dự án họ tham gia, bao gồm cả những chuyên gia không tham gia dự án nào.
SELECT CG.HoTen, COUNT(DISTINCT CGDA.MaDuAn) AS SLDuAn
FROM ChuyenGia CG
JOIN ChuyenGia_DuAn CGDA
ON CG.MaChuyenGia = CGDA.MaChuyenGia
GROUP BY CG.MaChuyenGia, CG.HoTen
ORDER BY CG.MaChuyenGia

-- 81*. Tìm chuyên gia có kỹ năng ở cấp độ cao nhất trong mỗi loại kỹ năng.
SELECT KN.LoaiKyNang, CG.HoTen, CGKN2.CapDo
FROM KyNang KN
JOIN (SELECT CGKN.MaKyNang, MAX(CGKN.CapDo) AS CapDoCaoNhat
	  FROM ChuyenGia_KyNang CGKN
	  GROUP BY CGKN.MaKyNang
	  )
AS MKN
ON KN.MaKyNang = MKN.MaKyNang
JOIN ChuyenGia_KyNang CGKN2
ON CGKN2.MaKyNang = KN.MaKyNang AND CGKN2.CapDo = MKN.CapDoCaoNhat
JOIN ChuyenGia CG
ON CG.MaChuyenGia = CGKN2.MaChuyenGia
GROUP BY KN.LoaiKyNang, CG.HoTen, CGKN2.CapDo


-- 82. Tính tỷ lệ phần trăm của mỗi chuyên ngành trong tổng số chuyên gia.
SELECT ChuyenNganh, COUNT(ChuyenNganh) * 100 / (SELECT COUNT(*) FROM ChuyenGia) AS TyLe
FROM ChuyenGia
GROUP BY ChuyenNganh

-- 83. Tìm các cặp kỹ năng thường xuất hiện cùng nhau nhất trong hồ sơ của các chuyên gia.
SELECT K1.TenKyNang AS KyNang1, K2.TenKyNang AS KyNang2, COUNT(*) AS SoLanXuatHien
FROM ChuyenGia_KyNang CGK1
JOIN ChuyenGia_KyNang CGK2 ON CGK1.MaChuyenGia = CGK2.MaChuyenGia AND CGK1.MaKyNang < CGK2.MaKyNang
JOIN KyNang K1 ON CGK1.MaKyNang = K1.MaKyNang
JOIN KyNang K2 ON CGK2.MaKyNang = K2.MaKyNang
GROUP BY K1.TenKyNang, K2.TenKyNang
ORDER BY SoLanXuatHien DESC;


-- 84. Tính số ngày trung bình giữa ngày bắt đầu và ngày kết thúc của các dự án cho mỗi công ty.
SELECT CT.MaCongTy, CT.TenCongTy, AVG(DATEDIFF(DAY, DA.NgayBatDau, DA.NgayKetThuc)) AS SoNgayTrungBinh
FROM CongTy CT
JOIN DuAn DA
ON CT.MaCongTy = DA.MaCongTy
GROUP BY CT.MaCongTy, CT.TenCongTy
-- 85*. Tìm chuyên gia có sự kết hợp độc đáo nhất của các kỹ năng (kỹ năng mà chỉ họ có).
SELECT cg.HoTen, cg.MaChuyenGia, kn.MaKyNang, kn.TenKyNang, kn.LoaiKyNang
FROM ChuyenGia cg
JOIN ChuyenGia_KyNang cgn ON cg.MaChuyenGia = cgn.MaChuyenGia
JOIN KyNang kn ON cgn.MaKyNang = kn.MaKyNang
WHERE NOT EXISTS (
    SELECT 1
    FROM ChuyenGia_KyNang cgn2
    WHERE cgn2.MaKyNang = cgn.MaKyNang
    AND cgn2.MaChuyenGia <> cgn.MaChuyenGia
    HAVING COUNT(cgn2.MaChuyenGia) > 0
)
ORDER BY cg.MaChuyenGia, kn.MaKyNang;


-- 86*. Tạo một bảng xếp hạng các chuyên gia dựa trên số lượng dự án và tổng cấp độ kỹ năng.
SELECT 
    cg.MaChuyenGia, 
    cg.HoTen, 
    COUNT(DISTINCT cda.MaDuAn) AS SoLuongDuAn, 
    SUM(cgkn.CapDo) AS TongCapDoKyNang,
    RANK() OVER (ORDER BY COUNT(DISTINCT cda.MaDuAn) DESC, SUM(cgkn.CapDo) DESC) AS XepHang
FROM 
    ChuyenGia cg
LEFT JOIN 
    ChuyenGia_DuAn cda ON cg.MaChuyenGia = cda.MaChuyenGia
LEFT JOIN 
    ChuyenGia_KyNang cgkn ON cg.MaChuyenGia = cgkn.MaChuyenGia
GROUP BY 
    cg.MaChuyenGia, 
    cg.HoTen
ORDER BY 
    XepHang;


-- 87. Tìm các dự án có sự tham gia của chuyên gia từ tất cả các chuyên ngành.
SELECT DA.TenDuAn, DA.TenDuAn
FROM DuAn DA
JOIN (
		SELECT CGDA.MaDuAn
		FROM ChuyenGia CG
		JOIN ChuyenGia_DuAn CGDA
		ON CG.MaChuyenGia = CGDA.MaChuyenGia
		GROUP BY CGDA.MaDuAn
		HAVING COUNT(CG.ChuyenNganh) = (SELECT COUNT(DISTINCT ChuyenNganh) FROM ChuyenGia))
AS CN 
ON CN.MaDuAn = DA.MaDuAn

-- 88. Tính tỷ lệ thành công của mỗi công ty dựa trên số dự án hoàn thành so với tổng số dự án.
SELECT CT.TenCongTy, COUNT(DA.MaDuAn) * 100 / (SELECT COUNT(*) FROM DuAn) AS TyLeThanhCong
FROM CongTy CT
JOIN DuAn DA
ON DA.MaCongTy = CT.MaCongTy
WHERE DA.TrangThai = N'Hoàn thành'
GROUP BY CT.MaCongTy, CT.TenCongTy

-- 89. Tìm các chuyên gia có kỹ năng "bù trừ" nhau (một người giỏi kỹ năng A nhưng yếu kỹ năng B, người kia ngược lại).
SELECT
FROM ChuyenGia_KyNang