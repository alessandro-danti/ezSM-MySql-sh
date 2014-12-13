<<<<<<< HEAD
-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: ezSvrMon
-- ------------------------------------------------------
-- Server version	5.1.73

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `CPU`
--

DROP TABLE IF EXISTS `CPU`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CPU` (
  `System_SystemID` int(11) NOT NULL,
  `Model` varchar(45) DEFAULT NULL,
  `Frequency` varchar(9) DEFAULT NULL,
  `Cache` varchar(5) DEFAULT NULL,
  `BogoMips` varchar(8) DEFAULT NULL,
  `Timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`System_SystemID`),
  KEY `fk_CPU_System1_idx` (`System_SystemID`),
  CONSTRAINT `fk_CPU_System1` FOREIGN KEY (`System_SystemID`) REFERENCES `System` (`SystemID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DiskTemperature`
--

DROP TABLE IF EXISTS `DiskTemperature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DiskTemperature` (
  `System_SystemID` int(11) NOT NULL,
  `DiskName` varchar(45) DEFAULT NULL,
  `DiskTemperature` varchar(45) DEFAULT NULL,
  `Timestamp` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`System_SystemID`),
  CONSTRAINT `fk_DiskTemperature_System1` FOREIGN KEY (`System_SystemID`) REFERENCES `System` (`SystemID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Diskspace`
--

DROP TABLE IF EXISTS `Diskspace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Diskspace` (
  `System_SystemID` int(11) NOT NULL,
  `FileSystem` varchar(45) DEFAULT NULL,
  `FileSystemStatus` varchar(45) DEFAULT NULL,
  `Timestamp` datetime DEFAULT NULL,
  `DiskspaceID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`DiskspaceID`),
  KEY `fk_Diskspace_System1` (`System_SystemID`),
  CONSTRAINT `fk_Diskspace_System1` FOREIGN KEY (`System_SystemID`) REFERENCES `System` (`SystemID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `LoadAverage`
--

DROP TABLE IF EXISTS `LoadAverage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LoadAverage` (
  `System_SystemID` int(11) NOT NULL,
  `OneMinute` varchar(12) DEFAULT NULL,
  `FiveMinutes` varchar(12) DEFAULT NULL,
  `FifteenMinutes` varchar(12) DEFAULT NULL,
  `Processes` varchar(45) DEFAULT NULL,
  `Timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`System_SystemID`),
  CONSTRAINT `fk_LoadAverage_System1` FOREIGN KEY (`System_SystemID`) REFERENCES `System` (`SystemID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NetworkInterfaces`
--

DROP TABLE IF EXISTS `NetworkInterfaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NetworkInterfaces` (
  `System_SystemID` int(11) NOT NULL,
  `InterfaceName` varchar(10) DEFAULT NULL,
  `InterfaceIP` int(11) DEFAULT NULL,
  `Timestamp` datetime DEFAULT NULL,
  `InterfaceID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`InterfaceID`),
  KEY `fk_NetworkInterfaces_System1` (`System_SystemID`),
  CONSTRAINT `fk_NetworkInterfaces_System1` FOREIGN KEY (`System_SystemID`) REFERENCES `System` (`SystemID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Ping`
--

DROP TABLE IF EXISTS `Ping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ping` (
  `System_SystemID` int(11) NOT NULL,
  `Host` varchar(253) DEFAULT NULL,
  `RTT` varchar(10) DEFAULT NULL,
  `Timestamp` datetime DEFAULT NULL,
  `PingID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`PingID`),
  KEY `fk_Ping_System1` (`System_SystemID`),
  CONSTRAINT `fk_Ping_System1` FOREIGN KEY (`System_SystemID`) REFERENCES `System` (`SystemID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RAM`
--

DROP TABLE IF EXISTS `RAM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RAM` (
  `System_SystemID` int(11) NOT NULL,
  `TotalRAM` int(11) DEFAULT NULL,
  `FreeRAM` int(11) DEFAULT NULL,
  `Timestamp` datetime NOT NULL,
  PRIMARY KEY (`System_SystemID`),
  KEY `fk_RAM_System_idx` (`System_SystemID`),
  CONSTRAINT `fk_RAM_System` FOREIGN KEY (`System_SystemID`) REFERENCES `System` (`SystemID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Services`
--

DROP TABLE IF EXISTS `Services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Services` (
  `System_SystemID` int(11) NOT NULL,
  `ServiceName` varchar(45) DEFAULT NULL,
  `ServiceHost` varchar(253) DEFAULT NULL,
  `ServicePort` int(11) DEFAULT NULL,
  `ServiceStatus` tinyint(1) DEFAULT NULL,
  `Timestamp` datetime DEFAULT NULL,
  `ServiceID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ServiceID`),
  KEY `fk_Services_System1` (`System_SystemID`),
  CONSTRAINT `fk_Services_System1` FOREIGN KEY (`System_SystemID`) REFERENCES `System` (`SystemID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `System`
--

DROP TABLE IF EXISTS `System`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `System` (
  `SystemID` int(11) NOT NULL AUTO_INCREMENT,
  `Hostname` varchar(253) DEFAULT NULL,
  `OS` varchar(45) DEFAULT NULL,
  `Kernel` varchar(45) DEFAULT NULL,
  `Uptime` varchar(45) DEFAULT NULL,
  `LastBoot` varchar(20) DEFAULT NULL,
  `CurrentUsers` int(11) DEFAULT NULL,
  `LastChanged` datetime DEFAULT NULL,
  PRIMARY KEY (`SystemID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SystemTemperature`
--

DROP TABLE IF EXISTS `SystemTemperature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SystemTemperature` (
  `System_SystemID` int(11) NOT NULL,
  `SensorName` varchar(45) DEFAULT NULL,
  `SensorTemperature` varchar(45) DEFAULT NULL,
  `Timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`System_SystemID`),
  CONSTRAINT `fk_SystemTemperature_System1` FOREIGN KEY (`System_SystemID`) REFERENCES `System` (`SystemID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-12-13 18:29:32
=======
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

>>>>>>> 6ce419ca4402fabcb4b9125b4d051c3b8a853451
