
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Table `rybinskib`.`adres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rybinskib`.`adres` (
  `idadres` INT NOT NULL AUTO_INCREMENT,
  `Miasto` VARCHAR(45) NOT NULL,
  `Ulica` VARCHAR(45) NOT NULL,
  `Kod_pocztowy` VARCHAR(6) NULL,
  PRIMARY KEY (`idadres`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rybinskib`.`kontakt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rybinskib`.`kontakt` (
  `idkontakt` INT NOT NULL AUTO_INCREMENT,
  `numer_telefonu` VARCHAR(9) NULL,
  `email` VARCHAR(45) NULL,
  `strona` VARCHAR(45) NULL,
  PRIMARY KEY (`idkontakt`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rybinskib`.`podmiot`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rybinskib`.`podmiot` (
  `nip` VARCHAR(10) NOT NULL,
  `nazwa` VARCHAR(255) NOT NULL,
  `data_rozpoczecia_dg` DATE NOT NULL,
  `status_dg` ENUM("aktywna", "zawieszona") NULL,
  `czyPodejzany` BIT NOT NULL DEFAULT 0,
  `adres_idadres` INT NOT NULL,
  `kontakt_idkontakt` INT NOT NULL,
  PRIMARY KEY (`nip`),
  UNIQUE INDEX `nip_UNIQUE` (`nip` ASC) VISIBLE,
  INDEX `fk_podmiot_adres1_idx` (`adres_idadres` ASC) VISIBLE,
  INDEX `fk_podmiot_kontakt1_idx` (`kontakt_idkontakt` ASC) VISIBLE,
  CONSTRAINT `fk_podmiot_adres1`
    FOREIGN KEY (`adres_idadres`)
    REFERENCES `rybinskib`.`adres` (`idadres`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_podmiot_kontakt1`
    FOREIGN KEY (`kontakt_idkontakt`)
    REFERENCES `rybinskib`.`kontakt` (`idkontakt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rybinskib`.`kontroler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rybinskib`.`kontroler` (
  `idkontroler` INT NOT NULL,
  `imie_nazwisko` VARCHAR(255) NOT NULL,
  `pesel` VARCHAR(11) NOT NULL,
  `data_ur` DATE NOT NULL,
  `data_zatrudnienia` DATE NOT NULL,
  `adres_idadres` INT NOT NULL,
  `kontakt_idkontakt` INT NOT NULL,
  PRIMARY KEY (`idkontroler`),
  INDEX `fk_kontroler_adres1_idx` (`adres_idadres` ASC) VISIBLE,
  INDEX `fk_kontroler_kontakt1_idx` (`kontakt_idkontakt` ASC) VISIBLE,
  CONSTRAINT `fk_kontroler_adres1`
    FOREIGN KEY (`adres_idadres`)
    REFERENCES `rybinskib`.`adres` (`idadres`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_kontroler_kontakt1`
    FOREIGN KEY (`kontakt_idkontakt`)
    REFERENCES `rybinskib`.`kontakt` (`idkontakt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rybinskib`.`protokol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rybinskib`.`protokol` (
  `IdKontroli` INT NOT NULL AUTO_INCREMENT,
  `podmiot_nip` VARCHAR(10) NOT NULL,
  `poczatek_kontroli` DATE NOT NULL,
  `koniec_kontroli` DATE NOT NULL,
  `Nieprawidlowosci` VARCHAR(1024) NULL DEFAULT 'brak nieprawidlowosci',
  PRIMARY KEY (`IdKontroli`),
  CONSTRAINT `fk_protokol_podmiot1`
    FOREIGN KEY (`podmiot_nip`)
    REFERENCES `rybinskib`.`podmiot` (`nip`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rybinskib`.`podatek`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rybinskib`.`podatek` (
  `idpodatek` INT NOT NULL AUTO_INCREMENT,
  `podstawa_prawna` VARCHAR(45) NOT NULL,
  `wysokosc` DOUBLE, NOT NULL,
  `data` DATE NOT NULL,
  PRIMARY KEY (`idpodatek`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rybinskib`.`przychodyrozchody`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rybinskib`.`przychodyrozchody` (
  `podmiot_nip` VARCHAR(10) NOT NULL,
  `okres_rozliczeniowy` YEAR NOT NULL,
  `przychody` DOUBLE NOT NULL,
  `rozchody` DOUBLE NOT NULL,
  `odliczony_VAT` DOUBLE NOT NULL,
  PRIMARY KEY (`podmiot_nip`, `okres_rozliczeniowy`),
  INDEX `fk_przychodyrozchody_podmiot2_idx` (`podmiot_nip` ASC) VISIBLE,
  CONSTRAINT `fk_przychodyrozchody_podmiot2`
    FOREIGN KEY (`podmiot_nip`)
    REFERENCES `rybinskib`.`podmiot` (`nip`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `rybinskib`.`faktury`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rybinskib`.`faktury` (
  `przychodyrozchody_podmiot_nip` VARCHAR(10) NOT NULL,
  `NIP` VARCHAR(45) NOT NULL,
  `numer_faktury` VARCHAR(45) NOT NULL,
  `Kwota` DOUBLE NOT NULL,
  `data` DATE NOT NULL,
  `podatek` DOUBLE NOT NULL,
  PRIMARY KEY (`przychodyrozchody_podmiot_nip`),
  INDEX `fk_faktury_przychodyrozchody1_idx` (`przychodyrozchody_podmiot_nip` ASC) VISIBLE,
  CONSTRAINT `fk_faktury_przychodyrozchody1`
    FOREIGN KEY (`przychodyrozchody_podmiot_nip`)
    REFERENCES `rybinskib`.`przychodyrozchody` (`podmiot_nip`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rybinskib`.`protokol_has_kontroler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rybinskib`.`protokol_has_kontroler` (
  `protokol_IdKontroli` INT NOT NULL,
  `kontroler_idkontroler` INT NOT NULL,
  PRIMARY KEY (`protokol_IdKontroli`, `kontroler_idkontroler`),
  INDEX `fk_protokol_has_kontroler_kontroler1_idx` (`kontroler_idkontroler` ASC) VISIBLE,
  INDEX `fk_protokol_has_kontroler_protokol1_idx` (`protokol_IdKontroli` ASC) VISIBLE,
  CONSTRAINT `fk_protokol_has_kontroler_protokol1`
    FOREIGN KEY (`protokol_IdKontroli`)
    REFERENCES `rybinskib`.`protokol` (`IdKontroli`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_protokol_has_kontroler_kontroler1`
    FOREIGN KEY (`kontroler_idkontroler`)
    REFERENCES `rybinskib`.`kontroler` (`idkontroler`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

DELIMITER //
CREATE TRIGGER podejrzenie
BEFORE INSERT ON przychodyrozchody
FOR EACH ROW
BEGIN
IF new.odliczony_VAT > 0.23*new.rozchody
THEN 
UPDATE podmiot SET czyPodejzany = 1 
WHERE nip = new.podmiot_nip;

END IF;

END; //


DELIMITER //
CREATE TRIGGER zawieszenie
BEFORE INSERT ON protokol
FOR EACH ROW
BEGIN
IF nieprawidlowosci == 'brak nieprawidlowosci'
THEN 
UPDATE podmiot SET status_dg = 'aktywna'; 
WHERE nip = new.podmiot_nip;
ELSE 
UPDATE podmiot SET status_dg = 'zawieszona'; 
WHERE nip = new.podmiot_nip;
END IF;

END; //

DELIMITER //
CREATE PROCEDURE lapowka(IN nip1 int)
BEGIN
UPDATE podmiot SET czyPodejzany = 0
WHERE nip = nip1;
END
//
DELIMITER ;



DELIMITER //
CREATE FUNCTION suma_odliczen
    RETURNS DOUBLE
BEGIN
    DECLARE suma DOUBLE;
    DECLARE nip DOUBLE;
    SELECT sum(podatek) INTO @suma FROM faktury;
    RETURN @suma;
END //

DELIMITER //

CREATE FUNCTION suma_odliczen(nip int, rok year)
    RETURNS DOUBLE
BEGIN
    DECLARE suma DOUBLE;
    SELECT sum(podatek) INTO @suma FROM faktury where przychodyrozchody_podmiot_nip = nip and year(data)=rok;
    RETURN @suma;
END //