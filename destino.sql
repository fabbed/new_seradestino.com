-- MySQL dump 10.11
--
-- Host: localhost    Database: seradestino
-- ------------------------------------------------------
-- Server version	5.0.75-0ubuntu10

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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Encuentros',NULL,'2009-12-12 13:57:09','2009-12-12 13:57:09'),(2,'Salud',NULL,'2009-12-12 13:57:10','2009-12-12 13:57:10'),(3,'Amor',NULL,'2009-12-12 13:57:10','2009-12-12 13:57:10'),(4,'Dinero',NULL,'2009-12-12 13:57:10','2009-12-12 13:57:10'),(5,'Suerte',NULL,'2009-12-12 13:57:10','2009-12-12 13:57:10'),(6,'Amigos',NULL,'2009-12-12 13:57:10','2009-12-12 13:57:10'),(7,'Trabajo',NULL,'2009-12-12 13:57:10','2009-12-12 13:57:10'),(8,'Sexo',NULL,'2009-12-12 13:57:10','2009-12-12 13:57:10'),(9,'Otros',NULL,'2009-12-12 13:57:10','2009-12-12 13:57:10');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL auto_increment,
  `commentable_id` int(11) default '0',
  `commentable_type` varchar(15) default '',
  `title` varchar(255) default '',
  `body` text,
  `subject` varchar(255) default '',
  `user_id` int(11) NOT NULL default '0',
  `ip` varchar(255) default NULL,
  `country_id` int(11) default NULL,
  `parent_id` int(11) default NULL,
  `lft` int(11) default NULL,
  `rgt` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_comments_on_user_id` (`user_id`),
  KEY `index_comments_on_commentable_id` (`commentable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,2,'Story','','Claro que sí. Todas las cosas que nos encontramos y nos hacen variar el rumbo a mejor, que nos abren los ojos, están ahí por algo. ¡Sólo hay que mirar bien y fijarse en el camino que nos disponen las estrellas!','',1,NULL,NULL,NULL,1,2,'2009-12-12 15:18:40','2009-12-12 15:18:40');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `countries` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `iso` varchar(255) default NULL,
  `visible` tinyint(1) default '1',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `sort_order` int(11) default NULL,
  `used_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=474 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'Afganistán','AF',1,'2008-09-13 18:59:33','2009-01-14 09:48:22',1000,1),(2,'Albania','AL',1,'2008-09-13 18:59:34','2009-01-14 09:48:22',1000,2),(3,'Alemania','DE',1,'2008-09-13 18:59:34','2009-01-14 09:48:22',1000,3),(4,'Andorra','AD',1,'2008-09-13 18:59:34','2009-01-14 09:48:22',1000,4),(5,'Angola','AO',1,'2008-09-13 18:59:34','2009-01-14 09:48:22',1000,5),(6,'Anguilla','AI',1,'2008-09-13 18:59:34','2009-01-14 09:48:22',1000,6),(7,'Antártida','AQ',1,'2008-09-13 18:59:35','2009-01-14 09:48:22',1000,7),(8,'Antigua y Barbuda','AG',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,8),(9,'Antillas Neerlandesas','AN',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,9),(10,'Arabia Saudí','SA',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,10),(11,'Argelia','DZ',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,11),(12,'Argentina','AR',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,12),(13,'Armenia','AM',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,13),(14,'Aruba','AW',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,14),(15,'ARY Macedonia','MK',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,15),(16,'Australia','AU',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,16),(17,'Austria','AT',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,17),(18,'Azerbaiyán','AZ',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,18),(19,'Bahamas','BS',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,19),(20,'Bahréin','BH',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,20),(21,'Bangladesh','BD',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,21),(22,'Barbados','BB',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,22),(23,'Bélgica','BE',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,23),(24,'Belice','BZ',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,24),(25,'Benin','BJ',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,25),(26,'Bermudas','BM',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,26),(27,'Bhután','BT',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,27),(28,'Bielorrusia','BY',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,28),(29,'Bolivia','BO',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,29),(30,'Bosnia y Herzegovina','BA',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,30),(31,'Botsuana','BW',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,31),(32,'Brasil','BR',1,'2008-09-13 18:59:36','2009-01-14 09:48:22',1000,32),(33,'Brunéi','BN',1,'2008-09-13 18:59:37','2009-01-14 09:48:22',1000,33),(34,'Bulgaria','BG',1,'2008-09-13 18:59:37','2009-01-14 09:48:22',1000,34),(35,'Burkina Faso','BF',1,'2008-09-13 18:59:37','2009-01-14 09:48:22',1000,35),(36,'Burundi','BI',1,'2008-09-13 18:59:37','2009-01-14 09:48:22',1000,36),(37,'Cabo Verde','CV',1,'2008-09-13 18:59:37','2009-01-14 09:48:22',1000,37),(38,'Camboya','KH',1,'2008-09-13 18:59:37','2009-01-14 09:48:22',1000,38),(39,'Camerún','CM',1,'2008-09-13 18:59:37','2009-01-14 09:48:22',1000,39),(40,'Canadá','CA',1,'2008-09-13 18:59:37','2009-01-14 09:48:22',1000,40),(41,'Chad','TD',1,'2008-09-13 18:59:37','2009-01-14 09:48:22',1000,41),(42,'Chile','CL',1,'2008-09-13 18:59:37','2009-01-14 09:48:22',1000,42),(43,'China','CN',1,'2008-09-13 18:59:37','2009-01-14 09:48:22',1000,43),(44,'Chipre','CY',1,'2008-09-13 18:59:37','2009-01-14 09:48:22',1000,44),(45,'Ciudad del Vaticano','VA',1,'2008-09-13 18:59:37','2009-01-14 09:48:22',1000,45),(46,'Colombia','CO',1,'2008-09-13 18:59:38','2009-01-14 09:48:22',1000,46),(47,'Comoras','KM',1,'2008-09-13 18:59:38','2009-01-14 09:48:22',1000,47),(48,'Congo','CG',1,'2008-09-13 18:59:38','2009-01-14 09:48:22',1000,48),(49,'Corea del Norte','KP',1,'2008-09-13 18:59:38','2009-01-14 09:48:22',1000,49),(50,'Corea del Sur','KR',1,'2008-09-13 18:59:39','2009-01-14 09:48:22',1000,50),(51,'Costa de Marfil','CI',1,'2008-09-13 18:59:39','2009-01-14 09:48:22',1000,51),(52,'Costa Rica','CR',1,'2008-09-13 18:59:39','2009-01-14 09:48:22',1000,52),(53,'Croacia','HR',1,'2008-09-13 18:59:39','2009-01-14 09:48:22',1000,53),(54,'Cuba','CU',1,'2008-09-13 18:59:39','2009-01-14 09:48:22',1000,54),(55,'Dinamarca','DK',1,'2008-09-13 18:59:39','2009-01-14 09:48:22',1000,55),(56,'Dominica','DM',1,'2008-09-13 18:59:39','2009-01-14 09:48:22',1000,56),(57,'Ecuador','EC',1,'2008-09-13 18:59:39','2009-01-14 09:48:22',1000,57),(58,'Egipto','EG',1,'2008-09-13 18:59:39','2009-01-14 09:48:22',1000,58),(59,'El Salvador','SV',1,'2008-09-13 18:59:39','2009-01-14 09:48:22',1000,59),(60,'Emiratos Árabes Unidos','AE',1,'2008-09-13 18:59:39','2009-01-14 09:48:22',1000,60),(61,'Eritrea','ER',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,61),(62,'Eslovaquia','SK',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,62),(63,'Eslovenia','SI',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,63),(64,'España','ES',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,64),(65,'Estados Unidos','US',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,65),(66,'Estonia','EE',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,66),(67,'Etiopía','ET',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,67),(68,'Filipinas','PH',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,68),(69,'Finlandia','FI',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,69),(70,'Fiyi','FJ',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,70),(71,'Francia','FR',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,71),(72,'Gabón','GA',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,72),(73,'Gambia','GM',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,73),(74,'Georgia','GE',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,74),(75,'Ghana','GH',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,75),(76,'Gibraltar','GI',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,76),(77,'Granada','GD',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,77),(78,'Grecia','GR',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,78),(79,'Groenlandia','GL',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,79),(80,'Guadalupe','GP',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,80),(81,'Guam','GU',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,81),(82,'Guatemala','GT',1,'2008-09-13 18:59:39','2009-01-14 09:48:23',1000,82),(83,'Guayana Francesa','GF',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,83),(84,'Guinea','GN',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,84),(85,'Guinea Ecuatorial','GQ',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,85),(86,'Guinea-Bissau','GW',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,86),(87,'Guyana','GY',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,87),(88,'Haití','HT',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,88),(89,'Honduras','HN',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,89),(90,'Hong Kong','HK',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,90),(91,'Hungría','HU',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,91),(92,'India','IN',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,92),(93,'Indonesia','ID',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,93),(94,'Irán','IR',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,94),(95,'Iraq','IQ',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,95),(96,'Irlanda','IE',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,96),(97,'Isla Bouvet','BV',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,97),(98,'Isla de Navidad','CX',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,98),(99,'Isla Norfolk','NF',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,99),(100,'Islandia','IS',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,100),(101,'Islas Caimán','KY',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,101),(102,'Islas Cocos','CC',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,102),(103,'Islas Cook','CK',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,103),(104,'Islas Feroe','FO',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,104),(105,'Islas Georgias del Sur y Sandwich del Sur','GS',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,105),(106,'Islas Heard y McDonald','HM',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,106),(107,'Islas Malvinas','FK',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,107),(108,'Islas Marianas del Norte','MP',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,108),(109,'Islas Marshall','MH',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,109),(110,'Islas Pitcairn','PN',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,110),(111,'Islas Salomón','SB',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,111),(112,'Islas Turcas y Caicos','TC',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,112),(113,'Islas ultramarinas de Estados Unidos','UM',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,113),(114,'Islas Vírgenes Británicas','VG',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,114),(115,'Islas Vírgenes de los Estados Unidos','VI',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,115),(116,'Islas Åland','AX',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,116),(117,'Israel','IL',1,'2008-09-13 18:59:40','2009-01-14 09:48:23',1000,117),(118,'Italia','IT',1,'2008-09-13 18:59:41','2009-01-14 09:48:23',1000,118),(119,'Jamaica','JM',1,'2008-09-13 18:59:41','2009-01-14 09:48:23',1000,119),(120,'Japón','JP',1,'2008-09-13 18:59:41','2009-01-14 09:48:23',1000,120),(121,'Jordania','JO',1,'2008-09-13 18:59:41','2009-01-14 09:48:23',1000,121),(122,'Kazajstán','KZ',1,'2008-09-13 18:59:41','2009-01-14 09:48:23',1000,122),(123,'Kenia','KE',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,123),(124,'Kirguistán','KG',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,124),(125,'Kiribati','KI',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,125),(126,'Kuwait','KW',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,126),(127,'Laos','LA',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,127),(128,'Lesotho','LS',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,128),(129,'Letonia','LV',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,129),(130,'Líbano','LB',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,130),(131,'Liberia','LR',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,131),(132,'Libia','LY',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,132),(133,'Liechtenstein','LI',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,133),(134,'Lituania','LT',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,134),(135,'Luxemburgo','LU',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,135),(136,'Macao','MO',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,136),(137,'Madagascar','MG',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,137),(138,'Malasia','MY',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,138),(139,'Malawi','MW',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,139),(140,'Maldivas','MV',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,140),(141,'Malí','ML',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,141),(142,'Malta','MT',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,142),(143,'Marruecos','MA',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,143),(144,'Martinica','MQ',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,144),(145,'Mauricio','MU',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,145),(146,'Mauritania','MR',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,146),(147,'Mayotte','YT',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,147),(148,'México','MX',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,148),(149,'Micronesia','FM',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,149),(150,'Moldavia','MD',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,150),(151,'Mónaco','MC',1,'2008-09-13 18:59:42','2009-01-14 09:48:23',1000,151),(152,'Mongolia','MN',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,152),(153,'Montserrat','MS',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,153),(154,'Mozambique','MZ',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,154),(155,'Myanmar','MM',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,155),(156,'Namibia','NA',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,156),(157,'Nauru','NR',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,157),(158,'Nepal','NP',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,158),(159,'Nicaragua','NI',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,159),(160,'Níger','NE',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,160),(161,'Nigeria','NG',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,161),(162,'Niue','NU',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,162),(163,'Noruega','NO',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,163),(164,'Nueva Caledonia','NC',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,164),(165,'Nueva Zelanda','NZ',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,165),(166,'Omán','OM',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,166),(167,'Países Bajos','NL',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,167),(168,'Pakistán','PK',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,168),(169,'Palau','PW',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,169),(170,'Palestina','PS',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,170),(171,'Panamá','PA',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,171),(172,'Papúa Nueva Guinea','PG',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,172),(173,'Paraguay','PY',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,173),(174,'Perú','PE',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,174),(175,'Polinesia Francesa','PF',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,175),(176,'Polonia','PL',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,176),(177,'Portugal','PT',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,177),(178,'Puerto Rico','PR',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,178),(179,'Qatar','QA',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,179),(180,'Reino Unido','GB',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,180),(181,'República Centroafricana','CF',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,181),(182,'República Checa','CZ',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,182),(183,'República Democrática del Congo','CD',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,183),(184,'República Dominicana','DO',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,184),(185,'Reunión','RE',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,185),(186,'Ruanda','RW',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,186),(187,'Rumania','RO',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,187),(188,'Rusia','RU',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,188),(189,'Sáhara Occidental','EH',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,189),(190,'Samoa','WS',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,190),(191,'Samoa Americana','AS',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,191),(192,'San Cristóbal y Nieves','KN',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,192),(193,'San Marino','SM',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,193),(194,'San Pedro y Miquelón','PM',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,194),(195,'San Vicente y las Granadinas','VC',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,195),(196,'Santa Helena','SH',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,196),(197,'Santa Lucía','LC',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,197),(198,'Santo Tomé y Príncipe','ST',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,198),(199,'Senegal','SN',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,199),(200,'Serbia y Montenegro','CS',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,200),(201,'Seychelles','SC',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,201),(202,'Sierra Leona','SL',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,202),(203,'Singapur','SG',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,203),(204,'Siria','SY',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,204),(205,'Somalia','SO',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,205),(206,'Sri Lanka','LK',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,206),(207,'Suazilandia','SZ',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,207),(208,'Sudáfrica','ZA',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,208),(209,'Sudán','SD',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,209),(210,'Suecia','SE',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,210),(211,'Suiza','CH',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,211),(212,'Surinam','SR',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,212),(213,'Svalbard y Jan Mayen','SJ',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,213),(214,'Tailandia','TH',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,214),(215,'Taiwán','TW',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,215),(216,'Tanzania','TZ',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,216),(217,'Tayikistán','TJ',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,217),(218,'Territorio Británico del Océano Índico','IO',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,218),(219,'Territorios Australes Franceses','TF',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,219),(220,'Timor Oriental','TL',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,220),(221,'Togo','TG',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,221),(222,'Tokelau','TK',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,222),(223,'Tonga','TO',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,223),(224,'Trinidad y Tobago','TT',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,224),(225,'Túnez','TN',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,225),(226,'Turkmenistán','TM',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,226),(227,'Turquía','TR',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,227),(228,'Tuvalu','TV',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,228),(229,'Ucrania','UA',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,229),(230,'Uganda','UG',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,230),(231,'Uruguay','UY',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,231),(232,'Uzbekistán','UZ',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,232),(233,'Vanuatu','VU',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,233),(234,'Venezuela','VE',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,234),(235,'Vietnam','VN',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,235),(236,'Wallis y Futuna','WF',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,236),(237,'Yemen','YE',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,237),(238,'Yibuti','DJ',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,238),(239,'Zambia','ZM',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,239),(240,'Zimbabue','ZW',1,'2008-09-13 18:59:43','2009-01-14 09:48:23',1000,240),(435,'Alemania','DE',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',0,3),(436,'Argentina','AR',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',1,12),(437,'Armenia','AM',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',2,13),(438,'Bolivia','BO',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',3,29),(439,'Brasil','BR',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',4,32),(440,'Chile','CL',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',5,42),(441,'Colombia','CO',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',6,46),(442,'Costa Rica','CR',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',7,52),(443,'Cuba','CU',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',8,54),(444,'Dominica','DM',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',9,56),(445,'Ecuador','EC',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',10,57),(446,'El Salvador','SV',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',11,59),(447,'España','ES',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',12,64),(448,'Estados Unidos','US',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',13,65),(449,'Guam','GU',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',14,81),(450,'Guatemala','GT',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',15,82),(451,'Guinea Ecuatorial','GQ',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',16,85),(452,'Honduras','HN',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',17,89),(453,'Italia','IT',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',18,118),(454,'Japón','JP',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',19,120),(455,'Marruecos','MA',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',20,143),(456,'Mauricio','MU',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',21,145),(457,'México','MX',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',22,148),(458,'Micronesia','FM',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',23,149),(459,'Nicaragua','NI',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',24,159),(460,'Países Bajos','NL',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',25,167),(461,'Panamá','PA',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',26,171),(462,'Paraguay','PY',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',27,173),(463,'Perú','PE',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',28,174),(464,'Puerto Rico','PR',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',29,178),(465,'República Dominicana','DO',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',30,184),(466,'Rusia','RU',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',31,188),(467,'Senegal','SN',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',32,199),(468,'Seychelles','SC',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',33,201),(469,'Togo','TG',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',34,221),(470,'Uruguay','UY',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',35,231),(471,'Vanuatu','VU',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',36,233),(472,'Venezuela','VE',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',37,234),(473,'Alemania','EU',1,'2009-01-14 09:48:23','2009-01-14 09:48:23',1000,3);
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `locations` (
  `id` int(11) NOT NULL auto_increment,
  `lng` float default NULL,
  `lat` float default NULL,
  `country_id` int(11) default NULL,
  `city` varchar(255) default NULL,
  `precision` varchar(255) default NULL,
  `country_code` varchar(255) default NULL,
  `locatable_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,13.4,52.5167,64,'Berlin','unknown','ES',1),(2,13.4,52.5167,64,'Berlin','unknown','ES',1),(3,13.4,52.5167,3,'Berlin','unknown','DE',2),(4,13.4,52.5167,3,'Berlin','unknown','DE',2),(5,13.4,52.5167,3,'Berlin','unknown','DE',1);
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsletter_registrations`
--

DROP TABLE IF EXISTS `newsletter_registrations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `newsletter_registrations` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `newsletter_registrations`
--

