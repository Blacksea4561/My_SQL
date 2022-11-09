-----subqueries

create  table calisanlar
(
id int,
isim varchar(50),
	sehir varchar(50),
	maas int,
	isyeri varchar(20)
);
insert into  calisanlar values (12345678,'Ali Seker', 'Istanbul', 2500, 'Vakko');
insert into calisanlar values (23456789, 'Ayşe Gül','Istanbul',1500,'LCWaikiki');
INSERT INTO calisanlar VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

select * from calisanlar

create table markalar
(
marka_id int,
marka_isim varchar(20),
calisan_sayisi int
);
insert into markalar values (100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

select * from  markalar
select * from calisanlar

select isim, maas, isyeri from calisanlar
where isyeri in (select  marka_isim from markalar where  calisan_sayisi > 15000)


--marka_id’si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.

select  isim, maas,sehir,marka_isim from calisanlar
where  isyeri in (select marka_isim from   markalar where marka_id > 101)

--Ankara’da calisani  olan     markalarin   marka id'lerini   ve   calisan sayilarini    listeleyiniz.

select  marka_id, calisan_sayisi, marka_isim from markalar
where  marka_isim in  ( select  isyeri  from  calisanlar where  sehir= 'Ankara')

select max( maas)from calisanlar
select sum(maas) from calisanlar
select avg(maas) from calisanlar
select round(avg(maas),2) from calisanlar
select min(maas) from calisanlar
select count(maas) from calisanlar


--Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.

select marka_id, marka_isim,
(select count(sehir) from calisanlar where  marka_isim=isyeri) as sehir_sayisi from  markalar

--Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
select marka_isim,calisan_sayisi,
(select  sum(maas) from calisanlar where marka_isim=isyeri) as toplam_maas from markalar

--Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.

select  marka_isim ,calisan_sayisi,
(select  max(maas) from calisanlar where marka_isim=isyeri) as en_yüksek_maas, 
(select min (maas) from calisanlar where marka_isim=isyeri) as en_yüksek_maas
from markalar

create table mart
(
urun_id int,
	musteri_isim varchar(50),
	urun_isim varchar(50)
)
insert into  mart values (10,'Mark','Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

select * from mart 

create table nisan
(
urun_id int,
	musteri_isim varchar(50),
	urun_isim varchar(50)
);
INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo')


select urun_id,musteri_isim from mart
where exists (select urun_id from nisan  where mart.urun_id=  nisan.urun_id)



--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
select  urun_isim, musteri

SELECT urun_isim,musteri_isim FROM nisan
WHERE exists (SELECT urun_isim FROM mart where mart.urun_isim=nisan.urun_isim)

--Her iki ayda ortak satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.

SELECT urun_isim,musteri_isim FROM nisan
WHERE  not exists (SELECT urun_isim FROM mart where mart.urun_isim=nisan.urun_isim)









