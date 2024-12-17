﻿
CREATE DATABASE QUANLYGIAOVU
USE QUANLYGIAOVU

----------------------------------------------------------------------------------------------------------------
------------------------------------- LAB 4 --------------------------------------------------------------------
---------------------------- PHAN 3 - TU CAU 19 DEN 35 ---------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

-- 19. Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất. 
SELECT TOP 1 WITH TIES
	MAKHOA,
	TENKHOA
FROM KHOA
ORDER BY NGTLAP

-- 20. Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”.
SELECT COUNT(*) AS SL_GS_PGS
FROM GIAOVIEN 
WHERE HOCHAM IN ('GS', 'PGS')

-- 21. Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi khoa. 
SELECT 
	K.TENKHOA,
	GV.HOCVI,
	COUNT(GV.MAGV) AS SL
FROM KHOA K
RIGHT JOIN GIAOVIEN GV
ON K.MAKHOA = GV.MAKHOA
GROUP BY K.MAKHOA, K.TENKHOA, GV.HOCVI
ORDER BY K.MAKHOA

-- 22. Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt). 
SELECT 
	MH.MAMH,
	MH.TENMH,
	ISNULL(KQ_DAT.SLDat, 0),
	ISNULL(KQ_KHONGDAT.SLKhongDat,0)
FROM MONHOC MH
LEFT JOIN (
	SELECT MAMH, COUNT(*) AS SLDat
	FROM KETQUATHI
	WHERE KQUA = 'Dat'
	GROUP BY MAMH
	) KQ_DAT
ON KQ_DAT.MAMH = MH.MAMH
LEFT JOIN (
	SELECT MAMH, COUNT(*) AS SLKhongDat
	FROM KETQUATHI
	WHERE KQUA = 'Khong Dat'
	GROUP BY MAMH
	) KQ_KHONGDAT
ON KQ_KHONGDAT.MAMH = MH.MAMH

-- 23. Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho lớp đó ít nhất một môn học. 
SELECT 
	GV.MAGV,
	GV.HOTEN
FROM GIAOVIEN GV
JOIN (
	SELECT DISTINCT L.MAGVCN
	FROM LOP L
	JOIN GIANGDAY GD
	ON GD.MALOP = L.MALOP
	) AS DAYMH
ON GV.MAGV = DAYMH.MAGVCN

-- 24. Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất.
SELECT
	L.TENLOP,
	CONCAT(HV.HO, ' ', HV.TEN) AS TruongLop 
FROM LOP L
JOIN HOCVIEN HV
ON HV.MAHV = L.TRGLOP
WHERE L.SISO = (SELECT MAX(SISO) FROM LOP)

-- 25. * Tìm họ tên những LOPTRG thi không đạt quá 3 môn (mỗi môn đều thi không đạt ở tất cả các lần thi). 
SELECT
	KQT.MAHV
FROM KETQUATHI KQT
JOIN (
	SELECT 
		MAHV,
		COUNT(*) AS TongLanThi
	FROM KETQUATHI
	GROUP BY MAHV
	) AS LT
ON LT.MAHV = KQT.MAHV
WHERE KQT.KQUA = 'Khong Dat'
GROUP BY KQT.MAHV, LT.TongLanThi
HAVING (COUNT(KQT.LANTHI)) = LT.TongLanThi AND COUNT(DISTINCT KQT.MAMH) > 3

SELECT
	CONCAT(HV.HO, ' ', HV.TEN) AS HoTen
FROM LOP L
JOIN HOCVIEN HV
ON L.TRGLOP = HV.MAHV
JOIN (
	SELECT
		KQT.MAHV
	FROM KETQUATHI KQT
	JOIN (
		SELECT 
			MAHV,
			COUNT(*) AS TongLanThi
		FROM KETQUATHI
		GROUP BY MAHV
		) AS LT
	ON LT.MAHV = KQT.MAHV
	WHERE KQT.KQUA = 'Khong Dat'
	GROUP BY KQT.MAHV, LT.TongLanThi
	HAVING (COUNT(KQT.LANTHI)) = LT.TongLanThi AND COUNT(DISTINCT KQT.MAMH) > 3
	) AS HV_THIKHONGDAT
ON HV_THIKHONGDAT.MAHV = L.TRGLOP

-- 26. Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9, 10 nhiều nhất.
SELECT TOP 1 WITH TIES
	KQT.MAHV
FROM KETQUATHI KQT
WHERE KQT.DIEM = 9 OR KQT.DIEM = 10
GROUP BY KQT.MAHV
ORDER BY COUNT(DISTINCT KQT.MAMH) DESC

SELECT
	CONCAT(HV.HO, ' ', HV.TEN) AS HoTen
