-- MySQL dump 10.11
--
-- Host: localhost    Database: sail_database
-- ------------------------------------------------------
-- Server version	5.0.41-log

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
-- Table structure for table `acl_class`
--

DROP TABLE IF EXISTS `acl_class`;
CREATE TABLE `acl_class` (
  `id` bigint(20) NOT NULL auto_increment,
  `class` varchar(255) NOT NULL,
  `OPTLOCK` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `class` (`class`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `acl_class`
--

LOCK TABLES `acl_class` WRITE;
/*!40000 ALTER TABLE `acl_class` DISABLE KEYS */;
INSERT INTO `acl_class` VALUES (1,'org.telscenter.sail.webapp.domain.project.impl.ProjectImpl',NULL);
/*!40000 ALTER TABLE `acl_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_entry`
--

DROP TABLE IF EXISTS `acl_entry`;
CREATE TABLE `acl_entry` (
  `id` bigint(20) NOT NULL auto_increment,
  `ace_order` int(11) NOT NULL,
  `audit_failure` bit(1) NOT NULL,
  `audit_success` bit(1) NOT NULL,
  `granting` bit(1) NOT NULL,
  `mask` int(11) NOT NULL,
  `OPTLOCK` int(11) default NULL,
  `sid` bigint(20) NOT NULL,
  `acl_object_identity` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `acl_object_identity` (`acl_object_identity`,`ace_order`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `acl_entry`
--

LOCK TABLES `acl_entry` WRITE;
/*!40000 ALTER TABLE `acl_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_object_identity`
--

DROP TABLE IF EXISTS `acl_object_identity`;
CREATE TABLE `acl_object_identity` (
  `id` bigint(20) NOT NULL auto_increment,
  `object_id_identity` bigint(20) NOT NULL,
  `object_id_identity_num` int(11) default NULL,
  `entries_inheriting` bit(1) NOT NULL,
  `OPTLOCK` int(11) default NULL,
  `object_id_class` bigint(20) NOT NULL,
  `owner_sid` bigint(20) default NULL,
  `parent_object` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `object_id_class` (`object_id_class`,`object_id_identity`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `acl_object_identity`
--

LOCK TABLES `acl_object_identity` WRITE;
/*!40000 ALTER TABLE `acl_object_identity` DISABLE KEYS */;
INSERT INTO `acl_object_identity` VALUES (1,15,NULL,'',NULL,1,1,NULL);
/*!40000 ALTER TABLE `acl_object_identity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_sid`
--

DROP TABLE IF EXISTS `acl_sid`;
CREATE TABLE `acl_sid` (
  `id` bigint(20) NOT NULL auto_increment,
  `principal` bit(1) NOT NULL,
  `sid` varchar(100) NOT NULL,
  `OPTLOCK` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `sid` (`sid`,`principal`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `acl_sid`
--

LOCK TABLES `acl_sid` WRITE;
/*!40000 ALTER TABLE `acl_sid` DISABLE KEYS */;
INSERT INTO `acl_sid` VALUES (1,'','admin',NULL);
/*!40000 ALTER TABLE `acl_sid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `annotationbundles`
--

DROP TABLE IF EXISTS `annotationbundles`;
CREATE TABLE `annotationbundles` (
  `id` bigint(20) NOT NULL auto_increment,
  `bundle` longtext NOT NULL,
  `OPTLOCK` int(11) default NULL,
  `workgroup_fk` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FKAA5FD222F54443B2` (`workgroup_fk`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `annotationbundles`
--

LOCK TABLES `annotationbundles` WRITE;
/*!40000 ALTER TABLE `annotationbundles` DISABLE KEYS */;
/*!40000 ALTER TABLE `annotationbundles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
CREATE TABLE `announcements` (
  `id` bigint(20) NOT NULL auto_increment,
  `announcement` text NOT NULL,
  `timestamp` datetime NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `announcements`
--

LOCK TABLES `announcements` WRITE;
/*!40000 ALTER TABLE `announcements` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curnits`
--

DROP TABLE IF EXISTS `curnits`;
CREATE TABLE `curnits` (
  `id` bigint(20) NOT NULL auto_increment,
  `OPTLOCK` int(11) default NULL,
  `sds_curnit_fk` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `sds_curnit_fk` (`sds_curnit_fk`),
  KEY `FK4329FBBA1B78E061` (`sds_curnit_fk`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `curnits`
--

LOCK TABLES `curnits` WRITE;
/*!40000 ALTER TABLE `curnits` DISABLE KEYS */;
INSERT INTO `curnits` VALUES (1,0,1),(2,0,2);
/*!40000 ALTER TABLE `curnits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diyprojectcommunicators`
--

DROP TABLE IF EXISTS `diyprojectcommunicators`;
CREATE TABLE `diyprojectcommunicators` (
  `diyportalhostname` varchar(255) default NULL,
  `previewdiyprojectsuffix` varchar(255) default NULL,
  `id` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK83FA9ED96FC1637F` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `diyprojectcommunicators`
--

LOCK TABLES `diyprojectcommunicators` WRITE;
/*!40000 ALTER TABLE `diyprojectcommunicators` DISABLE KEYS */;
/*!40000 ALTER TABLE `diyprojectcommunicators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `externalprojects`
--

DROP TABLE IF EXISTS `externalprojects`;
CREATE TABLE `externalprojects` (
  `external_id` bigint(20) default NULL,
  `id` bigint(20) NOT NULL,
  `projectcommunicator_fk` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKD8238145CE9C471A` (`projectcommunicator_fk`),
  KEY `FKD8238145E48A3C0A` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `externalprojects`
--

LOCK TABLES `externalprojects` WRITE;
/*!40000 ALTER TABLE `externalprojects` DISABLE KEYS */;
/*!40000 ALTER TABLE `externalprojects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `granted_authorities`
--

DROP TABLE IF EXISTS `granted_authorities`;
CREATE TABLE `granted_authorities` (
  `id` bigint(20) NOT NULL auto_increment,
  `authority` varchar(255) NOT NULL,
  `OPTLOCK` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `authority` (`authority`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `granted_authorities`
--

LOCK TABLES `granted_authorities` WRITE;
/*!40000 ALTER TABLE `granted_authorities` DISABLE KEYS */;
INSERT INTO `granted_authorities` VALUES (1,'ROLE_USER',0),(2,'ROLE_ADMINISTRATOR',0),(3,'ROLE_TEACHER',0),(4,'ROLE_STUDENT',0),(5,'ROLE_AUTHOR',0);
/*!40000 ALTER TABLE `granted_authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `OPTLOCK` int(11) default NULL,
  `parent_fk` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKB63DD9D4E696E7FF` (`parent_fk`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups_related_to_users`
--

DROP TABLE IF EXISTS `groups_related_to_users`;
CREATE TABLE `groups_related_to_users` (
  `group_fk` bigint(20) NOT NULL,
  `user_fk` bigint(20) NOT NULL,
  PRIMARY KEY  (`group_fk`,`user_fk`),
  KEY `FK3311F7E356CA53B6` (`user_fk`),
  KEY `FK3311F7E3895EAE0A` (`group_fk`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups_related_to_users`
--

LOCK TABLES `groups_related_to_users` WRITE;
/*!40000 ALTER TABLE `groups_related_to_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups_related_to_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jaxbquestions`
--

DROP TABLE IF EXISTS `jaxbquestions`;
CREATE TABLE `jaxbquestions` (
  `id` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK91A6B40C2C379613` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jaxbquestions`
--

LOCK TABLES `jaxbquestions` WRITE;
/*!40000 ALTER TABLE `jaxbquestions` DISABLE KEYS */;
/*!40000 ALTER TABLE `jaxbquestions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jnlps`
--

DROP TABLE IF EXISTS `jnlps`;
CREATE TABLE `jnlps` (
  `id` bigint(20) NOT NULL auto_increment,
  `OPTLOCK` int(11) default NULL,
  `sds_jnlp_fk` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `sds_jnlp_fk` (`sds_jnlp_fk`),
  KEY `FK6095FABA532A941` (`sds_jnlp_fk`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jnlps`
--

LOCK TABLES `jnlps` WRITE;
/*!40000 ALTER TABLE `jnlps` DISABLE KEYS */;
INSERT INTO `jnlps` VALUES (1,0,1),(2,0,2),(3,0,3);
/*!40000 ALTER TABLE `jnlps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
CREATE TABLE `modules` (
  `authors` varchar(255) default NULL,
  `computer_time` bigint(20) default NULL,
  `description` varchar(255) default NULL,
  `grades` varchar(255) default NULL,
  `tech_reqs` varchar(255) default NULL,
  `topic_keywords` varchar(255) default NULL,
  `total_time` bigint(20) default NULL,
  `id` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK492927875E6F3BA6` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `modules`
--

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` VALUES (NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,2);
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modules_related_to_owners`
--

DROP TABLE IF EXISTS `modules_related_to_owners`;
CREATE TABLE `modules_related_to_owners` (
  `module_fk` bigint(20) NOT NULL,
  `owners_fk` bigint(20) NOT NULL,
  PRIMARY KEY  (`module_fk`,`owners_fk`),
  KEY `FKE09C9860AA7F41` (`owners_fk`),
  KEY `FKE09C9839A4B723` (`module_fk`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `modules_related_to_owners`
--

LOCK TABLES `modules_related_to_owners` WRITE;
/*!40000 ALTER TABLE `modules_related_to_owners` DISABLE KEYS */;
/*!40000 ALTER TABLE `modules_related_to_owners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsitem`
--

DROP TABLE IF EXISTS `newsitem`;
CREATE TABLE `newsitem` (
  `id` bigint(20) NOT NULL auto_increment,
  `date` datetime NOT NULL,
  `news` text NOT NULL,
  `title` varchar(255) NOT NULL,
  `owner` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK532D646665E358B0` (`owner`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `newsitem`
--

LOCK TABLES `newsitem` WRITE;
/*!40000 ALTER TABLE `newsitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `newsitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offerings`
--

DROP TABLE IF EXISTS `offerings`;
CREATE TABLE `offerings` (
  `id` bigint(20) NOT NULL auto_increment,
  `OPTLOCK` int(11) default NULL,
  `sds_offering_fk` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `sds_offering_fk` (`sds_offering_fk`),
  KEY `FK73F0F12DAB4F6201` (`sds_offering_fk`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `offerings`
--

LOCK TABLES `offerings` WRITE;
/*!40000 ALTER TABLE `offerings` DISABLE KEYS */;
/*!40000 ALTER TABLE `offerings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portal`
--

DROP TABLE IF EXISTS `portal`;
CREATE TABLE `portal` (
  `id` bigint(20) NOT NULL auto_increment,
  `address` varchar(255) default NULL,
  `comments` varchar(255) default NULL,
  `google_map_key` varchar(255) default NULL,
  `sendmail_on_exception` bit(1) default NULL,
  `portalname` varchar(255) default NULL,
  `sendmail_properties` tinyblob,
  `OPTLOCK` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `portal`
--

LOCK TABLES `portal` WRITE;
/*!40000 ALTER TABLE `portal` DISABLE KEYS */;
/*!40000 ALTER TABLE `portal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `premadecommentlists`
--

DROP TABLE IF EXISTS `premadecommentlists`;
CREATE TABLE `premadecommentlists` (
  `id` bigint(20) NOT NULL auto_increment,
  `label` varchar(255) NOT NULL,
  `owner` bigint(20) default NULL,
  `run` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKF237B2CEF4421937` (`run`),
  KEY `FKF237B2CE65E358B0` (`owner`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `premadecommentlists`
--

LOCK TABLES `premadecommentlists` WRITE;
/*!40000 ALTER TABLE `premadecommentlists` DISABLE KEYS */;
/*!40000 ALTER TABLE `premadecommentlists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `premadecomments`
--

DROP TABLE IF EXISTS `premadecomments`;
CREATE TABLE `premadecomments` (
  `id` bigint(20) NOT NULL auto_increment,
  `comment` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `owner` bigint(20) default NULL,
  `run` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK7786D42CF4421937` (`run`),
  KEY `FK7786D42C65E358B0` (`owner`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `premadecomments`
--

LOCK TABLES `premadecomments` WRITE;
/*!40000 ALTER TABLE `premadecomments` DISABLE KEYS */;
/*!40000 ALTER TABLE `premadecomments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `premadecomments_related_to_premadecommentlists`
--

DROP TABLE IF EXISTS `premadecomments_related_to_premadecommentlists`;
CREATE TABLE `premadecomments_related_to_premadecommentlists` (
  `premadecommentslist_fk` bigint(20) NOT NULL,
  `premadecomments_fk` bigint(20) NOT NULL,
  PRIMARY KEY  (`premadecommentslist_fk`,`premadecomments_fk`),
  KEY `FK6958FC11C8153CF5` (`premadecomments_fk`),
  KEY `FK6958FC112FC6E4D5` (`premadecommentslist_fk`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `premadecomments_related_to_premadecommentlists`
--

LOCK TABLES `premadecomments_related_to_premadecommentlists` WRITE;
/*!40000 ALTER TABLE `premadecomments_related_to_premadecommentlists` DISABLE KEYS */;
/*!40000 ALTER TABLE `premadecomments_related_to_premadecommentlists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectcommunicators`
--

DROP TABLE IF EXISTS `projectcommunicators`;
CREATE TABLE `projectcommunicators` (
  `id` bigint(20) NOT NULL auto_increment,
  `address` varchar(255) default NULL,
  `baseurl` varchar(255) default NULL,
  `latitude` varchar(255) default NULL,
  `longitude` varchar(255) default NULL,
  `OPTLOCK` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projectcommunicators`
--

LOCK TABLES `projectcommunicators` WRITE;
/*!40000 ALTER TABLE `projectcommunicators` DISABLE KEYS */;
/*!40000 ALTER TABLE `projectcommunicators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `id` bigint(20) NOT NULL auto_increment,
  `familytag` int(11) default NULL,
  `iscurrent` bit(1) default NULL,
  `name` varchar(255) default NULL,
  `projecttype` int(11) default NULL,
  `OPTLOCK` int(11) default NULL,
  `curnit_fk` bigint(20) default NULL,
  `jnlp_fk` bigint(20) default NULL,
  `run_fk` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `run_fk` (`run_fk`),
  KEY `FKC479187A7F08E576` (`curnit_fk`),
  KEY `FKC479187ABD6D05A5` (`run_fk`),
  KEY `FKC479187A9568F016` (`jnlp_fk`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,NULL,'\0','a',NULL,0,1,1,NULL),(2,NULL,'\0','bb',NULL,0,1,1,NULL),(3,NULL,'\0','aa',NULL,0,1,1,NULL),(4,NULL,'\0','aa',NULL,0,1,1,NULL),(5,NULL,'\0','abc',NULL,0,1,1,NULL),(6,NULL,'\0','1',NULL,0,1,1,NULL),(7,NULL,'\0','2',NULL,0,1,1,NULL),(8,NULL,'\0','3',NULL,0,1,1,NULL),(9,NULL,'\0','4',NULL,0,1,1,NULL),(10,NULL,'\0','5',NULL,0,1,1,NULL),(11,NULL,'\0','6',NULL,0,1,1,NULL),(12,NULL,'\0','6',NULL,0,1,1,NULL),(13,NULL,'\0','aa',NULL,0,1,1,NULL),(14,NULL,'\0','aa',NULL,0,1,1,NULL),(15,NULL,'\0','aa',NULL,0,1,1,NULL),(16,NULL,'\0','aa',NULL,0,1,1,NULL),(17,NULL,'\0','aa',NULL,0,1,1,NULL);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects_related_to_bookmarkers`
--

DROP TABLE IF EXISTS `projects_related_to_bookmarkers`;
CREATE TABLE `projects_related_to_bookmarkers` (
  `projects_fk` bigint(20) NOT NULL,
  `bookmarkers` bigint(20) NOT NULL,
  PRIMARY KEY  (`projects_fk`,`bookmarkers`),
  KEY `FK5AA350A5AC92FD99` (`projects_fk`),
  KEY `FK5AA350A531C3B66D` (`bookmarkers`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projects_related_to_bookmarkers`
--

LOCK TABLES `projects_related_to_bookmarkers` WRITE;
/*!40000 ALTER TABLE `projects_related_to_bookmarkers` DISABLE KEYS */;
/*!40000 ALTER TABLE `projects_related_to_bookmarkers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects_related_to_owners`
--

DROP TABLE IF EXISTS `projects_related_to_owners`;
CREATE TABLE `projects_related_to_owners` (
  `projects_fk` bigint(20) NOT NULL,
  `owners_fk` bigint(20) NOT NULL,
  PRIMARY KEY  (`projects_fk`,`owners_fk`),
  KEY `FKDACF56CB60AA7F41` (`owners_fk`),
  KEY `FKDACF56CBAC92FD99` (`projects_fk`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projects_related_to_owners`
--

LOCK TABLES `projects_related_to_owners` WRITE;
/*!40000 ALTER TABLE `projects_related_to_owners` DISABLE KEYS */;
/*!40000 ALTER TABLE `projects_related_to_owners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects_related_to_shared_owners`
--

DROP TABLE IF EXISTS `projects_related_to_shared_owners`;
CREATE TABLE `projects_related_to_shared_owners` (
  `projects_fk` bigint(20) NOT NULL,
  `shared_owners_fk` bigint(20) NOT NULL,
  PRIMARY KEY  (`projects_fk`,`shared_owners_fk`),
  KEY `FK19A2B02FDB63ABE7` (`shared_owners_fk`),
  KEY `FK19A2B02FAC92FD99` (`projects_fk`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projects_related_to_shared_owners`
--

LOCK TABLES `projects_related_to_shared_owners` WRITE;
/*!40000 ALTER TABLE `projects_related_to_shared_owners` DISABLE KEYS */;
/*!40000 ALTER TABLE `projects_related_to_shared_owners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `runs`
--

DROP TABLE IF EXISTS `runs`;
CREATE TABLE `runs` (
  `end_time` datetime default NULL,
  `info` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `run_code` varchar(255) NOT NULL,
  `start_time` datetime NOT NULL,
  `id` bigint(20) NOT NULL,
  `project_fk` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `run_code` (`run_code`),
  KEY `FK3597486F1ED29A` (`project_fk`),
  KEY `FK3597481834F8D3` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `runs`
--

LOCK TABLES `runs` WRITE;
/*!40000 ALTER TABLE `runs` DISABLE KEYS */;
/*!40000 ALTER TABLE `runs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `runs_related_to_announcements`
--

DROP TABLE IF EXISTS `runs_related_to_announcements`;
CREATE TABLE `runs_related_to_announcements` (
  `runs_fk` bigint(20) NOT NULL,
  `announcements_fk` bigint(20) NOT NULL,
  PRIMARY KEY  (`runs_fk`,`announcements_fk`),
  UNIQUE KEY `announcements_fk` (`announcements_fk`),
  KEY `FKEDEF47F33BC1BEB5` (`announcements_fk`),
  KEY `FKEDEF47F350B193C8` (`runs_fk`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `runs_related_to_announcements`
--

LOCK TABLES `runs_related_to_announcements` WRITE;
/*!40000 ALTER TABLE `runs_related_to_announcements` DISABLE KEYS */;
/*!40000 ALTER TABLE `runs_related_to_announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `runs_related_to_groups`
--

DROP TABLE IF EXISTS `runs_related_to_groups`;
CREATE TABLE `runs_related_to_groups` (
  `runs_fk` bigint(20) NOT NULL,
  `groups_fk` bigint(20) NOT NULL,
  PRIMARY KEY  (`runs_fk`,`groups_fk`),
  UNIQUE KEY `groups_fk` (`groups_fk`),
  KEY `FK6CD673CD50B193C8` (`runs_fk`),
  KEY `FK6CD673CD12D98E95` (`groups_fk`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `runs_related_to_groups`
--

LOCK TABLES `runs_related_to_groups` WRITE;
/*!40000 ALTER TABLE `runs_related_to_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `runs_related_to_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `runs_related_to_owners`
--

DROP TABLE IF EXISTS `runs_related_to_owners`;
CREATE TABLE `runs_related_to_owners` (
  `runs_fk` bigint(20) NOT NULL,
  `owners_fk` bigint(20) NOT NULL,
  PRIMARY KEY  (`runs_fk`,`owners_fk`),
  KEY `FK7AC2FE1960AA7F41` (`owners_fk`),
  KEY `FK7AC2FE1950B193C8` (`runs_fk`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `runs_related_to_owners`
--

LOCK TABLES `runs_related_to_owners` WRITE;
/*!40000 ALTER TABLE `runs_related_to_owners` DISABLE KEYS */;
/*!40000 ALTER TABLE `runs_related_to_owners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `runs_related_to_shared_owners`
--

DROP TABLE IF EXISTS `runs_related_to_shared_owners`;
CREATE TABLE `runs_related_to_shared_owners` (
  `runs_fk` bigint(20) NOT NULL,
  `shared_owners_fk` bigint(20) NOT NULL,
  PRIMARY KEY  (`runs_fk`,`shared_owners_fk`),
  KEY `FKBD30D52150B193C8` (`runs_fk`),
  KEY `FKBD30D521DB63ABE7` (`shared_owners_fk`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `runs_related_to_shared_owners`
--

LOCK TABLES `runs_related_to_shared_owners` WRITE;
/*!40000 ALTER TABLE `runs_related_to_shared_owners` DISABLE KEYS */;
/*!40000 ALTER TABLE `runs_related_to_shared_owners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sds_curnits`
--

DROP TABLE IF EXISTS `sds_curnits`;
CREATE TABLE `sds_curnits` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `curnit_id` bigint(20) NOT NULL,
  `url` varchar(255) NOT NULL,
  `OPTLOCK` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `curnit_id` (`curnit_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sds_curnits`
--

LOCK TABLES `sds_curnits` WRITE;
/*!40000 ALTER TABLE `sds_curnits` DISABLE KEYS */;
INSERT INTO `sds_curnits` VALUES (1,'Meiosis',41256,'http://www.telscenter.org/confluence/download/attachments/19315/converted-wise-dev.berkeley.edu-29913.jar',0),(2,'Airbags',41257,'http://www.telscenter.org/confluence/download/attachments/13003/converted-wise-dev.berkeley.edu-24587.jar?version=11',0);
/*!40000 ALTER TABLE `sds_curnits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sds_jnlps`
--

DROP TABLE IF EXISTS `sds_jnlps`;
CREATE TABLE `sds_jnlps` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `jnlp_id` bigint(20) NOT NULL,
  `url` varchar(255) NOT NULL,
  `OPTLOCK` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `jnlp_id` (`jnlp_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sds_jnlps`
--

LOCK TABLES `sds_jnlps` WRITE;
/*!40000 ALTER TABLE `sds_jnlps` DISABLE KEYS */;
INSERT INTO `sds_jnlps` VALUES (1,'PLR Everything JDIC snapshot current',37985,'http://tels-develop.soe.berkeley.edu:8080/jnlp/org/telscenter/jnlp/plr-everything-jdic-snapshot/plr-everything-jdic-snapshot.jnlp',0),(2,'PLR Everything + OTrunk',37986,'http://tels-develop.soe.berkeley.edu:8080/jnlp/org/telscenter/jnlp/plr-everything-jdic-otrunk-snapshot/plr-everything-jdic-otrunk-snapshot.jnlp',0),(3,'All OTrunk Snapshot Always Update',37987,'http://jnlp.concord.org/dev/org/concord/maven-jnlp/all-otrunk-snapshot/all-otrunk-snapshot.jnlp',0);
/*!40000 ALTER TABLE `sds_jnlps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sds_offerings`
--

DROP TABLE IF EXISTS `sds_offerings`;
CREATE TABLE `sds_offerings` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `sds_curnitmap` longtext,
  `offering_id` bigint(20) NOT NULL,
  `OPTLOCK` int(11) default NULL,
  `sds_curnit_fk` bigint(20) NOT NULL,
  `sds_jnlp_fk` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `offering_id` (`offering_id`),
  KEY `FK242EBD70A532A941` (`sds_jnlp_fk`),
  KEY `FK242EBD701B78E061` (`sds_curnit_fk`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sds_offerings`
--

LOCK TABLES `sds_offerings` WRITE;
/*!40000 ALTER TABLE `sds_offerings` DISABLE KEYS */;
/*!40000 ALTER TABLE `sds_offerings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sds_users`
--

DROP TABLE IF EXISTS `sds_users`;
CREATE TABLE `sds_users` (
  `id` bigint(20) NOT NULL auto_increment,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `OPTLOCK` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sds_users`
--

LOCK TABLES `sds_users` WRITE;
/*!40000 ALTER TABLE `sds_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `sds_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sds_workgroups`
--

DROP TABLE IF EXISTS `sds_workgroups`;
CREATE TABLE `sds_workgroups` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `workgroup_id` bigint(20) NOT NULL,
  `sds_sessionbundle` longtext,
  `OPTLOCK` int(11) default NULL,
  `sds_offering_fk` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `workgroup_id` (`workgroup_id`),
  KEY `FK440A0C42AB4F6201` (`sds_offering_fk`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sds_workgroups`
--

LOCK TABLES `sds_workgroups` WRITE;
/*!40000 ALTER TABLE `sds_workgroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `sds_workgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sds_workgroups_related_to_sds_users`
--

DROP TABLE IF EXISTS `sds_workgroups_related_to_sds_users`;
CREATE TABLE `sds_workgroups_related_to_sds_users` (
  `sds_workgroup_fk` bigint(20) NOT NULL,
  `sds_user_fk` bigint(20) NOT NULL,
  PRIMARY KEY  (`sds_workgroup_fk`,`sds_user_fk`),
  KEY `FKA31D36785AAC23E7` (`sds_workgroup_fk`),
  KEY `FKA31D3678F342C661` (`sds_user_fk`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sds_workgroups_related_to_sds_users`
--

LOCK TABLES `sds_workgroups_related_to_sds_users` WRITE;
/*!40000 ALTER TABLE `sds_workgroups_related_to_sds_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `sds_workgroups_related_to_sds_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_user_details`
--

DROP TABLE IF EXISTS `student_user_details`;
CREATE TABLE `student_user_details` (
  `accountanswer` varchar(255) NOT NULL,
  `accountquestion` varchar(255) NOT NULL,
  `birthday` datetime NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `gender` int(11) NOT NULL,
  `lastlogintime` datetime default NULL,
  `lastname` varchar(255) NOT NULL,
  `numberoflogins` int(11) NOT NULL,
  `signupdate` datetime NOT NULL,
  `id` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FKC5AA2952D1D25907` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student_user_details`
--

LOCK TABLES `student_user_details` WRITE;
/*!40000 ALTER TABLE `student_user_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_user_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_user_details`
--

DROP TABLE IF EXISTS `teacher_user_details`;
CREATE TABLE `teacher_user_details` (
  `city` varchar(255) default NULL,
  `country` varchar(255) NOT NULL,
  `curriculumsubjects` tinyblob NOT NULL,
  `displayname` varchar(255) default NULL,
  `firstname` varchar(255) NOT NULL,
  `lastlogintime` datetime default NULL,
  `lastname` varchar(255) NOT NULL,
  `numberoflogins` int(11) NOT NULL,
  `schoollevel` int(11) NOT NULL,
  `schoolname` varchar(255) NOT NULL,
  `signupdate` datetime NOT NULL,
  `state` varchar(255) default NULL,
  `id` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FKAC84070BD1D25907` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacher_user_details`
--

LOCK TABLES `teacher_user_details` WRITE;
/*!40000 ALTER TABLE `teacher_user_details` DISABLE KEYS */;
INSERT INTO `teacher_user_details` VALUES ('Berkeley','USA','¬í\0ur\0[Ljava.lang.String;­ÒVçé{G\0\0xp\0\0\0t\0biology',NULL,'ad','2009-05-18 20:27:40','min',5,3,'Berkeley','2009-05-18 12:45:34','CA',1),('Berkeley','USA','¬í\0ur\0[Ljava.lang.String;­ÒVçé{G\0\0xp\0\0\0t\0biology',NULL,'preview',NULL,'user',0,3,'Berkeley','2009-05-18 12:45:34','CA',2);
/*!40000 ALTER TABLE `teacher_user_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `urlmodules`
--

DROP TABLE IF EXISTS `urlmodules`;
CREATE TABLE `urlmodules` (
  `module_url` varchar(255) default NULL,
  `id` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FKC83237389627A0C6` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `urlmodules`
--

LOCK TABLES `urlmodules` WRITE;
/*!40000 ALTER TABLE `urlmodules` DISABLE KEYS */;
/*!40000 ALTER TABLE `urlmodules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_details`
--

DROP TABLE IF EXISTS `user_details`;
CREATE TABLE `user_details` (
  `id` bigint(20) NOT NULL auto_increment,
  `account_not_expired` bit(1) NOT NULL,
  `account_not_locked` bit(1) NOT NULL,
  `credentials_not_expired` bit(1) NOT NULL,
  `email_address` varchar(255) default NULL,
  `enabled` bit(1) NOT NULL,
  `password` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `OPTLOCK` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_details`
--

LOCK TABLES `user_details` WRITE;
/*!40000 ALTER TABLE `user_details` DISABLE KEYS */;
INSERT INTO `user_details` VALUES (1,'','','',NULL,'','24c002f26c14d8e087ade986531c7b5d','admin',5),(2,'','','',NULL,'','2ece21e1cf40509868e5a74a48d49a50','previewuser',0);
/*!40000 ALTER TABLE `user_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_details_related_to_roles`
--

DROP TABLE IF EXISTS `user_details_related_to_roles`;
CREATE TABLE `user_details_related_to_roles` (
  `user_details_fk` bigint(20) NOT NULL,
  `granted_authorities_fk` bigint(20) NOT NULL,
  PRIMARY KEY  (`user_details_fk`,`granted_authorities_fk`),
  KEY `FKE6A5FBDEE3B038C2` (`user_details_fk`),
  KEY `FKE6A5FBDE44F8149A` (`granted_authorities_fk`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_details_related_to_roles`
--

LOCK TABLES `user_details_related_to_roles` WRITE;
/*!40000 ALTER TABLE `user_details_related_to_roles` DISABLE KEYS */;
INSERT INTO `user_details_related_to_roles` VALUES (1,1),(1,2),(1,3),(1,5),(2,1),(2,3),(2,5);
/*!40000 ALTER TABLE `user_details_related_to_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL auto_increment,
  `OPTLOCK` int(11) default NULL,
  `sds_user_fk` bigint(20) default NULL,
  `user_details_fk` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_details_fk` (`user_details_fk`),
  UNIQUE KEY `sds_user_fk` (`sds_user_fk`),
  KEY `FK6A68E08E3B038C2` (`user_details_fk`),
  KEY `FK6A68E08F342C661` (`sds_user_fk`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,0,NULL,1),(2,0,NULL,2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiseworkgroups`
--

DROP TABLE IF EXISTS `wiseworkgroups`;
CREATE TABLE `wiseworkgroups` (
  `externalId` bigint(20) default NULL,
  `is_teacher_workgroup` bit(1) default NULL,
  `id` bigint(20) NOT NULL,
  `period` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKF16C83C93013AD46` (`period`),
  KEY `FKF16C83C9F309B437` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wiseworkgroups`
--

LOCK TABLES `wiseworkgroups` WRITE;
/*!40000 ALTER TABLE `wiseworkgroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiseworkgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workgroups`
--

DROP TABLE IF EXISTS `workgroups`;
CREATE TABLE `workgroups` (
  `id` bigint(20) NOT NULL auto_increment,
  `OPTLOCK` int(11) default NULL,
  `group_fk` bigint(20) NOT NULL,
  `offering_fk` bigint(20) NOT NULL,
  `sds_workgroup_fk` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `sds_workgroup_fk` (`sds_workgroup_fk`),
  KEY `FKEC8E50255AAC23E7` (`sds_workgroup_fk`),
  KEY `FKEC8E502553AE0756` (`offering_fk`),
  KEY `FKEC8E5025895EAE0A` (`group_fk`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `workgroups`
--

LOCK TABLES `workgroups` WRITE;
/*!40000 ALTER TABLE `workgroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `workgroups` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-05-19  3:43:06
