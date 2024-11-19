use QUANLYBANHANG
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
--1. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20, và tổng trị giá hóa đơn lớn hơn 500.000. 
select distinct HD.SOHD
from HOADON HD
join CTHD
on HD.SOHD = CTHD.SOHD
where HD.TRIGIA > 500000 and (CTHD.SL between 10 and 20) and (CTHD.MASP = 'BB01' or CTHD.MASP = 'BB02') 

--2. Tìm các số hóa đơn mua cùng lúc 3 sản phẩm có mã số “BB01”, “BB02” và “BB03”, mỗi sản phẩm mua với số lượng từ 10 đến 20, và ngày mua hàng trong năm 2023. 
select distinct HD1.SOHD
from HOADON HD1
join CTHD 
on CTHD.SOHD = HD1.SOHD
where CTHD.MASP = 'BB01' and exists (select *
									from HOADON HD2
									join CTHD 
									on CTHD.SOHD = HD2.SOHD
									where CTHD.MASP = 'BB02' and exists (select *
																		from HOADON HD3
																		join CTHD 
																		on CTHD.SOHD = HD3.SOHD
																		where CTHD.MASP = 'BB03'
																		and HD1.SOHD = HD2.SOHD
																		and HD2.SOHD = HD3.SOHD
																		and year(HD1.NGHD) = 2023
																		)
									)
--3. Tìm các khách hàng đã mua ít nhất một sản phẩm có mã số “BB01” với số lượng từ 10 đến 20, và 
--tổng trị giá tất cả các hóa đơn của họ lớn hơn hoặc bằng 1 triệu đồng. 
select distinct KH.MAKH, KH.HOTEN
from KHACHHANG KH
join HOADON HD
on HD.MAKH = KH.MAKH
join CTHD 
on CTHD.SOHD = HD.SOHD
where CTHD.MASP = 'BB01' and (CTHD.SL between 10 and 20)
group by KH.MAKH, KH.HOTEN
having sum(HD.TRIGIA) >= 1000000
--4. Tìm các nhân viên bán hàng đã thực hiện giao dịch bán ít nhất một sản phẩm có mã số “BB01” 
--hoặc “BB02”, mỗi sản phẩm bán với số lượng từ 15 trở lên, và tổng trị giá của tất cả các hóa đơn mà 
--nhân viên đó xử lý lớn hơn hoặc bằng 2 triệu đồng. 
select NV.HOTEN
from NHANHVIEN NV
join HOADON HD
on HD.MANV = NV.MANV
join CTHD
on CTHD.SOHD = HD.SOHD
where (CTHD.MASP = 'BB01' or CTHD.MASP = 'BB02') and (CTHD.SL >= 15) 
group by NV.MANV, NV.HOTEN
having sum(HD.TRIGIA) >= 2000000
--5. Tìm các khách hàng đã mua ít nhất hai loại sản phẩm khác nhau với tổng số lượng từ tất cả các hóa 
--đơn của họ lớn hơn hoặc bằng 50 và tổng trị giá của họ lớn hơn hoặc bằng 5 triệu đồng. 
select KH.MAKH, 
	   KH.HOTEN, 
	   count( distinct CT.MASP) as SLSanPham,
	   sum(CT.SL) as TongSL,
	   sum(HD.TRIGIA) as TongTG
from KHACHHANG KH
join HOADON HD
on HD.MAKH = KH.MAKH
join CTHD CT
on CT.SOHD = HD.SOHD
group by KH.MAKH, KH.HOTEN
having count( distinct CT.MASP) >= 2
	   and sum(CT.SL) >= 50
	   and sum(HD.TRIGIA) >= 5000000 

--6. Tìm những khách hàng đã mua cùng lúc ít nhất ba sản phẩm khác nhau trong cùng một hóa đơn và 
--mỗi sản phẩm đều có số lượng từ 5 trở lên.
select KH.MAKH, 
	   KH.HOTEN, 
	   HD.SOHD,
	   count( distinct CT.MASP) as SLSanPham,
	   sum(CT.SL) as TongSL
from KHACHHANG KH
join HOADON HD
on HD.MAKH = KH.MAKH
join CTHD CT
on CT.SOHD = HD.SOHD
group by KH.MAKH, KH.HOTEN, HD.SOHD
having count( distinct CT.MASP) >= 3
	   and sum(CT.SL) >= 5
