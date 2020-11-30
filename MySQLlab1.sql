#Zadanie 5.1
SELECT k.rodzaj, AVG(e.ilosc *z.waga) FROM kreatura k, ekwipunek e, zasob z 
WHERE k.idKreatury=e.idKreatury AND e.idZasobu=z.idZasobu AND k.rodzaj NOT IN('malpa','waz')
GROUP BY rodzaj HAVING SUM(e.ilosc) < 30;
#Zadanie 5.2
SELECT DISTINCT k.rodzaj,
(SELECT CONCAT(k2.nazwa, " - " , k2.dataUr) FROM kreatura k2 WHERE k.rodzaj=k2.rodzaj ORDER BY k2.dataUr LIMIT 1) AS najstarsze,
(SELECT CONCAT(k2.nazwa, " - " , k2.dataUr) FROM kreatura k2 WHERE k.rodzaj=k2.rodzaj ORDER BY k2.dataUr DESC LIMIT 1) AS najmlodsze
FROM kreatura k;
#lab_07

#Zadanie 1.1
CREATE TABLE uczestnicy SELECT * FROM wikingowie.uczestnicy;
CREATE TABLE etapy_wyprawy SELECT * FROM wikingowie.etapy_wyprawy;
CREATE TABLE sektor SELECT * FROM wikingowie.sektor;
CREATE TABLE wyprawa SELECT * FROM wikingowie.wyprawa;
#Zadanie 1.2
SELECT k.nazwa FROM kreatura k WHERE k.idKreatury NOT IN (SELECT id_uczestnika FROM uczestnicy);
