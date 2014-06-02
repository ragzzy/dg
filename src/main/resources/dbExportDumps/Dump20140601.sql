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
-- Table structure for table `application_master`
--

DROP TABLE IF EXISTS `application_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_master` (
  `appl_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The database internal ID representation of an application.',
  `appl_nm` varchar(200) NOT NULL COMMENT 'The business name of an application.',
  `appl_dsc` varchar(1000) NOT NULL COMMENT 'The business description of an application.',
  `appl_rbac_controlled_flg` char(1) NOT NULL COMMENT 'Is the application RBAC controlled.  Y or N.',
  `appl_live_flg` char(1) NOT NULL COMMENT 'Is this application currently live in production.',
  `appl_decomm_date` timestamp NULL DEFAULT NULL COMMENT 'If the appl_live_flg is N, then what is/was the decommisioning date.',
  `create_tsp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The date and time the user was created.',
  `create_user_id` int(11) NOT NULL,
  `last_mod_tsp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'The last modification date time of the user record.',
  `last_mod_user_id` int(11) NOT NULL,
  PRIMARY KEY (`appl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table to house all application specific information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_master`
--

LOCK TABLES `application_master` WRITE;
/*!40000 ALTER TABLE `application_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `application_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_tier`
--

DROP TABLE IF EXISTS `application_tier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_tier` (
  `appl_tier_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Database internal representation for a Tier.',
  `appl_tier_nm` varchar(45) NOT NULL COMMENT 'The application tier name',
  `appl_tier_dsc` varchar(2000) NOT NULL COMMENT 'Tier Description',
  `tier_cert_id` int(11) DEFAULT NULL COMMENT 'Any certification calender attached to this tier.',
  PRIMARY KEY (`appl_tier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table to store the tiers an application is categorized in.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_tier`
--

LOCK TABLES `application_tier` WRITE;
/*!40000 ALTER TABLE `application_tier` DISABLE KEYS */;
/*!40000 ALTER TABLE `application_tier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business_process`
--

DROP TABLE IF EXISTS `business_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_process` (
  `bp_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The internal representation of a business process.',
  `bp_nm` varchar(45) NOT NULL COMMENT 'The business process name.',
  `dept_id` int(11) NOT NULL,
  `dept_team_id` int(11) DEFAULT NULL COMMENT 'The department postion that uses this business process.',
  `dept_func_nm` varchar(45) DEFAULT NULL,
  `bp_in_blueworks` char(1) DEFAULT 'N' COMMENT 'Is the business process documented in IBM Blueworks. Y or N.',
  `bp_blueworks_url` varchar(5000) DEFAULT NULL COMMENT 'If the business process IS documented in Blueworks, then attach Blueworks URL.',
  `bp_open_text` varchar(10000) DEFAULT NULL COMMENT 'If the business process is NOT defined in Blueworks, then explain process in text.',
  `create_tsp` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The date and time the user was created.',
  `create_user_id` int(11) DEFAULT NULL,
  `last_mod_tsp` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'The last modification date time of the user record.',
  `last_mod_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`bp_id`),
  KEY `fk_bus_prcss_ref_2_idx` (`dept_team_id`),
  KEY `fk_bus_prcss_ref_1` (`dept_id`),
  CONSTRAINT `fk_bus_prcss_ref_1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_bus_prcss_ref_2` FOREIGN KEY (`dept_team_id`) REFERENCES `department_team` (`dept_team_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table to store business processes used at the entreprise or application level.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_process`
--

LOCK TABLES `business_process` WRITE;
/*!40000 ALTER TABLE `business_process` DISABLE KEYS */;
/*!40000 ALTER TABLE `business_process` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certification_manager`
--

DROP TABLE IF EXISTS `certification_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certification_manager` (
  `cert_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Database internal representation of a certification ID.',
  `cert_typ_cd` varchar(2) NOT NULL,
  `cert_dsc` varchar(45) NOT NULL,
  `cert_frequency` int(11) DEFAULT NULL COMMENT 'Every so many months.',
  `cert_start_date` date DEFAULT NULL COMMENT 'Certification start date.',
  `cert_end_date` date DEFAULT NULL COMMENT 'Certification end date.',
  PRIMARY KEY (`cert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table to store Certification schedules for a tier.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certification_manager`
--

LOCK TABLES `certification_manager` WRITE;
/*!40000 ALTER TABLE `certification_manager` DISABLE KEYS */;
/*!40000 ALTER TABLE `certification_manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact` (
  `con_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The internal representation of a department contact.',
  `first_nm` varchar(45) NOT NULL COMMENT 'The contact within a department.',
  `email_id` varchar(100) NOT NULL COMMENT 'The contact email.',
  `phn_no` varchar(45) DEFAULT NULL COMMENT 'The contact phone.',
  `last_nm` varchar(45) NOT NULL,
  `middle_nm` varchar(45) DEFAULT NULL,
  `phn_extn` varchar(45) DEFAULT NULL,
  `purple_pages_link` varchar(500) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`con_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table to house all department contacts.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_entity_dependency`
--

DROP TABLE IF EXISTS `data_entity_dependency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_entity_dependency` (
  `dependency_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'A database internal for uniquely identifying a data entity hierarchy.',
  `data_entity_parent_id` int(11) DEFAULT NULL COMMENT 'The entity chosen as a PARENT entity.',
  `data_entity_child_id` int(11) DEFAULT NULL COMMENT 'The entity considered the CHILD entity, linked to a parent entity.',
  PRIMARY KEY (`dependency_id`),
  KEY `fk_data_entity_rlshp_mstr_ref_1` (`data_entity_parent_id`),
  KEY `fk_data_entity_rlshp_mstr_ref_2` (`data_entity_child_id`),
  CONSTRAINT `fk_data_entity_rlshp_mstr_ref_1` FOREIGN KEY (`data_entity_parent_id`) REFERENCES `data_entity_master` (`entity_id`),
  CONSTRAINT `fk_data_entity_rlshp_mstr_ref_2` FOREIGN KEY (`data_entity_child_id`) REFERENCES `data_entity_master` (`entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Table to store the parent-child relationships between Entities.  An entity can have 0, 1 or many sub entities.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_entity_dependency`
--

LOCK TABLES `data_entity_dependency` WRITE;
/*!40000 ALTER TABLE `data_entity_dependency` DISABLE KEYS */;
INSERT INTO `data_entity_dependency` VALUES (1,1,4),(2,1,6),(3,1,3),(4,2,7),(5,3,8);
/*!40000 ALTER TABLE `data_entity_dependency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_entity_master`
--

DROP TABLE IF EXISTS `data_entity_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_entity_master` (
  `entity_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The internal reference ID of a Data Entity record.',
  `entity_nm` varchar(200) NOT NULL COMMENT 'The business name of a Data Entity.',
  `entity_defn` varchar(5000) NOT NULL COMMENT 'The business description of a Data Entity.',
  `entity_ext_url_ref` varchar(5000) DEFAULT NULL COMMENT 'Any external pages that may contain more information on this Data Entity.',
  `create_tsp` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The date and time the user was created.',
  `create_user_id` int(11) DEFAULT NULL,
  `last_mod_tsp` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'The last modification date time of the user record.',
  `last_mod_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='Table to store entreprise level Data Entity definitions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_entity_master`
--

LOCK TABLES `data_entity_master` WRITE;
/*!40000 ALTER TABLE `data_entity_master` DISABLE KEYS */;
INSERT INTO `data_entity_master` VALUES (1,'Account Coding','An arrangement or agreement by which an organization, Scottrade or other,  accepts a customer\'s financial assets and holds them on behalf of the customer at his or her discretion. -Investopedia',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(2,'Admin','Administration of capital / fixed assets.',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(3,'Branch -  Internal Org','Branch information.',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(4,'Communication','Correspondence sent to clients.',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(5,'Compass/CRM','Data about customers',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(6,'Event ','Data about branch events. i.e. seminars',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(7,'HR','Payroll, Benefits, Training',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(8,'IT','Information technology.',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(9,'Market Data','Market data is a general term used to represent quotation and trade data disseminated by the exchanges. This information is a hollistic view of the market.',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(10,'Organization','A legal entity, which can be linked to many accounts. Internal, External, Advisor Services.',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(11,'Person - Account Representative','A person, or person acting as an agent of an organization, that has completed all or a portion of the online application.',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(12,'Person - Business contacts at external organizations','A person, that represents a business entity, with whom Scottrade maintains a business relationship.',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(13,'Person - Customer','A person, or person acting as an agent of an organization,  that has completed the application process and has funded at least one account.',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(14,'Person - Employee','A person employed by Scottrade.',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(15,'Revenue','Firm revenue.',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(16,'Securities','Master list of securities owned in the past, present and future by Scottrade account holders.',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(17,'Trading Platforms/ Feature Usage','Customer usage of trading platforms.',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(18,'Transactions - Account/Customer','Activity in an account for the benefit of a customer. Activity in a G/L account to offside a client side entry.',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(19,'Transactions - Firm','Activity in an account for the benefit of Scottrade. i.e. daily trade settlement.',NULL,'2014-04-23 18:58:51',0,'2014-04-23 18:58:51',0),(20,'Name','Desc','Link','2014-05-25 04:46:56',1,'2014-05-25 04:46:56',NULL);
/*!40000 ALTER TABLE `data_entity_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `dept_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The internal representation of a department.',
  `dept_nm` varchar(100) NOT NULL COMMENT 'The name of the department.',
  `dept_dsc` varchar(2000) NOT NULL COMMENT 'Description of duties of department.  People, process, etc.',
  `dept_in_blueworks_flg` char(1) NOT NULL COMMENT 'Is this department documented in Blueworks.  Y or N.',
  `enterprise_business_group_id` int(11) NOT NULL,
  PRIMARY KEY (`dept_id`),
  KEY `fk_dept_ent_bus_grp_ref2_idx` (`enterprise_business_group_id`),
  CONSTRAINT `fk_dept_ent_bus_grp_ref2` FOREIGN KEY (`enterprise_business_group_id`) REFERENCES `enterprise_business_group` (`business_group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8 COMMENT='Table to store the various departments in the entreprise.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Credit & Market Risk','','',1),(2,'Enterprise Fraud','','',1),(3,'Operational Risk','','',1),(4,'Enterprise AML','','',1),(5,'Internal Audit','','',2),(6,'Compliance Services','','',3),(7,'Regulatory Affairs','','',3),(8,'Distribution Compliance','','',3),(9,'Legal','','',4),(10,'Bank Compliance','','',5),(11,'Vendor Relations','','',6),(12,'Finance','','',7),(13,'Tax Department','','',8),(14,'Treasury','','',9),(15,'Finance','','',10),(16,'Asset Management - Data Center','','',11),(17,'Bank Accounting','','',11),(18,'Regulatory Reporting','','',11),(19,'Equipment Finance','','',11),(20,'Accounts Payable','','',11),(21,'Job Costing','','',11),(22,'Fixed Asset','','',11),(23,'Recon','','',11),(24,'Financial Systems','','',11),(25,'Special Projects','','',12),(26,'Intranet Multimedia & Design','','',13),(27,'Internal Communication','','',13),(28,'Facilities & Administration','','',14),(29,'Receptionist','','',15),(30,'Talent Management','','',16),(31,'IT Service Delivery & Chg Mgmt','','',17),(32,'IT Comm & Security','','',17),(33,'Architecture & Monitoring','','',17),(34,'Data Cntr Fac & Planning','','',17),(35,'Distributed Systems','','',17),(36,'IT Operations','','',17),(37,'Application Support','','',17),(38,'Admin-Information Tech Div','','',17),(39,'Quality Assurance','','',18),(40,'Business Relationship Mgmt','','',18),(41,'Program Management','','',18),(42,'Business Systems Analysis','','',18),(43,'Process Goverance & Rpt','','',18),(44,'Trading App Development','','',19),(45,'Enterprise Application','','',19),(46,'Application Architecture','','',19),(47,'Client Segment Experience','','',20),(48,'User Experience & Accessibility','','',20),(49,'AP Product & Content Development','','',20),(50,'Client Insight & Decision Support','','',20),(51,'Investor Segment Experience','','',20),(52,'Trader Segment Analytics','','',20),(53,'CRM & Campaign Mgmt.','','',20),(54,'Digital Active Trader Solution','','',21),(55,'Digital Solutions','','',21),(56,'Digital Innovation','','',21),(57,'Bank Platform','','',21),(58,'Digital Management','','',21),(59,'Reputation & Public Relations','','',22),(60,'Marketing Services','','',22),(61,'Creativity','','',22),(62,'Integrated Marketing ','','',22),(63,'Social Media ','','',22),(64,'Web Marketing','','',23),(65,'Advertising','','',23),(66,'Purchased Mortgages','','',24),(67,'Commercial Lending','','',25),(68,'Documentation','','',26),(69,'National Sales','','',26),(70,'Corporate Development','','',26),(71,'Mortgage Operations','','',27),(72,'Lender City - Blvd Bk-Mortgage','','',27),(73,'Consumer Loans','','',28),(74,'Admin-Bank Administration','','',29),(75,'Collections','','',28),(76,'Outdoor Amusement','','',28),(77,'Credit Administration','','',30),(78,'Bank Corporate','','',30),(79,'Credit Risk Management','','',30),(80,'Bank Equipment Finance','','',30),(81,'Blvd Bk-Joplin Main Office ','','',30),(82,'Account Services','','',31),(83,'Retail Prod Srvcs','','',31),(84,'SAS Business Development','','',32),(85,'SAS Program & Product Services','','',32),(86,'SAS Client Services','','',32),(87,'Guidance Solutions','','',33),(88,'Strategy & Support ','','',33),(89,'Operational Controls','','',34),(90,'Corporate Actions','','',34),(91,'Operations Technology & Asset Transfers','','',34),(92,'Margin','','',34),(93,'New Accounts Maintenance','','',34),(94,'Special Operations ','','',34),(95,'Settlement Opr/Sec Finance','','',34),(96,'Brokerage Financial Analysis','','',35),(97,'Brokerage Financial Reporting','','',35),(98,'Branch Admin','','',36),(99,'Service Center','','',36),(100,'Trading Support','','',37),(101,'Clearing & Option Services','','',37),(102,'Brokerage Program','','',37),(103,'Market Data Operations','','',37),(104,'Fixed Income','','',37);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_function`
--

DROP TABLE IF EXISTS `department_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department_function` (
  `dept_func_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'A database internal representation of a department function.',
  `dept_func_nm` varchar(45) NOT NULL COMMENT 'The function name.',
  `dept_func_dsc` varchar(45) DEFAULT NULL COMMENT 'The department description.',
  `dept_team_id` int(11) NOT NULL,
  `in_blueworks_flg` char(1) DEFAULT 'N',
  PRIMARY KEY (`dept_func_id`),
  KEY `fk_dept_func_ref2_idx` (`dept_team_id`),
  CONSTRAINT `fk_dept_func_ref2` FOREIGN KEY (`dept_team_id`) REFERENCES `department_team` (`dept_team_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=361 DEFAULT CHARSET=utf8 COMMENT='The high level functions that a department performs corresponding to Business Processes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_function`
--

LOCK TABLES `department_function` WRITE;
/*!40000 ALTER TABLE `department_function` DISABLE KEYS */;
INSERT INTO `department_function` VALUES (1,'Credit & Market Risk',NULL,1,'N'),(2,'Debt Recovery',NULL,2,'Y'),(3,'Enterprise Fraud',NULL,3,'Y'),(4,'Regulatory Response',NULL,4,'N'),(5,'Operational Risk',NULL,5,'N'),(6,'AML',NULL,6,'Y'),(7,'AML Technology',NULL,7,'Y'),(8,'Internal Audit',NULL,8,'N'),(9,'IT Internal Audit',NULL,9,'N'),(10,'Compliance Services',NULL,10,'Y'),(11,'Compliance Research',NULL,11,'N'),(12,'Regulatory Affairs',NULL,12,'N'),(13,'Public Communications',NULL,13,'N'),(14,'Surveillance',NULL,14,'I'),(15,'Branch Audit',NULL,15,'Y'),(16,'Investigation & Resolution',NULL,16,'Y'),(17,'Corp & Sec',NULL,17,'N'),(18,'Legal Dept Operations',NULL,18,'N'),(19,'Litigation',NULL,19,'N'),(20,'Bank Risk',NULL,20,'N'),(21,'Loan Compliance',NULL,21,'N'),(22,'Consumer Bank Compliance',NULL,22,'Y'),(23,'Lending Compliance',NULL,23,'N'),(24,'Services',NULL,24,'N'),(25,'Software',NULL,25,'N'),(26,'Contract',NULL,26,'N'),(27,'Telecomm',NULL,27,'N'),(28,'Hardware',NULL,28,'N'),(29,'Finance',NULL,29,'N'),(30,'Finance',NULL,30,'N'),(31,'Tax Reporting',NULL,31,'N'),(32,'Tax Reporting',NULL,167,'N'),(33,'Treasury',NULL,32,'N'),(34,'Risk Modeling',NULL,33,'N'),(35,'Asset Management',NULL,34,'N'),(36,'Leased Asset',NULL,35,'N'),(37,'Bank Accounting',NULL,36,'N'),(38,'Financial Reporting',NULL,37,'N'),(39,'Equipment Finance',NULL,38,'N'),(40,'Accounts Payable',NULL,39,'N'),(41,'Job Costing',NULL,40,'N'),(42,'Fixed Asset',NULL,41,'N'),(43,'Recon',NULL,42,'N'),(44,'Financial Systems',NULL,43,'N'),(45,'Special Projects',NULL,44,'N'),(46,'Intranet',NULL,45,'N'),(47,'Graphic Design',NULL,46,'N'),(48,'Multimedia',NULL,47,'N'),(49,'Internal Communication',NULL,48,'N'),(50,'Building Operations',NULL,49,'N'),(51,'Meetings & Events',NULL,50,'N'),(52,'Travel Manager',NULL,51,'N'),(53,'Physical Security',NULL,52,'N'),(54,'Branch Facilities',NULL,53,'N'),(55,'Corporate Facilities',NULL,54,'N'),(56,'Facilities Management Systems',NULL,55,'N'),(57,'Real Estate',NULL,56,'N'),(58,'Receptionist',NULL,57,'N'),(59,'Benefits',NULL,58,'N'),(60,'Recruitment',NULL,58,'N'),(61,'Human Resources',NULL,58,'N'),(62,'HR Compliance',NULL,59,'N'),(63,'Compensation',NULL,60,'N'),(64,'Incentive Compensation',NULL,60,'N'),(65,'Benefits',NULL,60,'N'),(66,'Rewards & Recognition',NULL,60,'N'),(67,'Relocation',NULL,60,'N'),(68,'Talent Acquisition',NULL,58,'N'),(69,'FINRA',NULL,58,'N'),(70,'Instructional Design',NULL,61,'N'),(71,'Leadership Development Program',NULL,61,'N'),(72,'Content/QA',NULL,61,'N'),(73,'LMS',NULL,61,'N'),(74,'ILT',NULL,61,'N'),(75,'Reporting & Metrics',NULL,62,'N'),(76,'HRIS',NULL,62,'N'),(77,'Payroll',NULL,62,'N'),(78,'EUT Engineers',NULL,63,'N'),(79,'EUT Service Desk Technicians',NULL,63,'N'),(80,'EUT Workstation Technicians',NULL,63,'N'),(81,'End User Administration',NULL,63,'N'),(82,'Change Management',NULL,64,'N'),(83,'Service Delivery',NULL,65,'N'),(84,'Network Engineers',NULL,66,'N'),(85,'Network/Telecom Technicians',NULL,66,'N'),(86,'Information Security',NULL,67,'N'),(87,'Disaster Recovery',NULL,68,'N'),(88,'Business Continuity',NULL,68,'Y'),(89,'Network Security Engineers',NULL,67,'N'),(90,'Application Security Engineers',NULL,67,'N'),(91,'End Point Security Engineers',NULL,67,'N'),(92,'Vulnerability Assessment Engineers',NULL,67,'N'),(93,'Information Forensics',NULL,67,'N'),(94,'Telecom Engineers',NULL,69,'N'),(95,'Messaging & Collaboration Engineers',NULL,69,'N'),(96,'Monitoring Engineers',NULL,70,'N'),(97,'Infrastructure Soltuions Architect',NULL,71,'N'),(98,'Information Security Architect',NULL,71,'N'),(99,'Data Center Planning Engineers',NULL,72,'N'),(100,'Data Center Facilities Technician',NULL,72,'N'),(101,'IS Virtualization',NULL,73,'N'),(102,'IS Storage',NULL,73,'N'),(103,'SQL DBA',NULL,74,'N'),(104,'Windows System Support',NULL,75,'N'),(105,'Linux System Support',NULL,75,'N'),(106,'iSeries Administration',NULL,76,'N'),(107,'Computer Operations',NULL,76,'N'),(108,'Application Support',NULL,77,'N'),(109,'Build & Release',NULL,77,'N'),(110,'IT Administrative',NULL,78,'N'),(111,'IT Receptionist',NULL,78,'N'),(112,'Quality Assurance Testing',NULL,79,'N'),(113,'Quality Assurance',NULL,79,'N'),(114,'Quality Assurance Automation',NULL,79,'N'),(115,'Business Relationship Mgmt',NULL,80,'N'),(116,'Project Analysis',NULL,81,'N'),(117,'Project Management',NULL,81,'N'),(118,'Project Release Management',NULL,81,'N'),(119,'Technical Writer',NULL,82,'Y'),(120,'Business Systems Analysis',NULL,82,'Y'),(121,'Portfolio',NULL,83,'N'),(122,'Reporting',NULL,83,'N'),(123,'Web Development',NULL,84,'N'),(124,'DB Development',NULL,84,'N'),(125,'Mid-Tier Development',NULL,84,'N'),(126,'Web Development',NULL,85,'N'),(127,'Elite Development',NULL,85,'N'),(128,'Mobile Development',NULL,85,'N'),(129,'Scottrader Development',NULL,85,'N'),(130,'Back Office Development',NULL,85,'N'),(131,'Mid-Tier Development',NULL,85,'N'),(132,'Market Data Development',NULL,85,'N'),(133,'OMS Development',NULL,85,'N'),(134,'Development Services',NULL,86,'N'),(135,'Database Development',NULL,85,'N'),(136,'Data Modeling',NULL,85,'N'),(137,'Data Integration / ETL Development',NULL,85,'N'),(138,'Data Analysis',NULL,87,'N'),(139,'BI Development',NULL,87,'N'),(140,'Enterprise Application Development',NULL,88,'N'),(141,'Enterprise Application Systems Analysis',NULL,88,'N'),(142,'Enterprise Application Architect',NULL,88,'N'),(143,'Database Solution Architect',NULL,89,'N'),(144,'Backoffice Solution Architect',NULL,89,'N'),(145,'Solution Architect',NULL,89,'N'),(146,'Client Segment Experience',NULL,90,'N'),(147,'Research',NULL,91,'N'),(148,'Design',NULL,91,'N'),(149,'Investment Education',NULL,92,'N'),(150,'Content',NULL,92,'N'),(151,'Graphic Design',NULL,92,'N'),(152,'Product & Services',NULL,93,'N'),(153,'Marketing',NULL,93,'N'),(154,'Research',NULL,94,'N'),(155,'Marketing Analytics ',NULL,95,'N'),(156,'Equipment Finance Marketng',NULL,96,'N'),(157,'Investor Segment Analytics',NULL,97,'N'),(158,'Trader Segment Analytics',NULL,98,'N'),(159,'Unica Product',NULL,99,'N'),(160,'CRM',NULL,100,'N'),(161,'Elite Platform',NULL,101,'N'),(162,'Mobile Platform',NULL,102,'N'),(163,'Digital Innovation',NULL,103,'N'),(164,'Bank Platform',NULL,104,'N'),(165,'Client App & Support Prod',NULL,105,'Y'),(166,'Client Website Platform',NULL,106,'N'),(167,'Scottrader Platform',NULL,107,'N'),(168,'Public Relations',NULL,108,'N'),(169,'Marketing Project Management',NULL,109,'N'),(170,'Marketing Compliance',NULL,110,'N'),(171,'Design',NULL,111,'N'),(172,'Design',NULL,112,'N'),(173,'Design',NULL,113,'N'),(174,'Content Analytics',NULL,114,'N'),(175,'Content Strategy',NULL,114,'N'),(176,'Account Communication',NULL,114,'N'),(177,'Integrated Marketing ',NULL,115,'N'),(178,'Social Communication',NULL,116,'N'),(179,'WCM Analytics',NULL,117,'N'),(180,'SEO Analytics',NULL,118,'N'),(181,'Email Analytics',NULL,119,'N'),(182,'Web Analytics',NULL,120,'N'),(183,'Digital Marketing Analytics',NULL,121,'N'),(184,'Display',NULL,122,'N'),(185,'Media',NULL,123,'N'),(186,'Search Analytics',NULL,124,'N'),(187,'Correspondent Relationship',NULL,125,'N'),(188,'Financial Analytics ',NULL,126,'N'),(189,'Financial Analytics ',NULL,148,'N'),(190,'Analytics',NULL,127,'N'),(191,'Coordination',NULL,128,'N'),(192,'Inside Sales',NULL,129,'N'),(193,'Inside Sales',NULL,132,'N'),(194,'Documentation',NULL,130,'N'),(195,'Business Developmnt',NULL,131,'N'),(196,'Capital Markets',NULL,133,'N'),(197,'Loan Officer',NULL,134,'N'),(198,'Loan Processing',NULL,135,'N'),(199,'Loan Officer',NULL,136,'N'),(200,'Loan Officer',NULL,137,'N'),(201,'Loan Processing',NULL,138,'N'),(202,'Loan Processing',NULL,145,'N'),(203,'Loan Quality Control',NULL,138,'N'),(204,'Loan Quality Control',NULL,145,'N'),(205,'Administrative',NULL,139,'N'),(206,'Collector',NULL,140,'N'),(207,'Loan Portfolio',NULL,141,'N'),(208,'Loan OFC',NULL,142,'N'),(209,'Administrative',NULL,143,'N'),(210,'Legal Collatreral Resol',NULL,144,'N'),(211,'Mortgage Closing / Processing',NULL,146,'N'),(212,'Compliance',NULL,147,'N'),(213,'Analytics',NULL,126,'N'),(214,'Analytics',NULL,148,'N'),(215,'Analytics',NULL,149,'N'),(216,'Analytics',NULL,150,'N'),(217,'Analytics',NULL,151,'N'),(218,'Operations',NULL,152,'N'),(219,'Loan Servicing',NULL,152,'N'),(220,'Retail Bank Operations',NULL,153,'Y'),(221,'Retail Bank Operations',NULL,154,'Y'),(222,'Retail Bank Strategy Performance Analytics',NULL,153,'Y'),(223,'Retail Bank Strategy Performance Analytics',NULL,154,'Y'),(224,'Business Dev',NULL,155,'N'),(225,'SAS Product Dev',NULL,156,'N'),(226,'SAS Product Integration',NULL,156,'N'),(227,'SAS Platform',NULL,156,'N'),(228,'Managed Inv. Solutions',NULL,156,'N'),(229,'Ops Solutions Analytics',NULL,157,'N'),(230,'SAS Oversight',NULL,157,'N'),(231,'Transition Services',NULL,157,'I'),(232,'SAS Acct Services',NULL,157,'I'),(233,'Relationship Management',NULL,158,'Y'),(234,'Guidance',NULL,159,'N'),(235,'Brokerage Strategy',NULL,160,'N'),(236,'Analytics & Comp Intel',NULL,160,'N'),(237,'Client Fullfillment & Implementation',NULL,161,'N'),(238,'Client Offer Management',NULL,161,'Y'),(239,'Brokerage Strategy Campaign',NULL,162,'N'),(240,'Mutual Funds & ETFs',NULL,163,'N'),(241,'Mutual Funds & ETFs',NULL,164,'N'),(242,'Portfolio Mgmt Strategy',NULL,163,'N'),(243,'Portfolio Mgmt Strategy',NULL,164,'N'),(244,'Active Trader Strategy',NULL,163,'N'),(245,'Active Trader Strategy',NULL,164,'N'),(246,'Product Dev & Analytics',NULL,163,'N'),(247,'Product Dev & Analytics',NULL,164,'N'),(248,'Analytics',NULL,165,'N'),(249,'Special Handling',NULL,166,'Y'),(250,'IRA',NULL,166,'Y'),(251,'Identity Verification',NULL,166,'Y'),(252,'Tax Reporting',NULL,31,'Y'),(253,'Tax Reporting',NULL,167,'Y'),(254,'Cost Basis',NULL,31,'Y'),(255,'Cost Basis',NULL,167,'Y'),(256,'Dividends',NULL,168,'Y'),(257,'Reorganization',NULL,168,'Y'),(258,'Enterprise Content Manager',NULL,169,'N'),(259,'Print Production',NULL,170,'N'),(260,'Mailroom',NULL,170,'N'),(261,'Supplies Purchasing',NULL,171,'N'),(262,'Internal Supply',NULL,172,'N'),(263,'Ops Processing',NULL,172,'N'),(264,'Shipping & Receiving',NULL,172,'N'),(265,'Back Office Automation',NULL,173,'N'),(266,'Back Office Analytics',NULL,173,'N'),(267,'Data Governance',NULL,174,'N'),(268,'Privacy',NULL,174,'N'),(269,'Tailored Services',NULL,175,'Y'),(270,'Tailored Services',NULL,183,'Y'),(271,'Account Services',NULL,175,'Y'),(272,'Account Services',NULL,183,'Y'),(273,'Support Center',NULL,175,'Y'),(274,'Support Center',NULL,183,'Y'),(275,'Options First',NULL,176,'Y'),(276,'AP Account Maintenance',NULL,175,'Y'),(277,'AP Account Maintenance',NULL,183,'Y'),(278,'AP New Account',NULL,175,'Y'),(279,'AP New Account',NULL,183,'Y'),(280,'Middle Office',NULL,175,'Y'),(281,'Middle Office',NULL,183,'Y'),(282,'Transfer In',NULL,177,'Y'),(283,'Transfer Out',NULL,177,'Y'),(284,'Stock Transfer',NULL,177,'Y'),(285,'Cashless Stock Options',NULL,177,'Y'),(286,'Follow Up',NULL,177,'Y'),(287,'Claims Settlement',NULL,177,'Y'),(288,'Securities Processing',NULL,178,'Y'),(289,'Stock Receipt',NULL,178,'Y'),(290,'Large Quantity',NULL,178,'Y'),(291,'Physical Transfer',NULL,178,'Y'),(292,'Image Processing',NULL,179,'Y'),(293,'Image Research',NULL,179,'Y'),(294,'Margin',NULL,180,'Y'),(295,'Cashiering',NULL,180,'Y'),(296,'Margin Process Audit',NULL,180,'N'),(297,'Bank Deposit Program',NULL,181,'Y'),(298,'Complex Options Margin/Risk',NULL,182,'N'),(299,'Check Writing',NULL,181,'Y'),(300,'Money Direct',NULL,181,'Y'),(301,'Wire Transfer',NULL,181,'Y'),(302,'Back Office Operations',NULL,184,'N'),(303,'Stock Record Fail Control',NULL,185,'I'),(304,'Stock Record Buy In',NULL,185,'I'),(305,'Stock Record Settlement',NULL,185,'I'),(306,'Reconciliation',NULL,185,'Y'),(307,'Mutual Fund Trade Reconciliation',NULL,185,'Y'),(308,'Mutual Fund Networking Reconciliation',NULL,186,'Y'),(309,'Mutual Fund Networking',NULL,186,'Y'),(310,'Mutual Fund Product',NULL,186,'Y'),(311,'Mutual Fund SERV/Trader',NULL,186,'Y'),(312,'Mutual ACAT Out',NULL,186,'Y'),(313,'Sec Lending Sales Trader',NULL,187,'I'),(314,'Sec Lending Ops',NULL,188,'I'),(315,'Analytics',NULL,189,'N'),(316,'Reporting',NULL,190,'N'),(317,'Branch',NULL,191,'I'),(318,'Client Srvcs Bus Process',NULL,192,'N'),(319,'Client Relations',NULL,193,'N'),(320,'Branch Support',NULL,193,'I'),(321,'Branch Inventive Oversight',NULL,193,'N'),(322,'Broker',NULL,194,'N'),(323,'Technician',NULL,194,'N'),(324,'Workforce Planning',NULL,195,'N'),(325,'SC Workforce',NULL,196,'N'),(326,'Analytics',NULL,197,'N'),(327,'Financial Service Representative',NULL,198,'N'),(328,'Customer Service',NULL,199,'N'),(329,'Customer Support',NULL,200,'N'),(330,'SC Business Analytics',NULL,201,'N'),(331,'Service Center Quality',NULL,202,'N'),(332,'Bank Customer Service',NULL,203,'N'),(333,'Chat',NULL,204,'Y'),(334,'Email',NULL,204,'Y'),(335,'Active Trader',NULL,205,'N'),(336,'Options First Application',NULL,206,'N'),(337,'SC Technician',NULL,207,'N'),(338,'AP Quality',NULL,194,'N'),(339,'AP Training',NULL,194,'N'),(340,'Execution Quality Analytics',NULL,208,'I'),(341,'Trading Srvcs Clearing',NULL,209,'Y'),(342,'Deriv Mkt Structure Analytics',NULL,209,'Y'),(343,'Option Analytics',NULL,209,'Y'),(344,'Fixed Income',NULL,210,'Y'),(345,'Clearing',NULL,210,'Y'),(346,'Purchase & Sales',NULL,210,'Y'),(347,'Trading Support',NULL,211,'I'),(348,'Trading Services',NULL,211,'I'),(349,'Security Master',NULL,211,'Y'),(350,'OATS',NULL,211,'Y'),(351,'Brokerage Program Director',NULL,212,'N'),(352,'Reporting Services',NULL,213,'I'),(353,'Trding Services Regulatory',NULL,214,'I'),(354,'Market Data Business',NULL,215,'Y'),(355,'Market Data Compliance',NULL,216,'Y'),(356,'Market Data Quality',NULL,217,'Y'),(357,'Analytics',NULL,218,'Y'),(358,'Fixed Income',NULL,218,'Y'),(359,'Special Order Handling',NULL,219,'I'),(360,'Trading Support',NULL,219,'I');
/*!40000 ALTER TABLE `department_function` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_position`
--

DROP TABLE IF EXISTS `department_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department_position` (
  `dept_posn_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'A database internal representation of a department position.',
  `dept_posn_nm` varchar(45) NOT NULL COMMENT 'The department position name.',
  `dept_posn_dsc` varchar(250) NOT NULL COMMENT 'The department position description.',
  `dept_id` int(11) NOT NULL COMMENT 'The department.',
  PRIMARY KEY (`dept_posn_id`),
  KEY `fk_dept_postions_ref1_idx` (`dept_id`),
  CONSTRAINT `fk_dept_postions_ref1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The job positions within a department.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_position`
--

LOCK TABLES `department_position` WRITE;
/*!40000 ALTER TABLE `department_position` DISABLE KEYS */;
/*!40000 ALTER TABLE `department_position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_team`
--

DROP TABLE IF EXISTS `department_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department_team` (
  `dept_team_id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_team_nm` varchar(45) NOT NULL,
  `dept_team_dsc` varchar(1000) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `dept_team_con_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`dept_team_id`),
  KEY `fk_dept_team_ref1_idx` (`dept_id`),
  KEY `fk_dept_team_ref2_idx` (`dept_team_con_id`),
  CONSTRAINT `fk_dept_team_ref1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_dept_team_ref2` FOREIGN KEY (`dept_team_con_id`) REFERENCES `contact` (`con_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=utf8 COMMENT='Table to store the teams in a department.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_team`
--

LOCK TABLES `department_team` WRITE;
/*!40000 ALTER TABLE `department_team` DISABLE KEYS */;
INSERT INTO `department_team` VALUES (1,'Credit & Market Risk',NULL,1,NULL),(2,'Debt Recovery',NULL,2,NULL),(3,'Enterprise Fraud',NULL,2,NULL),(4,'Regulatory Response',NULL,3,NULL),(5,'Operational Risk',NULL,3,NULL),(6,'AML',NULL,4,NULL),(7,'AML Technology',NULL,4,NULL),(8,'Internal Audit',NULL,5,NULL),(9,'IT Internal Audit',NULL,5,NULL),(10,'Compliance Services',NULL,6,NULL),(11,'Compliance Research',NULL,6,NULL),(12,'Regulatory Affairs',NULL,7,NULL),(13,'Public Communications',NULL,7,NULL),(14,'Surveillance',NULL,8,NULL),(15,'Branch Audit',NULL,8,NULL),(16,'Investigation & Resolution',NULL,9,NULL),(17,'Corp & Sec',NULL,9,NULL),(18,'Legal Dept Operations',NULL,9,NULL),(19,'Litigation',NULL,9,NULL),(20,'Bank Risk',NULL,10,NULL),(21,'Loan Compliance',NULL,10,NULL),(22,'Consumer Bank Compliance',NULL,10,NULL),(23,'Lending Compliance',NULL,10,NULL),(24,'Services',NULL,11,NULL),(25,'Software',NULL,11,NULL),(26,'Contract',NULL,11,NULL),(27,'Telecomm',NULL,11,NULL),(28,'Hardware',NULL,11,NULL),(29,'Finance',NULL,12,NULL),(30,'Finance',NULL,15,NULL),(31,'Tax Reporting',NULL,13,NULL),(32,'Treasury',NULL,14,NULL),(33,'Risk Modeling',NULL,14,NULL),(34,'Asset Management',NULL,16,NULL),(35,'Leased Asset',NULL,16,NULL),(36,'Bank Accounting',NULL,17,NULL),(37,'Financial Reporting',NULL,18,NULL),(38,'Equipment Finance',NULL,19,NULL),(39,'Accounts Payable',NULL,20,NULL),(40,'Job Costing',NULL,21,NULL),(41,'Fixed Asset',NULL,22,NULL),(42,'Recon',NULL,23,NULL),(43,'Financial Systems',NULL,24,NULL),(44,'Special Projects',NULL,25,NULL),(45,'Intranet',NULL,26,NULL),(46,'Graphic Design',NULL,26,NULL),(47,'Multimedia',NULL,26,NULL),(48,'Internal Communication',NULL,27,NULL),(49,'Building Operations',NULL,28,NULL),(50,'Meetings & Events',NULL,28,NULL),(51,'Travel Manager',NULL,28,NULL),(52,'Physical Security',NULL,28,NULL),(53,'Branch Facilities',NULL,28,NULL),(54,'Corporate Facilities',NULL,28,NULL),(55,'Facilities Management Systems',NULL,28,NULL),(56,'Real Estate',NULL,28,NULL),(57,'Receptionist',NULL,29,NULL),(58,'HR Business Partner',NULL,30,NULL),(59,'HR Compliance',NULL,30,NULL),(60,'Total Rewards',NULL,30,NULL),(61,'Learning & Development',NULL,30,NULL),(62,'HR Operations',NULL,30,NULL),(63,'End User Technology',NULL,31,NULL),(64,'Change Management',NULL,31,NULL),(65,'Service Delivery',NULL,31,NULL),(66,'Networking',NULL,32,NULL),(67,'IT Security',NULL,32,NULL),(68,'Bus Continuity & Disaster Rec.',NULL,32,NULL),(69,'IT Communications',NULL,32,NULL),(70,'Enterpr Monitoring & Capacity',NULL,33,NULL),(71,'Infrastructure Architecture',NULL,33,NULL),(72,'Data Center Facilities',NULL,34,NULL),(73,'Storage Administration',NULL,35,NULL),(74,'Database Administration',NULL,35,NULL),(75,'Server Administration',NULL,35,NULL),(76,'Computer Operations',NULL,36,NULL),(77,'Application Support',NULL,37,NULL),(78,'IT Administrative',NULL,38,NULL),(79,'Quality Assurance',NULL,39,NULL),(80,'Business Relationship Mgmt',NULL,40,NULL),(81,'Project Management',NULL,41,NULL),(82,'Business Systems Analysis',NULL,42,NULL),(83,'Process Goverance & Rpt',NULL,43,NULL),(84,'Advisor Services Development',NULL,44,NULL),(85,'Development',NULL,44,NULL),(86,'Mid-Tier/OMS',NULL,44,NULL),(87,'Business Intelligence',NULL,45,NULL),(88,'Enterprise Application',NULL,45,NULL),(89,'Development Architects',NULL,46,NULL),(90,'Client Segment Experience',NULL,47,NULL),(91,'User Experience',NULL,48,NULL),(92,'Content Development',NULL,49,NULL),(93,'Product Development',NULL,49,NULL),(94,'Marketing & Customer Experience',NULL,50,NULL),(95,'Marketing Analytics ',NULL,50,NULL),(96,'Equipment Finance Marketng',NULL,51,NULL),(97,'Investor Segment Analytics',NULL,51,NULL),(98,'Trader Segment Analytics',NULL,52,NULL),(99,'Unica Product',NULL,53,NULL),(100,'CRM',NULL,53,NULL),(101,'Elite Platform',NULL,54,NULL),(102,'Mobile Platform',NULL,55,NULL),(103,'Digital Innovation',NULL,56,NULL),(104,'Bank Platform',NULL,57,NULL),(105,'Client App & Support Prod',NULL,58,NULL),(106,'Client Website Platform',NULL,58,NULL),(107,'Scottrader Platform',NULL,58,NULL),(108,'Public Relations',NULL,59,NULL),(109,'Marketing Project Management',NULL,60,NULL),(110,'Marketing Compliance',NULL,60,NULL),(111,'Digital Web Marketing',NULL,61,NULL),(112,'Creative Services',NULL,61,NULL),(113,'Digital Advertising',NULL,61,NULL),(114,'Content Strategy',NULL,61,NULL),(115,'Integrated Marketing ',NULL,62,NULL),(116,'Social Communication',NULL,63,NULL),(117,'WCM',NULL,64,NULL),(118,'SEO',NULL,64,NULL),(119,'Email ',NULL,64,NULL),(120,'Web',NULL,64,NULL),(121,'Digital Marketing',NULL,64,NULL),(122,'Display & Programmatic',NULL,65,NULL),(123,'Media',NULL,65,NULL),(124,'SEM & Social Advertising',NULL,65,NULL),(125,'Correspondent Relationship',NULL,66,NULL),(126,'Financial Analytics ',NULL,66,NULL),(127,'Commercial Credit',NULL,67,NULL),(128,'Commercial Loan',NULL,67,NULL),(129,'Inside Sales',NULL,68,NULL),(130,'Documentation',NULL,68,NULL),(131,'Business Developmnt',NULL,69,NULL),(132,'Inside Sales',NULL,69,NULL),(133,'Capital Markets',NULL,70,NULL),(134,'Lock Dsk/Mrtgage',NULL,71,NULL),(135,'Conforming Mortgage Loans',NULL,72,NULL),(136,'InDirect Consumer Loan',NULL,73,NULL),(137,'Jr Loan Officer - Consumer',NULL,73,NULL),(138,'Loan Processing',NULL,73,NULL),(139,'Bank Administrative',NULL,74,NULL),(140,'Collector',NULL,75,NULL),(141,'Loan Portfolio',NULL,76,NULL),(142,'Loan OFC',NULL,76,NULL),(143,'Office Administration',NULL,76,NULL),(144,'Legal Collatreral Resol',NULL,75,NULL),(145,'Loan Processing',NULL,77,NULL),(146,'Mortgage Closing / Processing',NULL,77,NULL),(147,'Compliance',NULL,77,NULL),(148,'Financial Analytics ',NULL,78,NULL),(149,'Credit Risk',NULL,79,NULL),(150,'Loan Review',NULL,79,NULL),(151,'Credit Anlaysis',NULL,80,NULL),(152,'Operations & Retail',NULL,81,NULL),(153,'Retail Banking',NULL,82,NULL),(154,'Retail Banking',NULL,83,NULL),(155,'Business Dev',NULL,84,NULL),(156,'SAS Prgms & Prod Strategy',NULL,85,NULL),(157,'SAS Acct and Trans Svc',NULL,86,NULL),(158,'SAS Relations',NULL,86,NULL),(159,'Guidance',NULL,87,NULL),(160,'Brokerage Strgy & Bus Plan',NULL,88,NULL),(161,'Brokerage Implementation',NULL,88,NULL),(162,'Sales Strategy',NULL,88,NULL),(163,'Brokerage Product',NULL,87,NULL),(164,'Brokerage Product',NULL,88,NULL),(165,'Operational Controls',NULL,89,NULL),(166,'Special Handling IVT',NULL,89,NULL),(167,'Tax Reporting',NULL,90,NULL),(168,'Dividends/Reorganization',NULL,90,NULL),(169,'Enterprise Content Manager',NULL,91,NULL),(170,'Mailroom',NULL,91,NULL),(171,'Supplies',NULL,91,NULL),(172,'Logistics',NULL,91,NULL),(173,'Back Office Opr Analytics',NULL,91,NULL),(174,'Privacy & Data Goverance',NULL,91,NULL),(175,'Account Operations',NULL,91,NULL),(176,'Options First-Operations',NULL,91,NULL),(177,'ACATS',NULL,91,NULL),(178,'Securities Processing',NULL,91,NULL),(179,'Image Processing/Research',NULL,91,NULL),(180,'Margin & Cashiering',NULL,92,NULL),(181,'Check Writing/Money Direct',NULL,92,NULL),(182,'Complex Options Margin/Risk',NULL,92,NULL),(183,'Account Operations',NULL,93,NULL),(184,'Back Office Operations',NULL,94,NULL),(185,'Stock Record',NULL,95,NULL),(186,'Mutual Funds',NULL,95,NULL),(187,'Securities Lending Trading',NULL,95,NULL),(188,'Securities Lending Ops ',NULL,95,NULL),(189,'Brokerage Financial Analysis',NULL,96,NULL),(190,'Brokerage Financial Reporting',NULL,97,NULL),(191,'Branch',NULL,98,NULL),(192,'Client Srvcs Bus Process',NULL,98,NULL),(193,'Client Services Support',NULL,98,NULL),(194,'AP Call Center',NULL,99,NULL),(195,'Workforce Planning',NULL,99,NULL),(196,'SC Workforce',NULL,99,NULL),(197,'Call Center Reporting Analytics',NULL,99,NULL),(198,'Financial Service Representative',NULL,99,NULL),(199,'Customer Service',NULL,99,NULL),(200,'Customer Support',NULL,99,NULL),(201,'SC Business Analytics',NULL,99,NULL),(202,'Service Center Quality',NULL,99,NULL),(203,'Bank Customer Service',NULL,99,NULL),(204,'Chat & Email',NULL,99,NULL),(205,'Active Trader',NULL,99,NULL),(206,'Options First Application',NULL,99,NULL),(207,'SC Technician',NULL,99,NULL),(208,'Execution Quality Analytics',NULL,100,NULL),(209,'Options',NULL,101,NULL),(210,'Purchase & Sales',NULL,101,NULL),(211,'Trading Operations',NULL,100,NULL),(212,'Brokerage Program Director',NULL,102,NULL),(213,'Reporting Services',NULL,100,NULL),(214,'Trding Services Regulatory',NULL,100,NULL),(215,'Market Data Business',NULL,103,NULL),(216,'Market Data Compliance',NULL,103,NULL),(217,'Market Data Quality',NULL,103,NULL),(218,'Fixed Income',NULL,104,NULL),(219,'Trading Infrastructure',NULL,100,NULL);
/*!40000 ALTER TABLE `department_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dg_app_execution_contol`
--

DROP TABLE IF EXISTS `dg_app_execution_contol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dg_app_execution_contol` (
  `dg_exec_cntrl_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Database internal representation of an execution control.',
  `log_page_hits` int(10) unsigned NOT NULL COMMENT '0 or 1 if we need to build performance charts on page hits.',
  `log_level` varchar(45) NOT NULL COMMENT 'SLF4J logger level string.',
  `log_user_stats` int(11) NOT NULL COMMENT '0 or 1 to log user metrics.  New users signed up in a day.  Or, count based on user role level.',
  PRIMARY KEY (`dg_exec_cntrl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for the entire application to store flags that denote logging levels, page hit counts.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dg_app_execution_contol`
--

LOCK TABLES `dg_app_execution_contol` WRITE;
/*!40000 ALTER TABLE `dg_app_execution_contol` DISABLE KEYS */;
/*!40000 ALTER TABLE `dg_app_execution_contol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dg_app_user`
--

DROP TABLE IF EXISTS `dg_app_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dg_app_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The application internal representation of a User.',
  `user_nm` varchar(45) NOT NULL COMMENT 'The user name chosen by the User.',
  `user_pwd` varchar(45) NOT NULL COMMENT 'The password chosen by the User.',
  `user_first_nm` varchar(45) NOT NULL COMMENT 'The first name of the User.',
  `user_last_nm` varchar(45) NOT NULL COMMENT 'The last name of the User.',
  `user_nick_nm` varchar(45) DEFAULT NULL COMMENT 'The display name of the User.',
  `user_email_id` varchar(300) NOT NULL COMMENT 'The email address of the User.',
  `user_role_id` int(11) NOT NULL,
  `create_tsp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The date and time the user was created.',
  `last_mod_user_id` int(11) NOT NULL,
  `last_mod_tsp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'The last modification date time of the user record.',
  `last_pwd_chg_tsp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date and time the user last changed the password.',
  PRIMARY KEY (`user_id`),
  KEY `fk_dg_user_role_ref` (`user_role_id`),
  CONSTRAINT `fk_dg_user_role_ref` FOREIGN KEY (`user_role_id`) REFERENCES `dg_app_user_role` (`user_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Table stores user information for the frontend application.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dg_app_user`
--

LOCK TABLES `dg_app_user` WRITE;
/*!40000 ALTER TABLE `dg_app_user` DISABLE KEYS */;
INSERT INTO `dg_app_user` VALUES (1,'rnandakumar','RaghuRaghu','Raghu','Nandakumar','Raghu','rnandakumar@scottrade.com',1,'2014-05-14 22:10:08',1,'2014-05-14 22:10:08','2014-05-14 22:10:08');
/*!40000 ALTER TABLE `dg_app_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dg_app_user_role`
--

DROP TABLE IF EXISTS `dg_app_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dg_app_user_role` (
  `user_role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The internal representation ID for a User Role.',
  `user_role_nm` varchar(45) NOT NULL COMMENT 'The name of the role that the User has access to.',
  `user_role_dsc` varchar(45) NOT NULL COMMENT 'The description of the role name.',
  `create_tsp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The date and time the user was created.',
  `create_user_id` int(11) NOT NULL,
  `last_mod_tsp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'The last modification date time of the user record.',
  `last_mod_user_id` int(11) NOT NULL,
  PRIMARY KEY (`user_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='The roles and permissions the user is granted for this Data Governance application.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dg_app_user_role`
--

LOCK TABLES `dg_app_user_role` WRITE;
/*!40000 ALTER TABLE `dg_app_user_role` DISABLE KEYS */;
INSERT INTO `dg_app_user_role` VALUES (1,'DG_ROLE','Data Governance role, that opens up all appli','2014-05-14 22:07:11',1,'2014-05-14 22:07:11',1);
/*!40000 ALTER TABLE `dg_app_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_business_division`
--

DROP TABLE IF EXISTS `enterprise_business_division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_business_division` (
  `business_division_id` int(11) NOT NULL AUTO_INCREMENT,
  `business_division_nm` varchar(45) NOT NULL,
  `business_division_dsc` varchar(250) DEFAULT NULL,
  `business_line_id` int(11) NOT NULL,
  PRIMARY KEY (`business_division_id`),
  KEY `fk_business_division_ref1_idx` (`business_line_id`),
  CONSTRAINT `fk_business_division_ref1` FOREIGN KEY (`business_line_id`) REFERENCES `enterprise_business_line` (`business_line_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='The business division under the line of business.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_business_division`
--

LOCK TABLES `enterprise_business_division` WRITE;
/*!40000 ALTER TABLE `enterprise_business_division` DISABLE KEYS */;
INSERT INTO `enterprise_business_division` VALUES (1,'Legal & Compliance',NULL,1),(2,'Finance Division',NULL,1),(3,'Special Projects',NULL,1),(4,'Administration',NULL,1),(5,'Information Technology',NULL,1),(6,'Marketing',NULL,1),(7,'Bank Division',NULL,2),(8,'Brokerage Division',NULL,3);
/*!40000 ALTER TABLE `enterprise_business_division` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_business_group`
--

DROP TABLE IF EXISTS `enterprise_business_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_business_group` (
  `business_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_nm` varchar(100) NOT NULL,
  `group_dsc` varchar(2000) DEFAULT NULL,
  `business_division_id` int(11) NOT NULL,
  PRIMARY KEY (`business_group_id`),
  KEY `fk_busi_group_ref_1_idx` (`business_division_id`),
  CONSTRAINT `fk_busi_group_ref_1` FOREIGN KEY (`business_division_id`) REFERENCES `enterprise_business_division` (`business_division_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='Table that stores enterprise business group.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_business_group`
--

LOCK TABLES `enterprise_business_group` WRITE;
/*!40000 ALTER TABLE `enterprise_business_group` DISABLE KEYS */;
INSERT INTO `enterprise_business_group` VALUES (1,'Enterprise Risk - SFS',NULL,1),(2,'Internal Audit-SFS',NULL,1),(3,'Compliance',NULL,1),(4,'Legal',NULL,1),(5,'Bank Compliance',NULL,1),(6,'Procurement',NULL,2),(7,'Corporate Finance',NULL,2),(8,'Tax',NULL,2),(9,'Investment & Treasury',NULL,2),(10,'Bank Finance',NULL,2),(11,'Accounting',NULL,2),(12,'Special Projects',NULL,3),(13,'Corporate Communications',NULL,4),(14,'Corporate Facilities',NULL,4),(15,'Admin-People Services',NULL,4),(16,'People Services',NULL,4),(17,'Technology',NULL,5),(18,'Bus Relation & System',NULL,5),(19,'IT Development',NULL,5),(20,'Client Segments & Exper',NULL,6),(21,'Digital Solutions',NULL,6),(22,'External Communications',NULL,6),(23,'Digital Marketing',NULL,6),(24,'Bank Purchased Mortgages',NULL,7),(25,'Commercial Lending',NULL,7),(26,'Bank Equipment Finance',NULL,7),(27,'Mortgage Lending',NULL,7),(28,'Consumer Lending',NULL,7),(29,'Admin-Bank Administration',NULL,7),(30,'Operations',NULL,7),(31,'Retail Operations',NULL,7),(32,'Advisor Services',NULL,8),(33,'Brokerage Strategy & Prod',NULL,8),(34,'Brokerage Operations',NULL,8),(35,'Brokerage Finance',NULL,8),(36,'Brokerage Client Services',NULL,8),(37,'Trading Services & Program Management',NULL,8);
/*!40000 ALTER TABLE `enterprise_business_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_business_line`
--

DROP TABLE IF EXISTS `enterprise_business_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_business_line` (
  `business_line_id` int(11) NOT NULL AUTO_INCREMENT,
  `line_nm` varchar(45) NOT NULL,
  `line_dsc` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`business_line_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='The line of business within the entreprise.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_business_line`
--

LOCK TABLES `enterprise_business_line` WRITE;
/*!40000 ALTER TABLE `enterprise_business_line` DISABLE KEYS */;
INSERT INTO `enterprise_business_line` VALUES (1,'Corporate',NULL),(2,'Bank',NULL),(3,'Brokerage',NULL);
/*!40000 ALTER TABLE `enterprise_business_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `owner_info`
--

DROP TABLE IF EXISTS `owner_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `owner_info` (
  `owner_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'An internal representation that uniquely identifies an owner across the entreprise.',
  `owner_nm` varchar(100) NOT NULL COMMENT 'The full name of the owner.',
  `owner_typ_id` int(11) NOT NULL COMMENT 'This is a column that identifies an owner by type, within data governance scope.',
  `owner_title` varchar(45) NOT NULL,
  `dept_id` int(11) NOT NULL COMMENT 'The department of the Owner.',
  `owner_email_id` varchar(100) DEFAULT NULL COMMENT 'The email address of the owner.',
  `owner_contact_info_txt` varchar(1000) DEFAULT NULL COMMENT 'Any contact info for the owner.  Free form text.',
  `dept_posn_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`owner_id`),
  KEY `fk_owner_info_ref_1` (`dept_id`),
  KEY `fk_owner_info_ref_2` (`owner_typ_id`),
  KEY `fk_owner_info_ref_3_idx` (`dept_posn_id`),
  CONSTRAINT `fk_owner_info_ref_1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`),
  CONSTRAINT `fk_owner_info_ref_2` FOREIGN KEY (`owner_typ_id`) REFERENCES `owner_type` (`owner_typ_id`),
  CONSTRAINT `fk_owner_info_ref_3` FOREIGN KEY (`dept_posn_id`) REFERENCES `department_position` (`dept_posn_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table to collect ALL owner information within data govenance scope.  A Owner is a person (within the data govenance scope) who assumes responsibility for an application or business process.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owner_info`
--

LOCK TABLES `owner_info` WRITE;
/*!40000 ALTER TABLE `owner_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `owner_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `owner_type`
--

DROP TABLE IF EXISTS `owner_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `owner_type` (
  `owner_typ_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The internal representation number that uniquely identifies an owner type.',
  `owner_typ_cd` varchar(3) DEFAULT NULL COMMENT 'A 3 character type code that is uniquely assigned to as owner type.  At this time of table creation, we have DEO (Data Entity Owner), BPO (Business Process Owner), BAO (Business Application Owner), ITO (IT Application Owner).',
  `owner_typ_defn` varchar(100) DEFAULT NULL COMMENT 'A short definition on what the roles of this type is.',
  `owner_typ_dsc` varchar(250) DEFAULT NULL COMMENT 'An explanation on what this ownership governs.',
  PRIMARY KEY (`owner_typ_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table to store different owner types identified for data governance.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owner_type`
--

LOCK TABLES `owner_type` WRITE;
/*!40000 ALTER TABLE `owner_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `owner_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'thoward333','Trey','Howard'),(2,'joeherbers','Joe','Herbers'),(3,'jdoe','John','Doe'),(4,'r','rrr','lrrrr'),(5,'ddd','ddddd','ddddddd');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rlshp_dataentity_appl`
--

DROP TABLE IF EXISTS `rlshp_dataentity_appl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rlshp_dataentity_appl` (
  `app_entity_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The internal reference for an application, entity relationship record.',
  `appl_id` int(11) NOT NULL COMMENT 'The application ID.',
  `entity_id` int(11) NOT NULL COMMENT 'The data entity id.',
  PRIMARY KEY (`app_entity_id`),
  KEY `fk_appl_entity_rlshp_ref_1` (`appl_id`),
  KEY `fk_appl_entity_rlshp_ref_2` (`entity_id`),
  CONSTRAINT `fk_appl_entity_rlshp_ref_1` FOREIGN KEY (`appl_id`) REFERENCES `application_master` (`appl_id`),
  CONSTRAINT `fk_appl_entity_rlshp_ref_2` FOREIGN KEY (`entity_id`) REFERENCES `data_entity_master` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table to store application and entity relationships.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rlshp_dataentity_appl`
--

LOCK TABLES `rlshp_dataentity_appl` WRITE;
/*!40000 ALTER TABLE `rlshp_dataentity_appl` DISABLE KEYS */;
/*!40000 ALTER TABLE `rlshp_dataentity_appl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rlshp_dataentity_busprcs`
--

DROP TABLE IF EXISTS `rlshp_dataentity_busprcs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rlshp_dataentity_busprcs` (
  `bp_entity_rlshp_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The internal representation of a business process.',
  `bp_id` int(11) NOT NULL COMMENT 'The business process.',
  `entity_id` int(11) NOT NULL COMMENT 'The data entity id.',
  PRIMARY KEY (`bp_entity_rlshp_id`),
  KEY `fk_bp_entity_rlshp_ref_1` (`bp_id`),
  KEY `fk_bp_entity_rlshp_ref_2` (`entity_id`),
  CONSTRAINT `fk_bp_entity_rlshp_ref_1` FOREIGN KEY (`bp_id`) REFERENCES `business_process` (`bp_id`),
  CONSTRAINT `fk_bp_entity_rlshp_ref_2` FOREIGN KEY (`entity_id`) REFERENCES `data_entity_master` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table to store relationships between Business processes and Entities.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rlshp_dataentity_busprcs`
--

LOCK TABLES `rlshp_dataentity_busprcs` WRITE;
/*!40000 ALTER TABLE `rlshp_dataentity_busprcs` DISABLE KEYS */;
/*!40000 ALTER TABLE `rlshp_dataentity_busprcs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rlshp_dataentity_dept`
--

DROP TABLE IF EXISTS `rlshp_dataentity_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rlshp_dataentity_dept` (
  `de_dept_rlshp_id` int(11) NOT NULL AUTO_INCREMENT,
  `data_entity_id` int(11) NOT NULL COMMENT 'The original data entity internal representation.',
  `dept_id` int(11) NOT NULL COMMENT 'The original department id (database internal representation).',
  PRIMARY KEY (`de_dept_rlshp_id`),
  KEY `fk_data_entity_dept_rlshp_ref1_idx` (`data_entity_id`),
  KEY `fk_data_entity_dept_rlshp_ref2_idx` (`dept_id`),
  CONSTRAINT `fk_data_entity_dept_rlshp_ref1` FOREIGN KEY (`data_entity_id`) REFERENCES `data_entity_master` (`entity_id`),
  CONSTRAINT `fk_data_entity_dept_rlshp_ref2` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table to store the Data Entity to Department relationship.  1 data entity can be controlled/assigned by N departments.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rlshp_dataentity_dept`
--

LOCK TABLES `rlshp_dataentity_dept` WRITE;
/*!40000 ALTER TABLE `rlshp_dataentity_dept` DISABLE KEYS */;
/*!40000 ALTER TABLE `rlshp_dataentity_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temp_load_departments`
--

DROP TABLE IF EXISTS `temp_load_departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_load_departments` (
  `line_of_business` varchar(100) DEFAULT NULL,
  `division` varchar(100) DEFAULT NULL,
  `group` varchar(100) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `team` varchar(100) DEFAULT NULL,
  `function` varchar(100) DEFAULT NULL,
  `in_blueworks_flg` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temp_load_departments`
--

LOCK TABLES `temp_load_departments` WRITE;
/*!40000 ALTER TABLE `temp_load_departments` DISABLE KEYS */;
INSERT INTO `temp_load_departments` VALUES ('Corporate','Legal & Compliance','Enterprise Risk - SFS','Credit & Market Risk','Credit & Market Risk','Credit & Market Risk','N'),('Corporate','Legal & Compliance','Enterprise Risk - SFS','Enterprise Fraud','Debt Recovery','Debt Recovery','Y'),('Corporate','Legal & Compliance','Enterprise Risk - SFS','Enterprise Fraud','Enterprise Fraud','Enterprise Fraud','Y'),('Corporate','Legal & Compliance','Enterprise Risk - SFS','Operational Risk','Regulatory Response','Regulatory Response','N'),('Corporate','Legal & Compliance','Enterprise Risk - SFS','Operational Risk','Operational Risk','Operational Risk','N'),('Corporate','Legal & Compliance','Enterprise Risk - SFS','Enterprise AML','AML','AML','Y'),('Corporate','Legal & Compliance','Enterprise Risk - SFS','Enterprise AML','AML Technology','AML Technology','Y'),('Corporate','Legal & Compliance','Internal Audit-SFS','Internal Audit','Internal Audit','Internal Audit','N'),('Corporate','Legal & Compliance','Internal Audit-SFS','Internal Audit','IT Internal Audit','IT Internal Audit','N'),('Corporate','Legal & Compliance','Compliance','Compliance Services','Compliance Services','Compliance Services','Y'),('Corporate','Legal & Compliance','Compliance','Compliance Services','Compliance Research','Compliance Research','N'),('Corporate','Legal & Compliance','Compliance','Regulatory Affairs','Regulatory Affairs','Regulatory Affairs','N'),('Corporate','Legal & Compliance','Compliance','Regulatory Affairs','Public Communications','Public Communications','N'),('Corporate','Legal & Compliance','Compliance','Distribution Compliance','Surveillance','Surveillance','IP'),('Corporate','Legal & Compliance','Compliance','Distribution Compliance','Branch Audit','Branch Audit','Y'),('Corporate','Legal & Compliance','Legal','Legal','Investigation & Resolution','Investigation & Resolution','Y'),('Corporate','Legal & Compliance','Legal','Legal','Corp & Sec','Corp & Sec','N'),('Corporate','Legal & Compliance','Legal','Legal','Legal Dept Operations','Legal Dept Operations','N'),('Corporate','Legal & Compliance','Legal','Legal','Litigation','Litigation','N'),('Corporate','Legal & Compliance','Bank Compliance','Bank Compliance','Bank Risk','Bank Risk','N'),('Corporate','Legal & Compliance','Bank Compliance','Bank Compliance','Loan Compliance','Loan Compliance','N'),('Corporate','Legal & Compliance','Bank Compliance','Bank Compliance','Consumer Bank Compliance','Consumer Bank Compliance','Y'),('Corporate','Legal & Compliance','Bank Compliance','Bank Compliance','Lending Compliance','Lending Compliance','N'),('Corporate','Finance Division','Procurement','Vendor Relations','Services','Services','N'),('Corporate','Finance Division','Procurement','Vendor Relations','Software','Software','N'),('Corporate','Finance Division','Procurement','Vendor Relations','Contract','Contract','N'),('Corporate','Finance Division','Procurement','Vendor Relations','Telecomm','Telecomm','N'),('Corporate','Finance Division','Procurement','Vendor Relations','Hardware','Hardware','N'),('Corporate','Finance Division','Corporate Finance','Finance','Finance','Finance','N'),('Corporate','Finance Division','Tax','Tax Department','Tax Reporting','Tax Reporting','N'),('Corporate','Finance Division','Investment & Treasury','Treasury','Treasury','Treasury','N'),('Corporate','Finance Division','Investment & Treasury','Treasury','Risk Modeling','Risk Modeling','N'),('Corporate','Finance Division','Bank Finance','Finance','Finance','Finance','N'),('Corporate','Finance Division','Accounting','Asset Management - Data Center','Asset Management','Asset Management','N'),('Corporate','Finance Division','Accounting','Asset Management - Data Center','Leased Asset','Leased Asset','N'),('Corporate','Finance Division','Accounting','Bank Accounting','Bank Accounting','Bank Accounting','N'),('Corporate','Finance Division','Accounting','Regulatory Reporting','Financial Reporting','Financial Reporting','N'),('Corporate','Finance Division','Accounting','Equipment Finance','Equipment Finance','Equipment Finance','N'),('Corporate','Finance Division','Accounting','Accounts Payable','Accounts Payable','Accounts Payable','N'),('Corporate','Finance Division','Accounting','Job Costing','Job Costing','Job Costing','N'),('Corporate','Finance Division','Accounting','Fixed Asset','Fixed Asset','Fixed Asset','N'),('Corporate','Finance Division','Accounting','Recon','Recon','Recon','N'),('Corporate','Finance Division','Accounting','Financial Systems','Financial Systems','Financial Systems','N'),('Corporate','Special Projects','Special Projects','Special Projects','Special Projects','Special Projects','N'),('Corporate','Administration','Corporate Communications','Intranet Multimedia & Design','Intranet','Intranet','N'),('Corporate','Administration','Corporate Communications','Intranet Multimedia & Design','Graphic Design','Graphic Design','N'),('Corporate','Administration','Corporate Communications','Intranet Multimedia & Design','Multimedia','Multimedia','N'),('Corporate','Administration','Corporate Communications','Internal Communication','Internal Communication','Internal Communication','N'),('Corporate','Administration','Corporate Facilities','Facilities & Administration','Building Operations','Building Operations','N'),('Corporate','Administration','Corporate Facilities','Facilities & Administration','Meetings & Events','Meetings & Events','N'),('Corporate','Administration','Corporate Facilities','Facilities & Administration','Travel Manager','Travel Manager','N'),('Corporate','Administration','Corporate Facilities','Facilities & Administration','Physical Security','Physical Security','N'),('Corporate','Administration','Corporate Facilities','Facilities & Administration','Branch Facilities','Branch Facilities','N'),('Corporate','Administration','Corporate Facilities','Facilities & Administration','Corporate Facilities','Corporate Facilities','N'),('Corporate','Administration','Corporate Facilities','Facilities & Administration','Facilities Management Systems','Facilities Management Systems','N'),('Corporate','Administration','Corporate Facilities','Facilities & Administration','Real Estate','Real Estate','N'),('Corporate','Administration','Admin-People Services','Receptionist','Receptionist','Receptionist','N'),('Corporate','Administration','People Services','Talent Management','HR Business Partner','Benefits','N'),('Corporate','Administration','People Services','Talent Management','HR Business Partner','Recruitment','N'),('Corporate','Administration','People Services','Talent Management','HR Business Partner','Human Resources','N'),('Corporate','Administration','People Services','Talent Management','HR Compliance','HR Compliance','N'),('Corporate','Administration','People Services','Talent Management','Total Rewards','Compensation','N'),('Corporate','Administration','People Services','Talent Management','Total Rewards','Incentive Compensation','N'),('Corporate','Administration','People Services','Talent Management','Total Rewards','Benefits','N'),('Corporate','Administration','People Services','Talent Management','Total Rewards','Rewards & Recognition','N'),('Corporate','Administration','People Services','Talent Management','Total Rewards','Relocation','N'),('Corporate','Administration','People Services','Talent Management','HR Business Partner','Talent Acquisition','N'),('Corporate','Administration','People Services','Talent Management','HR Business Partner','Recruitment','N'),('Corporate','Administration','People Services','Talent Management','HR Business Partner','FINRA','N'),('Corporate','Administration','People Services','Talent Management','Learning & Development','Instructional Design','N'),('Corporate','Administration','People Services','Talent Management','Learning & Development','Leadership Development Program','N'),('Corporate','Administration','People Services','Talent Management','Learning & Development','Content/QA','N'),('Corporate','Administration','People Services','Talent Management','Learning & Development','LMS','N'),('Corporate','Administration','People Services','Talent Management','Learning & Development','ILT','N'),('Corporate','Administration','People Services','Talent Management','HR Operations','Reporting & Metrics','N'),('Corporate','Administration','People Services','Talent Management','HR Operations','HRIS','N'),('Corporate','Administration','People Services','Talent Management','HR Operations','Payroll','N'),('Corporate','Information Technology','Technology','IT Service Delivery & Chg Mgmt','End User Technology','EUT Engineers','N'),('Corporate','Information Technology','Technology','IT Service Delivery & Chg Mgmt','End User Technology','EUT Service Desk Technicians','N'),('Corporate','Information Technology','Technology','IT Service Delivery & Chg Mgmt','End User Technology','EUT Workstation Technicians','N'),('Corporate','Information Technology','Technology','IT Service Delivery & Chg Mgmt','End User Technology','End User Administration','N'),('Corporate','Information Technology','Technology','IT Service Delivery & Chg Mgmt','Change Management','Change Management','N'),('Corporate','Information Technology','Technology','IT Service Delivery & Chg Mgmt','Service Delivery','Service Delivery','N'),('Corporate','Information Technology','Technology','IT Comm & Security','Networking','Network Engineers','N'),('Corporate','Information Technology','Technology','IT Comm & Security','Networking','Network/Telecom Technicians','N'),('Corporate','Information Technology','Technology','IT Comm & Security','IT Security','Information Security','N'),('Corporate','Information Technology','Technology','IT Comm & Security','Bus Continuity & Disaster Rec.','Disaster Recovery','N'),('Corporate','Information Technology','Technology','IT Comm & Security','Bus Continuity & Disaster Rec.','Business Continuity','Y'),('Corporate','Information Technology','Technology','IT Comm & Security','IT Security','Network Security Engineers','N'),('Corporate','Information Technology','Technology','IT Comm & Security','IT Security','Application Security Engineers','N'),('Corporate','Information Technology','Technology','IT Comm & Security','IT Security','End Point Security Engineers','N'),('Corporate','Information Technology','Technology','IT Comm & Security','IT Security','Vulnerability Assessment Engineers','N'),('Corporate','Information Technology','Technology','IT Comm & Security','IT Security','Information Forensics','N'),('Corporate','Information Technology','Technology','IT Comm & Security','IT Communications','Telecom Engineers','N'),('Corporate','Information Technology','Technology','IT Comm & Security','IT Communications','Messaging & Collaboration Engineers','N'),('Corporate','Information Technology','Technology','Architecture & Monitoring','Enterpr Monitoring & Capacity','Monitoring Engineers','N'),('Corporate','Information Technology','Technology','Architecture & Monitoring','Infrastructure Architecture','Infrastructure Soltuions Architect','N'),('Corporate','Information Technology','Technology','Architecture & Monitoring','Infrastructure Architecture','Information Security Architect','N'),('Corporate','Information Technology','Technology','Data Cntr Fac & Planning','Data Center Facilities','Data Center Planning Engineers','N'),('Corporate','Information Technology','Technology','Data Cntr Fac & Planning','Data Center Facilities','Data Center Facilities Technician','N'),('Corporate','Information Technology','Technology','Distributed Systems','Storage Administration','IS Virtualization','N'),('Corporate','Information Technology','Technology','Distributed Systems','Storage Administration','IS Storage','N'),('Corporate','Information Technology','Technology','Distributed Systems','Database Administration','SQL DBA','N'),('Corporate','Information Technology','Technology','Distributed Systems','Server Administration','Windows System Support','N'),('Corporate','Information Technology','Technology','Distributed Systems','Server Administration','Linux System Support','N'),('Corporate','Information Technology','Technology','IT Operations','Computer Operations','iSeries Administration','N'),('Corporate','Information Technology','Technology','IT Operations','Computer Operations','Computer Operations','N'),('Corporate','Information Technology','Technology','Application Support','Application Support','Application Support','N'),('Corporate','Information Technology','Technology','Application Support','Application Support','Build & Release','N'),('Corporate','Information Technology','Technology','Admin-Information Tech Div','IT Administrative','IT Administrative','N'),('Corporate','Information Technology','Technology','Admin-Information Tech Div','IT Administrative','IT Receptionist','N'),('Corporate','Information Technology','Bus Relation & System','Quality Assurance','Quality Assurance','Quality Assurance Testing','N'),('Corporate','Information Technology','Bus Relation & System','Quality Assurance','Quality Assurance','Quality Assurance','N'),('Corporate','Information Technology','Bus Relation & System','Quality Assurance','Quality Assurance','Quality Assurance Automation','N'),('Corporate','Information Technology','Bus Relation & System','Business Relationship Mgmt','Business Relationship Mgmt','Business Relationship Mgmt','N'),('Corporate','Information Technology','Bus Relation & System','Program Management','Project Management','Project Analysis','N'),('Corporate','Information Technology','Bus Relation & System','Program Management','Project Management','Project Management','N'),('Corporate','Information Technology','Bus Relation & System','Program Management','Project Management','Project Release Management','N'),('Corporate','Information Technology','Bus Relation & System','Business Systems Analysis','Business Systems Analysis','Technical Writer','Y'),('Corporate','Information Technology','Bus Relation & System','Business Systems Analysis','Business Systems Analysis','Business Systems Analysis','Y'),('Corporate','Information Technology','Bus Relation & System','Process Goverance & Rpt','Process Goverance & Rpt','Portfolio','N'),('Corporate','Information Technology','Bus Relation & System','Process Goverance & Rpt','Process Goverance & Rpt','Reporting','N'),('Corporate','Information Technology','IT Development','Trading App Development','Advisor Services Development','Web Development','N'),('Corporate','Information Technology','IT Development','Trading App Development','Advisor Services Development','DB Development','N'),('Corporate','Information Technology','IT Development','Trading App Development','Advisor Services Development','Mid-Tier Development','N'),('Corporate','Information Technology','IT Development','Trading App Development','Development','Web Development','N'),('Corporate','Information Technology','IT Development','Trading App Development','Development','Elite Development','N'),('Corporate','Information Technology','IT Development','Trading App Development','Development','Mobile Development','N'),('Corporate','Information Technology','IT Development','Trading App Development','Development','Scottrader Development','N'),('Corporate','Information Technology','IT Development','Trading App Development','Development','Back Office Development','N'),('Corporate','Information Technology','IT Development','Trading App Development','Development','Mid-Tier Development','N'),('Corporate','Information Technology','IT Development','Trading App Development','Development','Market Data Development','N'),('Corporate','Information Technology','IT Development','Trading App Development','Development','OMS Development','N'),('Corporate','Information Technology','IT Development','Trading App Development','Mid-Tier/OMS','Development Services','N'),('Corporate','Information Technology','IT Development','Trading App Development','Development','Database Development','N'),('Corporate','Information Technology','IT Development','Trading App Development','Development','Data Modeling','N'),('Corporate','Information Technology','IT Development','Trading App Development','Development','Data Integration / ETL Development','N'),('Corporate','Information Technology','IT Development','Enterprise Application','Business Intelligence','Data Analysis','N'),('Corporate','Information Technology','IT Development','Enterprise Application','Business Intelligence','BI Development','N'),('Corporate','Information Technology','IT Development','Enterprise Application','Enterprise Application','Enterprise Application Development','N'),('Corporate','Information Technology','IT Development','Enterprise Application','Enterprise Application','Enterprise Application Systems Analysis','N'),('Corporate','Information Technology','IT Development','Enterprise Application','Enterprise Application','Enterprise Application Architect','N'),('Corporate','Information Technology','IT Development','Application Architecture','Development Architects','Database Solution Architect','N'),('Corporate','Information Technology','IT Development','Application Architecture','Development Architects','Backoffice Solution Architect','N'),('Corporate','Information Technology','IT Development','Application Architecture','Development Architects','Solution Architect','N'),('Corporate','Marketing','Client Segments & Exper','Client Segment Experience','Client Segment Experience','Client Segment Experience','N'),('Corporate','Marketing','Client Segments & Exper','User Experience & Accessibility','User Experience','Research','N'),('Corporate','Marketing','Client Segments & Exper','User Experience & Accessibility','User Experience','Design','N'),('Corporate','Marketing','Client Segments & Exper','AP Product & Content Development','Content Development','Investment Education','N'),('Corporate','Marketing','Client Segments & Exper','AP Product & Content Development','Content Development','Content','N'),('Corporate','Marketing','Client Segments & Exper','AP Product & Content Development','Content Development','Graphic Design','N'),('Corporate','Marketing','Client Segments & Exper','AP Product & Content Development','Product Development','Product & Services','N'),('Corporate','Marketing','Client Segments & Exper','AP Product & Content Development','Product Development','Marketing','N'),('Corporate','Marketing','Client Segments & Exper','Client Insight & Decision Support','Marketing & Customer Experience','Research','N'),('Corporate','Marketing','Client Segments & Exper','Client Insight & Decision Support','Marketing Analytics ','Marketing Analytics ','N'),('Corporate','Marketing','Client Segments & Exper','Investor Segment Experience','Equipment Finance Marketng','Equipment Finance Marketng','N'),('Corporate','Marketing','Client Segments & Exper','Investor Segment Experience','Investor Segment Analytics','Investor Segment Analytics','N'),('Corporate','Marketing','Client Segments & Exper','Trader Segment Analytics','Trader Segment Analytics','Trader Segment Analytics','N'),('Corporate','Marketing','Client Segments & Exper','CRM & Campaign Mgmt.','Unica Product','Unica Product','N'),('Corporate','Marketing','Client Segments & Exper','CRM & Campaign Mgmt.','CRM','CRM','N'),('Corporate','Marketing','Digital Solutions','Digital Active Trader Solution','Elite Platform','Elite Platform','N'),('Corporate','Marketing','Digital Solutions','Digital Solutions','Mobile Platform','Mobile Platform','N'),('Corporate','Marketing','Digital Solutions','Digital Innovation','Digital Innovation','Digital Innovation','N'),('Corporate','Marketing','Digital Solutions','Bank Platform','Bank Platform','Bank Platform','N'),('Corporate','Marketing','Digital Solutions','Digital Management','Client App & Support Prod','Client App & Support Prod','Y'),('Corporate','Marketing','Digital Solutions','Digital Management','Client Website Platform','Client Website Platform','N'),('Corporate','Marketing','Digital Solutions','Digital Management','Scottrader Platform','Scottrader Platform','N'),('Corporate','Marketing','External Communications','Reputation & Public Relations','Public Relations','Public Relations','N'),('Corporate','Marketing','External Communications','Marketing Services','Marketing Project Management','Marketing Project Management','N'),('Corporate','Marketing','External Communications','Marketing Services','Marketing Compliance','Marketing Compliance','N'),('Corporate','Marketing','External Communications','Creativity','Digital Web Marketing','Design','N'),('Corporate','Marketing','External Communications','Creativity','Creative Services','Design','N'),('Corporate','Marketing','External Communications','Creativity','Digital Advertising','Design','N'),('Corporate','Marketing','External Communications','Creativity','Content Strategy','Content Analytics','N'),('Corporate','Marketing','External Communications','Creativity','Content Strategy','Content Strategy','N'),('Corporate','Marketing','External Communications','Creativity','Content Strategy','Account Communication','N'),('Corporate','Marketing','External Communications','Integrated Marketing ','Integrated Marketing ','Integrated Marketing ','N'),('Corporate','Marketing','External Communications','Social Media ','Social Communication','Social Communication','N'),('Corporate','Marketing','Digital Marketing','Web Marketing','WCM','WCM Analytics','N'),('Corporate','Marketing','Digital Marketing','Web Marketing','SEO','SEO Analytics','N'),('Corporate','Marketing','Digital Marketing','Web Marketing','Email ','Email Analytics','N'),('Corporate','Marketing','Digital Marketing','Web Marketing','Web','Web Analytics','N'),('Corporate','Marketing','Digital Marketing','Web Marketing','Digital Marketing','Digital Marketing Analytics','N'),('Corporate','Marketing','Digital Marketing','Advertising','Display & Programmatic','Display','N'),('Corporate','Marketing','Digital Marketing','Advertising','Media','Media','N'),('Corporate','Marketing','Digital Marketing','Advertising','SEM & Social Advertising','Search Analytics','N'),('Bank','Bank Division','Bank Purchased Mortgages','Purchased Mortgages','Correspondent Relationship','Correspondent Relationship','N'),('Bank','Bank Division','Bank Purchased Mortgages','Purchased Mortgages','Financial Analytics ','Financial Analytics ','N'),('Bank','Bank Division','Commercial Lending','Commercial Lending','Commercial Credit','Analytics','N'),('Bank','Bank Division','Commercial Lending','Commercial Lending','Commercial Loan','Coordination','N'),('Bank','Bank Division','Bank Equipment Finance','Documentation','Inside Sales','Inside Sales','N'),('Bank','Bank Division','Bank Equipment Finance','Documentation','Documentation','Documentation','N'),('Bank','Bank Division','Bank Equipment Finance','National Sales','Business Developmnt','Business Developmnt','N'),('Bank','Bank Division','Bank Equipment Finance','National Sales','Inside Sales','Inside Sales','N'),('Bank','Bank Division','Bank Equipment Finance','Corporate Development','Capital Markets','Capital Markets','N'),('Bank','Bank Division','Mortgage Lending','Mortgage Operations','Lock Dsk/Mrtgage','Loan Officer','N'),('Bank','Bank Division','Mortgage Lending','Lender City - Blvd Bk-Mortgage','Conforming Mortgage Loans','Loan Processing','N'),('Bank','Bank Division','Consumer Lending','Consumer Loans','InDirect Consumer Loan','Loan Officer','N'),('Bank','Bank Division','Consumer Lending','Consumer Loans','Jr Loan Officer - Consumer','Loan Officer','N'),('Bank','Bank Division','Consumer Lending','Consumer Loans','Loan Processing','Loan Processing','N'),('Bank','Bank Division','Consumer Lending','Consumer Loans','Loan Processing','Loan Quality Control','N'),('Bank','Bank Division','Admin-Bank Administration','Admin-Bank Administration','Bank Administrative','Administrative','N'),('Bank','Bank Division','Consumer Lending','Collections','Collector','Collector','N'),('Bank','Bank Division','Consumer Lending','Outdoor Amusement','Loan Portfolio','Loan Portfolio','N'),('Bank','Bank Division','Consumer Lending','Outdoor Amusement','Loan OFC','Loan OFC','N'),('Bank','Bank Division','Consumer Lending','Outdoor Amusement','Office Administration','Administrative','N'),('Bank','Bank Division','Consumer Lending','Collections','Legal Collatreral Resol','Legal Collatreral Resol','N'),('Bank','Bank Division','Operations','Credit Administration','Loan Processing','Loan Processing','N'),('Bank','Bank Division','Operations','Credit Administration','Mortgage Closing / Processing','Mortgage Closing / Processing','N'),('Bank','Bank Division','Operations','Credit Administration','Compliance','Compliance','N'),('Bank','Bank Division','Operations','Bank Corporate','Financial Analytics ','Analytics','N'),('Bank','Bank Division','Operations','Credit Risk Management','Credit Risk','Analytics','N'),('Bank','Bank Division','Operations','Credit Risk Management','Loan Review','Analytics','N'),('Bank','Bank Division','Operations','Bank Equipment Finance','Credit Anlaysis','Analytics','N'),('Bank','Bank Division','Operations','Blvd Bk-Joplin Main Office ','Operations & Retail','Operations','N'),('Bank','Bank Division','Operations','Blvd Bk-Joplin Main Office ','Operations & Retail','Loan Servicing','N'),('Bank','Bank Division','Retail Operations','Account Services','Retail Banking','Retail Bank Operations','Y'),('Bank','Bank Division','Retail Operations','Retail Prod Srvcs','Retail Banking','Retail Bank Strategy Performance Analytics','Y'),('Brokerage','Brokerage Division','Advisor Services','SAS Business Development','Business Dev','Business Dev','N'),('Brokerage','Brokerage Division','Advisor Services','SAS Program & Product Services','SAS Prgms & Prod Strategy','SAS Product Dev','N'),('Brokerage','Brokerage Division','Advisor Services','SAS Program & Product Services','SAS Prgms & Prod Strategy','SAS Product Integration','N'),('Brokerage','Brokerage Division','Advisor Services','SAS Program & Product Services','SAS Prgms & Prod Strategy','SAS Platform','N'),('Brokerage','Brokerage Division','Advisor Services','SAS Program & Product Services','SAS Prgms & Prod Strategy','Managed Inv. Solutions','N'),('Brokerage','Brokerage Division','Advisor Services','SAS Client Services','SAS Acct and Trans Svc','Ops Solutions Analytics','N'),('Brokerage','Brokerage Division','Advisor Services','SAS Client Services','SAS Acct and Trans Svc','SAS Oversight','N'),('Brokerage','Brokerage Division','Advisor Services','SAS Client Services','SAS Acct and Trans Svc','Transition Services','IP'),('Brokerage','Brokerage Division','Advisor Services','SAS Client Services','SAS Acct and Trans Svc','SAS Acct Services','IP'),('Brokerage','Brokerage Division','Advisor Services','SAS Client Services','SAS Relations','Relationship Management','Y'),('Brokerage','Brokerage Division','Brokerage Strategy & Prod','Guidance Solutions','Guidance','Guidance','N'),('Brokerage','Brokerage Division','Brokerage Strategy & Prod','Strategy & Support ','Brokerage Strgy & Bus Plan','Brokerage Strategy','N'),('Brokerage','Brokerage Division','Brokerage Strategy & Prod','Strategy & Support ','Brokerage Strgy & Bus Plan','Analytics & Comp Intel','N'),('Brokerage','Brokerage Division','Brokerage Strategy & Prod','Strategy & Support ','Brokerage Implementation','Client Fullfillment & Implementation','N'),('Brokerage','Brokerage Division','Brokerage Strategy & Prod','Strategy & Support ','Brokerage Implementation','Client Offer Management','Y'),('Brokerage','Brokerage Division','Brokerage Strategy & Prod','Strategy & Support ','Sales Strategy','Brokerage Strategy Campaign','N'),('Brokerage','Brokerage Division','Brokerage Strategy & Prod','Guidance Solutions','Brokerage Product','Mutual Funds & ETFs','N'),('Brokerage','Brokerage Division','Brokerage Strategy & Prod','Strategy & Support','Brokerage Product','Portfolio Mgmt Strategy','N'),('Brokerage','Brokerage Division','Brokerage Strategy & Prod','Guidance Solutions','Brokerage Product','Active Trader Strategy','N'),('Brokerage','Brokerage Division','Brokerage Strategy & Prod','Strategy & Support','Brokerage Product','Product Dev & Analytics','N'),('Brokerage','Brokerage Division','Brokerage Operations','Operational Controls','Operational Controls','Analytics','N'),('Brokerage','Brokerage Division','Brokerage Operations','Operational Controls','Special Handling IVT','Special Handling','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operational Controls','Special Handling IVT','IRA','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operational Controls','Special Handling IVT','Identity Verification','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Corporate Actions','Tax Reporting','Tax Reporting','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Corporate Actions','Tax Reporting','Cost Basis','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Corporate Actions','Dividends/Reorganization','Dividends','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Corporate Actions','Dividends/Reorganization','Reorganization','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Enterprise Content Manager','Enterprise Content Manager','N'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Mailroom','Print Production','N'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Mailroom','Mailroom','N'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Supplies','Supplies Purchasing','N'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Logistics','Internal Supply','N'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Logistics','Ops Processing','N'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Logistics','Shipping & Receiving','N'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Back Office Opr Analytics','Back Office Automation','N'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Back Office Opr Analytics','Back Office Analytics','N'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Privacy & Data Goverance','Data Governance','N'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Privacy & Data Goverance','Privacy','N'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Account Operations','Tailored Services','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Account Operations','Account Services','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Account Operations','Support Center','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Options First-Operations','Options First','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Account Operations','AP Account Maintenance','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Account Operations','AP New Account','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Account Operations','Middle Office','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','ACATS','Transfer In','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','ACATS','Transfer Out','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','ACATS','Stock Transfer','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','ACATS','Cashless Stock Options','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','ACATS','Follow Up','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','ACATS','Claims Settlement','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Securities Processing','Securities Processing','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Securities Processing','Stock Receipt','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Securities Processing','Large Quantity','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Securities Processing','Physical Transfer','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Image Processing/Research','Image Processing','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Operations Technology & Asset Transfers','Image Processing/Research','Image Research','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Margin','Margin & Cashiering','Margin','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Margin','Margin & Cashiering','Cashiering','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Margin','Margin & Cashiering','Margin Process Audit','N'),('Brokerage','Brokerage Division','Brokerage Operations','Margin','Check Writing/Money Direct','Bank Deposit Program','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Margin','Complex Options Margin/Risk','Complex Options Margin/Risk','N'),('Brokerage','Brokerage Division','Brokerage Operations','Margin','Check Writing/Money Direct','Check Writing','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Margin','Check Writing/Money Direct','Money Direct','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Margin','Check Writing/Money Direct','Wire Transfer','Y'),('Brokerage','Brokerage Division','Brokerage Operations','New Accounts Maintenance','Account Operations','Account Services','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Special Operations ','Back Office Operations','Back Office Operations','N'),('Brokerage','Brokerage Division','Brokerage Operations','Settlement Opr/Sec Finance','Stock Record','Stock Record Fail Control','IP'),('Brokerage','Brokerage Division','Brokerage Operations','Settlement Opr/Sec Finance','Stock Record','Stock Record Buy In','IP'),('Brokerage','Brokerage Division','Brokerage Operations','Settlement Opr/Sec Finance','Stock Record','Stock Record Settlement','IP'),('Brokerage','Brokerage Division','Brokerage Operations','Settlement Opr/Sec Finance','Stock Record','Reconciliation','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Settlement Opr/Sec Finance','Stock Record','Mutual Fund Trade Reconciliation','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Settlement Opr/Sec Finance','Mutual Funds','Mutual Fund Networking Reconciliation','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Settlement Opr/Sec Finance','Mutual Funds','Mutual Fund Networking','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Settlement Opr/Sec Finance','Mutual Funds','Mutual Fund Product','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Settlement Opr/Sec Finance','Mutual Funds','Mutual Fund SERV/Trader','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Settlement Opr/Sec Finance','Mutual Funds','Mutual ACAT Out','Y'),('Brokerage','Brokerage Division','Brokerage Operations','Settlement Opr/Sec Finance','Securities Lending Trading','Sec Lending Sales Trader','IP'),('Brokerage','Brokerage Division','Brokerage Operations','Settlement Opr/Sec Finance','Securities Lending Ops ','Sec Lending Ops','IP'),('Brokerage','Brokerage Division','Brokerage Finance','Brokerage Financial Analysis','Brokerage Financial Analysis','Analytics','N'),('Brokerage','Brokerage Division','Brokerage Finance','Brokerage Financial Reporting','Brokerage Financial Reporting','Reporting','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Branch Admin','Branch','Branch','IP'),('Brokerage','Brokerage Division','Brokerage Client Services','Branch Admin','Client Srvcs Bus Process','Client Srvcs Bus Process','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Branch Admin','Client Services Support','Client Relations','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Branch Admin','Client Services Support','Branch Support','IP'),('Brokerage','Brokerage Division','Brokerage Client Services','Branch Admin','Client Services Support','Branch Inventive Oversight','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Service Center','AP Call Center','Broker','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Service Center','AP Call Center','Technician','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Service Center','Workforce Planning','Workforce Planning','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Service Center','SC Workforce','SC Workforce','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Service Center','Call Center Reporting Analytics','Analytics','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Service Center','Financial Service Representative','Financial Service Representative','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Service Center','Customer Service','Customer Service','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Service Center','Customer Support','Customer Support','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Service Center','SC Business Analytics','SC Business Analytics','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Service Center','Service Center Quality','Service Center Quality','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Service Center','Bank Customer Service','Bank Customer Service','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Service Center','Chat & Email','Chat','Y'),('Brokerage','Brokerage Division','Brokerage Client Services','Service Center','Chat & Email','Email','Y'),('Brokerage','Brokerage Division','Brokerage Client Services','Service Center','Active Trader','Active Trader','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Service Center','Options First Application','Options First Application','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Service Center','SC Technician','SC Technician','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Service Center','AP Call Center','AP Quality','N'),('Brokerage','Brokerage Division','Brokerage Client Services','Service Center','AP Call Center','AP Training','N'),('Brokerage','Brokerage Division','Trading Services & Program Management','Trading Support','Execution Quality Analytics','Execution Quality Analytics','IP'),('Brokerage','Brokerage Division','Trading Services & Program Management','Clearing & Option Services','Options','Trading Srvcs Clearing','Y'),('Brokerage','Brokerage Division','Trading Services & Program Management','Clearing & Option Services','Options','Deriv Mkt Structure Analytics','Y'),('Brokerage','Brokerage Division','Trading Services & Program Management','Clearing & Option Services','Options','Option Analytics','Y'),('Brokerage','Brokerage Division','Trading Services & Program Management','Clearing & Option Services','Purchase & Sales','Fixed Income','Y'),('Brokerage','Brokerage Division','Trading Services & Program Management','Clearing & Option Services','Purchase & Sales','Clearing','Y'),('Brokerage','Brokerage Division','Trading Services & Program Management','Clearing & Option Services','Purchase & Sales','Purchase & Sales','Y'),('Brokerage','Brokerage Division','Trading Services & Program Management','Trading Support','Trading Operations','Trading Support','IP'),('Brokerage','Brokerage Division','Trading Services & Program Management','Trading Support','Trading Operations','Trading Services','IP'),('Brokerage','Brokerage Division','Trading Services & Program Management','Trading Support','Trading Operations','Security Master','Y'),('Brokerage','Brokerage Division','Trading Services & Program Management','Trading Support','Trading Operations','OATS','Y'),('Brokerage','Brokerage Division','Trading Services & Program Management','Brokerage Program','Brokerage Program Director','Brokerage Program Director','N'),('Brokerage','Brokerage Division','Trading Services & Program Management','Trading Support','Reporting Services','Reporting Services','IP'),('Brokerage','Brokerage Division','Trading Services & Program Management','Trading Support','Trding Services Regulatory','Trding Services Regulatory','IP'),('Brokerage','Brokerage Division','Trading Services & Program Management','Market Data Operations','Market Data Business','Market Data Business','Y'),('Brokerage','Brokerage Division','Trading Services & Program Management','Market Data Operations','Market Data Compliance','Market Data Compliance','Y'),('Brokerage','Brokerage Division','Trading Services & Program Management','Market Data Operations','Market Data Quality','Market Data Quality','Y'),('Brokerage','Brokerage Division','Trading Services & Program Management','Fixed Income','Fixed Income','Analytics','Y'),('Brokerage','Brokerage Division','Trading Services & Program Management','Fixed Income','Fixed Income','Fixed Income','Y'),('Brokerage','Brokerage Division','Trading Services & Program Management','Trading Support','Trading Infrastructure','Special Order Handling','IP'),('Brokerage','Brokerage Division','Trading Services & Program Management','Trading Support','Trading Infrastructure','Trading Support','IP');
/*!40000 ALTER TABLE `temp_load_departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'data_governance'
--
/*!50003 DROP PROCEDURE IF EXISTS `load_dept` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dg_admin`@`%` PROCEDURE `load_dept`()
BEGIN
	DECLARE temp_str VARCHAR(50);
	DECLARE temp_str2 VARCHAR(50);
	DECLARE temp_id INT;
	DECLARE done INT DEFAULT FALSE;

	DECLARE dept_cur CURSOR
		FOR 
			select distinct tld.department, business_group_id
			 from enterprise_business_group ebg,
				  temp_load_departments tld
			where tld.group = ebg.group_nm;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	-- Populate departments
	OPEN dept_cur;
		dept_loop: LOOP
			FETCH dept_cur INTO temp_str, temp_id;

			IF done THEN
				LEAVE dept_loop;
			END IF;

			INSERT INTO department (dept_nm, enterprise_business_group_id) values (temp_str, temp_id);
		END LOOP dept_loop;
	CLOSE dept_cur;
	COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `load_div` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dg_admin`@`%` PROCEDURE `load_div`()
BEGIN
	DECLARE temp_str VARCHAR(50);
	DECLARE temp_str2 VARCHAR(50);
	DECLARE temp_id INT;
	DECLARE done INT DEFAULT FALSE;

	DECLARE div_cur CURSOR
		FOR
			SELECT DISTINCT tld.division, ebl.business_line_id
			  FROM temp_load_departments tld,
				   enterprise_business_line ebl
			 WHERE tld.line_of_business = ebl.line_nm;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	-- Populate enterprise business division.
	OPEN div_cur;
		div_loop: LOOP
			FETCH div_cur INTO temp_str, temp_id;

			IF done THEN
				LEAVE div_loop;
			END IF;

			INSERT INTO enterprise_business_division (business_division_nm, business_line_id) values (temp_str, temp_id);
		END LOOP div_loop;
	CLOSE div_cur;
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `load_func` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dg_admin`@`%` PROCEDURE `load_func`()
BEGIN
	DECLARE temp_str VARCHAR(50);
	DECLARE temp_str2 VARCHAR(50);
	DECLARE temp_id INT;
	DECLARE done INT DEFAULT FALSE;

	DECLARE func_cur CURSOR
		FOR 
			select distinct tld.function, dt.dept_team_id, tld.in_blueworks_flg
			 from department_team dt,
				  temp_load_departments tld
			where tld.team = dt.dept_team_nm;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	-- Populate functions
	OPEN func_cur;
		func_loop: LOOP
			FETCH func_cur INTO temp_str, temp_id, temp_str2;

			IF done THEN
				LEAVE func_loop;
			END IF;

			INSERT INTO department_function (dept_func_nm, dept_team_id, in_blueworks_flg) values (temp_str, temp_id, temp_str2);
		END LOOP func_loop;
	CLOSE func_cur;
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `load_grp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dg_admin`@`%` PROCEDURE `load_grp`()
BEGIN
	DECLARE temp_str VARCHAR(50);
	DECLARE temp_str2 VARCHAR(50);
	DECLARE temp_id INT;
	DECLARE done INT DEFAULT FALSE;

	DECLARE grp_cur CURSOR
		FOR 
			select distinct tld.group, business_division_id
			 from enterprise_business_division ebd,
				  temp_load_departments tld
			where tld.division = ebd.business_division_nm;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	-- Populate enterprise business group.
	OPEN grp_cur;
		grp_loop: LOOP
			FETCH grp_cur INTO temp_str, temp_id;

			IF done THEN
				LEAVE grp_loop;
			END IF;

			INSERT INTO enterprise_business_group (group_nm, business_division_id) values (temp_str, temp_id);
		END LOOP grp_loop;
	CLOSE grp_cur;
	COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `load_lob` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dg_admin`@`%` PROCEDURE `load_lob`()
BEGIN
	DECLARE temp_str VARCHAR(50);
	DECLARE temp_str2 VARCHAR(50);
	DECLARE temp_id INT;
	DECLARE done INT DEFAULT FALSE;

	-- The line of business cursor
	DECLARE lob_cur CURSOR
		FOR
			SELECT DISTINCT line_of_business
              FROM temp_load_departments;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	-- Populate enterprise business line.
	OPEN lob_cur;
		lob_loop: LOOP
			FETCH lob_cur INTO temp_str;

			IF done THEN
				LEAVE lob_loop;
			END IF;

			INSERT INTO enterprise_business_line (line_nm) Values (temp_str);
		END LOOP lob_loop;
	CLOSE lob_cur;
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `load_team` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dg_admin`@`%` PROCEDURE `load_team`()
BEGIN
	DECLARE temp_str VARCHAR(50);
	DECLARE temp_str2 VARCHAR(50);
	DECLARE temp_id INT;
	DECLARE done INT DEFAULT FALSE;

	DECLARE team_cur CURSOR
		FOR 
			select distinct tld.team, dept_id
			 from department dept,
				  temp_load_departments tld
			where tld.department = dept.dept_nm;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	-- Populate team
	OPEN team_cur;
		team_loop: LOOP
			FETCH team_cur INTO temp_str, temp_id;

			IF done THEN
				LEAVE team_loop;
			END IF;

			INSERT INTO department_team (dept_team_nm, dept_id) values (temp_str, temp_id);
		END LOOP team_loop;
	CLOSE team_cur;
	COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-06-01 23:49:43
