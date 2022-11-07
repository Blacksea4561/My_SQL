----subqueries

select * from calisanlar2
select * from markalar 
-----Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz

select  marka_isim, calisan_sayisi,
(select sum (maas) from calisanlar2  where marka_isim=isyeri) as  calisanlar_toplam_maas
from markalar

--Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.

select marka_isim,calisan_sayisi,
(select  max(maas) from calisanlar2 where marka_isim=isyeri) as en_yuksek_maas,
(select  min(maas) from calisanlar2 where marka_isim=isyeri) as en_dusuk_maas

from markalar


CREATE TABLE mart
(
urun_id int,
musteri_isim varchar(50), 
urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan
(
urun_id int ,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');


select * from mart 
select * from nisan
--MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
 --URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
-- MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız.
select urun_id, musteri_isim from mart
where exists (select urun_id from  nisan where mart.urun_id= nisan.urun_id)
----Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız

select urun_isim, musteri_isim from nisan
where exists (select urun_isim from mart where mart.urun_isim = nisan.urun_isim)

----Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız

select urun_isim, musteri_isim from nisan
where  not exists (select urun_isim from mart where mart.urun_isim = nisan.urun_isim)

CREATE TABLE tedarikciler4 -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);

INSERT INTO tedarikciler4 VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler4 VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler4 VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler4 VALUES (104, 'Apple', 'Adam Eve');
CREATE TABLE urunler4 -- child
(
ted_vergino int,
urun_id int,
urun_isim VARCHAR(50),
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) REFERENCES tedarikciler4(vergi_no)
on delete cascade
);

INSERT INTO urunler4 VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler4 VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler4 VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler4 VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler4 VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler4 VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler4 VALUES(104, 1007,'Phone', 'Aslan Yılmaz');


select * from tedarikciler4
select * from urunler4

-- vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.
update tedarikciler4
set firma_ismi= 'vestel' where vergi_no = 102;

--vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.
update tedarikciler4
set  firma_ismi= 'casper', irtibat_ismi= 'Ali Veli' where vergi_no = 101  
--urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.
update urunler4 
set  urun_isim ='Telefon' 
where  urun_isim = 'Phone' 

--urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id’sini 1 arttırın.

UPDATE urunler4 
SET urun_id = urun_id+1 WHERE urun_id > 1004;
select * from urunler4


--urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun değerleri ile toplayarak güncelleyiniz.

UPDATE urunler4 
SET urun_id = urun_id + ted_vergino;

---urunler tablosoundaki tüm ürünlerin isimlerini,
update urunler4
set urun_isim=concat(urun_isim,'-', musteri_isim)

---urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci tablosunda irtibat_ismi
---'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz.


CREATE TABLE tedarikciler4 -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);

INSERT INTO tedarikciler4 VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler4 VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler4 VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler4 VALUES (104, 'Apple', 'Adam Eve');
CREATE TABLE urunler4 -- child
(
ted_vergino int,
urun_id int,
urun_isim VARCHAR(50),
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) REFERENCES tedarikciler4(vergi_no)
on delete cascade
);

INSERT INTO urunler4 VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler4 VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler4 VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler4 VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler4 VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler4 VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler4 VALUES(104, 1007,'Phone', 'Aslan Yılmaz');


select * from tedarikciler4
select * from urunler4

update urunler4
set urun_isim= (select firma_ismi from tedarikciler4 where irtibat_ismi='Adam Eve')
where  musteri_isim='Ali Bak'

--Urunler tablosunda laptop satin alan musterilerin ismini, firma_ismi Apple’in irtibat_isim'i ile degistirin.

update urunler4
set  musteri_isim =(select irtibat_ismi from tedarikciler4  where  firma_ismi='Apple')
where urun_isim='Laptop'

----Allies
select urun_id as id, urun_isim as isim from  urunler4
select urun_id as id , urun_isim ||''|| musteri_isim as urun_isim_musteri_isim
from urunler4
-------------------------------------------------------------
CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50), 
adres varchar(50)
);

INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa');
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');


select * from insanlar

SELECT* FROM insanlar WHERE isim IS NULL;
SELECT* FROM insanlar WHERE isim IS not NULL;




