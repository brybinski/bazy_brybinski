#1
CREATE TABLE kreatura SELECT * FROM wikingowie.kreatura;
CREATE TABLE zasob SELECT * FROM wikingowie.zasob;
CREATE TABLE ekwipunek SELECT * FROM wikingowie.ekwipunek;
SELECT * FROM zasob;
SELECT * FROM zasob where rodzaj = 'jedzenie';
SELECT idZasobu, ilosc FROM ekwipunek where idKreatury IN (1, 3, 5);
SELECT * FROM kreatura where rodzaj != 'wiedzma' and udzwig > 50;
SELECT * FROM zasob where waga BETWEEN 2 AND 5;
SELECT * FROM kreatura where nazwa LIKE '%or%' AND udzwig BETWEEN 30 and 70;
SELECT * FROM zasob WHERE MONTH(dataPozyskania) IN(7, 8);
SELECT * FROM zasob WHERE rodzaj IS NOT NULL ORDER BY waga ASC;
SELECT * FROM kreatura ORDER BY dataUr ASC LIMIT 5;
SELECT DISTINCT rodzaj FROM zasob;
SELECT CONCAT(nazwa, ' - ', rodzaj) FROM kreatura WHERE rodzaj LIKE "wi%";
SELECT nazwa, waga*ilosc FROM zasob WHERE YEAR(dataPozyskania) BETWEEN 2000 AND 2007;
SELECT nazwa ,0.7*waga*ilosc as 'Waga netto',0.3*waga*ilosc as 'Waga odpadkow' FROM zasob;
SELECT * FROM zasob WHERE rodzaj IS NULL;
SELECT DISTINCT(rodzaj) FROM zasob WHERE nazwa LIKE 'Ba%' OR nazwa LIKE '%os' ORDER BY rodzaj asc;

