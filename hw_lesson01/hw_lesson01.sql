CREATE SCHEMA IF NOT EXISTS `countries_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `countries_db`.`country` (
  `idcountry` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcountry`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `countries_db`.`region` (
  `idregion` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  `country_idcountry` INT NOT NULL,
  PRIMARY KEY (`idregion`),
  INDEX `fk_region_country_idx` (`country_idcountry` ASC) VISIBLE,
  CONSTRAINT `fk_region_country`
    FOREIGN KEY (`country_idcountry`)
    REFERENCES `countries_db`.`country` (`idcountry`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `countries_db`.`district` (
  `iddistrict` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `region_idregion` INT NOT NULL,
  PRIMARY KEY (`iddistrict`),
  INDEX `fk_district_region1_idx` (`region_idregion` ASC) VISIBLE,
  CONSTRAINT `fk_district_region1`
    FOREIGN KEY (`region_idregion`)
    REFERENCES `countries_db`.`region` (`idregion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `countries_db`.`city` (
  `idsity` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `district_iddistrict` INT NOT NULL,
  PRIMARY KEY (`idsity`),
  INDEX `fk_city_district1_idx` (`district_iddistrict` ASC) VISIBLE,
  CONSTRAINT `fk_city_district1`
    FOREIGN KEY (`district_iddistrict`)
    REFERENCES `countries_db`.`district` (`iddistrict`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;