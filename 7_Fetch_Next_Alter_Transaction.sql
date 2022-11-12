----contex
---FETCH NEXT (SAYI) ROW ONLY - OFFSET
-- ALTER TABLE --
--TRANSACTION (Begin – Savepoint – rollback - commit)





--FETCH NEXT (SAYI) ROW ONLY - OFFSET Kullanımı
select * from musteri_urun2

--Sirali tablodan ilk 3 kaydi listeleyin
SELECT * FROM musteri_urun2 
ORDER BY urun_id
FETCH NEXT 3 ROW ONLY
--Sirali tablodan 4. kayittan 7.kayida kadar olan kayitlari listeleyin
SELECT * FROM musteri_urun2
ORDER BY urun_id
OFFSET 3 ROW -- 3 satır atla
FETCH NEXT 4 ROW ONLY -- Sonra 4 satırı getir

-- ALTER TABLE -- Tablodaki sutun ekleme field'daki veri tipini değiştirme,
--tablo adını değiştirme gibi tablodaki güncelleme işlemleri için kullanılır

CREATE TABLE personel  (
id int,
isim varchar(50),  
sehir varchar(50),  
maas int,  
sirket varchar(20)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

DROP TABLE if exists personel; -- Eğer tablo varsa siler

select * from personel

--1) ADD default deger ile tabloya bir field ekleme
ALTER TABLE personel
ADD ulke_ismi varchar(20)

-- DEFAULT değer olarak atama yapmak
ALTER TABLE personel
ADD sehir_ismi varchar(20) DEFAULT 'Istanbul'

--Tabloya birden fazla field ekleme
ALTER TABLE personel
ADD gender char(1), ADD okul varchar(10);

--3) DROP tablodan sutun silme
ALTER TABLE personel
DROP COLUMN gender

--4) RENAME COLUMN sutun adi degistirme
ALTER TABLE personel
RENAME COLUMN ulke_ismi TO ulke_adi

select * from isciler

--RENAME tablonun ismini degistirme
ALTER TABLE personel
RENAME TO isciler

--TYPE/SET sutunlarin ozelliklerini degistirme
ALTER TABLE isciler
ALTER COLUMN sehir_ismi TYPE varchar(15)

ALTER TABLE isciler
ALTER COLUMN sirket SET NOT NULL

ALTER TABLE isciler
ALTER COLUMN ulke_adi TYPE int USING(ulke_adi::int) --String bir data tipini int. yapmak için bu şekilde kullanırız

--TRANSACTION (Begin – Savepoint – rollback - commit)
CREATE TABLE ogrenciler2
(
id serial, --AUTO_INCREMENT
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);
BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);

ROLLBACK to x;
COMMIT;
--SERIAL DATA TURU KULLANIMI
INSERT INTO ogrenciler2 (isim,veli_isim,yazili_notu) VALUES ('erol','ahmet',95.5);
INSERT INTO ogrenciler2 (isim,veli_isim,yazili_notu) VALUES ('evren','cemil',85.5)
select * from ogrenciler2
delete from ogrenciler2

drop table ogrenciler2

-- PRACTİCE
CREATE TABLE isciler2
(
id int,
isim VARCHAR(50),
soyisim VARCHAR(50),
email varchar(30),
ise_baslama_tarih date,
is_unvani varchar(15),
maas int    
);

select * from isciler2

insert into isciler2 values (123456789, 'Ali', 'Can', 'alican@gmail.com', '10-APR-10', 'isci', 5000);
insert into isciler2 values (123456788, 'Veli', 'Cem', 'velicem@gmail.com', '10-JAN-12','isci', 5500);
insert into isciler2 values (123456787, 'Ayse', 'Gul', 'aysegul@gmail.com', '01-MAY-14', 'muhasebeci', 4500);
insert into isciler2 values (123456789, 'Fatma', 'Yasa', 'fatmayasa@gmail.com', '10-APR-09', 'muhendis', 7500);

