-- MySQL dump 10.13  Distrib 5.7.36, for Linux (x86_64)
--
-- Host: localhost    Database: directus
-- ------------------------------------------------------
-- Server version	5.7.36

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
-- Table structure for table `directus_activity`
--

DROP TABLE IF EXISTS `directus_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_activity` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(45) NOT NULL,
  `action_by` int(11) unsigned NOT NULL DEFAULT '0',
  `action_on` datetime NOT NULL,
  `ip` varchar(50) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `collection` varchar(64) NOT NULL,
  `item` varchar(255) NOT NULL,
  `edited_on` datetime DEFAULT NULL,
  `comment` text CHARACTER SET utf8mb4,
  `comment_deleted_on` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `directus_activity`
--

LOCK TABLES `directus_activity` WRITE;
/*!40000 ALTER TABLE `directus_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `directus_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `directus_collection_presets`
--

DROP TABLE IF EXISTS `directus_collection_presets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_collection_presets` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `user` int(11) unsigned DEFAULT NULL,
  `role` int(11) unsigned DEFAULT NULL,
  `collection` varchar(64) NOT NULL,
  `search_query` varchar(100) DEFAULT NULL,
  `filters` text,
  `view_type` varchar(100) NOT NULL DEFAULT 'tabular',
  `view_query` text,
  `view_options` text,
  `translation` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_collection_title` (`user`,`collection`,`title`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `directus_collection_presets`
--

LOCK TABLES `directus_collection_presets` WRITE;
/*!40000 ALTER TABLE `directus_collection_presets` DISABLE KEYS */;
INSERT INTO `directus_collection_presets` VALUES (1,NULL,NULL,NULL,'directus_activity',NULL,NULL,'timeline','{\"timeline\":{\"sort\":\"-action_on\"}}','{\"timeline\":{\"date\":\"action_on\",\"title\":\"{{ action }} by {{ action_by.first_name }} {{ action_by.last_name }} (#{{ item }})\",\"content\":\"collection\",\"color\":\"action\"}}',NULL),(2,NULL,NULL,NULL,'directus_files',NULL,NULL,'cards',NULL,'{\"cards\":{\"title\":\"title\",\"subtitle\":\"type\",\"content\":\"description\",\"src\":\"data\"}}',NULL),(3,NULL,NULL,NULL,'directus_users',NULL,NULL,'cards',NULL,'{\"cards\":{\"title\":\"first_name\",\"subtitle\":\"last_name\",\"content\":\"title\",\"src\":\"avatar\",\"icon\":\"person\"}}',NULL),(4,NULL,NULL,NULL,'directus_webhooks',NULL,NULL,'tabular','{\"tabular\":{\"fields\":\"status,http_action,url,collection,directus_action\"}}','{\"tabular\":{\"widths\":{\"status\":32,\"http_action\":72,\"url\":200,\"collection\":200,\"directus_action\":200}}}',NULL),(5,NULL,1,NULL,'meny',NULL,NULL,'tabular','{\"tabular\":{\"sort\":\"sort\"}}',NULL,NULL),(6,NULL,1,NULL,'sidor',NULL,NULL,'tabular','{\"tabular\":{\"sort\":\"titel\"}}',NULL,NULL),(7,NULL,1,NULL,'nyheter',NULL,NULL,'tabular','{\"tabular\":{\"sort\":\"-publish_date\"}}','{\"tabular\":{\"widths\":{\"status\":132,\"ingress\":200,\"publish_date\":271,\"titel\":200}}}',NULL);
/*!40000 ALTER TABLE `directus_collection_presets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `directus_collections`
--

DROP TABLE IF EXISTS `directus_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_collections` (
  `collection` varchar(64) NOT NULL,
  `managed` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `hidden` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `single` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `icon` varchar(30) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `translation` text,
  PRIMARY KEY (`collection`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `directus_collections`
--

LOCK TABLES `directus_collections` WRITE;
/*!40000 ALTER TABLE `directus_collections` DISABLE KEYS */;
INSERT INTO `directus_collections` VALUES ('meny',1,0,0,'menu','Sidans meny',NULL),('nyheter',1,0,0,NULL,'Här kan nyheter läggas upp',NULL),('nyheter_directus_files',1,1,0,NULL,'Junction Collection',NULL),('sidor',1,0,0,NULL,'Här läggs vanliga sidor',NULL),('sidor_directus_files',1,1,0,NULL,'Junction Collection',NULL);
/*!40000 ALTER TABLE `directus_collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `directus_fields`
--

DROP TABLE IF EXISTS `directus_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_fields` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `collection` varchar(64) NOT NULL,
  `field` varchar(64) NOT NULL,
  `type` varchar(64) NOT NULL,
  `interface` varchar(64) DEFAULT NULL,
  `options` text,
  `locked` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `validation` varchar(500) DEFAULT NULL,
  `required` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `readonly` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `hidden_detail` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `hidden_browse` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `sort` int(11) unsigned DEFAULT NULL,
  `width` varchar(50) DEFAULT 'full',
  `group` int(11) unsigned DEFAULT NULL,
  `note` varchar(1024) DEFAULT NULL,
  `translation` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_collection_field` (`collection`,`field`)
) ENGINE=InnoDB AUTO_INCREMENT=244 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `directus_fields`
--

LOCK TABLES `directus_fields` WRITE;
/*!40000 ALTER TABLE `directus_fields` DISABLE KEYS */;
INSERT INTO `directus_fields` VALUES (1,'directus_fields','id','integer','primary-key',NULL,1,NULL,1,0,1,0,NULL,'full',NULL,NULL,NULL),(2,'directus_fields','collection','m2o','many-to-one',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(3,'directus_fields','field','string','text-input',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(4,'directus_fields','type','string','primary-key',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(5,'directus_fields','interface','string','primary-key',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(6,'directus_fields','options','json','json',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(7,'directus_fields','locked','boolean','switch',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(8,'directus_fields','translation','json','repeater','{\n                    \"fields\": [\n                        {\n                            \"field\": \"locale\",\n                            \"type\": \"string\",\n                            \"interface\": \"language\",\n                            \"options\": {\n                                \"limit\": true\n                            },\n                            \"width\": \"half\"\n                        },\n                        {\n                            \"field\": \"translation\",\n                            \"type\": \"string\",\n                            \"interface\": \"text-input\",\n                            \"width\": \"half\"\n                        }\n                    ]\n                }',1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(9,'directus_fields','readonly','boolean','switch',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(10,'directus_fields','validation','string','text-input',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(11,'directus_fields','required','boolean','switch',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(12,'directus_fields','sort','sort','sort',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(13,'directus_fields','note','string','text-input',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(14,'directus_fields','hidden_detail','boolean','switch',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(15,'directus_fields','hidden_browse','boolean','switch',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(16,'directus_fields','width','integer','numeric',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(17,'directus_fields','group','m2o','many-to-one',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(18,'directus_activity','id','integer','primary-key',NULL,1,NULL,1,1,1,0,NULL,'full',NULL,NULL,NULL),(19,'directus_activity','action','string','text-input','{\"iconRight\":\"change_history\"}',1,NULL,0,1,0,0,1,'full',NULL,NULL,NULL),(20,'directus_activity','collection','string','collections','{\"iconRight\":\"list_alt\",\"include_system\":true}',1,NULL,0,1,0,0,2,'half',NULL,NULL,NULL),(21,'directus_activity','item','string','text-input','{\"iconRight\":\"link\"}',1,NULL,0,1,0,0,3,'half',NULL,NULL,NULL),(22,'directus_activity','action_by','integer','user','{\"iconRight\":\"account_circle\"}',1,NULL,0,1,0,0,4,'half',NULL,NULL,NULL),(23,'directus_activity','action_on','datetime','datetime','{\"showRelative\":true,\"iconRight\":\"calendar_today\"}',1,NULL,0,1,0,0,5,'half',NULL,NULL,NULL),(24,'directus_activity','edited_on','datetime','datetime','{\"showRelative\":true,\"iconRight\":\"edit\"}',1,NULL,0,1,0,0,6,'half',NULL,NULL,NULL),(25,'directus_activity','comment_deleted_on','datetime','datetime','{\"showRelative\":true,\"iconRight\":\"delete_outline\"}',1,NULL,0,1,0,0,7,'half',NULL,NULL,NULL),(26,'directus_activity','ip','string','text-input','{\"iconRight\":\"my_location\"}',1,NULL,0,1,0,0,8,'half',NULL,NULL,NULL),(27,'directus_activity','user_agent','string','text-input','{\"iconRight\":\"devices_other\"}',1,NULL,0,1,0,0,9,'half',NULL,NULL,NULL),(28,'directus_activity','comment','string','textarea',NULL,1,NULL,0,1,0,0,10,'full',NULL,NULL,NULL),(29,'directus_collection_presets','id','integer','primary-key',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(30,'directus_collection_presets','title','string','text-input',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(31,'directus_collection_presets','user','integer','user',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(32,'directus_collection_presets','role','m2o','many-to-one',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(33,'directus_collection_presets','collection','m2o','many-to-one',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(34,'directus_collection_presets','search_query','string','text-input',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(35,'directus_collection_presets','filters','json','json',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(36,'directus_collection_presets','view_options','json','json',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(37,'directus_collection_presets','view_type','string','text-input',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(38,'directus_collection_presets','view_query','json','json',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(39,'directus_collections','fields','o2m','one-to-many',NULL,1,NULL,0,0,1,1,1,'full',NULL,NULL,NULL),(40,'directus_collections','collection','string','primary-key',NULL,1,NULL,1,1,0,0,2,'half',NULL,NULL,NULL),(41,'directus_collections','note','string','text-input',NULL,1,NULL,0,0,0,0,3,'half',NULL,'An internal description.',NULL),(42,'directus_collections','managed','boolean','switch',NULL,1,NULL,0,0,1,0,4,'half',NULL,'[Learn More](https://docs.directus.io/guides/collections.html#managing-collections).',NULL),(43,'directus_collections','hidden','boolean','switch',NULL,1,NULL,0,0,0,0,5,'half',NULL,'[Learn More](https://docs.directus.io/guides/collections.html#hidden).',NULL),(44,'directus_collections','single','boolean','switch',NULL,1,NULL,0,0,0,0,6,'half',NULL,'[Learn More](https://docs.directus.io/guides/collections.html#single).',NULL),(45,'directus_collections','translation','json','repeater','{\n                    \"fields\": [\n                        {\n                            \"field\": \"locale\",\n                            \"type\": \"string\",\n                            \"interface\": \"language\",\n                            \"options\": {\n                                \"limit\": true\n                            },\n                            \"width\": \"half\"\n                        },\n                        {\n                            \"field\": \"translation\",\n                            \"type\": \"string\",\n                            \"interface\": \"text-input\",\n                            \"width\": \"half\"\n                        }\n                    ]\n                }',1,NULL,0,0,0,0,7,'full',NULL,NULL,NULL),(46,'directus_collections','icon','string','icon',NULL,1,NULL,0,0,0,0,8,'full',NULL,'The icon shown in the App\'s navigation sidebar.',NULL),(47,'directus_files','preview','alias','file-preview',NULL,1,NULL,0,0,0,0,1,'full',NULL,NULL,NULL),(48,'directus_files','title','string','text-input','{\"placeholder\":\"Enter a descriptive title...\",\"iconRight\":\"title\"}',1,NULL,0,0,0,0,2,'full',NULL,NULL,NULL),(49,'directus_files','tags','array','tags','{\"placeholder\":\"Enter a keyword then hit enter...\"}',1,NULL,0,0,0,0,3,'half',NULL,NULL,NULL),(50,'directus_files','location','string','text-input','{\"placeholder\":\"Enter a location...\",\"iconRight\":\"place\"}',1,NULL,0,0,0,0,4,'half',NULL,NULL,NULL),(51,'directus_files','description','string','wysiwyg','{\"toolbar\":[\"bold\",\"italic\",\"underline\",\"link\",\"code\"]}',1,NULL,0,0,0,0,5,'full',NULL,NULL,NULL),(52,'directus_files','filename_download','string','text-input','{\"monospace\":true,\"iconRight\":\"get_app\"}',1,NULL,0,0,0,0,6,'full',NULL,NULL,NULL),(53,'directus_files','filename_disk','string','text-input','{\"placeholder\":\"Enter a unique file name...\",\"iconRight\":\"insert_drive_file\"}',1,NULL,0,0,0,0,7,'full',NULL,NULL,NULL),(54,'directus_files','private_hash','slug','slug','{\"iconRight\":\"lock\"}',1,NULL,0,0,0,0,8,'half',NULL,NULL,NULL),(55,'directus_files','checksum','string','text-input','{\"iconRight\":\"check\",\"monospace\":true}',1,NULL,0,1,0,0,9,'half',NULL,NULL,NULL),(56,'directus_files','uploaded_on','datetime','datetime','{\"iconRight\":\"today\"}',1,NULL,1,1,0,0,10,'half',NULL,NULL,NULL),(57,'directus_files','uploaded_by','owner','owner',NULL,1,NULL,1,1,0,0,11,'half',NULL,NULL,NULL),(58,'directus_files','width','integer','numeric','{\"iconRight\":\"straighten\"}',1,NULL,0,1,0,0,12,'half',NULL,NULL,NULL),(59,'directus_files','height','integer','numeric','{\"iconRight\":\"straighten\"}',1,NULL,0,1,0,0,13,'half',NULL,NULL,NULL),(60,'directus_files','duration','integer','numeric','{\"iconRight\":\"timer\"}',1,NULL,0,1,0,0,14,'half',NULL,NULL,NULL),(61,'directus_files','filesize','integer','file-size','{\"iconRight\":\"storage\"}',1,NULL,0,1,0,0,15,'half',NULL,NULL,NULL),(62,'directus_files','metadata','json','key-value','{\"keyInterface\":\"text-input\",\"keyDataType\":\"string\",\"keyOptions\":{\"monospace\":true,\"placeholder\":\"Key\"},\"valueInterface\":\"text-input\",\"valueDataType\":\"string\",\"valueOptions\":{\"monospace\":true,\"placeholder\":\"Value\"}}',1,NULL,0,0,0,0,15,'full',NULL,NULL,NULL),(63,'directus_files','data','alias','file',NULL,1,NULL,0,0,1,0,NULL,'full',NULL,NULL,NULL),(64,'directus_files','id','integer','primary-key',NULL,1,NULL,1,0,1,0,NULL,'full',NULL,NULL,NULL),(65,'directus_files','type','string','text-input',NULL,1,NULL,0,1,1,0,NULL,'full',NULL,NULL,NULL),(66,'directus_files','charset','string','text-input',NULL,1,NULL,0,1,1,1,NULL,'full',NULL,NULL,NULL),(67,'directus_files','embed','string','text-input',NULL,1,NULL,0,1,1,0,NULL,'full',NULL,NULL,NULL),(68,'directus_files','folder','m2o','many-to-one',NULL,1,NULL,0,0,1,0,NULL,'full',NULL,NULL,NULL),(69,'directus_files','storage','string','text-input',NULL,1,NULL,0,0,1,1,NULL,'full',NULL,NULL,NULL),(70,'directus_folders','id','integer','primary-key',NULL,1,NULL,1,0,1,0,NULL,'full',NULL,NULL,NULL),(71,'directus_folders','name','string','text-input',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(72,'directus_folders','parent_folder','m2o','many-to-one',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(73,'directus_roles','id','integer','primary-key',NULL,1,NULL,1,0,1,0,NULL,'full',NULL,NULL,NULL),(74,'directus_roles','external_id','string','text-input',NULL,1,NULL,0,1,1,1,NULL,'full',NULL,NULL,NULL),(75,'directus_roles','name','string','text-input',NULL,1,NULL,1,0,0,0,1,'half',NULL,NULL,NULL),(76,'directus_roles','description','string','text-input',NULL,1,NULL,0,0,0,0,2,'half',NULL,NULL,NULL),(77,'directus_roles','ip_whitelist','array','tags','{\"\":\"Add an IP address...\"}',1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(78,'directus_roles','enforce_2fa','boolean','switch',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(79,'directus_roles','users','o2m','one-to-many','{\"fields\":\"first_name,last_name\"}',1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(80,'directus_roles','module_listing','json','repeater','{\"template\":\"{{ name }}\",\"createItemText\":\"Add Module\",\"fields\":[{\"field\":\"name\",\"interface\":\"text-input\",\"type\":\"string\",\"width\":\"half\"},{\"field\":\"link\",\"interface\":\"text-input\",\"type\":\"string\",\"width\":\"half\"},{\"field\":\"icon\",\"interface\":\"icon\",\"type\":\"string\",\"width\":\"full\"}]}',1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(81,'directus_roles','collection_listing','json','repeater','{\"template\":\"{{ group_name }}\",\"createItemText\":\"Add Group\",\"fields\":[{\"field\":\"group_name\",\"width\":\"full\",\"interface\":\"text-input\",\"type\":\"string\"},{\"field\":\"collections\",\"interface\":\"repeater\",\"type\":\"JSON\",\"options\":{\"createItemText\":\"Add Collection\",\"fields\":[{\"field\":\"collection\",\"type\":\"string\",\"interface\":\"collections\",\"width\":\"full\"}]}}]}',1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(82,'directus_permissions','id','integer','primary-key',NULL,1,NULL,1,0,1,0,NULL,'full',NULL,NULL,NULL),(83,'directus_permissions','collection','m2o','many-to-one',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(84,'directus_permissions','role','m2o','many-to-one',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(85,'directus_permissions','status','string','text-input',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(86,'directus_permissions','create','string','text-input',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(87,'directus_permissions','read','string','text-input',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(88,'directus_permissions','update','string','text-input',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(89,'directus_permissions','delete','string','primary-key',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(90,'directus_permissions','comment','string','text-input',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(91,'directus_permissions','explain','string','text-input',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(92,'directus_permissions','status_blacklist','array','tags',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(93,'directus_permissions','read_field_blacklist','array','tags',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(94,'directus_permissions','write_field_blacklist','array','tags',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(95,'directus_relations','id','integer','primary-key',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(96,'directus_relations','collection_many','string','collections',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(97,'directus_relations','field_many','string','text-input',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(98,'directus_relations','collection_one','string','collections',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(99,'directus_relations','field_one','string','text-input',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(100,'directus_relations','junction_field','string','text-input',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(101,'directus_revisions','id','integer','primary-key',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(102,'directus_revisions','activity','m2o','many-to-one',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(103,'directus_revisions','collection','m2o','many-to-one',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(104,'directus_revisions','item','string','text-input',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(105,'directus_revisions','data','json','json',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(106,'directus_revisions','delta','json','json',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(107,'directus_revisions','parent_item','string','text-input',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(108,'directus_revisions','parent_collection','string','collections',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(109,'directus_revisions','parent_changed','boolean','switch',NULL,1,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(110,'directus_settings','project_name','string','text-input','{\"iconRight\":\"title\"}',1,NULL,1,0,0,0,1,'half',NULL,'Logo in the top-left of the App (40x40)',NULL),(111,'directus_settings','project_url','string','text-input','{\"iconRight\":\"link\"}',1,NULL,0,0,0,0,2,'half',NULL,'External link for the App\'s top-left logo',NULL),(112,'directus_settings','project_logo','file','file',NULL,1,NULL,0,0,0,0,3,'half',NULL,'A 40x40 brand logo, ideally a white SVG/PNG',NULL),(113,'directus_settings','project_color','string','color',NULL,1,NULL,0,0,0,0,4,'half',NULL,'Color for login background and App\'s logo',NULL),(114,'directus_settings','project_foreground','file','file',NULL,1,NULL,0,0,0,0,5,'half',NULL,'Centered image (eg: logo) for the login page',NULL),(115,'directus_settings','project_background','file','file',NULL,1,NULL,0,0,0,0,6,'half',NULL,'Full-screen background for the login page',NULL),(116,'directus_settings','project_public_note','string','markdown',NULL,1,NULL,0,0,0,0,7,'full',NULL,'This value will be shown on the public pages of the app',NULL),(117,'directus_settings','default_locale','string','language','{\"limit\":true}',1,NULL,0,0,0,0,8,'half',NULL,'Default locale for Directus Users',NULL),(118,'directus_settings','telemetry','boolean','switch',NULL,1,NULL,0,0,0,0,9,'half',NULL,'<a href=\"https://docs.directus.io/getting-started/concepts.html#telemetry\" target=\"_blank\">Learn More</a>',NULL),(119,'directus_settings','data_divider','alias','divider','{\"style\":\"large\",\"title\":\"Data\",\"hr\":true}',1,NULL,0,0,0,1,11,'full',NULL,NULL,NULL),(120,'directus_settings','default_limit','integer','numeric','{\"iconRight\":\"keyboard_tab\"}',1,NULL,1,0,0,0,12,'half',NULL,'Default item count in API and App responses',NULL),(121,'directus_settings','sort_null_last','boolean','switch',NULL,1,NULL,0,0,0,0,13,'half',NULL,'NULL values are sorted last',NULL),(122,'directus_settings','security_divider','alias','divider','{\"style\":\"large\",\"title\":\"Security\",\"hr\":true}',1,NULL,0,0,0,1,20,'full',NULL,NULL,NULL),(123,'directus_settings','auto_sign_out','integer','numeric','{\"iconRight\":\"timer\"}',1,NULL,1,0,0,0,22,'half',NULL,'Minutes before idle users are signed out',NULL),(124,'directus_settings','login_attempts_allowed','integer','numeric','{\"iconRight\":\"lock\"}',1,NULL,0,0,0,0,23,'half',NULL,'Failed login attempts before suspending users',NULL),(125,'directus_settings','password_policy','string','dropdown','{\"choices\":{\"\":\"None\",\"\\/^.{8,}$\\/\":\"Weak\",\"\\/(?=^.{8,}$)(?=.*\\\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()_+}{\';\'?>.<,])(?!.*\\\\s).*$\\/\":\"Strong\"}}',1,NULL,0,0,0,0,24,'half',NULL,'Weak: Minimum length 8; Strong: 1 small-case letter, 1 capital letter, 1 digit, 1 special character and the length should be minimum 8',NULL),(126,'directus_settings','files_divider','alias','divider','{\"style\":\"large\",\"title\":\"Files & Thumbnails\",\"hr\":true}',1,NULL,0,0,0,1,30,'full',NULL,NULL,NULL),(127,'directus_settings','file_naming','string','dropdown','{\"choices\":{\"uuid\":\"UUID (Obfuscated)\",\"file_name\":\"File Name (Readable)\"}}',1,NULL,0,0,0,0,31,'half',NULL,'File-system naming convention for uploads',NULL),(129,'directus_settings','file_mimetype_whitelist','array','tags','{\"placeholder\":\"Enter a file mimetype then hit enter (eg: image\\/jpeg)\"}',1,NULL,0,0,0,0,33,'half',NULL,NULL,NULL),(130,'directus_settings','asset_whitelist','json','repeater','{\"template\":\"{{key}}\",\"fields\":[{\"field\":\"key\",\"interface\":\"slug\",\"width\":\"half\",\"type\":\"string\",\"required\":true,\"options\":{\"onlyOnCreate\":false}},{\"field\":\"fit\",\"interface\":\"dropdown\",\"width\":\"half\",\"type\":\"string\",\"options\":{\"choices\":{\"crop\":\"Crop (forces exact size)\",\"contain\":\"Contain (preserve aspect ratio)\"}},\"required\":true},{\"field\":\"width\",\"interface\":\"numeric\",\"width\":\"half\",\"type\":\"integer\",\"required\":true},{\"field\":\"height\",\"interface\":\"numeric\",\"width\":\"half\",\"type\":\"integer\",\"required\":true},{\"field\":\"quality\",\"interface\":\"slider\",\"width\":\"full\",\"type\":\"integer\",\"default\":80,\"options\":{\"min\":0,\"max\":100,\"step\":1},\"required\":true}]}',0,NULL,0,0,0,0,34,'full',NULL,'Defines how the thumbnail will be generated based on the requested params.',NULL),(131,'directus_settings','asset_whitelist_system','json','json',NULL,0,NULL,0,1,1,1,35,'half',NULL,NULL,NULL),(132,'directus_settings','youtube_api_key','string','text-input','{\"iconRight\":\"videocam\"}',1,NULL,0,0,0,0,36,'full',NULL,'Allows fetching more YouTube Embed info',NULL),(133,'directus_users','id','integer','primary-key',NULL,1,NULL,1,0,1,0,1,'full',NULL,NULL,NULL),(134,'directus_users','status','status','status','{\"status_mapping\":{\"draft\":{\"name\":\"Draft\",\"text_color\":\"white\",\"background_color\":\"light-gray\",\"listing_subdued\":false,\"listing_badge\":true,\"soft_delete\":false},\"invited\":{\"name\":\"Invited\",\"text_color\":\"white\",\"background_color\":\"light-gray\",\"listing_subdued\":false,\"listing_badge\":true,\"soft_delete\":false},\"active\":{\"name\":\"Active\",\"text_color\":\"white\",\"background_color\":\"success\",\"listing_subdued\":false,\"listing_badge\":false,\"soft_delete\":false},\"suspended\":{\"name\":\"Suspended\",\"text_color\":\"white\",\"background_color\":\"light-gray\",\"listing_subdued\":false,\"listing_badge\":true,\"soft_delete\":false},\"deleted\":{\"name\":\"Deleted\",\"text_color\":\"white\",\"background_color\":\"danger\",\"listing_subdued\":false,\"listing_badge\":true,\"soft_delete\":true}}}',1,NULL,1,0,0,0,2,'full',NULL,NULL,NULL),(135,'directus_users','first_name','string','text-input','{\"iconRight\":\"account_circle\"}',1,NULL,1,0,0,0,3,'half',NULL,NULL,NULL),(136,'directus_users','last_name','string','text-input','{\"iconRight\":\"account_circle\"}',1,NULL,1,0,0,0,4,'half',NULL,NULL,NULL),(137,'directus_users','email','string','text-input','{\"iconRight\":\"alternate_email\"}',1,'$email',1,0,0,0,5,'half',NULL,NULL,NULL),(138,'directus_users','email_notifications','boolean','switch',NULL,1,NULL,0,0,0,0,6,'half',NULL,NULL,NULL),(139,'directus_users','password','hash','password',NULL,1,NULL,1,0,0,0,7,'half',NULL,NULL,NULL),(140,'directus_users','role','m2o','user-roles',NULL,1,NULL,1,0,0,0,8,'half',NULL,NULL,NULL),(141,'directus_users','company','string','text-input','{\"iconRight\":\"location_city\"}',0,NULL,0,0,0,0,9,'half',NULL,NULL,NULL),(142,'directus_users','title','string','text-input','{\"iconRight\":\"text_fields\"}',0,NULL,0,0,0,0,10,'half',NULL,NULL,NULL),(143,'directus_users','timezone','string','dropdown','{\"choices\":{\"Pacific\\/Midway\":\"(UTC-11:00) Midway Island\",\"Pacific\\/Samoa\":\"(UTC-11:00) Samoa\",\"Pacific\\/Honolulu\":\"(UTC-10:00) Hawaii\",\"US\\/Alaska\":\"(UTC-09:00) Alaska\",\"America\\/Los_Angeles\":\"(UTC-08:00) Pacific Time (US & Canada)\",\"America\\/Tijuana\":\"(UTC-08:00) Tijuana\",\"US\\/Arizona\":\"(UTC-07:00) Arizona\",\"America\\/Chihuahua\":\"(UTC-07:00) Chihuahua\",\"America\\/Mexico\\/La_Paz\":\"(UTC-07:00) La Paz\",\"America\\/Mazatlan\":\"(UTC-07:00) Mazatlan\",\"US\\/Mountain\":\"(UTC-07:00) Mountain Time (US & Canada)\",\"America\\/Managua\":\"(UTC-06:00) Central America\",\"US\\/Central\":\"(UTC-06:00) Central Time (US & Canada)\",\"America\\/Guadalajara\":\"(UTC-06:00) Guadalajara\",\"America\\/Mexico_City\":\"(UTC-06:00) Mexico City\",\"America\\/Monterrey\":\"(UTC-06:00) Monterrey\",\"Canada\\/Saskatchewan\":\"(UTC-06:00) Saskatchewan\",\"America\\/Bogota\":\"(UTC-05:00) Bogota\",\"US\\/Eastern\":\"(UTC-05:00) Eastern Time (US & Canada)\",\"US\\/East-Indiana\":\"(UTC-05:00) Indiana (East)\",\"America\\/Lima\":\"(UTC-05:00) Lima\",\"America\\/Quito\":\"(UTC-05:00) Quito\",\"Canada\\/Atlantic\":\"(UTC-04:00) Atlantic Time (Canada)\",\"America\\/New_York\":\"(UTC-04:00) New York\",\"America\\/Caracas\":\"(UTC-04:30) Caracas\",\"America\\/La_Paz\":\"(UTC-04:00) La Paz\",\"America\\/Santiago\":\"(UTC-04:00) Santiago\",\"America\\/Santo_Domingo\":\"(UTC-04:00) Santo Domingo\",\"Canada\\/Newfoundland\":\"(UTC-03:30) Newfoundland\",\"America\\/Sao_Paulo\":\"(UTC-03:00) Brasilia\",\"America\\/Argentina\\/Buenos_Aires\":\"(UTC-03:00) Buenos Aires\",\"America\\/Argentina\\/GeorgeTown\":\"(UTC-03:00) Georgetown\",\"America\\/Godthab\":\"(UTC-03:00) Greenland\",\"America\\/Noronha\":\"(UTC-02:00) Mid-Atlantic\",\"Atlantic\\/Azores\":\"(UTC-01:00) Azores\",\"Atlantic\\/Cape_Verde\":\"(UTC-01:00) Cape Verde Is.\",\"Africa\\/Casablanca\":\"(UTC+00:00) Casablanca\",\"Europe\\/Edinburgh\":\"(UTC+00:00) Edinburgh\",\"Etc\\/Greenwich\":\"(UTC+00:00) Greenwich Mean Time : Dublin\",\"Europe\\/Lisbon\":\"(UTC+00:00) Lisbon\",\"Europe\\/London\":\"(UTC+00:00) London\",\"Africa\\/Monrovia\":\"(UTC+00:00) Monrovia\",\"UTC\":\"(UTC+00:00) UTC\",\"Europe\\/Amsterdam\":\"(UTC+01:00) Amsterdam\",\"Europe\\/Belgrade\":\"(UTC+01:00) Belgrade\",\"Europe\\/Berlin\":\"(UTC+01:00) Berlin\",\"Europe\\/Bern\":\"(UTC+01:00) Bern\",\"Europe\\/Bratislava\":\"(UTC+01:00) Bratislava\",\"Europe\\/Brussels\":\"(UTC+01:00) Brussels\",\"Europe\\/Budapest\":\"(UTC+01:00) Budapest\",\"Europe\\/Copenhagen\":\"(UTC+01:00) Copenhagen\",\"Europe\\/Ljubljana\":\"(UTC+01:00) Ljubljana\",\"Europe\\/Madrid\":\"(UTC+01:00) Madrid\",\"Europe\\/Paris\":\"(UTC+01:00) Paris\",\"Europe\\/Prague\":\"(UTC+01:00) Prague\",\"Europe\\/Rome\":\"(UTC+01:00) Rome\",\"Europe\\/Sarajevo\":\"(UTC+01:00) Sarajevo\",\"Europe\\/Skopje\":\"(UTC+01:00) Skopje\",\"Europe\\/Stockholm\":\"(UTC+01:00) Stockholm\",\"Europe\\/Vienna\":\"(UTC+01:00) Vienna\",\"Europe\\/Warsaw\":\"(UTC+01:00) Warsaw\",\"Africa\\/Lagos\":\"(UTC+01:00) West Central Africa\",\"Europe\\/Zagreb\":\"(UTC+01:00) Zagreb\",\"Europe\\/Athens\":\"(UTC+02:00) Athens\",\"Europe\\/Bucharest\":\"(UTC+02:00) Bucharest\",\"Africa\\/Cairo\":\"(UTC+02:00) Cairo\",\"Africa\\/Harare\":\"(UTC+02:00) Harare\",\"Europe\\/Helsinki\":\"(UTC+02:00) Helsinki\",\"Europe\\/Istanbul\":\"(UTC+02:00) Istanbul\",\"Asia\\/Jerusalem\":\"(UTC+02:00) Jerusalem\",\"Europe\\/Kyiv\":\"(UTC+02:00) Kyiv\",\"Africa\\/Johannesburg\":\"(UTC+02:00) Pretoria\",\"Europe\\/Riga\":\"(UTC+02:00) Riga\",\"Europe\\/Sofia\":\"(UTC+02:00) Sofia\",\"Europe\\/Tallinn\":\"(UTC+02:00) Tallinn\",\"Europe\\/Vilnius\":\"(UTC+02:00) Vilnius\",\"Asia\\/Baghdad\":\"(UTC+03:00) Baghdad\",\"Asia\\/Kuwait\":\"(UTC+03:00) Kuwait\",\"Europe\\/Minsk\":\"(UTC+03:00) Minsk\",\"Africa\\/Nairobi\":\"(UTC+03:00) Nairobi\",\"Asia\\/Riyadh\":\"(UTC+03:00) Riyadh\",\"Europe\\/Volgograd\":\"(UTC+03:00) Volgograd\",\"Asia\\/Tehran\":\"(UTC+03:30) Tehran\",\"Asia\\/Abu_Dhabi\":\"(UTC+04:00) Abu Dhabi\",\"Asia\\/Baku\":\"(UTC+04:00) Baku\",\"Europe\\/Moscow\":\"(UTC+04:00) Moscow\",\"Asia\\/Muscat\":\"(UTC+04:00) Muscat\",\"Europe\\/St_Petersburg\":\"(UTC+04:00) St. Petersburg\",\"Asia\\/Tbilisi\":\"(UTC+04:00) Tbilisi\",\"Asia\\/Yerevan\":\"(UTC+04:00) Yerevan\",\"Asia\\/Kabul\":\"(UTC+04:30) Kabul\",\"Asia\\/Islamabad\":\"(UTC+05:00) Islamabad\",\"Asia\\/Karachi\":\"(UTC+05:00) Karachi\",\"Asia\\/Tashkent\":\"(UTC+05:00) Tashkent\",\"Asia\\/Calcutta\":\"(UTC+05:30) Chennai\",\"Asia\\/Kolkata\":\"(UTC+05:30) Kolkata\",\"Asia\\/Mumbai\":\"(UTC+05:30) Mumbai\",\"Asia\\/New_Delhi\":\"(UTC+05:30) New Delhi\",\"Asia\\/Sri_Jayawardenepura\":\"(UTC+05:30) Sri Jayawardenepura\",\"Asia\\/Katmandu\":\"(UTC+05:45) Kathmandu\",\"Asia\\/Almaty\":\"(UTC+06:00) Almaty\",\"Asia\\/Astana\":\"(UTC+06:00) Astana\",\"Asia\\/Dhaka\":\"(UTC+06:00) Dhaka\",\"Asia\\/Yekaterinburg\":\"(UTC+06:00) Ekaterinburg\",\"Asia\\/Rangoon\":\"(UTC+06:30) Rangoon\",\"Asia\\/Bangkok\":\"(UTC+07:00) Bangkok\",\"Asia\\/Hanoi\":\"(UTC+07:00) Hanoi\",\"Asia\\/Jakarta\":\"(UTC+07:00) Jakarta\",\"Asia\\/Novosibirsk\":\"(UTC+07:00) Novosibirsk\",\"Asia\\/Beijing\":\"(UTC+08:00) Beijing\",\"Asia\\/Chongqing\":\"(UTC+08:00) Chongqing\",\"Asia\\/Hong_Kong\":\"(UTC+08:00) Hong Kong\",\"Asia\\/Krasnoyarsk\":\"(UTC+08:00) Krasnoyarsk\",\"Asia\\/Kuala_Lumpur\":\"(UTC+08:00) Kuala Lumpur\",\"Australia\\/Perth\":\"(UTC+08:00) Perth\",\"Asia\\/Singapore\":\"(UTC+08:00) Singapore\",\"Asia\\/Taipei\":\"(UTC+08:00) Taipei\",\"Asia\\/Ulan_Bator\":\"(UTC+08:00) Ulaan Bataar\",\"Asia\\/Urumqi\":\"(UTC+08:00) Urumqi\",\"Asia\\/Irkutsk\":\"(UTC+09:00) Irkutsk\",\"Asia\\/Osaka\":\"(UTC+09:00) Osaka\",\"Asia\\/Sapporo\":\"(UTC+09:00) Sapporo\",\"Asia\\/Seoul\":\"(UTC+09:00) Seoul\",\"Asia\\/Tokyo\":\"(UTC+09:00) Tokyo\",\"Australia\\/Adelaide\":\"(UTC+09:30) Adelaide\",\"Australia\\/Darwin\":\"(UTC+09:30) Darwin\",\"Australia\\/Brisbane\":\"(UTC+10:00) Brisbane\",\"Australia\\/Canberra\":\"(UTC+10:00) Canberra\",\"Pacific\\/Guam\":\"(UTC+10:00) Guam\",\"Australia\\/Hobart\":\"(UTC+10:00) Hobart\",\"Australia\\/Melbourne\":\"(UTC+10:00) Melbourne\",\"Pacific\\/Port_Moresby\":\"(UTC+10:00) Port Moresby\",\"Australia\\/Sydney\":\"(UTC+10:00) Sydney\",\"Asia\\/Yakutsk\":\"(UTC+10:00) Yakutsk\",\"Asia\\/Vladivostok\":\"(UTC+11:00) Vladivostok\",\"Pacific\\/Auckland\":\"(UTC+12:00) Auckland\",\"Pacific\\/Fiji\":\"(UTC+12:00) Fiji\",\"Pacific\\/Kwajalein\":\"(UTC+12:00) International Date Line West\",\"Asia\\/Kamchatka\":\"(UTC+12:00) Kamchatka\",\"Asia\\/Magadan\":\"(UTC+12:00) Magadan\",\"Pacific\\/Marshall_Is\":\"(UTC+12:00) Marshall Is.\",\"Asia\\/New_Caledonia\":\"(UTC+12:00) New Caledonia\",\"Asia\\/Solomon_Is\":\"(UTC+12:00) Solomon Is.\",\"Pacific\\/Wellington\":\"(UTC+12:00) Wellington\",\"Pacific\\/Tongatapu\":\"(UTC+13:00) Nuku\'alofa\"},\"placeholder\":\"Choose a timezone...\"}',1,NULL,1,0,0,0,11,'half',NULL,NULL,NULL),(144,'directus_users','locale','string','language','{\"limit\":true}',1,NULL,0,0,0,0,12,'half',NULL,NULL,NULL),(145,'directus_users','avatar','file','file',NULL,1,NULL,0,0,0,0,13,'full',NULL,NULL,NULL),(146,'directus_users','theme','string','radio-buttons','{\"format\":true,\"choices\":{\"auto\":\"Auto\",\"light\":\"Light\",\"dark\":\"Dark\"}}',1,NULL,0,0,0,0,14,'full',NULL,NULL,NULL),(147,'directus_users','2fa_secret','string','2fa-secret',NULL,1,NULL,0,1,0,0,15,'full',NULL,NULL,NULL),(148,'directus_users','locale_options','json','json',NULL,1,NULL,0,0,1,1,16,'full',NULL,NULL,NULL),(149,'directus_users','token','string','text-input',NULL,1,NULL,0,0,1,1,17,'full',NULL,NULL,NULL),(150,'directus_users','last_access_on','datetime','datetime',NULL,1,NULL,0,1,1,0,18,'full',NULL,NULL,NULL),(151,'directus_users','last_page','string','text-input',NULL,1,NULL,0,1,1,1,19,'full',NULL,NULL,NULL),(152,'directus_users','external_id','string','text-input',NULL,1,NULL,0,1,1,1,NULL,'full',NULL,NULL,NULL),(153,'directus_user_sessions','id','integer','primary-key',NULL,1,NULL,1,0,1,0,NULL,'full',NULL,NULL,NULL),(154,'directus_user_sessions','user','user','user',NULL,0,NULL,1,0,0,0,NULL,'full',NULL,NULL,NULL),(155,'directus_user_sessions','token_type','string','text-input',NULL,0,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(156,'directus_user_sessions','token','string','text-input',NULL,0,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(157,'directus_user_sessions','ip_address','string','text-input',NULL,0,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(158,'directus_user_sessions','user_agent','string','text-input',NULL,0,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(159,'directus_user_sessions','created_on','datetime','datetime',NULL,0,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(160,'directus_user_sessions','token_expired_at','datetime','datetime',NULL,0,NULL,0,0,0,0,NULL,'full',NULL,NULL,NULL),(161,'directus_webhooks','id','integer','primary-key',NULL,1,NULL,1,0,1,0,NULL,'full',NULL,NULL,NULL),(162,'directus_webhooks','status','status','status','{\"status_mapping\":{\"active\":{\"name\":\"Active\",\"value\":\"active\",\"text_color\":\"white\",\"background_color\":\"green\",\"browse_subdued\":false,\"browse_badge\":true,\"soft_delete\":false,\"published\":true},\"inactive\":{\"name\":\"Inactive\",\"value\":\"inactive\",\"text_color\":\"white\",\"background_color\":\"blue-grey\",\"browse_subdued\":true,\"browse_badge\":true,\"soft_delete\":false,\"published\":false}}}',1,NULL,0,0,0,0,1,'full',NULL,NULL,NULL),(163,'directus_webhooks','http_action','string','dropdown','{\"choices\":{\"get\":\"GET\",\"post\":\"POST\"}}',1,NULL,1,0,0,0,2,'half-space',NULL,NULL,NULL),(164,'directus_webhooks','url','string','text-input','{\"placeholder\":\"https:\\/\\/example.com\",\"iconRight\":\"link\"}',1,NULL,1,0,0,0,3,'full',NULL,'',NULL),(165,'directus_webhooks','collection','string','collections',NULL,1,NULL,1,0,0,0,4,'half',NULL,'',NULL),(166,'directus_webhooks','directus_action','string','dropdown','{\"choices\":{\"item.create:after\":\"Create\",\"item.update:after\":\"Update\",\"item.delete:after\":\"Delete\"}}',1,NULL,1,0,0,0,5,'half',NULL,'',NULL),(167,'directus_webhooks','info','alias','divider','{\"style\":\"medium\",\"title\":\"How Webhooks Work\",\"hr\":true,\"margin\":false,\"description\":\"When the selected action occurs for the selected collection, Directus will send an HTTP request to the above URL.\"}',1,NULL,0,0,0,1,6,'full',NULL,NULL,NULL),(168,'sidor','id','integer','primary-key',NULL,0,NULL,0,0,1,1,1,'full',NULL,NULL,NULL),(169,'sidor','status','status','status','{\"status_mapping\":{\"published\":{\"name\":\"Published\",\"value\":\"published\",\"text_color\":\"white\",\"background_color\":\"accent\",\"browse_subdued\":false,\"browse_badge\":true,\"soft_delete\":false,\"published\":true,\"required_fields\":true},\"draft\":{\"name\":\"Draft\",\"value\":\"draft\",\"text_color\":\"white\",\"background_color\":\"blue-grey-100\",\"browse_subdued\":true,\"browse_badge\":true,\"soft_delete\":false,\"published\":false,\"required_fields\":false},\"deleted\":{\"name\":\"Deleted\",\"value\":\"deleted\",\"text_color\":\"white\",\"background_color\":\"red\",\"browse_subdued\":true,\"browse_badge\":true,\"soft_delete\":true,\"published\":false,\"required_fields\":false}}}',0,NULL,1,0,0,0,3,'full',NULL,NULL,NULL),(170,'sidor','sort','sort','sort',NULL,0,NULL,0,0,1,1,4,'full',NULL,NULL,NULL),(171,'sidor','created_on','datetime_created','datetime-created',NULL,0,NULL,0,1,1,1,5,'full',NULL,NULL,NULL),(172,'sidor','modified_on','datetime_updated','datetime-updated',NULL,0,NULL,0,1,1,1,6,'full',NULL,NULL,NULL),(174,'sidor','ingress','string','textarea','{\"rows\":\"3\",\"serif\":false}',0,NULL,0,0,0,1,10,'full',NULL,'Här kan en introduktionstext till sidan skrivas','[]'),(175,'sidor','body','string','wysiwyg','{\"toolbar\":[\"bold\",\"italic\",\"underline\",\"removeformat\",\"link\",\"bullist\",\"numlist\",\"h1\",\"h2\",\"h3\",\"image\",\"media\",\"hr\",\"code\",\"copy\",\"cut\",\"paste\",\"undo\",\"redo\",\"remove\",\"table\"],\"custom_formats\":null}',0,NULL,0,0,0,1,12,'fill',NULL,'Här skrivs sidans innehåll','[]'),(176,'nyheter','id','integer','primary-key',NULL,0,NULL,0,0,1,1,1,'full',NULL,NULL,NULL),(177,'nyheter','status','status','status','{\"status_mapping\":{\"published\":{\"name\":\"Published\",\"value\":\"published\",\"text_color\":\"white\",\"background_color\":\"accent\",\"browse_subdued\":false,\"browse_badge\":true,\"soft_delete\":false,\"published\":true,\"required_fields\":true},\"draft\":{\"name\":\"Draft\",\"value\":\"draft\",\"text_color\":\"white\",\"background_color\":\"blue-grey-100\",\"browse_subdued\":true,\"browse_badge\":true,\"soft_delete\":false,\"published\":false,\"required_fields\":false},\"deleted\":{\"name\":\"Deleted\",\"value\":\"deleted\",\"text_color\":\"white\",\"background_color\":\"red\",\"browse_subdued\":true,\"browse_badge\":true,\"soft_delete\":true,\"published\":false,\"required_fields\":false}}}',0,NULL,1,0,0,0,2,'full',NULL,NULL,NULL),(178,'nyheter','sort','sort','sort',NULL,0,NULL,0,0,1,1,3,'full',NULL,NULL,NULL),(179,'nyheter','created_by','owner','owner','{\"template\":\"{{first_name}} {{last_name}}\",\"display\":\"both\"}',0,NULL,0,1,1,1,4,'full',NULL,NULL,NULL),(180,'nyheter','created_on','datetime_created','datetime-created','[]',0,NULL,0,1,1,0,5,'full',NULL,'','[]'),(181,'nyheter','modified_by','user_updated','user-updated','{\"template\":\"{{first_name}} {{last_name}}\",\"display\":\"both\"}',0,NULL,0,1,1,1,6,'full',NULL,NULL,NULL),(182,'nyheter','modified_on','datetime_updated','datetime-updated',NULL,0,NULL,0,1,1,1,7,'full',NULL,NULL,NULL),(184,'nyheter','ingress','string','textarea','{\"rows\":\"3\",\"serif\":false}',0,NULL,0,0,0,1,12,'full',NULL,'Här kan en introduktionstext för nyheten skrivas','[]'),(185,'nyheter','body','string','wysiwyg','{\"toolbar\":[\"bold\",\"italic\",\"underline\",\"removeformat\",\"link\",\"bullist\",\"numlist\",\"h1\",\"h2\",\"h3\",\"image\",\"media\",\"hr\",\"code\",\"copy\",\"cut\",\"paste\",\"undo\",\"redo\",\"remove\"],\"custom_formats\":null}',0,NULL,0,0,0,1,13,'full',NULL,'Här läggs nyhetens innehåll','[{\"locale\":\"no-NO\",\"translation\":\"Inneh\\u00e5ll\"}]'),(187,'nyheter','publish_date','datetime','datetime','{\"defaultToCurrentDatetime\":true,\"format\":\"ymd\"}',0,NULL,1,0,0,0,10,'full',NULL,'Här sätts nyhetens publiceringsdatum','[]'),(213,'meny','id','integer','primary-key',NULL,0,NULL,0,0,1,1,1,'full',NULL,NULL,NULL),(214,'meny','status','status','status','{\"status_mapping\":{\"published\":{\"name\":\"Published\",\"value\":\"published\",\"text_color\":\"white\",\"background_color\":\"accent\",\"browse_subdued\":false,\"browse_badge\":true,\"soft_delete\":false,\"published\":true,\"required_fields\":true},\"draft\":{\"name\":\"Draft\",\"value\":\"draft\",\"text_color\":\"white\",\"background_color\":\"blue-grey-100\",\"browse_subdued\":true,\"browse_badge\":true,\"soft_delete\":false,\"published\":false,\"required_fields\":false},\"deleted\":{\"name\":\"Deleted\",\"value\":\"deleted\",\"text_color\":\"white\",\"background_color\":\"red\",\"browse_subdued\":true,\"browse_badge\":true,\"soft_delete\":true,\"published\":false,\"required_fields\":false}}}',0,NULL,1,0,0,0,2,'full',NULL,NULL,NULL),(215,'meny','sort','sort','sort','[]',0,NULL,0,0,1,1,3,'full',NULL,'','[]'),(217,'meny','menu_item','string','text-input','{\"trim\":true,\"showCharacterCount\":true,\"formatValue\":false,\"monospace\":false}',0,NULL,0,0,0,0,5,'full',NULL,'Här kan en ny menylänk skapas','[]'),(218,'sidor','fk_menu','integer','numeric','{\"localized\":false,\"monospace\":false}',0,NULL,0,0,1,1,2,'full',NULL,NULL,'[]'),(219,'meny','submenu','o2m','one-to-many','{\"delete_mode\":\"relation\",\"allow_create\":false,\"allow_select\":true,\"sort_field\":\"sort\",\"template\":\"\",\"fields\":\"status,titel\"}',0,NULL,0,0,0,0,7,'full',NULL,'Här kan man lägga till en undermeny för denna menynotering. Länken ovan blir då inaktiv och skapar en undermeny istället.','[]'),(220,'meny','menu_link','m2o','many-to-one','{\"placeholder\":\"V\\u00e4lj en\",\"threshold\":20,\"visible_fields\":\"\",\"template\":\"{{titel}}\"}',0,NULL,0,0,0,0,6,'full',NULL,'Här kan man länka menyn','[]'),(221,'sidor','url','string','text-input','{\"trim\":true,\"showCharacterCount\":true,\"formatValue\":false,\"monospace\":false,\"placeholder\":\"exempel: om-oss\"}',0,'(^([0-9a-zA-Z-]+)$)',1,0,0,0,9,'half-right',NULL,'Här skrivs sidan url. Den skrivs med små bokstäver, utan  åäö och med möjlighet att använda streck i. Den måste också vara unik. Exempel # om-oss # klubben # ','[]'),(222,'sidor','header','file','file','{\"crop\":true,\"viewType\":\"cards\",\"viewOptions\":{\"title\":\"title\",\"subtitle\":\"type\",\"content\":\"description\",\"src\":\"data\"},\"viewQuery\":[],\"filters\":[],\"accept\":\"image\\/jpg,image\\/jpeg,image\\/png\"}',0,NULL,0,0,0,1,11,'fill',NULL,'Här kan en toppbild sättas. (Om ingen väljs sätts en standardbild)','[]'),(223,'sidor','titel','string','text-input','{\"trim\":true,\"showCharacterCount\":true,\"formatValue\":false,\"monospace\":false}',0,NULL,1,0,0,0,8,'half-left',NULL,'Här skrivs sidans titel','[]'),(224,'nyheter','titel','string','text-input','{\"trim\":true,\"showCharacterCount\":true,\"formatValue\":false,\"monospace\":false}',0,NULL,0,0,0,0,8,'half-left',NULL,'Här skrivs nyhetens titel','[]'),(230,'sidor','files','o2m','files','{\"fields\":\"title\",\"template\":\"{{ title }}\",\"allow_create\":true,\"allow_select\":true,\"accept\":\"\"}',0,NULL,0,0,0,0,13,'full',NULL,'Här kan filer läggas upp för sidan','[]'),(231,'sidor_directus_files','id','integer','primary-key',NULL,0,NULL,0,0,0,0,0,'full',NULL,NULL,NULL),(232,'sidor_directus_files','sidor_id','integer',NULL,NULL,0,NULL,1,0,0,0,0,'full',NULL,NULL,NULL),(233,'sidor_directus_files','directus_files_id','integer',NULL,NULL,0,NULL,1,0,0,0,0,'full',NULL,NULL,NULL),(234,'nyheter','url','string','text-input','{\"trim\":true,\"showCharacterCount\":true,\"formatValue\":false,\"monospace\":false,\"placeholder\":\"exempel: nyhet-1\"}',0,'(^([0-9a-zA-Z-]+)$)',1,0,0,0,9,'half-right',NULL,'Här skrivs nyhetens adress. Den skrivs med små bokstäver, utan  åäö och med möjlighet att använda streck i. Den måste också vara unik. Exempel # nyhet-1 # nyhet2 # ','[]'),(235,'nyheter','header','file','file','{\"crop\":true,\"viewType\":\"cards\",\"viewOptions\":{\"title\":\"title\",\"subtitle\":\"type\",\"content\":\"description\",\"src\":\"data\"},\"viewQuery\":[],\"filters\":[]}',0,NULL,0,0,0,1,11,'full',NULL,'Här kan en toppbild sättas. (Om ingen väljs sätts en standardbild)','[]'),(236,'nyheter_directus_files','id','integer','primary-key',NULL,0,NULL,0,0,0,0,0,'full',NULL,NULL,NULL),(237,'nyheter','files','o2m','files','{\"fields\":\"title\",\"template\":\"{{ title }}\",\"allow_create\":true,\"allow_select\":true}',0,NULL,0,0,0,0,14,'full',NULL,NULL,'[]'),(238,'nyheter_directus_files','nyheter_id','integer',NULL,NULL,0,NULL,1,0,0,0,0,'full',NULL,NULL,NULL),(239,'nyheter_directus_files','directus_files_id','integer',NULL,NULL,0,NULL,1,0,0,0,0,'full',NULL,NULL,NULL),(240,'sidor','medlemmar','array','checkboxes','{\"choices\":{\"members-only\":\"Ja\"},\"allow_other\":false,\"draggable\":false,\"wrap\":false,\"formatting\":true,\"single\":true}',0,NULL,0,0,0,0,7,'full',NULL,'Endast synlig för inloggade medlemmar','[]'),(241,'meny','medlemmar','array','checkboxes','{\"theme\":\"solid\",\"allow_other\":false,\"draggable\":false,\"wrap\":false,\"formatting\":false,\"single\":false,\"choices\":{\"members-only\":\"Ja\\/Nej\"}}',0,NULL,0,0,0,0,4,'full',NULL,'Endast synlig för medlemmar eller ej.','[]'),(242,'directus_users','password_reset_token','string','text-input',NULL,1,NULL,0,1,1,0,NULL,'full',NULL,NULL,NULL),(243,'directus_settings','asset_url_naming','string','dropdown','{\"choices\":{\"private_hash\":\"Private Hash (Obfuscated)\",\"filename_download\":\"File Name (Readable)\"}}',1,NULL,0,0,0,0,32,'half',NULL,'Thumbnail URL convention',NULL);
/*!40000 ALTER TABLE `directus_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `directus_files`
--

DROP TABLE IF EXISTS `directus_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_files` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `storage` varchar(50) NOT NULL DEFAULT 'local',
  `private_hash` varchar(16) DEFAULT NULL,
  `filename_disk` varchar(255) NOT NULL,
  `filename_download` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `uploaded_by` int(11) unsigned NOT NULL,
  `uploaded_on` datetime NOT NULL,
  `charset` varchar(50) DEFAULT NULL,
  `filesize` int(11) unsigned NOT NULL DEFAULT '0',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `embed` varchar(200) DEFAULT NULL,
  `folder` int(11) unsigned DEFAULT NULL,
  `description` text,
  `location` varchar(200) DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `checksum` varchar(32) DEFAULT NULL,
  `metadata` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `directus_files`
--

LOCK TABLES `directus_files` WRITE;
/*!40000 ALTER TABLE `directus_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `directus_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `directus_folders`
--

DROP TABLE IF EXISTS `directus_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_folders` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 NOT NULL,
  `parent_folder` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name_parent_folder` (`name`,`parent_folder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `directus_folders`
--

LOCK TABLES `directus_folders` WRITE;
/*!40000 ALTER TABLE `directus_folders` DISABLE KEYS */;
/*!40000 ALTER TABLE `directus_folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `directus_migrations`
--

DROP TABLE IF EXISTS `directus_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_migrations` (
  `version` bigint(20) NOT NULL,
  `migration_name` varchar(100) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `breakpoint` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `directus_migrations`
--

LOCK TABLES `directus_migrations` WRITE;
/*!40000 ALTER TABLE `directus_migrations` DISABLE KEYS */;
INSERT INTO `directus_migrations` VALUES (20180220023123,'CreateFieldsTable','2020-01-11 11:16:23','2020-01-11 11:16:23',0),(20180220023138,'CreateActivityTable','2020-01-11 11:16:23','2020-01-11 11:16:23',0),(20180220023152,'CreateCollectionsPresetsTable','2020-01-11 11:16:23','2020-01-11 11:16:23',0),(20180220023157,'CreateCollectionsTable','2020-01-11 11:16:23','2020-01-11 11:16:23',0),(20180220023208,'CreateFilesTable','2020-01-11 11:16:23','2020-01-11 11:16:23',0),(20180220023213,'CreateFoldersTable','2020-01-11 11:16:23','2020-01-11 11:16:23',0),(20180220023217,'CreateRolesTable','2020-01-11 11:16:23','2020-01-11 11:16:23',0),(20180220023226,'CreatePermissionsTable','2020-01-11 11:16:23','2020-01-11 11:16:23',0),(20180220023232,'CreateRelationsTable','2020-01-11 11:16:23','2020-01-11 11:16:24',0),(20180220023238,'CreateRevisionsTable','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20180220023243,'CreateSettingsTable','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20180220023248,'CreateUsersTable','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20181022175715,'Upgrade070003','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20181102153600,'TimezoneChoices','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20181105165224,'Upgrade070006','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20181122195602,'LocaleInterface','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20181123171520,'RemoveScope','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20181210204720,'AddTrustedProxiesSettingField','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20181222023800,'AddProjectUrlSettingField','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20181227042755,'IncreaseUsersLastPageLength','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190104155309,'AddUsersEmailValidation','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190111193724,'AddAppUrlSettingField','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190111212736,'AddMissingSettingsField','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190118181424,'AddRolesUsersField','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190130215921,'AddFilesChecksumField','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190318173400,'AddNavOverride','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190412122400,'SetPasswordTypeToHash','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190412123000,'UseFileInterface','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190412145800,'SetO2mOptionsRoles','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190415125300,'SetWidth','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190419154400,'SettingsFields','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190419161200,'CollectionNotes','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190419173000,'MiscRequiredFields','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190422131600,'UseJson','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190426156200,'SetNullableValueFieldSettingsTable','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190520094300,'UseTimeline','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190614103321,'AddUsers2faSecretField','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190618190024,'AddEnforce2faRoleField','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190626114228,'AddFileNamingInSetting','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190702092323,'AddLoginAttemptsAllowedSetting','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190704063752,'UpdateIstanbulTimezone','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190708095522,'AddFileExtensionSetting','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190709053719,'AddFileMaxSizeSetting','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190722110232,'PasswordValidationSettingField','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190726064001,'UpdateNoteForDefaultLimit','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190819070856,'UpdateDirectusFieldsField','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190912072543,'CreateUserSessions','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20190917090849,'CreateWebHooks','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191123053252,'UpdateDirectusFilesField','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191129123300,'UseNewWysiwyg','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191202164200,'AddUserSessions','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191202164201,'AddWebhooks','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191202164202,'RemoveActivitySeen','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191202164203,'ConvertUserRoles','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191202164204,'UpdateDirectusUsers','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191202164205,'UpdateDirectusSettings','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191202164206,'UpdateDirectusFiles','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191202164207,'UpdateDirectusRoles','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191202164208,'ResetDirectusRelations','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191202164209,'ResetDirectusFields','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191203105400,'AddHashFiledownloadIfEmpty','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191204151300,'UseCorrectWysiwyg','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191205150000,'UpdateDirectusThumbnailSizes','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191209130300,'AddProjectPublicNote','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191209141700,'SetOptionsCollectionListing','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191211140300,'AllowNullInSettings','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191211141600,'HideExternalid','2020-01-11 11:16:24','2020-01-11 11:16:24',0),(20191213160000,'NewTranslationsStructure','2020-04-07 09:59:12','2020-04-07 09:59:12',0),(20191216134009,'AddUserLastPasswordUpdate','2020-04-07 09:59:12','2020-04-07 09:59:12',0),(20191216175050,'RemoveFileMaxSize','2020-04-07 09:59:12','2020-04-07 09:59:12',0),(20191220102232,'UpdateUserCreatedToOwner','2020-04-07 09:59:12','2020-04-07 09:59:12',0),(20191223121542,'UpdateSlugType','2020-04-07 09:59:12','2020-04-07 09:59:12',0),(20200108122313,'AddAssetURLNamingSetting','2020-04-07 09:59:12','2020-04-07 09:59:12',0),(20200120170859,'UpdateTypeOfCollectionListing','2020-04-07 09:59:12','2020-04-07 09:59:12',0),(20200121134200,'RenameToggle','2020-04-07 09:59:12','2020-04-07 09:59:12',0),(20200121134353,'UpdateUserCreatedInterface','2020-04-07 09:59:12','2020-04-07 09:59:12',0),(20200123161848,'UpdateValidationSizeForDirectusField','2020-04-07 09:59:12','2020-04-07 09:59:12',0),(20200129100037,'UpdateLoginAttemptValue','2020-04-07 09:59:12','2020-04-07 09:59:12',0),(20200207095101,'UpdateSlugOptionForAssetWhiteList','2020-04-07 09:59:12','2020-04-07 09:59:12',0);
/*!40000 ALTER TABLE `directus_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `directus_permissions`
--

DROP TABLE IF EXISTS `directus_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_permissions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `collection` varchar(64) NOT NULL,
  `role` int(11) unsigned NOT NULL,
  `status` varchar(64) DEFAULT NULL,
  `create` varchar(16) DEFAULT 'none',
  `read` varchar(16) DEFAULT 'none',
  `update` varchar(16) DEFAULT 'none',
  `delete` varchar(16) DEFAULT 'none',
  `comment` varchar(8) DEFAULT 'none',
  `explain` varchar(8) DEFAULT 'none',
  `read_field_blacklist` varchar(1000) DEFAULT NULL,
  `write_field_blacklist` varchar(1000) DEFAULT NULL,
  `status_blacklist` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `directus_permissions`
--

LOCK TABLES `directus_permissions` WRITE;
/*!40000 ALTER TABLE `directus_permissions` DISABLE KEYS */;
INSERT INTO `directus_permissions` VALUES (1,'directus_activity',3,NULL,'full','mine','none','none','update','none',NULL,NULL,NULL),(2,'directus_collection_presets',3,NULL,'full','full','mine','mine','none','none',NULL,NULL,NULL),(3,'directus_collections',3,NULL,'none','full','none','none','none','none',NULL,NULL,NULL),(4,'directus_fields',3,NULL,'none','full','none','none','none','none',NULL,NULL,NULL),(5,'directus_files',3,NULL,'full','full','full','full','none','none',NULL,NULL,NULL),(6,'directus_folders',3,NULL,'full','full','full','full','none','none',NULL,NULL,NULL),(7,'directus_permissions',3,NULL,'none','mine','none','none','none','none',NULL,NULL,NULL),(8,'directus_relations',3,NULL,'none','full','none','none','none','none',NULL,NULL,NULL),(9,'directus_revisions',3,NULL,'full','full','none','none','none','none',NULL,NULL,NULL),(10,'directus_roles',3,NULL,'none','mine','none','none','none','none',NULL,NULL,NULL),(11,'directus_settings',3,NULL,'none','full','none','none','none','none',NULL,NULL,NULL),(12,'directus_users',3,'active','none','full','mine','mine','none','none',NULL,NULL,NULL),(13,'directus_users',3,'deleted','none','none','none','none','none','none',NULL,NULL,NULL),(14,'directus_users',3,'draft','none','none','none','none','none','none',NULL,NULL,NULL),(15,'directus_users',3,'invited','none','none','none','none','none','none',NULL,NULL,NULL),(16,'directus_users',3,'suspended','none','none','none','none','none','none',NULL,NULL,NULL),(17,'directus_activity',4,NULL,'full','mine','none','none','update','none',NULL,NULL,NULL),(18,'directus_collection_presets',4,NULL,'full','full','mine','mine','none','none',NULL,NULL,NULL),(19,'directus_collections',4,NULL,'none','full','none','none','none','none',NULL,NULL,NULL),(20,'directus_fields',4,NULL,'none','full','none','none','none','none',NULL,NULL,NULL),(21,'directus_files',4,NULL,'full','full','full','full','none','none',NULL,NULL,NULL),(22,'directus_folders',4,NULL,'full','full','full','full','none','none',NULL,NULL,NULL),(23,'directus_permissions',4,NULL,'none','mine','none','none','none','none',NULL,NULL,NULL),(24,'directus_relations',4,NULL,'none','full','none','none','none','none',NULL,NULL,NULL),(25,'directus_revisions',4,NULL,'full','full','none','none','none','none',NULL,NULL,NULL),(26,'directus_roles',4,NULL,'none','mine','none','none','none','none',NULL,NULL,NULL),(27,'directus_settings',4,NULL,'none','full','none','none','none','none',NULL,NULL,NULL),(28,'directus_users',4,'active','none','full','mine','mine','none','none',NULL,NULL,NULL),(29,'directus_users',4,'deleted','none','none','none','none','none','none',NULL,NULL,NULL),(30,'directus_users',4,'draft','none','none','none','none','none','none',NULL,NULL,NULL),(31,'directus_users',4,'invited','none','none','none','none','none','none',NULL,NULL,NULL),(32,'directus_users',4,'suspended','none','none','none','none','none','none',NULL,NULL,NULL),(33,'meny',4,'published','none','full','none','none','none','none',NULL,NULL,NULL),(34,'meny',4,'draft','none','full','none','none','none','none',NULL,NULL,NULL),(35,'meny',4,'deleted','none','full','none','none','none','none',NULL,NULL,NULL),(36,'nyheter',4,'published','none','full','none','none','none','none',NULL,NULL,NULL),(37,'nyheter',4,'draft','none','full','none','none','none','none',NULL,NULL,NULL),(38,'nyheter',4,'deleted','none','full','none','none','none','none',NULL,NULL,NULL),(39,'sidor',4,'published','none','full','none','none','none','none',NULL,NULL,NULL),(40,'sidor',4,'draft','none','full','none','none','none','none',NULL,NULL,NULL),(41,'sidor',4,'deleted','none','full','none','none','none','none',NULL,NULL,NULL),(42,'directus_files',2,NULL,'none','none','none','none','none','none',NULL,NULL,NULL),(43,'sidor_directus_files',4,NULL,'none','full','none','none','none','none',NULL,NULL,NULL),(44,'nyheter_directus_files',4,NULL,'none','full','none','none','none','none',NULL,NULL,NULL);
/*!40000 ALTER TABLE `directus_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `directus_relations`
--

DROP TABLE IF EXISTS `directus_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_relations` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `collection_many` varchar(64) NOT NULL,
  `field_many` varchar(45) NOT NULL,
  `collection_one` varchar(64) DEFAULT NULL,
  `field_one` varchar(64) DEFAULT NULL,
  `junction_field` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `directus_relations`
--

LOCK TABLES `directus_relations` WRITE;
/*!40000 ALTER TABLE `directus_relations` DISABLE KEYS */;
INSERT INTO `directus_relations` VALUES (1,'directus_activity','action_by','directus_users',NULL,NULL),(2,'directus_collections_presets','user','directus_users',NULL,NULL),(3,'directus_collections_presets','group','directus_groups',NULL,NULL),(4,'directus_fields','collection','directus_collections','fields',NULL),(5,'directus_files','uploaded_by','directus_users',NULL,NULL),(6,'directus_files','folder','directus_folders',NULL,NULL),(7,'directus_folders','parent_folder','directus_folders',NULL,NULL),(8,'directus_permissions','group','directus_groups',NULL,NULL),(9,'directus_revisions','activity','directus_activity',NULL,NULL),(10,'directus_users','role','directus_roles','users',NULL),(11,'directus_users','avatar','directus_files',NULL,NULL),(12,'sidor','action','meny','undermeny',NULL),(17,'sidor','fk_menu','meny','submenu',NULL),(18,'meny','menu_link','sidor',NULL,NULL),(23,'sidor_directus_files','sidor_id','sidor','files','directus_files_id'),(24,'sidor_directus_files','directus_files_id','directus_files','sidor','sidor_id'),(25,'nyheter_directus_files','nyheter_id','nyheter','files','directus_files_id'),(26,'nyheter_directus_files','directus_files_id','directus_files','nyheter','nyheter_id');
/*!40000 ALTER TABLE `directus_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `directus_revisions`
--

DROP TABLE IF EXISTS `directus_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_revisions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `activity` int(11) unsigned NOT NULL,
  `collection` varchar(64) NOT NULL,
  `item` varchar(255) NOT NULL,
  `data` longtext NOT NULL,
  `delta` longtext,
  `parent_collection` varchar(64) DEFAULT NULL,
  `parent_item` varchar(255) DEFAULT NULL,
  `parent_changed` tinyint(1) unsigned DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `directus_revisions`
--

LOCK TABLES `directus_revisions` WRITE;
/*!40000 ALTER TABLE `directus_revisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `directus_revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `directus_roles`
--

DROP TABLE IF EXISTS `directus_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_roles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `ip_whitelist` text,
  `external_id` varchar(255) DEFAULT NULL,
  `module_listing` text,
  `collection_listing` text,
  `enforce_2fa` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_group_name` (`name`),
  UNIQUE KEY `idx_roles_external_id` (`external_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `directus_roles`
--

LOCK TABLES `directus_roles` WRITE;
/*!40000 ALTER TABLE `directus_roles` DISABLE KEYS */;
INSERT INTO `directus_roles` VALUES (1,'Administrator','Admins have access to all managed data within the system by default',NULL,NULL,NULL,NULL,0),(2,'Public','Controls what API data is publicly available without authenticating',NULL,NULL,NULL,NULL,0),(3,'Members','Här läggs medlemmar in',NULL,'e734db1e-dc8a-46bf-97b5-6cd44210380a',NULL,NULL,0),(4,'Api',NULL,NULL,'523f706c-507e-42de-b94b-ad13931e0f0a',NULL,NULL,0);
/*!40000 ALTER TABLE `directus_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `directus_settings`
--

DROP TABLE IF EXISTS `directus_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_settings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(64) NOT NULL,
  `value` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `directus_settings`
--

LOCK TABLES `directus_settings` WRITE;
/*!40000 ALTER TABLE `directus_settings` DISABLE KEYS */;
INSERT INTO `directus_settings` VALUES (1,'project_url','App'),(2,'project_logo','1'),(3,'project_color','#2196F3'),(4,'project_foreground','4'),(5,'project_background',NULL),(6,'project_public_note',''),(7,'default_locale','en-US'),(8,'telemetry','1'),(9,'default_limit','200'),(10,'sort_null_last','1'),(11,'password_policy','/^.{8,}$/'),(12,'auto_sign_out','10080'),(13,'login_attempts_allowed','25'),(14,'trusted_proxies',''),(16,'file_mimetype_whitelist',''),(17,'file_naming','uuid'),(18,'youtube_api_key',''),(19,'asset_whitelist','[{\"key\":\"thumbnail\",\"width\":200,\"height\":200,\"fit\":\"contain\",\"quality\":80},{\"newItem\":true,\"key\":\"header-asset\",\"fit\":\"crop\",\"width\":\"2400\",\"height\":\"532\",\"quality\":50},{\"newItem\":true,\"key\":\"header-asset-stretch\",\"fit\":\"contain\",\"width\":\"2400\",\"height\":\"532\",\"quality\":50}]'),(20,'asset_whitelist_system','[{\"key\":\"directus-small-crop\",\"width\":64,\"height\":64,\"fit\":\"crop\",\"quality\":80},{\"key\":\"directus-small-contain\",\"width\":64,\"height\":64,\"fit\":\"contain\",\"quality\":80},{\"key\":\"directus-medium-crop\",\"width\":300,\"height\":300,\"fit\":\"crop\",\"quality\":80},{\"key\":\"directus-medium-contain\",\"width\":300,\"height\":300,\"fit\":\"contain\",\"quality\":80},{\"key\":\"directus-large-crop\",\"width\":800,\"height\":600,\"fit\":\"crop\",\"quality\":80},{\"key\":\"directus-large-contain\",\"width\":800,\"height\":600,\"fit\":\"contain\",\"quality\":80}]'),(21,'project_name','App'),(22,'asset_url_naming','private_hash');
/*!40000 ALTER TABLE `directus_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `directus_user_sessions`
--

DROP TABLE IF EXISTS `directus_user_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_user_sessions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user` int(11) unsigned DEFAULT NULL,
  `token_type` varchar(255) DEFAULT NULL,
  `token` varchar(520) DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `user_agent` text,
  `created_on` datetime DEFAULT NULL,
  `token_expired_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `directus_user_sessions`
--

LOCK TABLES `directus_user_sessions` WRITE;
/*!40000 ALTER TABLE `directus_user_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `directus_user_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `directus_users`
--

DROP TABLE IF EXISTS `directus_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(16) NOT NULL DEFAULT 'draft',
  `role` int(11) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(128) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `timezone` varchar(32) NOT NULL DEFAULT 'UTC',
  `locale` varchar(8) DEFAULT NULL,
  `locale_options` text,
  `avatar` int(11) unsigned DEFAULT NULL,
  `company` varchar(191) DEFAULT NULL,
  `title` varchar(191) DEFAULT NULL,
  `email_notifications` int(1) NOT NULL DEFAULT '1',
  `last_access_on` datetime DEFAULT NULL,
  `last_page` varchar(192) DEFAULT NULL,
  `external_id` varchar(255) DEFAULT NULL,
  `theme` varchar(100) DEFAULT 'auto',
  `2fa_secret` varchar(100) DEFAULT NULL,
  `password_reset_token` varchar(520) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_users_email` (`email`),
  UNIQUE KEY `idx_users_token` (`token`),
  UNIQUE KEY `idx_users_external_id` (`external_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `directus_users`
--

LOCK TABLES `directus_users` WRITE;
/*!40000 ALTER TABLE `directus_users` DISABLE KEYS */;
INSERT INTO `directus_users` VALUES (1,'active',1,'Admin','User','admin@admin.com','$2y$10$t3X/2egqlcwxBGUEGKS56uw4FWIJX6lSx00Hlm2Lxn0ZGk0k8tvGy','cJ4BvXW8Ppp7Vubj83Y2dDpk','UTC','en-US',NULL,NULL,NULL,NULL,1,'2021-12-14 11:24:41','/_/settings',NULL,'auto',NULL,NULL),(2,'active',4,'app','app','app@app.se','$2y$10$E5s01GNkHPAOBdKjb.mfR.3/h3sj8ppHOhb36VvglWrJp04kD9mAe','dofUvNoEaY7pG9jfqY58mKZHqEPqBVgQ','Europe/Amsterdam',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'e19ccc3d-0bba-4ee8-91c2-0643db9a82c7','auto',NULL,NULL),(4,'active',3,'Temp','Temp','temp@temp.com','$2y$10$STHikhK16O/jLyL70l/Ph.c.1A9owOsXrAx69MhYbpvlD2FMnv4Eq',NULL,'UTC',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'1ba028a6-4282-4829-97c8-4902d52fb99a','auto',NULL,NULL);
/*!40000 ALTER TABLE `directus_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `directus_webhooks`
--

DROP TABLE IF EXISTS `directus_webhooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_webhooks` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(16) NOT NULL DEFAULT 'inactive',
  `http_action` varchar(255) DEFAULT NULL,
  `url` varchar(510) DEFAULT NULL,
  `collection` varchar(255) DEFAULT NULL,
  `directus_action` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `directus_webhooks`
--

LOCK TABLES `directus_webhooks` WRITE;
/*!40000 ALTER TABLE `directus_webhooks` DISABLE KEYS */;
/*!40000 ALTER TABLE `directus_webhooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meny`
--

DROP TABLE IF EXISTS `meny`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meny` (
  `id` int(15) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(20) DEFAULT 'draft',
  `sort` int(10) unsigned DEFAULT NULL,
  `menu_item` varchar(200) DEFAULT NULL COMMENT 'Här kan en ny menylänk skapas',
  `menu_link` int(10) unsigned DEFAULT NULL COMMENT 'Här kan man länka menyn',
  `medlemmar` varchar(255) DEFAULT NULL COMMENT 'Endast synlig för medlemmar eller ej.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meny`
--

LOCK TABLES `meny` WRITE;
/*!40000 ALTER TABLE `meny` DISABLE KEYS */;
INSERT INTO `meny` VALUES (1,'published',2,'Klubben',NULL,NULL),(2,'published',1,'Medlemmar',7,NULL),(3,'published',NULL,'OM OSS',8,NULL);
/*!40000 ALTER TABLE `meny` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nyheter`
--

DROP TABLE IF EXISTS `nyheter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nyheter` (
  `id` int(15) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(20) DEFAULT 'draft',
  `sort` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `modified_by` int(10) unsigned DEFAULT NULL,
  `modified_on` datetime DEFAULT NULL,
  `ingress` text COMMENT 'Här kan en introduktionstext för nyheten skrivas',
  `body` text COMMENT 'Här läggs nyhetens innehåll',
  `publish_date` datetime DEFAULT NULL COMMENT 'Här sätts nyhetens publiceringsdatum',
  `titel` varchar(200) DEFAULT NULL COMMENT 'Här skrivs nyhetens titel',
  `url` varchar(200) DEFAULT NULL COMMENT 'Här skrivs nyhetens adress. Den skrivs med små bokstäver, utan  åäö och med möjlighet att använda streck i. Den måste också vara unik. Exempel # nyhet-1 # nyhet2 # ',
  `header` int(10) unsigned DEFAULT NULL COMMENT 'Här kan en toppbild sättas. (Om ingen väljs sätts en standardbild)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nyheter`
--

LOCK TABLES `nyheter` WRITE;
/*!40000 ALTER TABLE `nyheter` DISABLE KEYS */;
INSERT INTO `nyheter` VALUES (2,'published',NULL,1,'2020-02-23 12:25:26',1,'2020-02-29 09:38:52','Nyhet test',NULL,'2020-02-23 13:25:15','Nyhet 2','nyhet-2',NULL),(3,'published',NULL,1,'2020-03-01 12:24:51',1,'2020-03-01 12:24:57','asdf','<p>fasdfasdf</p>','2020-03-01 13:24:23','Nyhet 3','nyhet-3',NULL),(4,'published',NULL,1,'2020-03-01 12:33:52',1,'2020-03-01 12:33:56','Test','<p>Test</p>','2020-03-01 13:33:35','Nyhet test','nyhet-test',NULL),(5,'published',NULL,1,'2020-03-01 12:34:18',1,'2020-03-01 12:34:30','Test','<p>Test</p>','2020-03-01 13:34:00','Nyhet 3','nyhet',NULL),(7,'published',NULL,1,'2020-03-01 12:35:46',1,'2020-03-01 14:09:00','asfdasdfafd','<p>asfasdfasdf</p>','2020-03-01 13:35:31','Nyhet4','nyhet-55',4),(8,'published',NULL,1,'2020-03-25 10:34:38',1,'2020-03-25 10:37:59','asdfasdfasfd','<p>asfasdf</p>','2019-01-25 11:34:25','Test','testdd33',NULL);
/*!40000 ALTER TABLE `nyheter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nyheter_directus_files`
--

DROP TABLE IF EXISTS `nyheter_directus_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nyheter_directus_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nyheter_id` int(10) unsigned DEFAULT NULL,
  `directus_files_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nyheter_directus_files`
--

LOCK TABLES `nyheter_directus_files` WRITE;
/*!40000 ALTER TABLE `nyheter_directus_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `nyheter_directus_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sidor`
--

DROP TABLE IF EXISTS `sidor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sidor` (
  `id` int(15) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(20) DEFAULT 'draft',
  `sort` int(10) unsigned DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `modified_on` datetime DEFAULT NULL,
  `ingress` text COMMENT 'Här kan en introduktionstext till sidan skrivas',
  `body` text COMMENT 'Här skrivs sidans innehåll',
  `fk_menu` int(11) DEFAULT NULL,
  `url` varchar(200) DEFAULT '' COMMENT 'Här skrivs sidan url. Den skrivs med små bokstäver, utan  åäö och med möjlighet att använda streck i. Den måste också vara unik. Exempel # om-oss # klubben # ',
  `header` int(10) unsigned DEFAULT NULL COMMENT 'Här kan en toppbild sättas. (Om ingen väljs sätts en standardbild)',
  `titel` varchar(200) DEFAULT NULL COMMENT 'Här skrivs sidans titel',
  `medlemmar` varchar(255) DEFAULT NULL COMMENT 'Endast synlig för inloggade medlemmar',
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sidor`
--

LOCK TABLES `sidor` WRITE;
/*!40000 ALTER TABLE `sidor` DISABLE KEYS */;
INSERT INTO `sidor` VALUES (1,'deleted',1,'2020-01-11 11:50:42','2021-12-14 08:11:54','Om','',1,'om-oss',NULL,'Om oss','members-only'),(2,'published',2,'2020-01-11 12:06:40','2021-12-14 07:19:04','','<p>Page</p>',1,'stadgar',NULL,'Stadgar','members-only'),(5,'published',3,'2020-01-19 14:36:36','2021-12-14 07:45:29',NULL,'<p>Page</p>',1,'styrelse',NULL,'Styrelse',NULL),(7,'published',NULL,'2020-03-29 12:19:15','2021-12-13 19:32:20','Medlemmar','<p>Text</p>',NULL,'medlemmar',NULL,'Medlemmar',NULL),(8,'published',NULL,'2021-12-14 11:11:05','2021-12-14 11:12:17',NULL,'<p>Page</p>',NULL,'om',NULL,'Om oss',NULL);
/*!40000 ALTER TABLE `sidor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sidor_directus_files`
--

DROP TABLE IF EXISTS `sidor_directus_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sidor_directus_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sidor_id` int(10) unsigned DEFAULT NULL,
  `directus_files_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sidor_directus_files`
--

LOCK TABLES `sidor_directus_files` WRITE;
/*!40000 ALTER TABLE `sidor_directus_files` DISABLE KEYS */;
INSERT INTO `sidor_directus_files` VALUES (1,6,5),(2,1,5),(3,6,6),(4,6,7),(5,6,1),(6,7,5);
/*!40000 ALTER TABLE `sidor_directus_files` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-14 11:32:38
