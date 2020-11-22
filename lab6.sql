#6
    zadanie 1
SELECT avg(waga) AS srednia_waga_wikingow FROM kreatura WHERE rodzaj = 'wiking';
SELECT rodzaj, count(*), avg(waga) FROM kreatura GROUP BY rodzaj;
SELECT rodzaj, avg(year(now())-year(dataUr)) FROM kreatura GROUP BY rodzaj;
    zadanie2
SELECT rodzaj, sum(waga) FROM zasob GROUP BY rodzaj;
SELECT nazwa, sum(waga) AS suma FROM zasob WHERE ilosc >= 4  GROUP BY nazwa HAVING suma>10;
alternative SELECT nazwa, avg(waga*ilosc) from zasob group by nazwa having sum(waga*ilosc)>10;
SELECT rodzaj, count(distinct(nazwa)) as ilosc_zasobow FROM zasob GROUP BY rodzaj HAVING ilosc_zasobow >1;
    zadanie3
SELECT nazwa, idZasobu, ilosc from kreatura k, ekwipunek e where k.idKreatury=e.idKreatury;
SELECT k.nazwa, e.idZasobu, e.ilosc, z.nazwa from kreatura k, ekwipunek e, zasob z where k.idKreatury=e.idKreatury and e.idZasobu = z.idZasobu ORDER BY k.nazwa;