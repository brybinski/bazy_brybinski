#Zadanie 1.3
select w.nazwa, sum(e.ilosc) from wyprawa w, ekwipunek e, uczestnicy u where
u.id_wyprawy=w.id_wyprawy and u.id_uczestnika=e.idKreatury group by w.nazwa;
#Zadanie 2.1
SELECT w.nazwa, sum(u.id_uczestnika), group_concat(k.nazwa) 
FROM wyprawa w, kreatura k, uczestnicy u 
WHERE u.id_wyprawy=w.id_wyprawy AND u.id_uczestnika=k.idKreatury GROUP BY w.nazwa;
#Zadanie 2.2
select e.idEtapu, s.nazwa as "nazwa sektora", k.nazwa as "nazwa kierownika" 
from etapy_wyprawy e, sektor s, wyprawa w, kreatura k 
where w.kierownik=k.idKreatury and w.id_wyprawy=e.idWyprawy and e.sektor=s.id_sektora 
order by w.data_rozpoczecia, e.kolejnosc;
#Zadanie 3.1
SELECT s.nazwa, count(e.sektor)
from sektor s left join etapy_wyprawy e on s.id_sektora=e.sektor GROUP BY s.nazwa;
#Zadanie 3.2
SELECT distinct k.nazwa, if(u.id_uczestnika IS NULL, 'nie brał udziału w wyprawie', 'brał udział w wyprawie') 
from kreatura k left join uczestnicy u on u.id_uczestnika=idKreatury;
#Zadanie 4.1
select w.nazwa, sum(length(e.dziennik)) 
from wyprawa w, etapy_wyprawy e where w.id_wyprawy=e.idWyprawy 
group by w.nazwa having sum(length(e.dziennik)) < 400;
#Zadanie 4.2
select w.nazwa as "wyprawa", sum(z.waga*e.ilosc)/count(u.id_uczestnika) 
from kreatura k, zasob z, wyprawa w, uczestnicy u, ekwipunek e 
where z.idZasobu=e.idZasobu and k.idKreatury=e.idKreatury 
and u.id_uczestnika=k.idKreatury and u.id_wyprawy=w.id_wyprawy group by w.nazwa;
#Zadanie 5

SELECT k.nazwa, w.nazwa, abs(datediff(k.dataUr, w.data_rozpoczecia)) as ile_dni
from kreatura k, wyprawa w, uczestnicy u, sektor s, etapy_wyprawy e
WHERE u.id_uczestnika=k.idKreatury and w.id_wyprawy=u.id_wyprawy
and e.idWyprawy=w.id_Wyprawy and e.sektor=id_sektora and s.nazwa = 'Chatka dziadka';