LOCK TABLES `newsletter_registrations` WRITE;
/*!40000 ALTER TABLE `newsletter_registrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `newsletter_registrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ratings` (
  `id` int(11) NOT NULL auto_increment,
  `rateable_id` int(11) default NULL,
  `rateable_type` varchar(255) default NULL,
  `average_rating` float default NULL,
  `ratings_count` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_ratings_on_rateable_id_and_rateable_type` (`rateable_id`,`rateable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20090504154415'),('20090511185000'),('20091125074912'),('20091125082648'),('20091125173745'),('20091126201835'),('20091126202120'),('20091206182446'),('20091209101325'),('20091209111327'),('20091209111335'),('20091209141048'),('20091209162148'),('20091211144723');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slugs`
--

DROP TABLE IF EXISTS `slugs`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `slugs` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `sluggable_id` int(11) default NULL,
  `sequence` int(11) NOT NULL default '1',
  `sluggable_type` varchar(40) default NULL,
  `scope` varchar(40) default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_slugs_on_name_and_sluggable_type_and_scope_and_sequence` (`name`,`sluggable_type`,`scope`,`sequence`),
  KEY `index_slugs_on_sluggable_id` (`sluggable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `slugs`
--

LOCK TABLES `slugs` WRITE;
/*!40000 ALTER TABLE `slugs` DISABLE KEYS */;
INSERT INTO `slugs` VALUES (1,'asi-se-conocieron-mis-padres',1,1,'Story',NULL,'2009-12-12 14:36:54'),(2,'lo-que-me-hizo-creer-en-los-signos-y-el-camino-predeterminado-de-una-persona',2,1,'Story',NULL,'2009-12-12 15:04:40');
/*!40000 ALTER TABLE `slugs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stories`
--

DROP TABLE IF EXISTS `stories`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `stories` (
  `id` int(11) NOT NULL auto_increment,
  `body` text,
  `title` varchar(100) default NULL,
  `seo_title` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `rated_top` int(11) default '0',
  `rated_flop` int(11) default '0',
  `anonymous` tinyint(1) default '1',
  `on_startpage` tinyint(1) default '0',
  `category_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `location_id` int(11) default NULL,
  `country_id` int(11) default NULL,
  `ip` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `notifications` tinyint(1) default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `stories`
--

LOCK TABLES `stories` WRITE;
/*!40000 ALTER TABLE `stories` DISABLE KEYS */;
INSERT INTO `stories` VALUES (1,'La que sería mi abuela materna era entonces una niña de 13 años y trabaja de costurera para una señora más mayor, que sería, años después, la madre de mi padre. Tuvieron una muy buena relación durante mucho tiempo, inluso después de dejar de trabajar para ella.\r\n\r\nLa última vez que se vieron, la madre de mi madre visitó a la otra para conocer al hijo que acababa de tener. MI abuela iba embarazada de mi madre. Y mi abuela le dijo: Raquel, a ver si tienes una niña para mi niño. Una broma que se puede hacer.\r\n\r\nMi abuela por parte de padre, murió a los dos años y mis padres nunca se vieron de niños pero mi madre siempre escuchó historias de esa familia.\r\n\r\nAl cabo de los años, mi madre entró en una discoteca con dos amigas y vió a un chico en la barra, le gustó y, quizá también como una broma cualquiera dijo: \"Ése es el hombre con el qe¡ue me voy a casar.\" Sus amigas se rieron con la tontería pero 10 meses después estaban casados.\r\n\r\nImaginaos el susto de mi abuela Raquel cuando se enteró de quién era hijo el que iba a ser marido de su hija.\r\n\r\nSí, pueden ser casualidades, cosas que se dicen sin pensar, tal vez muchas veces, pero acertaron. ¿Sólo una casualidad? A mí me gusta pensar que no. :)))))','Así se conocieron mis padres','Así se conocieron mis padres','',0,0,0,0,3,1,1,NULL,NULL,'2009-12-12 14:36:54','2009-12-12 14:40:44',1),(2,'Fue en alemania, en colonia.\r\nEn una noche estuvimos mi amigo y yo al lado del Rhin, tocando la guitarra, cantando, tomando cervecitas al borde del rio.\r\n\r\nSucedió que mis amigos fueron a comprar más cerveza y yo me quedé solo tocando la guitarra. Empecé con los primeras acordes de  \"The end\"(El fin), de Jim Morrisson y The Doors.\r\n\r\nCuando empezaba a cantar una chica pasó por el camino, se paró y me miró fijamente a los ojos mientas escuchaba la cancion. Yo tambián la miré y me puse algo nervioso. Directamente sentía que con ella algo iba a pasar. La verdad es que fueron 3 minutos super mágicos. Cuando terminé la cancion, ella se acercó y dijo \"Hola\". No habia duda de que me hablaba a mí, tenia que ser asi, no habáa otra persona. Nos miramos un rato más y empezamos una conversación de muy pocas palabras, pues todo estaba claro. Ella y yo pensábamos lo mismo: \"Nos tenemos que conocer, tenemos que estar juntos.\"\r\n\r\nElla: Me tengo que ir a tomar el bus.\r\nYo: Voy contigo y te acompaño a la estación.\r\nElla: Claro que vienes conmigo.\r\n\r\nEn la estacion me dió su número y me dijo que la llamara al dá siguiente. Cuando se subió al bus me dijo: \"Has leído El Alquimista, el libro de Paulo Coehlo?\". Yo  respondí con un \"No\".\r\n\r\nMe enamoré intensamente y a la mañana siguiente no fui a la uni, sino a la librería a comprar \"El Alquimista\". Sin pausas lo leí en un dia.\r\n\r\nPara que los que no conocen al libro, trata de un joven que esta buscando su camino, y mientras aprende que cada persona tiene un camino predeterminado y que sólo hay que estar atento para ver los signos que lo guían.\r\n\r\nMe encantó. Y pensé: \"Esa chica se cruzó en mi camino sólo para hablarme del libro, para que yo empiece a sensibilizarme\"\r\n\r\nY asi fue! Muy enamorado la llamé y le dije \"Ya me he terminado el libro, es increíble, muy bueno. Era un signo que me hablaras de él\".\r\n\r\nQuedamos el día después en mi casa, tomamos mucho vino y empezamos a besarnos y nos acostamos. Pero, os lo podéis creer? Se fue toda la magia, no nos llevabamos bien, una catástrofe. Ella no me gustababa nada y yo a ella tampoco. Se fue de mi casa y nunca más quedé con ella ni la volví a ver.\r\n\r\nLo que se quedó era lo que aprendí en el libro: Creer en los signos, sensibilizarse para ver lo que \"el destino\" te pone en tu camino. Si eres capaz de ver los signos en tu camino, que se manifiestan en personas, en cosas, en tus sueños... el destino te muestra lo que tienes que hacer y va a ser bueno para ti.\r\n\r\nAl final esto es lo que creo: Esta chica me la crucé para que me hablara del libro, para creer en mi destino. Muchas cosas cambiaron a partir de entonces con mis nuevos ojos.\r\n\r\n¿Que creen ustedes?\r\n¿Era destino o sólo casualidad?\r\n','Lo que me hizo creer en los signos y el camino predeterminado de una persona','Lo que me hizo creer en los signos y el camino predeterminado de una persona','fabian.dittrich@gmail.com',0,0,1,0,1,2,3,NULL,NULL,'2009-12-12 15:04:40','2009-12-12 15:14:00',1);
/*!40000 ALTER TABLE `stories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taggings`
--

DROP TABLE IF EXISTS `taggings`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `taggings` (
  `id` int(11) NOT NULL auto_increment,
  `tag_id` int(11) default NULL,
  `taggable_id` int(11) default NULL,
  `taggable_type` varchar(255) default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_taggings_on_tag_id` (`tag_id`),
  KEY `index_taggings_on_taggable_id_and_taggable_type` (`taggable_id`,`taggable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `taggings`
--

LOCK TABLES `taggings` WRITE;
/*!40000 ALTER TABLE `taggings` DISABLE KEYS */;
INSERT INTO `taggings` VALUES (1,1,1,'Story','2009-12-12 14:36:54'),(2,2,1,'Story','2009-12-12 14:36:54'),(3,3,1,'Story','2009-12-12 14:36:54'),(4,4,1,'Story','2009-12-12 14:36:54'),(5,5,2,'Story','2009-12-12 15:04:40'),(6,6,2,'Story','2009-12-12 15:04:40'),(7,7,2,'Story','2009-12-12 15:04:40'),(8,8,2,'Story','2009-12-12 15:04:40');
/*!40000 ALTER TABLE `taggings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'amor'),(2,'conocerse'),(3,'encuentros'),(4,'matrimonio'),(5,'signos'),(6,'enamorado'),(7,'libros'),(8,'alquimista');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_ratings`
--

DROP TABLE IF EXISTS `user_ratings`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `user_ratings` (
  `id` int(11) NOT NULL auto_increment,
  `rating_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `score` int(11) default NULL,
  `anonymous` varchar(255) default '1',
  `vcode` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_user_ratings_on_user_id_and_rating_id` (`user_id`,`rating_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `user_ratings`
--

LOCK TABLES `user_ratings` WRITE;
/*!40000 ALTER TABLE `user_ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(40) default NULL,
  `name` varchar(100) default '',
  `email` varchar(100) default NULL,
  `crypted_password` varchar(40) default NULL,
  `salt` varchar(40) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `remember_token` varchar(40) default NULL,
  `remember_token_expires_at` datetime default NULL,
  `activation_code` varchar(40) default NULL,
  `activated_at` datetime default NULL,
  `birthdate` datetime default NULL,
  `gender` varchar(1) default NULL,
  `country_id` int(11) default NULL,
  `location_id` int(11) default NULL,
  `avatar_file_name` varchar(255) default NULL,
  `avatar_content_type` varchar(255) default NULL,
  `avatar_file_size` int(11) default NULL,
  `avatar_updated_at` datetime default NULL,
  `vcode` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_users_on_login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'lunallena','','elenacon@hotmail.com','a016695effe1e2106b35669372c72cb4476850c8','f7b370d688d33e5e152006de82432253b7bb027f','2009-12-12 14:40:03','2009-12-12 14:44:26',NULL,NULL,NULL,'2009-12-12 14:40:41','1983-01-01 00:00:00','f',NULL,2,'Snapshot_of_me_11.png','image/png',136135,'2009-12-12 14:44:25','w9i4zckn'),(2,'esceptico28','','fabian.dittrich@gmail.com','33dc909e879b70c0725ad7527d0782f89ec7f850','648e3eef0d2d2201d8371fd3ad82af86f5e15dc1','2009-12-12 15:12:22','2009-12-12 15:13:23',NULL,NULL,NULL,'2009-12-12 15:13:04','1981-03-29 00:00:00','m',NULL,4,'fab_cool.jpg','image/jpeg',23460,'2009-12-12 15:13:22','1r60l9ri');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitor_sessions`
--

DROP TABLE IF EXISTS `visitor_sessions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `visitor_sessions` (
  `id` int(11) NOT NULL auto_increment,
  `visitor_id` int(11) default NULL,
  `ip` varchar(15) NOT NULL,
  `session_id` varchar(255) NOT NULL,
  `user_agent` varchar(255) default NULL,
  `referer` varchar(255) default NULL,
  `pageviews` int(11) default '1',
  `stories` text,
  `comments` text,
  `ratings` text,
  `recommendations` text,
  `request_method` varchar(7) NOT NULL,
  `http_accept_language` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `visitor_sessions`
--

LOCK TABLES `visitor_sessions` WRITE;
/*!40000 ALTER TABLE `visitor_sessions` DISABLE KEYS */;
INSERT INTO `visitor_sessions` VALUES (1,1,'89.247.237.152','364f1e877f5f6a295d42e5b56ef05c51','Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1.5) Gecko/20091102 Firefox/3.5.5',NULL,19,'--- \n- 2\n','--- []\n\n','--- []\n\n','--- []\n\n','GET','de','2009-12-12 14:25:19','2009-12-12 16:05:28'),(2,2,'89.247.237.152','2fabaa6e6e2fc768f5d5945567152b15','Mozilla/5.0 (Windows; U; Windows NT 5.1; es-ES; rv:1.9.1.5) Gecko/20091102 Firefox/3.5.5',NULL,26,'--- \n- 1\n','--- \n- 1\n','--- []\n\n','--- []\n\n','GET','es-es,es;q=0.8,en-us;q=0.5,en;q=0.3','2009-12-12 14:26:41','2009-12-12 15:17:01');
/*!40000 ALTER TABLE `visitor_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitors`
--

DROP TABLE IF EXISTS `visitors`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `visitors` (
  `id` int(11) NOT NULL auto_increment,
  `email` varchar(255) default NULL,
  `vcode` varchar(255) default NULL,
  `logins` int(11) default '1',
  `ip` varchar(15) NOT NULL,
  `referer` varchar(255) default NULL,
  `manipulation_level` varchar(255) default NULL,
  `user_agent` varchar(255) default NULL,
  `country_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `visitors`
--

LOCK TABLES `visitors` WRITE;
/*!40000 ALTER TABLE `visitors` DISABLE KEYS */;
INSERT INTO `visitors` VALUES (1,NULL,'1r60l9ri',1,'89.247.237.152',NULL,NULL,'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1.5) Gecko/20091102 Firefox/3.5.5',3,'2009-12-12 14:25:18','2009-12-12 14:25:18'),(2,NULL,'w9i4zckn',1,'89.247.237.152',NULL,NULL,'Mozilla/5.0 (Windows; U; Windows NT 5.1; es-ES; rv:1.9.1.5) Gecko/20091102 Firefox/3.5.5',3,'2009-12-12 14:26:40','2009-12-12 14:26:40');
/*!40000 ALTER TABLE `visitors` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-12-12 16:13:53