FROM HOCVIEN HV
JOIN (
	SELECT TOP 1 WITH TIES
		KQT.MAHV
	FROM KETQUATHI KQT
	WHERE KQT.DIEM = 9 OR KQT.DIEM = 10
	GROUP BY KQT.MAHV
	ORDER BY COUNT(DISTINCT KQT.MAMH) DESC
	) AS DIEMCAONHAT
ON DIEMCAONHAT.MAHV = HV.MAHV

-- 27. Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9, 10 nhiều nhất. 
SELECT 
	HV.MALOP,
	MAX(HV_DATDIEMCAO.SoMonDiemCao)
FROM HOCVIEN HV
JOIN (
	SELECT 
		KQT.MAHV, COUNT(DISTINCT KQT.MAMH) AS SoMonDiemCao
	FROM KETQUATHI KQT
	WHERE KQT.DIEM = 9 OR KQT.DIEM = 10
	GROUP BY KQT.MAHV
	) AS HV_DATDIEMCAO
ON HV_DATDIEMCAO.MAHV = HV.MAHV
GROUP BY HV.MALOP

SELECT HV.*
FROM HOCVIEN HV
JOIN (
	SELECT 
		KQT.MAHV,
		COUNT(DISTINCT KQT.MAMH) AS SoMonDiemCao 
	FROM KETQUATHI KQT
	WHERE KQT.DIEM = 9 OR KQT.DIEM = 10
	GROUP BY KQT.MAHV
	) AS HV_DATDIEMCAO
ON HV_DATDIEMCAO.MAHV = HV.MAHV
WHERE HV_DATDIEMCAO.SoMonDiemCao IN
 (
	SELECT MAX(HV_DATDIEMCAO2.SoMonDiemCao)
	FROM (
		SELECT 
			KQT.MAHV,
			COUNT(DISTINCT KQT.MAMH) AS SoMonDiemCao 
		FROM KETQUATHI KQT
		WHERE KQT.DIEM = 9 OR KQT.DIEM = 10
		GROUP BY KQT.MAHV
		) AS HV_DATDIEMCAO2
	JOIN HOCVIEN HV1
	ON HV_DATDIEMCAO2.MAHV = HV1.MAHV
	GROUP BY HV1.MALOP
)

-- 28. Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao nhiêu lớp. 
SELECT 
	GV.HOTEN,
	GD.HOCKY,
	GD.NAM,
	COUNT(MAMH) AS SoMH,
	COUNT (MALOP) AS SoLop
FROM GIANGDAY GD
JOIN GIAOVIEN GV
ON GV.MAGV = GD.MAGV
GROUP BY GD.HOCKY, GD.NAM, GV.HOTEN, GV.MAGV
ORDER BY GV.MAGV

-- 29. Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất. 

SELECT 
	T1.HOCKY,
	T1.NAM,
	T1.HOTEN
FROM (
	SELECT 
		GV.HOTEN,
		GD.HOCKY,
		GD.NAM,
		COUNT(MAMH) AS SoMH,
		COUNT (MALOP) AS SoLop
	FROM GIANGDAY GD
	JOIN GIAOVIEN GV
	ON GV.MAGV = GD.MAGV
	GROUP BY GD.HOCKY, GD.NAM, GV.HOTEN, GV.MAGV
	) AS T1
JOIN (
	SELECT 
		PHANCONG.HOCKY,
		PHANCONG.NAM,
		MAX(PHANCONG.SoLop) AS DayNhieuNhat
	FROM (
		SELECT 
			GV.HOTEN,
			GD.HOCKY,
			GD.NAM,
			COUNT(MAMH) AS SoMH,
			COUNT (MALOP) AS SoLop
		FROM GIANGDAY GD
		JOIN GIAOVIEN GV
		ON GV.MAGV = GD.MAGV
		GROUP BY GD.HOCKY, GD.NAM, GV.HOTEN, GV.MAGV
		) AS PHANCONG
	GROUP BY PHANCONG.HOCKY, PHANCONG.NAM
	) AS T2
ON T1.HOCKY = T2.HOCKY AND T1.NAM = T2.NAM AND T1.SoLop = T2.DayNhieuNhat

-- 30. Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt (ở lần thi thứ 1) nhất.
SELECT TOP 1 WITH TIES
	MH.MAMH,
	MH.TENMH
FROM KETQUATHI KQT
JOIN MONHOC MH
ON MH.MAMH = KQT.MAMH
WHERE KQT.LANTHI = 1 AND KQT.KQUA = 'Khong Dat'
GROUP BY MH.MAMH, MH.TENMH
ORDER BY COUNT(KQT.MAHV) DESC