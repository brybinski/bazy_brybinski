#1
delete from postac WHERE rodzaj='wiking' and nazwa<>'Bjorn' order by data_ur ASC limit 2;
ALTER TABLE walizka DROP FOREIGN KEY walizka_ibfk_1;
ALTER TABLE przetwory DROP FOREIGN KEY przetwory_ibfk_1;
ALTER TABLE przetwory DROP FOREIGN KEY przetwory_ibfk_2;
ALTER TABLE postac MODIFY id_postaci int;
ALTER TABLE postac DROP PRIMARY KEY;
#2
ALTER TABLE postac ADD COLUMN pesel VARCHAR(11) FIRST;
UPDATE postac set pesel='12345678901' + id_postaci;
ALTER TABLE postac ADD PRIMARY KEY(pesel);
AlTER TABLE postac MODIFY rodzaj ENUM('wiking', 'ptak', 'kobieta', 'syrena');
INSERT INTO postac VALUES (9, 'Gertruda Nieszczera', 'syrena', '1653-04-14', 350, DEFAULT, default, 12439545673);
#3
UPDATE postac SET statek='szprotka' WHERE nazwa LIKE '%a%';
UPDATE statek SET max_ladownosc=max_ladownosc*0.7 WHERE data_wodowania BETWEEN '1901-01-01' AND '2000-12-31';
CHECK (wiek < 1000);
#4
ALTER TABLE postac MODIFY rodzaj ENUM('wiking', 'ptak', 'kobieta', 'syrena', 'waz');
INSERT INTO postac VALUES (10, 'Loko', 'waz', '2001-09-11', 21, DEFAULT, default, 14439545631);
CREATE TABLE marynarz LIKE postac;
INSERT INTO marynarz SELECT * FROM postac WHERE statek IS NOT NULL;
CREATE TABLE marynarz2 SELECT * FROM postac;
5#
UPDATE postac SET statek NULL;
DELETE FROM postac WHERE nazwa = 'Omel';
DELETE FROM statek;
ALTER TABLE postac DROP FOREIGN KEY postac_ibfk_1;
DROP TABLE statek;
CREATE TABLE zwierz (id int PRIMARY KEY AUTO_INCREMENT, nazwa varchar(40), wiek int);
INSERT INTO zwierz(nazwa, wiek) SELECT nazwa, wiek FROM postac WHERE rodzaj='waz' OR rodzaj='ptak';