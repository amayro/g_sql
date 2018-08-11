ALTER TABLE `geodata`.`_countries`
DROP COLUMN `title_ua`,
DROP COLUMN `title_be`,
DROP COLUMN `title_en`,
DROP COLUMN `title_es`,
DROP COLUMN `title_pt`,
DROP COLUMN `title_de`,
DROP COLUMN `title_fr`,
DROP COLUMN `title_it`,
DROP COLUMN `title_pl`,
DROP COLUMN `title_ja`,
DROP COLUMN `title_lt`,
DROP COLUMN `title_lv`,
DROP COLUMN `title_cz`;

ALTER TABLE `geodata`.`_regions`
DROP COLUMN `title_ua`,
DROP COLUMN `title_be`,
DROP COLUMN `title_en`,
DROP COLUMN `title_es`,
DROP COLUMN `title_pt`,
DROP COLUMN `title_de`,
DROP COLUMN `title_fr`,
DROP COLUMN `title_it`,
DROP COLUMN `title_pl`,
DROP COLUMN `title_ja`,
DROP COLUMN `title_lt`,
DROP COLUMN `title_lv`,
DROP COLUMN `title_cz`;

ALTER TABLE `geodata`.`_cities` 
DROP COLUMN `area_ru`,
DROP COLUMN `region_ru`,
DROP COLUMN `title_ua`,
DROP COLUMN `area_ua`,
DROP COLUMN `region_ua`,
DROP COLUMN `title_be` ,
DROP COLUMN `area_be`,
DROP COLUMN `region_be`,
DROP COLUMN `title_en`,
DROP COLUMN `area_en`,
DROP COLUMN `region_en`,
DROP COLUMN `title_es`,
DROP COLUMN `area_es` ,
DROP COLUMN `region_es` ,
DROP COLUMN `title_pt` ,
DROP COLUMN `area_pt` ,
DROP COLUMN `region_pt` ,
DROP COLUMN `title_de` ,
DROP COLUMN `area_de` ,
DROP COLUMN `region_de` ,
DROP COLUMN `title_fr` ,
DROP COLUMN `area_fr` ,
DROP COLUMN `region_fr` ,
DROP COLUMN `title_it` ,
DROP COLUMN `area_it` ,
DROP COLUMN `region_it` ,
DROP COLUMN `title_pl` ,
DROP COLUMN `area_pl` ,
DROP COLUMN `region_pl` ,
DROP COLUMN `title_ja` ,
DROP COLUMN `area_ja` ,
DROP COLUMN `region_ja` ,
DROP COLUMN `title_lt` ,
DROP COLUMN `area_lt`,
DROP COLUMN `region_lt` ,
DROP COLUMN `title_lv` ,
DROP COLUMN `area_lv` ,
DROP COLUMN `region_lv` ,
DROP COLUMN `title_cz` ,
DROP COLUMN `area_cz` ,
DROP COLUMN `region_cz`;



ALTER TABLE `geodata`.`_countries`
CHANGE COLUMN `country_id` `id` INT(11) NOT NULL AUTO_INCREMENT,
CHANGE COLUMN `title_ru` `title` VARCHAR(150) NOT NULL,
ADD PRIMARY KEY (`id`);

ALTER TABLE `geodata`.`_regions`
CHANGE COLUMN `region_id` `id` INT(11) NOT NULL AUTO_INCREMENT,
CHANGE COLUMN `title_ru` `title` VARCHAR(150) NOT NULL,
ADD PRIMARY KEY (`id`);



INSERT INTO `geodata`.`_countries` (`title`) VALUE ('не определено');

INSERT INTO `geodata`.`_regions` (`country_id`, `title`) VALUE ('236', 'не определено');

UPDATE `geodata`.`_cities` SET region_id = 5468685 WHERE region_id is NULL;



ALTER TABLE `geodata`.`_cities`
CHANGE COLUMN `city_id` `id` INT(11) NOT NULL AUTO_INCREMENT,
CHANGE COLUMN `important` `important` TINYINT(1) NOT NULL,
CHANGE COLUMN `region_id` `region_id` INT(11) NOT NULL,
CHANGE COLUMN `title_ru` `title` VARCHAR(150) NOT NULL,
ADD PRIMARY KEY (`id`);



CREATE INDEX `index_title`
ON `geodata`.`_regions` (`title`);

CREATE INDEX `index_title`
ON `geodata`.`_countries` (`title`);

CREATE INDEX `index_title`
ON `geodata`.`_cities` (`title`);


ALTER TABLE `geodata`.`_regions` 
 ADD CONSTRAINT `fk__regions__countries`
  FOREIGN KEY (`country_id`)
  REFERENCES `geodata`.`_countries` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `geodata`.`_cities` 
ADD CONSTRAINT `fk__cities__regions`
  FOREIGN KEY (`region_id`)
  REFERENCES `geodata`.`_regions` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `geodata`.`_cities` 
ADD CONSTRAINT `fk__cities__countries`
  FOREIGN KEY (`country_id`)
  REFERENCES `geodata`.`_countries` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;










