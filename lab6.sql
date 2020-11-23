#6
    zadanie1
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
SELECT k.idKreatury, k.nazwa, e.idKreatury from kreatura k left join ekwipunek e on k.idKreatury=e.idKreatury WHERE e.idKreatury is null;
\\SELECT k.idKreatury, k.nazwa from kreatura k where k.idKreatury not in(select idKreatury from ekwipunek where idKreatury is not null);
    zadanie4
SELECT k.nazwa, z.nazwa
FROM kreatura k, zasob z, ekwipunek e
WHERE k.idKreatury=e.idKreatury
AND e.idZasobu=z.idZasobu
AND k.rodzaj='wiking'
AND YEAR(k.dataUr) BETWEEN 1670 AND 1679;
// z natural join
SELECT k.nazwa, z.nazwa
FROM zasob z, kreatura k natural join ekwipunek e
WHERE e.idZasobu=z.idZasobu
AND k.rodzaj='wiking'
AND YEAR(k.dataUr) BETWEEN 1670 AND 1679;

SELECT k.nazwa, z.rodzaj, k.dataUr FROM kreatura k INNER JOIN ekwipunek e ON k.idKreatury = e.idKreatury INNER JOIN zasob z ON z.idZasobu = e.idZasobu WHERE z.rodzaj='jedzenie' ORDER BY k.dataUr DESC LIMIT 5;

SELECT k.nazwa, k2.nazwa FROM kreatura k, kreatura k2 where k.idKreatury=k2.idKreatury+5;