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

