-- MySQL Script generated by MySQL Workbench
-- sáb 24 may 2025 20:47:46
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema art_gallery
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `art_gallery` ;

-- -----------------------------------------------------
-- Schema art_gallery
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `art_gallery` ;
USE `art_gallery` ;

-- -----------------------------------------------------
-- Table `art_gallery`.`artist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `art_gallery`.`artist` ;

CREATE TABLE IF NOT EXISTS `art_gallery`.`artist` (
  `artist_id` INT NOT NULL,
  `first_name` VARCHAR(60) NOT NULL,
  `middle_name` VARCHAR(60) NULL,
  `last_name` VARCHAR(60) NOT NULL,
  `dob` INT NOT NULL,
  `dod` INT NULL,
  `country` VARCHAR(100) NOT NULL,
  `local` ENUM('y', 'n') NULL,
  PRIMARY KEY (`artist_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `art_gallery`.`keyword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `art_gallery`.`keyword` ;

CREATE TABLE IF NOT EXISTS `art_gallery`.`keyword` (
  `keyword_id` INT NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`keyword_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `art_gallery`.`artwork`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `art_gallery`.`artwork` ;

CREATE TABLE IF NOT EXISTS `art_gallery`.`artwork` (
  `artwork_id` INT NOT NULL,
  `artist_artist_id` INT NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `year` INT NOT NULL,
  `period` VARCHAR(100) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `file` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`artwork_id`),
  INDEX `fk_artwork_artist1_idx` (`artist_artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_artwork_artist1`
    FOREIGN KEY (`artist_artist_id`)
    REFERENCES `art_gallery`.`artist` (`artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `art_gallery`.`artwork_has_keyword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `art_gallery`.`artwork_has_keyword` ;

CREATE TABLE IF NOT EXISTS `art_gallery`.`artwork_has_keyword` (
  `artwork_artwork_id` INT NOT NULL,
  `keyword_keyword_id` INT NOT NULL,
  PRIMARY KEY (`artwork_artwork_id`, `keyword_keyword_id`),
  INDEX `fk_artwork_has_keyword_keyword1_idx` (`keyword_keyword_id` ASC) VISIBLE,
  INDEX `fk_artwork_has_keyword_artwork1_idx` (`artwork_artwork_id` ASC) VISIBLE,
  CONSTRAINT `fk_artwork_has_keyword_artwork1`
    FOREIGN KEY (`artwork_artwork_id`)
    REFERENCES `art_gallery`.`artwork` (`artwork_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artwork_has_keyword_keyword1`
    FOREIGN KEY (`keyword_keyword_id`)
    REFERENCES `art_gallery`.`keyword` (`keyword_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO art_gallery.keyword VALUES
(1,'flowers'),
(2,'blue'),
(3,'landscape'),
(4,'girl'),
(5,'people'),
(6,'battle'),
(7,'boat'),
(8,'water'),
(9,'Christ'),
(10,'Food'),
(11,'baby');


INSERT INTO art_gallery.artist VALUES
(1,'Vincent',NULL,'van Gogh',1853,1890,'France','n'),
(2,'Rembrandt','Harmenszoon','van Rijn',1606,1669,'Netherlands','n'),
(3,'Leonardo',null,'da Vinci',1452,1519,'Italy','n'),
(4,'Venture','Lonzo','Coy',1965,null,'United States','y'),
(5,'Deborah',null,'Gill',1970,null,'United States','y'),
(6,'Claude',null,'Monet',1840,1926,'France','n'),
(7,'Pablo',null,'Picasso',1904,1973,'Spain','n'),
(8,'Michelangelo','di Lodovico','Simoni',1475,1564,'Italy','n');

INSERT INTO art_gallery.artwork VALUES
(1,1,'Irises',1889,'Impressionism','Oil','irises.jpg'),
(2,1,'The Starry Night',1889,'Post-Impressionism','Oil','starrynight.jpg'),
(3,1,'Sunflowers',1888,'Post-impressionism','Oil','sunflowers.jpg'),
(4,2,'Night Watch',1642,'Baroque','Oil','nightwatch.jpg'),
(5,2,'Storm on the Sea of Galilee',1633,'Dutch Golden Age','Oil','stormgalilee.jpg'),
(6,3,'Head of a Woman',1508,'High Renaissance','Oil','headwoman.jpg'),
(7,3,'Last Supper',1498,'Renaissance','Tempra ','lastsupper.jpg'),
(8,3,'Mona Lisa',1517,'Renaissance','Oil','monalisa.jpg'),
(9,4,'Hillside Stream',2005,'Modern','Oil','hillsidestream.jpg'),
(10,4,'Old Barn',1992,'Modern','Oil','oldbarn.jpg'),
(11,5,'Beach Baby',1999,'Modern','Watercolor','beachbaby.jpg'),
(12,6,'Women in the Garden',1866,'Impressionism','Oil','womengarden.jpg'),
(13,7,'Old Guitarist',1904,'Modern','Oil','guitarist.jpg');

INSERT INTO art_gallery.artwork_has_keyword VALUES
(1,1),
(2,2),	(2,3),
(3,1),
(4,4),	(4,5),	(4,6),
(5,7),	(5,8),	(5,5),	(5,9),
(6,4),	(6,5),
(7,10),	(7,5),	(7,9),
(8,4),	(8,5),
(9,8),	(9,3),
(10,3),
(11,8),(11,5),	(11,11),
(12,3),	(12,5),	(12,1),
(13,2),	(13,5);