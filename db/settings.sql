-- MySQL dump 10.11
--
-- Host: localhost    Database: iglesia
-- ------------------------------------------------------
-- Server version	5.0.51a-log

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
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL auto_increment,
  `var` varchar(255) NOT NULL,
  `value` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (14,'site_address','Casa Provincial de las Hermanas Salesianas <br /> 124 Saladaeng Road, Bangkok 10500, Thailand','2008-08-25 10:03:15','2008-08-25 10:03:15'),(15,'site_footer1','Comunidad Catolica Latina en Bangkok, Tailandia','2008-08-25 10:03:26','2008-08-25 10:03:26'),(17,'site_verse','Porque donde hay dos o tres reunidos en mi Nombre, yo estoy presente en medio de ellos. (Mt 18, 20)','2008-08-25 10:07:23','2008-08-25 10:09:59'),(5,'per_page','20','2008-08-25 09:56:11','2008-08-25 09:58:18'),(6,'logo_title','Comunidad Catolica Latina','2008-08-25 09:59:33','2008-08-25 09:59:33'),(7,'logo_subtitle','Donde Los Catolicos Latinos se Reúnen en Bangkok.','2008-08-25 09:59:54','2008-08-25 09:59:54'),(8,'email','admin@comunidad-catolica.com','2008-08-25 10:00:28','2008-08-25 10:00:37'),(9,'site_email','comunidadcatolicabk@gmail.com','2008-08-25 10:00:55','2008-08-25 10:00:55'),(10,'google_analytics_key','UA-737604-12','2008-08-25 10:01:22','2008-08-25 10:01:22'),(11,'content_keywords','Catholic Church, Bangkok, Iglesia Catolica, Latina, Hispano, Tailandia, Thailand, Spanish, Espanol, Misa, Mass','2008-08-25 10:01:45','2008-08-25 10:01:45'),(12,'theme','toader','2008-08-25 10:01:52','2008-08-25 10:01:52'),(13,'content_author','Comunidad Catolica Latina en Bangkok, Tailandia','2008-08-25 10:02:05','2008-08-25 10:02:05'),(16,'site_footer2','Misas todos los sabados, 18:00 pm.','2008-08-25 10:03:37','2008-08-25 10:03:37');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2008-08-25 12:09:20