--7. Tìm các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất và đã được bán ra ít nhất 5 lần 
--trong năm 2007 
select SP.MASP, SP.TENSP
from SANPHAM SP
join CTHD CT
on CT.MASP = SP.MASP
join HOADON HD
on HD.SOHD = CT.SOHD
where year (HD.NGHD) = 2007 and SP.NUOCSX = N'Trung Quoc'
group by SP.MASP, SP.TENSP
having count (distinct CT.SOHD) >= 5
--8. Tìm các khách hàng đã mua ít nhất một sản phẩm do “Singapore” sản xuất trong năm 2006 và tổng 
--trị giá hóa đơn của họ trong năm đó lớn hơn 1 triệu đồng. 
select KH.MAKH, KH.HOTEN
from KHACHHANG KH
join HOADON HD
on HD.MAKH = KH.MAKH
join CTHD CT
on CT.SOHD = HD.SOHD
join SANPHAM SP
on SP.MASP = CT.MASP
where SP.NUOCSX = N'Singapore' and year(HD.NGHD) = 2006
group by KH.MAKH, KH.HOTEN
having count(CT.MASP) >= 1
--9. Tìm những nhân viên bán hàng đã thực hiện giao dịch bán nhiều nhất các sản phẩm do “Trung 
--Quoc” sản xuất trong năm 2006. 
SELECT NV.MANV, NV.HOTEN, SUM(CT.SL) AS TongSoLuong
FROM NHANHVIEN NV
INNER JOIN HOADON HD ON NV.MANV = HD.MANV
INNER JOIN CTHD CT ON HD.SOHD = CT.SOHD
INNER JOIN SANPHAM SP ON CT.MASP = SP.MASP
WHERE YEAR(HD.NGHD) = 2006 AND SP.NUOCSX = 'Trung Quoc'
GROUP BY NV.MANV, NV.HOTEN
ORDER BY TongSoLuong DESC;
--10. Tìm những khách hàng chưa từng mua bất kỳ sản phẩm nào do “Singapore” sản xuất nhưng đã 
--mua ít nhất một sản phẩm do “Trung Quoc” sản xuất. 
select KH.MAKH, KH.HOTEN
from KHACHHANG KH
join HOADON HD
on HD.MAKH = KH.MAKH
join CTHD CT
on CT.SOHD = HD.SOHD
join SANPHAM SP
on SP.MASP = CT.MASP
where SP.NUOCSX = N'Trung Quoc' and not exists (select *
												from KHACHHANG KH1
												join HOADON HD
												on HD.MAKH = KH.MAKH
												join CTHD CT
												on CT.SOHD = HD.SOHD
												join SANPHAM SP
												on SP.MASP = CT.MASP
												where SP.NUOCSX = N'Singapore'
												and KH1.MAKH = KH.MAKH
												)
group by KH.MAKH, KH.HOTEN
having count(CT.MASP) >= 1
--11. Tìm những hóa đơn có chứa tất cả các sản phẩm do “Singapore” sản xuất và trị giá hóa đơn lớn 
--hơn tổng trị giá trung bình của tất cả các hóa đơn trong hệ thống. 
with 
	HD_SP_Singapore as (
		select HD.SOHD
		from HOADON HD
		join CTHD CT
		on CT.SOHD = HD.SOHD
		join SANPHAM SP
		on SP.MASP = CT.MASP
		where SP.NUOCSX = N'Singapore'
		group by HD.SOHD
		having count(CT.MASP) = (select count(*) from SANPHAM SP where SP.NUOCSX = N'Singapore')
	),
	GTTB as (
		select avg(HD.TRIGIA) as TongTB
		from HOADON HD
	)
select HD.SOHD
from HOADON HD
join HD_SP_Singapore HDSPS
on HDSPS.SOHD = HD.SOHD
cross join GTTB
where HD.TRIGIA > GTTB.TongTB


--12. Tìm danh sách các nhân viên có tổng số lượng bán ra của tất cả các loại sản phẩm vượt quá số 
--lượng trung bình của tất cả các nhân viên khác. 
with 
	NV_TongSLBR as (
		select NV.MANV, NV.HOTEN, sum(CT.SL) as TongSL
		from NHANHVIEN NV
		join HOADON HD
		on HD.MANV = NV.MANV
		join CTHD CT
		on CT.SOHD = HD.SOHD
		group by NV.MANV, NV.HOTEN
	),
	SLTB as (
		select AVG(TSL.TongSL) as TB
		from NV_TongSLBR TSL
	)
select NV_TongSLBR.*
from NV_TongSLBR
cross join SLTB
where NV_TongSLBR.TongSL > SLTB.TB
--13. Tìm danh sách các hóa đơn có chứa ít nhất một sản phẩm từ mỗi nước sản xuất khác nhau có 
--trong hệ thống. 
select HD.SOHD
from HOADON HD
join CTHD CT
on CT.SOHD = HD.SOHD
join SANPHAM SP
on SP.MASP = CT.MASP
group by HD.SOHD
having count(CT.MASP) = (select count(distinct SANPHAM.NUOCSX) from SANPHAM)