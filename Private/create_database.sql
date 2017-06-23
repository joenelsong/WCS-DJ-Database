-- MySQL Script generated by MySQL Workbench
-- 06/23/17 15:55:10
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema wcs_djbase
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `wcs_djbase` ;

-- -----------------------------------------------------
-- Schema wcs_djbase
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `wcs_djbase` DEFAULT CHARACTER SET latin1 ;
USE `wcs_djbase` ;

-- -----------------------------------------------------
-- Table `wcs_djbase`.`DJ`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wcs_djbase`.`DJ` ;

CREATE TABLE IF NOT EXISTS `wcs_djbase`.`DJ` (
  `id` MEDIUMINT(9) NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(45) NOT NULL COMMENT '',
  `city` VARCHAR(45) NULL COMMENT '',
  `state` VARCHAR(4) NULL DEFAULT NULL COMMENT '',
  `country` VARCHAR(20) NULL DEFAULT NULL COMMENT '',
  `experience` TINYINT(4) NULL DEFAULT NULL COMMENT '',
  `url` TEXT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 60
DEFAULT CHARACTER SET = latin1
COMMENT = 'Requirs that dj\'s publish there playlist online to register and supply the url so we can track them';


-- -----------------------------------------------------
-- Table `wcs_djbase`.`Playlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wcs_djbase`.`Playlist` ;

CREATE TABLE IF NOT EXISTS `wcs_djbase`.`Playlist` (
  `id` MEDIUMINT(9) NOT NULL AUTO_INCREMENT COMMENT '',
  `DJ_id` MEDIUMINT(9) NULL COMMENT '',
  `date` DATE NULL COMMENT '',
  `event` VARCHAR(45) NULL COMMENT '',
  `notes` TEXT NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_Playlist_DJ1_idx` (`DJ_id` ASC)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `wcs_djbase`.`Track`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wcs_djbase`.`Track` ;

CREATE TABLE IF NOT EXISTS `wcs_djbase`.`Track` (
  `title` VARCHAR(45) NOT NULL COMMENT '',
  `artist` VARCHAR(45) NOT NULL COMMENT '',
  `genre` VARCHAR(45) NULL COMMENT '',
  `bpm` TINYINT(4) NULL DEFAULT NULL COMMENT '',
  `year` YEAR NULL DEFAULT NULL COMMENT '',
  `length` TIME NULL DEFAULT NULL COMMENT '',
  `key_camelot` VARCHAR(3) NULL COMMENT '',
  `key_musical` VARCHAR(16) NULL COMMENT '',
  `RadioStation_has_Tracks_radio_station_id` TINYINT(4) NULL COMMENT '',
  `RadioStation_has_Tracks_timestamp` DATETIME NULL COMMENT '',
  PRIMARY KEY (`title`, `artist`)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `wcs_djbase`.`Playlist_has_Tracks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wcs_djbase`.`Playlist_has_Tracks` ;

CREATE TABLE IF NOT EXISTS `wcs_djbase`.`Playlist_has_Tracks` (
  `Track_title` VARCHAR(45) NOT NULL COMMENT '',
  `Track_artist` VARCHAR(45) NOT NULL COMMENT '',
  `Playlist_id` MEDIUMINT(9) NOT NULL COMMENT '',
  PRIMARY KEY (`Track_title`, `Track_artist`, `Playlist_id`)  COMMENT '',
  INDEX `fk_Playlist_has_Tracks_Track1_idx` (`Track_title` ASC, `Track_artist` ASC)  COMMENT '',
  INDEX `fk_Playlist_has_Tracks_Playlist1_idx` (`Playlist_id` ASC)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `wcs_djbase`.`RadioStation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wcs_djbase`.`RadioStation` ;

CREATE TABLE IF NOT EXISTS `wcs_djbase`.`RadioStation` (
  `id` MEDIUMINT(9) NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(45) NULL COMMENT '',
  `url` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `wcs_djbase`.`RadioStation_has_Tracks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wcs_djbase`.`RadioStation_has_Tracks` ;

CREATE TABLE IF NOT EXISTS `wcs_djbase`.`RadioStation_has_Tracks` (
  `timestamp` DATETIME NOT NULL COMMENT '',
  `RadioStation_id` MEDIUMINT(9) NOT NULL COMMENT '',
  `Track_title` VARCHAR(45) NOT NULL COMMENT '',
  `Track_artist` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`timestamp`, `RadioStation_id`, `Track_title`, `Track_artist`)  COMMENT '',
  INDEX `fk_RadioStation_has_Tracks_RadioStation1_idx` (`RadioStation_id` ASC)  COMMENT '',
  INDEX `fk_RadioStation_has_Tracks_Track1_idx` (`Track_title` ASC, `Track_artist` ASC)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_german1_ci;


-- -----------------------------------------------------
-- Table `wcs_djbase`.`Toplist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wcs_djbase`.`Toplist` ;

CREATE TABLE IF NOT EXISTS `wcs_djbase`.`Toplist` (
  `id` MEDIUMINT(9) NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `url` TEXT NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `wcs_djbase`.`Toplist_has_Tracks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wcs_djbase`.`Toplist_has_Tracks` ;

CREATE TABLE IF NOT EXISTS `wcs_djbase`.`Toplist_has_Tracks` (
  `Toplist_toplist_id` MEDIUMINT(9) NOT NULL COMMENT '',
  `Track_title` VARCHAR(45) NOT NULL COMMENT '',
  `Track_artist` VARCHAR(45) NOT NULL COMMENT '',
  `date` DATE NOT NULL COMMENT '',
  PRIMARY KEY (`Toplist_toplist_id`, `date`, `Track_title`, `Track_artist`)  COMMENT '',
  INDEX `fk_Toplist_has_Tracks_Toplist1_idx` (`Toplist_toplist_id` ASC)  COMMENT '',
  INDEX `fk_Toplist_has_Tracks_Track1_idx` (`Track_title` ASC, `Track_artist` ASC)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `wcs_djbase`.`Track_Lyrics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wcs_djbase`.`Track_Lyrics` ;

CREATE TABLE IF NOT EXISTS `wcs_djbase`.`Track_Lyrics` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `lyrics` MEDIUMTEXT NOT NULL COMMENT '',
  `Track_title` VARCHAR(45) NOT NULL COMMENT '',
  `Track_artist` VARCHAR(45) NOT NULL COMMENT '',
  INDEX `fk_Track_Lyrics_Track1_idx` (`Track_title` ASC, `Track_artist` ASC)  COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'separate table because lyric entries can be long and will be accessed less frequently than other track meta data';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;