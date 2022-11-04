--create --tablo  oluşturma
create table ogrenciler
(
id char(4),
isim_soyisim varchar(30),
not_ort real,
kayit_tarih date
);

--varolan bir tablodan yeni bir tablo oluşturma
create table ogrenci_ortalama
as
select isim_soyisim, not_ort
from ogrenciler;


--SELECT - DQL-
select * from ogrenciler; --- bir tablodaki tüm verileri çağırmak için  * kullan
select * from ogrenci_ortalama;
select isim_soyisim from ogrenciler; ---bir tablodan sadece bir yada  birden fazla field'i çağırmak için
selec