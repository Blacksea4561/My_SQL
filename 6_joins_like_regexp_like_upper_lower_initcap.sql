---contex
---left join
----right  join 
----full joın
-------like kullanımı
--Regexp-Like
----upper(belirtilen fielddeki verieleri büyük harf yazar)
-- lower(belirtilen fielddeki verieleri küçük harf yazar) 
---initcap(belirtilen fielddeki verielerin ilk harf büyük yazar) 

---left join

--Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler inner JOIN siparisler
ON sirketler.sirket_id = siparisler.sirket_id

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler left JOIN siparisler
ON sirketler.sirket_id = siparisler.sirket_id

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM siparisler left JOIN sirketler
ON sirketler.sirket_id = siparisler.sirket_id ----şirket ismi olmadığı için null 


SELECT * from sirketler
SELECT * from siparisler


----right  join 

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler right JOIN siparisler
ON sirketler.sirket_id = siparisler.sirket_id

----full joın

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler full JOIN siparisler
ON sirketler.sirket_id = siparisler.sirket_id

SELECT sirketler.sirket_id, sirketler.sirket_isim, siparisler. siparis_id, siparisler. siparis_tarihi
FROM sirketler LEFT JOIN siparisler
ON sirketler.sirket_id = siparisler.sirket_id;
-------------------
CREATE TABLE personel8
(
id int,
isim varchar(20),
title varchar(60), 
yonetici_id int
);
INSERT INTO personel8 VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel8 VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel8 VALUES(3, 'Ayse Gul', 'QA Lead', 4);
INSERT INTO personel8 VALUES(4, 'Fatma Can', 'CEO', 5);

select * from personel8

--Her personelin yanina yonetici ismini yazdiran bir tablo olusturun

select p1.isim as personel_isim, p2.isim as yonetici_isim
from personel8 p1 inner join personel8 p2
on p1.yonetici_id = p2.id

-------like kullanımı
CREATE TABLE musteriler2
(
id int UNIQUE,
isim varchar(50) NOT NULL,
gelir int
);

INSERT INTO musteriler2 (id, isim, gelir) VALUES (1001, 'Ali', 62000); 
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1002, 'Ayse', 57500);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1004, 'Fatma', 42000);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1005, 'Kasim', 44000);

--SORU	: Ismi A harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yazin

select  * from musteriler2 where  isim like 'A%';

select  * from musteriler2 where  isim ilike 'a%';

select  * from musteriler2 where  isim ilike 'f%';

select  * from musteriler2 where  isim ~~ 'A%';

select  * from musteriler2 where  isim ~~* 'a%';

--Ismi e harfi ile biten musterilerin isimlerini ve gelir’lerini yazdiran QUERYyazin

SELECT isim,gelir FROM musteriler2 WHERE isim ILIKE '%e';

--Ismininicinde er olan musterilerin isimlerini ve gelir’lerini yazdiran QUERYyazin

SELECT isim,gelir FROM musteriler2 WHERE isim ILIKE '%er%';

SELECT isim,gelir FROM musteriler2 WHERE isim ILIKE '%';


SELECT isim,gelir FROM musteriler2 WHERE isim ILIKE '%er%';

SORU : Ismi 5 harfli olup son 4 harfi atma olan musterilerin tum bilgilerini yazdiran QUERY yazin
11:02
SORU : Ikinci harfi a olan musterilerin tum bilgilerini yazdiran QUERY yazin
11:02
SORU : Ucuncu harfi s olan musterilerin tum bilgilerini yazdiran QUERY yazin

SELECT* FROM musteriler2 WHERE isim LIKE'_atma';

select * from  musteriler2 where isim like '_a%'

select * from  musteriler2 where isim ~~'__s%'

SORU : Ucuncu harfi s olan ismi 4 harfli musterilerin tum bilgilerini yazdiran QUERY yazin

SORU : Ilk harfi F olan en az 4 harfli musterilerin tum bilgilerini yazdiran QUERY yazin

SORU : Ikinci harfi a,4.harfi m olan musterilerin tum bilgilerini yazdiran QUERY yazin

select * from musteriler2 where isim like'__s_'
select * from musteriler2 where isim like'F___%'
select * from musteriler2 where isim  like '_a_m%'


CREATE TABLE kelimeler (
id int UNIQUE,
kelime varchar(50) NOT NULL,
Harf_sayisi int
);



INSERT INTO kelimeler VALUES (1001, 'hot', 3); 
INSERT INTO kelimeler VALUES (1002, 'hat', 3); 
INSERT INTO kelimeler VALUES (1003, 'hit', 3); 
INSERT INTO kelimeler VALUES (1004, 'hbt', 3); 
INSERT INTO kelimeler VALUES (1008, 'hct', 3); 
INSERT INTO kelimeler VALUES (1005, 'adem', 4); 
INSERT INTO kelimeler VALUES (1006, 'selim', 5); 
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);

-- SORU : Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini  yazdiran QUERY yazin

select * from kelimeler WHERE kelime ~'h[ai]t';

select * from kelimeler WHERE kelime ~'h[a-k]t';

--Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERYyazin

select * from kelimeler where kelime ~ '[mi]'

select * from  kelimeler where  kelime ~'^[as]'

select * from  kelimeler where kelime ~ '[mf]$'


--Regexp-Like kullanımında sonuç belirtmek için $ sembol kullanılır
11:48
--SORU 1 : ilk harfi h olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime not like 'h%'
--SORU 1 : ilk harfi h olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime !~~'h%'

--SORU 2 : a harfi icermeyen kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime  !~~ '%a%'

--SORU 3 : ikinci ve ucuncu harfi ‘de’ olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin

select * from kelimeler where kelime  not like '_de%'

--SORU 4 : 2. harfi e,i veya o olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin

select * from kelimeler where kelime  !~ '[_eio]'

----upper(belirtilen fielddeki verieleri büyük harf yazar)
-- lower(belirtilen fielddeki verieleri küçük harf yazar) 
---initcap(belirtilen fielddeki verielerin ilk harf büyük yazar) 

select  upper(kelime) as kelime from kelimeler
select  lower(kelime) as kelime from kelimeler
select  initcap(kelime) as kelime from kelimeler


CREATE TABLE musteri_urun
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal');
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal');
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma');
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut');
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma');
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal');
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi');
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

select * from musteri_urun


select  distinct(urun_isim) from musteri_urun 


select  distinct musteri_isim from musteri_urun


select musteri_isim , count(distinct(urun_isim)) as meyve_sayisi from musteri_urun 
group by musteri_isim

SELECT count(urun_isim), urun_isim from musteri_urun
group by ( urun_isim )























