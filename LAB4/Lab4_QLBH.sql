USE QLBH
--------------------------------------------------------------------
----------------- LAB 4 - PHAN III ---------------------------------
--------------------------------------------------------------------

-- 19. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua? 
SELECT HD.SOHD
FROM HOADON HD
JOIN KHACHHANG KH
ON KH.MAKH = HD.MAKH
WHERE KH.NGDK = NULL
GROUP BY HD.SOHD, HD.MAKH

-- 20. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006. 
SELECT DISTINCT SP.*
FROM SANPHAM SP
JOIN CTHD
ON CTHD.MASP = SP.MASP
JOIN HOADON HD
ON HD.SOHD = CTHD.SOHD
WHERE YEAR(HD.NGHD) = 2006

-- 21. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu? 
SELECT MAX(TRIGIA) AS TriGiaCaoNhat, MIN(TRIGIA) AS TriGiaThapNhat
FROM HOADON 

-- 22. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
SELECT AVG(TRIGIA) AS TriGiaTrungBinh
FROM HOADON

-- 23. Tính doanh thu bán hàng trong năm 2006.
SELECT SUM(TRIGIA) AS TongDoanhThuNam2006
FROM HOADON
WHERE YEAR(NGHD) = 2006

-- 24. Tìm số hóa đơn có trị giá cao nhất trong năm 2006. 
SELECT SOHD AS SoHDCoTriGiaCaoNhat, TRIGIA
FROM HOADON
WHERE YEAR(NGHD) = 2006 AND TRIGIA = (SELECT MAX(TRIGIA) 
									  FROM HOADON
									  WHERE YEAR(NGHD) = 2006)

-- 25. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
SELECT KH.HOTEN
FROM HOADON HD
JOIN KHACHHANG KH
ON KH.MAKH = HD.MAKH
WHERE YEAR(HD.NGHD) = 2006 AND HD.TRIGIA = (SELECT MAX(TRIGIA) 
											  FROM HOADON
											  WHERE YEAR(NGHD) = 2006)

-- 26. In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất. 
SELECT TOP 3 WITH TIES MAKH, HOTEN
FROM KHACHHANG
ORDER BY DOANHSO DESC

-- 27. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất. 
SELECT MASP, TENSP
FROM SANPHAM
WHERE GIA IN (SELECT DISTINCT TOP 3 WITH TIES  GIA
				FROM SANPHAM
				ORDER BY GIA DESC
				)

-- 28. In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = N'Thai Lan' AND GIA IN (SELECT DISTINCT TOP 3 WITH TIES  GIA
										FROM SANPHAM
										ORDER BY GIA DESC
										)

-- 29. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = N'Trung Quoc' AND GIA IN (SELECT DISTINCT TOP 3 WITH TIES  GIA
										FROM SANPHAM
										ORDER BY GIA DESC
										)

--30. * In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng).
SELECT TOP 3 MAKH, HOTEN
FROM KHACHHANG
ORDER BY DOANHSO DESC

-- 31. Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
SELECT COUNT(*) AS TongSoSP
FROM SANPHAM
WHERE NUOCSX = N'Trung Quoc'

-- 32. Tính tổng số sản phẩm của từng nước sản xuất. 
SELECT NUOCSX, COUNT(*) AS TongSoSP
FROM SANPHAM
GROUP BY NUOCSX
ORDER BY NUOCSX

-- 33. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm. 
SELECT 
	NUOCSX, 
	MAX(GIA) AS GiaBanCaoNhat,
	MIN(GIA) AS GiaBanThapNhat,
	AVG(GIA) AS GiaBanTrungBinh
FROM SANPHAM
GROUP BY NUOCSX
ORDER BY NUOCSX

-- 34. Tính doanh thu bán hàng mỗi ngày. 
SELECT 
	NGHD,
	SUM(TRIGIA) AS DoanhThuTrongNgay
FROM HOADON
GROUP BY NGHD
ORDER BY NGHD

-- 35. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
SELECT 
	SP.MASP,
	SP.TENSP,
	SUM(CTHD.SL) AS TongSLSanPham
FROM SANPHAM SP
JOIN CTHD 
ON CTHD.MASP = SP.MASP
JOIN HOADON HD
ON HD.SOHD = CTHD.SOHD
WHERE MONTH(HD.NGHD) = 10 AND YEAR(HD.NGHD) = 2006
GROUP BY SP.MASP, SP.TENSP
ORDER BY SP.MASP

