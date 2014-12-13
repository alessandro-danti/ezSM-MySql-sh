-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ezSvrMon
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ezSvrMon
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ezSvrMon` DEFAULT CHARACTER SET utf8 ;
USE `ezSvrMon` ;

-- -----------------------------------------------------
-- Table `ezSvrMon`.`System`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ezSvrMon`.`System` (
  `SystemID` INT(11) NOT NULL AUTO_INCREMENT,
  `Hostname` VARCHAR(253) NULL DEFAULT NULL,
  `OS` VARCHAR(45) NULL DEFAULT NULL,
  `Kernel` VARCHAR(45) NULL DEFAULT NULL,
  `Uptime` VARCHAR(45) NULL DEFAULT NULL,
  `LastBoot` VARCHAR(20) NULL DEFAULT NULL,
  `CurrentUsers` INT(11) NULL DEFAULT NULL,
  `LastChanged` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`SystemID`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ezSvrMon`.`CPU`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ezSvrMon`.`CPU` (
  `System_SystemID` INT(11) NOT NULL,
  `Model` VARCHAR(45) NULL DEFAULT NULL,
  `Frequency` VARCHAR(9) NULL DEFAULT NULL,
  `Cache` VARCHAR(5) NULL DEFAULT NULL,
  `BogoMips` VARCHAR(8) NULL DEFAULT NULL,
  `Timestamp` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`System_SystemID`),
  INDEX `fk_CPU_System1_idx` (`System_SystemID` ASC),
  CONSTRAINT `fk_CPU_System1`
    FOREIGN KEY (`System_SystemID`)
    REFERENCES `ezSvrMon`.`System` (`SystemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ezSvrMon`.`DiskTemperature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ezSvrMon`.`DiskTemperature` (
  `System_SystemID` INT(11) NOT NULL,
  `DiskName` VARCHAR(45) NULL DEFAULT NULL,
  `DiskTemperature` VARCHAR(45) NULL DEFAULT NULL,
  `Timestamp` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`System_SystemID`),
  CONSTRAINT `fk_DiskTemperature_System1`
    FOREIGN KEY (`System_SystemID`)
    REFERENCES `ezSvrMon`.`System` (`SystemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ezSvrMon`.`Diskspace`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ezSvrMon`.`Diskspace` (
  `System_SystemID` INT(11) NOT NULL,
  `FileSystem` VARCHAR(45) NULL DEFAULT NULL,
  `FileSystemStatus` VARCHAR(45) NULL DEFAULT NULL,
  `Timestamp` DATETIME NULL DEFAULT NULL,
  `DiskspaceID` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`DiskspaceID`),
  INDEX `fk_Diskspace_System1` (`System_SystemID` ASC),
  CONSTRAINT `fk_Diskspace_System1`
    FOREIGN KEY (`System_SystemID`)
    REFERENCES `ezSvrMon`.`System` (`SystemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ezSvrMon`.`LoadAverage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ezSvrMon`.`LoadAverage` (
  `System_SystemID` INT(11) NOT NULL,
  `OneMinute` VARCHAR(12) NULL DEFAULT NULL,
  `FiveMinutes` VARCHAR(12) NULL DEFAULT NULL,
  `FifteenMinutes` VARCHAR(12) NULL DEFAULT NULL,
  `Processes` VARCHAR(45) NULL DEFAULT NULL,
  `Timestamp` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`System_SystemID`),
  CONSTRAINT `fk_LoadAverage_System1`
    FOREIGN KEY (`System_SystemID`)
    REFERENCES `ezSvrMon`.`System` (`SystemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ezSvrMon`.`NetworkInterfaces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ezSvrMon`.`NetworkInterfaces` (
  `System_SystemID` INT(11) NOT NULL,
  `InterfaceName` VARCHAR(10) NULL DEFAULT NULL,
  `InterfaceIP` INT(11) NULL DEFAULT NULL,
  `Timestamp` DATETIME NULL DEFAULT NULL,
  `InterfaceID` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`InterfaceID`),
  INDEX `fk_NetworkInterfaces_System1` (`System_SystemID` ASC),
  CONSTRAINT `fk_NetworkInterfaces_System1`
    FOREIGN KEY (`System_SystemID`)
    REFERENCES `ezSvrMon`.`System` (`SystemID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ezSvrMon`.`Ping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ezSvrMon`.`Ping` (
  `System_SystemID` INT(11) NOT NULL,
  `Host` VARCHAR(253) NULL DEFAULT NULL,
  `RTT` VARCHAR(10) NULL DEFAULT NULL,
  `Timestamp` DATETIME NULL DEFAULT NULL,
  `PingID` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`PingID`),
  INDEX `fk_Ping_System1` (`System_SystemID` ASC),
  CONSTRAINT `fk_Ping_System1`
    FOREIGN KEY (`System_SystemID`)
    REFERENCES `ezSvrMon`.`System` (`SystemID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ezSvrMon`.`RAM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ezSvrMon`.`RAM` (
  `System_SystemID` INT(11) NOT NULL,
  `TotalRAM` INT(11) NULL DEFAULT NULL,
  `FreeRAM` INT(11) NULL DEFAULT NULL,
  `Timestamp` DATETIME NOT NULL,
  PRIMARY KEY (`System_SystemID`),
  INDEX `fk_RAM_System_idx` (`System_SystemID` ASC),
  CONSTRAINT `fk_RAM_System`
    FOREIGN KEY (`System_SystemID`)
    REFERENCES `ezSvrMon`.`System` (`SystemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ezSvrMon`.`Services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ezSvrMon`.`Services` (
  `System_SystemID` INT(11) NOT NULL,
  `ServiceName` VARCHAR(45) NULL DEFAULT NULL,
  `ServiceHost` VARCHAR(253) NULL DEFAULT NULL,
  `ServicePort` INT(11) NULL DEFAULT NULL,
  `ServiceStatus` TINYINT(1) NULL DEFAULT NULL,
  `Timestamp` DATETIME NULL DEFAULT NULL,
  `ServiceID` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ServiceID`),
  INDEX `fk_Services_System1` (`System_SystemID` ASC),
  CONSTRAINT `fk_Services_System1`
    FOREIGN KEY (`System_SystemID`)
    REFERENCES `ezSvrMon`.`System` (`SystemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ezSvrMon`.`SystemTemperature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ezSvrMon`.`SystemTemperature` (
  `System_SystemID` INT(11) NOT NULL,
  `SensorName` VARCHAR(45) NULL DEFAULT NULL,
  `SensorTemperature` VARCHAR(45) NULL DEFAULT NULL,
  `Timestamp` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`System_SystemID`),
  CONSTRAINT `fk_SystemTemperature_System1`
    FOREIGN KEY (`System_SystemID`)
    REFERENCES `ezSvrMon`.`System` (`SystemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