/*
+Yukarda verilen “personel” tablosunu olusturun+
+Tablodan maasi 5000’den az veya unvani isci olanlarin isimlerini listeleyin
+Iscilerin tum bilgilerini listeleyin
+Soyadi Can,Cem veya Gul olanlarin unvanlarini ve maaslarini listeleyin
+Maasi 5000’den cok olanlarin emailve is baslama tarihlerini listeleyin
Maasi 5000’den cok veya 7000’den az olanlarin tum bilgilerini listeleyin
*/
--Tablodan maasi 5000’den az veya unvani isci olanlarin isimlerini listeleyin
SELECT isim,is_unvani,maas FROM isciler2 
WHERE maas<5000 or is_unvani='isci'
--Iscilerin tum bilgilerini listeleyin
select * from isciler2
--Soyadi Can,Cem veya Gul olanlarin unvanlarini ve maaslarini listeleyin
SELECT soyisim,is_unvani,maas FROM isciler2 
WHERE soyisim in ('Can','Cem','Gul')
--Maasi 5000’den cok olanlarin emailve is baslama tarihlerini listeleyin
SELECT email,ise_baslama_tarih,maas FROM isciler2 WHERE maas>5000
--Maasi 5000’den cok veya 7000’den az olanlarin tum bilgilerini listeleyin
SELECT * FROM isciler2 WHERE maas between 5000 and 7000

--INTERVIEW QUESTION
drop table personel
CREATE TABLE personel  
(
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20)
);
INSERT INTO personel VALUES(123456789, 'Johnny Walk', 'New Hampshire', 2500, 'IBM');
INSERT INTO personel VALUES(234567891, 'Brian Pitt', 'Florida', 1500, 'LINUX');
INSERT INTO personel VALUES(245678901, 'Eddie Murphy', 'Texas', 3000, 'WELLS FARGO');
INSERT INTO personel VALUES(456789012, 'Teddy Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO personel VALUES(567890124, 'Eddie Murphy', 'Massachuset', 7000, 'MICROSOFT');  
INSERT INTO personel VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'TD BANK');
INSERT INTO personel VALUES(123456719, 'Adem Stone', 'New Jersey', 2500, 'IBM');

CREATE TABLE isciler3
(
id int,  
isim varchar(50),
sehir varchar(50),  
maas int,  
sirket varchar(20)
);
INSERT INTO isciler3 VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');  
INSERT INTO isciler3 VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');  
INSERT INTO isciler3 VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO isciler3 VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');  
INSERT INTO isciler3 VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');  
INSERT INTO isciler3 VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO isciler3 VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

select * from personel
select * from isciler3
--Her iki tablodaki ortak id’leri ve personel tablosunda bu id’ye sahip isimleri listeleyen query  yaziniz
SELECT isim,id FROM personel
WHERE id IN (SELECT id FROM isciler3 WHERE isciler3.id=personel.id)

--Her iki tablodaki ortak id ve isme sahip kayitlari listeleyen query yaziniz
Select id,isim from personel
INTERSECT
select id,isim from isciler3

--Personel tablosunda id’si cift sayi olan personel’in tum bilgilerini listeleyen Query yaziniz
SELECT * FROM personel WHERE MOD(id,2)=0

--Isciler tablosunda en yuksek maasi alan kisinin tum bilgilerini gosteren query yazin
SELECT * FROM isciler3 ORDER BY maas DESC FETCH NEXT 1 ROW ONLY

--Personel tablosunda en dusuk maasi alan kisinin tum bilgilerini gosteren query yazin
SELECT * FROM isciler3 ORDER BY maas FETCH NEXT 1 ROW ONLY

--Isciler tablosunda ikinci en yuksek maasi gosteren query yazin
SELECT * from isciler3 ORDER BY maas DESC OFFSET 1 ROW FETCH NEXT 1 ROW ONLY