-- 36. Tính doanh thu bán hàng của từng tháng trong năm 2006.
SELECT 
	T.Thang, 
	ISNULL(SUM(HOADON.TRIGIA), 0) AS TongDoanhThu 
FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12)) AS T(Thang) 
LEFT JOIN HOADON 
ON T.Thang = MONTH(HOADON.NGHD) AND YEAR(HOADON.NGHD) = 2006 
GROUP BY T.Thang 
ORDER BY T.Thang

-- 37. Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau. 
SELECT HD.SOHD
FROM HOADON HD
JOIN CTHD
ON CTHD.SOHD = HD.SOHD
JOIN SANPHAM SP
ON SP.MASP = CTHD.MASP
GROUP BY HD.SOHD
HAVING COUNT(DISTINCT SP.MASP) >= 4

-- 38. Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau).
SELECT HD.SOHD
FROM HOADON HD
JOIN CTHD
ON CTHD.SOHD = HD.SOHD
JOIN SANPHAM SP
ON SP.MASP = CTHD.MASP
WHERE SP.NUOCSX = N'Viet Nam'
GROUP BY HD.SOHD
HAVING COUNT(DISTINCT SP.MASP) >= 3

-- 39. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất. 
SELECT TOP 1 WITH TIES
	KH.MAKH,
	KH.HOTEN,
	TongHD_KH.TongHD
FROM KHACHHANG KH
JOIN (
	SELECT
		KH.MAKH,
		COUNT(DISTINCT HD.SOHD) AS TongHD
	FROM KHACHHANG KH
	JOIN HOADON HD
	ON HD.MAKH = KH.MAKH
	GROUP BY KH.MAKH
) AS TongHD_KH
ON TongHD_KH.MAKH = KH.MAKH
ORDER BY TongHD_KH.TongHD DESC

-- 40. Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ?
SELECT TOP 1 WITH TIES T.Thang
FROM (
	SELECT MONTH(HOADON.NGHD) AS Thang
	FROM HOADON
	WHERE YEAR(HOADON.NGHD) = 2006
	GROUP BY MONTH(HOADON.NGHD)
	) AS T
JOIN (
	SELECT MONTH(HOADON.NGHD) AS THANG, SUM(TRIGIA) AS TongDoanhSo
	FROM HOADON
	WHERE YEAR(HOADON.NGHD) = 2006
	GROUP BY MONTH(HOADON.NGHD)
) AS DOANHSO
ON DOANHSO.THANG = T.Thang
ORDER BY DOANHSO.TongDoanhSo DESC

-- 41. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006. 
SELECT TOP 1 WITH TIES
	SP.MASP,
	SP.TENSP,
	TongSL_SP.TongSL
FROM SANPHAM SP
JOIN (
	SELECT 
		CTHD.MASP AS MASP,
		SUM(CTHD.SL) AS TongSL
	FROM CTHD
	JOIN HOADON HD
	ON CTHD.SOHD = HD.SOHD
	WHERE YEAR(HD.NGHD) = 2006
	GROUP BY CTHD.MASP
	) AS TongSL_SP
ON TongSL_SP.MASP = SP.MASP
ORDER BY TongSL_SP.TongSL

-- 42. *Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất. 
SELECT 
	SP.MASP,
	SP.TENSP,
	SP.NUOCSX,
	SP.GIA
FROM SANPHAM SP
JOIN (
	SELECT NUOCSX, MAX(GIA) AS GIAMAX
	FROM SANPHAM
	GROUP BY SANPHAM.NUOCSX
	) GiaBanSP_NuocSX
ON GiaBanSP_NuocSX.NUOCSX = SP.NUOCSX
WHERE SP.GIA = GiaBanSP_NuocSX.GIAMAX

-- 43. Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau. 
SELECT NUOCSX
FROM SANPHAM
GROUP BY NUOCSX
HAVING COUNT(DISTINCT GIA) >= 3

-- 44. *Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất. 
SELECT TOP 1 WITH TIES
	Top10KH.MAKH,
	Top10KH.HOTEN,
	COUNT(DISTINCT HD.SOHD) AS SoLanMua
FROM (
	SELECT TOP 10 
		MAKH, 
		HOTEN,
		DOANHSO
	FROM KHACHHANG
	ORDER BY DOANHSO DESC, MAKH ASC
	) AS Top10KH
JOIN HOADON HD
ON HD.MAKH = Top10KH.MAKH
GROUP BY Top10KH.MAKH, Top10KH.HOTEN
ORDER BY COUNT(DISTINCT HD.SOHD) DESC