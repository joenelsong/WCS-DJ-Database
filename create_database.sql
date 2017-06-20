-- MySQL Script generated by MySQL Workbench
-- 06/20/17 16:45:01
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema dj_wcs
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dj_wcs
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dj_wcs` DEFAULT CHARACTER SET latin1 ;
USE `dj_wcs` ;

-- -----------------------------------------------------
-- Table `dj_wcs`.`DJ`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dj_wcs`.`DJ` (
  `dj_id` MEDIUMINT(9) NOT NULL AUTO_INCREMENT COMMENT '',
  `dj_name` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `dj_city` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `dj_state` VARCHAR(4) NULL DEFAULT NULL COMMENT '',
  `dj_country` VARCHAR(20) NULL DEFAULT NULL COMMENT '',
  `dj_experience` TINYINT(4) NULL DEFAULT NULL COMMENT '',
  `dj_url` TEXT NOT NULL COMMENT '',
  PRIMARY KEY (`dj_id`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 60
DEFAULT CHARACTER SET = latin1
COMMENT = 'Requirs that dj\'s publish there playlist online to register and supply the url so we can track them';


-- -----------------------------------------------------
-- Table `dj_wcs`.`Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dj_wcs`.`Playlist` (
  `id` MEDIUMINT(9) NOT NULL AUTO_INCREMENT COMMENT '',
  `dj_id` MEDIUMINT(9) NULL DEFAULT NULL COMMENT '',
  `date` DATE NULL DEFAULT NULL COMMENT '',
  `notes` TEXT NULL DEFAULT NULL COMMENT '',
  `DJ_dj_id` MEDIUMINT(9) NOT NULL COMMENT '',
  PRIMARY KEY (`id`, `DJ_dj_id`)  COMMENT '',
  INDEX `fk_Playlist_DJ1_idx` (`DJ_dj_id` ASC)  COMMENT '',
  CONSTRAINT `fk_Playlist_DJ1`
    FOREIGN KEY (`DJ_dj_id`)
    REFERENCES `dj_wcs`.`DJ` (`dj_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dj_wcs`.`Playlist_has_Tracks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dj_wcs`.`Playlist_has_Tracks` (
  `playlist_id` MEDIUMINT(9) NOT NULL COMMENT '',
  `track_title` VARCHAR(45) NOT NULL COMMENT '',
  `track_artist` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`playlist_id`, `track_title`, `track_artist`)  COMMENT '',
  INDEX `fk_Playlist_has_tracks_Track_idx` (`track_title` ASC)  COMMENT '',
  CONSTRAINT `fk_Playlist_has_tracks_Playlist`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `dj_wcs`.`Playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dj_wcs`.`RadioStation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dj_wcs`.`RadioStation` (
  `radio_station_id` MEDIUMINT(9) NOT NULL AUTO_INCREMENT COMMENT '',
  `radio_station_name` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `url` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `RadioStation_has_Tracks_radio_station_id` TINYINT(4) NOT NULL COMMENT '',
  `RadioStation_has_Tracks_timestamp` DATETIME NOT NULL COMMENT '',
  PRIMARY KEY (`radio_station_id`, `RadioStation_has_Tracks_radio_station_id`, `RadioStation_has_Tracks_timestamp`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dj_wcs`.`Track_Lyrics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dj_wcs`.`Track_Lyrics` (
  `track_id` INT(11) NOT NULL COMMENT '',
  `text` MEDIUMTEXT NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`track_id`)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'separate table because lyric entries can be long and will be accessed less frequently than other track meta data';


-- -----------------------------------------------------
-- Table `dj_wcs`.`Track`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dj_wcs`.`Track` (
  `title` VARCHAR(45) NOT NULL COMMENT '',
  `artist` VARCHAR(45) NOT NULL COMMENT '',
  `genre` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `year` YEAR NULL DEFAULT NULL COMMENT '',
  `bpm` TINYINT(4) NULL DEFAULT NULL COMMENT '',
  `length` TIME NULL DEFAULT NULL COMMENT '',
  `Track_Lyrics_track_id` INT(11) NOT NULL COMMENT '',
  `RadioStation_has_Tracks_radio_station_id` TINYINT(4) NOT NULL COMMENT '',
  `RadioStation_has_Tracks_timestamp` DATETIME NOT NULL COMMENT '',
  `key_camelot` VARCHAR(3) NULL COMMENT '',
  `key_musical` VARCHAR(16) NULL COMMENT '',
  PRIMARY KEY (`title`, `artist`, `Track_Lyrics_track_id`, `RadioStation_has_Tracks_radio_station_id`, `RadioStation_has_Tracks_timestamp`)  COMMENT '',
  INDEX `fk_Track_Track_Lyrics1_idx` (`Track_Lyrics_track_id` ASC)  COMMENT '',
  CONSTRAINT `fk_Track_Track_Lyrics1`
    FOREIGN KEY (`Track_Lyrics_track_id`)
    REFERENCES `dj_wcs`.`Track_Lyrics` (`track_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dj_wcs`.`RadioStation_has_Tracks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dj_wcs`.`RadioStation_has_Tracks` (
  `radio_station_id` TINYINT(4) NOT NULL COMMENT '',
  `timestamp` DATETIME NOT NULL COMMENT '',
  `track_title` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `track_artist` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `RadioStation_radio_station_id` MEDIUMINT(9) NOT NULL COMMENT '',
  `RadioStation_RadioStation_has_Tracks_radio_station_id` TINYINT(4) NOT NULL COMMENT '',
  `RadioStation_RadioStation_has_Tracks_timestamp` DATETIME NOT NULL COMMENT '',
  `Track_title` VARCHAR(45) NOT NULL COMMENT '',
  `Track_artist` VARCHAR(45) NOT NULL COMMENT '',
  `Track_Track_Lyrics_track_id` INT(11) NOT NULL COMMENT '',
  `Track_RadioStation_has_Tracks_radio_station_id` TINYINT(4) NOT NULL COMMENT '',
  `Track_RadioStation_has_Tracks_timestamp` DATETIME NOT NULL COMMENT '',
  PRIMARY KEY (`radio_station_id`, `timestamp`)  COMMENT '',
  INDEX `fk_RadioStation_has_Tracks_Tracks_title_idx` (`track_title` ASC)  COMMENT '',
  INDEX `fk_RadioStation_has_Tracks_Track_artist_idx` (`track_artist` ASC)  COMMENT '',
  INDEX `fk_RadioStation_has_Tracks_RadioStation1_idx` (`RadioStation_radio_station_id` ASC, `RadioStation_RadioStation_has_Tracks_radio_station_id` ASC, `RadioStation_RadioStation_has_Tracks_timestamp` ASC)  COMMENT '',
  INDEX `fk_RadioStation_has_Tracks_Track1_idx` (`Track_title` ASC, `Track_artist` ASC, `Track_Track_Lyrics_track_id` ASC, `Track_RadioStation_has_Tracks_radio_station_id` ASC, `Track_RadioStation_has_Tracks_timestamp` ASC)  COMMENT '',
  CONSTRAINT `fk_RadioStation_has_Tracks_RadioStation1`
    FOREIGN KEY (`RadioStation_radio_station_id` , `RadioStation_RadioStation_has_Tracks_radio_station_id` , `RadioStation_RadioStation_has_Tracks_timestamp`)
    REFERENCES `dj_wcs`.`RadioStation` (`radio_station_id` , `RadioStation_has_Tracks_radio_station_id` , `RadioStation_has_Tracks_timestamp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RadioStation_has_Tracks_Track1`
    FOREIGN KEY (`Track_title` , `Track_artist` , `Track_Track_Lyrics_track_id` , `Track_RadioStation_has_Tracks_radio_station_id` , `Track_RadioStation_has_Tracks_timestamp`)
    REFERENCES `dj_wcs`.`Track` (`title` , `artist` , `Track_Lyrics_track_id` , `RadioStation_has_Tracks_radio_station_id` , `RadioStation_has_Tracks_timestamp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dj_wcs`.`Toplist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dj_wcs`.`Toplist` (
  `toplist_id` MEDIUMINT(9) NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `url` TEXT NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`toplist_id`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dj_wcs`.`Toplist_has_Tracks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dj_wcs`.`Toplist_has_Tracks` (
  `toplist_id` MEDIUMINT(9) NOT NULL COMMENT '',
  `date` DATE NOT NULL COMMENT '',
  `track_title` VARCHAR(45) NOT NULL COMMENT '',
  `track_artist` VARCHAR(45) NOT NULL COMMENT '',
  `Toplist_toplist_id` MEDIUMINT(9) NOT NULL COMMENT '',
  `Track_title` VARCHAR(45) NOT NULL COMMENT '',
  `Track_artist` VARCHAR(45) NOT NULL COMMENT '',
  `Track_Track_Lyrics_track_id` INT(11) NOT NULL COMMENT '',
  `Track_RadioStation_has_Tracks_radio_station_id` TINYINT(4) NOT NULL COMMENT '',
  `Track_RadioStation_has_Tracks_timestamp` DATETIME NOT NULL COMMENT '',
  PRIMARY KEY (`toplist_id`, `date`, `track_title`, `track_artist`, `Track_title`, `Track_artist`, `Track_Track_Lyrics_track_id`, `Track_RadioStation_has_Tracks_radio_station_id`, `Track_RadioStation_has_Tracks_timestamp`)  COMMENT '',
  INDEX `fk_Toplist_has_Track_track_artist_idx` (`track_artist` ASC)  COMMENT '',
  INDEX `fk_Toplist_has_Track_track_idx` (`track_title` ASC, `track_artist` ASC)  COMMENT '',
  INDEX `fk_Toplist_has_Tracks_Toplist1_idx` (`Toplist_toplist_id` ASC)  COMMENT '',
  INDEX `fk_Toplist_has_Tracks_Track1_idx` (`Track_title` ASC, `Track_artist` ASC, `Track_Track_Lyrics_track_id` ASC, `Track_RadioStation_has_Tracks_radio_station_id` ASC, `Track_RadioStation_has_Tracks_timestamp` ASC)  COMMENT '',
  CONSTRAINT `fk_Toplist_has_Tracks_Toplist1`
    FOREIGN KEY (`Toplist_toplist_id`)
    REFERENCES `dj_wcs`.`Toplist` (`toplist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Toplist_has_Tracks_Track1`
    FOREIGN KEY (`Track_title` , `Track_artist` , `Track_Track_Lyrics_track_id` , `Track_RadioStation_has_Tracks_radio_station_id` , `Track_RadioStation_has_Tracks_timestamp`)
    REFERENCES `dj_wcs`.`Track` (`title` , `artist` , `Track_Lyrics_track_id` , `RadioStation_has_Tracks_radio_station_id` , `RadioStation_has_Tracks_timestamp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
