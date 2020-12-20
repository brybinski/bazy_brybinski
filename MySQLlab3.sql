#Lab08

#Zadanie 1
drop trigger kreatura_before_insert;
DELIMITER //
CREATE TRIGGER  kreatura_before_insert
BEFORE INSERT ON kreatura
for each row
BEGIN
	IF NEW.waga <= 0
    THEN
		set NEW.waga = 1;
    END IF;
END
//
DELIMITER ;

#Zadanie 2
CREATE TABLE archiwum_wypraw LIKE wyprawa;
ALTER TABLE archiwum_wypraw MODIFY kierownik varchar (100);

DELIMITER //
CREATE TRIGGER wyprawa_after_delete
AFTER DELETE ON wyprawa
FOR EACH ROW
BEGIN
DECLARE kierownik_nazwa VARCHAR(100);
SET kierownik_nazwa = (SELECT kreatura.nazwa FROM kreatura WHERE idKreatury = OLD.kierownik);
INSERT INTO archiwum_wypraw VALUES (OLD.id_wyprawy, OLD.nazwa, OLD.data_rozpoczecia, OLD.data_zakonczenia, kierownik_nazwa);
END
//
DELIMITER ;




#Zadanie 3.1
DELIMITER //
CREATE PROCEDURE eliksir_sily(IN id int)
BEGIN
UPDATE kreatura SET udzwig = udzwig * 1.2 where id=idKreatury;
END
//
DELIMITER ;


#Zadanie 3.2
DELIMITER //
CREATE FUNCTION wielkie_litery(text varchar(255))
	RETURNS VARCHAR(255)
BEGIN
	DECLARE ucase VARCHAR(255);
    SET @ucase = UCASE(text);
    RETURN @ucase;
END
//
DELIMITER ;

DROP procedure eliksir_sily;

SELECT wielkie_litery('xddddddddddddddd');

#Zadanie 4
CREATE TABLE system_alarmowy(id_alarmu int primary key, wiadomosc varchar(100));
DELIMITER //

CREATE TRIGGER uczestnicy_after_insert
AFTER INSERT ON uczestnicy
FOR EACH ROW
BEGIN
DECLARE tesciowa varchar(100);
DECLARE sektor_id integer;
SET tesciowa = 'Tesciowa';
SET sektor_id = 7;

	IF tesciowa IN(
	SELECT nazwa FROM kreatura WHERE idKreatury IN
	( SELECT id_uczestnika FROM uczestnicy WHERE id_wyprawy=NEW.id_wyprawy))
	THEN
		IF sektor_id IN (
		SELECT sektor FROM etapy_wyprawy WHERE idWyprawy=NEW.id_wyprawy
		)
		THEN
		INSERT INTO system_alarmowy VALUES(DEFAULT,'Tesciowa nadchodzi');
		END IF;
	END IF;
    
END
//
DELIMITER ;

