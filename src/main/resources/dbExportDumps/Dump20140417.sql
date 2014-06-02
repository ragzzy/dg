CREATE DATABASE  IF NOT EXISTS `data_governance` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `data_governance`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: 127.0.0.1    Database: data_governance
-- ------------------------------------------------------
-- Server version	5.6.17

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
-- Table structure for table `application_info`
--

DROP TABLE IF EXISTS `application_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_info` (
  `appl_id` int(11) NOT NULL COMMENT 'The database internal ID representation of an application.',
  `appl_nm` varchar(200) NOT NULL COMMENT 'The business name of an application.',
  `appl_dsc` varchar(1000) NOT NULL COMMENT 'The business description of an application.',
  PRIMARY KEY (`appl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table to house all application specific information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_info`
--

LOCK TABLES `application_info` WRITE;
/*!40000 ALTER TABLE `application_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `application_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_entity_info`
--

DROP TABLE IF EXISTS `data_entity_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_entity_info` (
  `entity_id` int(11) NOT NULL COMMENT 'The internal reference ID of a Data Entity record.',
  `entity_nm` varchar(200) NOT NULL COMMENT 'The business name of a Data Entity.',
  `entity_dsc` varchar(3000) NOT NULL COMMENT 'The business description of a Data Entity.',
  `entity_ext_url_ref` varchar(5000) DEFAULT NULL COMMENT 'Any external pages that may contain more information on this Data Entity.',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table to store entreprise level Data Entity definitions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_entity_info`
--

LOCK TABLES `data_entity_info` WRITE;
/*!40000 ALTER TABLE `data_entity_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_entity_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'data_governance'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-17 15:06:57
