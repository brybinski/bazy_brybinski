#6
SELECT avg(waga) AS srednia_waga_wikingow FROM kreatura WHERE rodzaj = 'wiking';
SELECT rodzaj, count(*), avg(waga) FROM kreatura GROUP BY rodzaj;
SELECT rodzaj, avg(year(now())-year(dataUr)) FROM kreatura GROUP BY rodzaj;
SELECT rodzaj, sum(waga) FROM zasob GROUP BY rodzaj;
SELECT nazwa, sum(waga) AS suma FROM zasob WHERE ilosc >= 4  GROUP BY nazwa HAVING suma>10;
alternative SELECT nazwa, avg(waga*ilosc) from zasob group by nazwa having sum(waga*ilosc)>10;
SELECT rodzaj, count(distinct(nazwa)) as ilosc_zasobow FROM zasob GROUP BY rodzaj;
SELECT count(*) from kreatura;