-- MySQL dump 10.13  Distrib 5.1.35, for apple-darwin9.5.0 (i386)
--
-- Host: localhost    Database: sail_database
-- ------------------------------------------------------
-- Server version	5.1.35-log

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
-- Current Database: `sail_database`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `sail_database` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `sail_database`;

--
-- Table structure for table `EVENTS`
--

DROP TABLE IF EXISTS `EVENTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EVENTS` (
  `EVENT_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `EVENT_DATE` datetime DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`EVENT_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_class`
--

DROP TABLE IF EXISTS `acl_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_class` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `class` varchar(255) NOT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `class` (`class`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_entry`
--

DROP TABLE IF EXISTS `acl_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_entry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ace_order` int(11) NOT NULL,
  `audit_failure` bit(1) NOT NULL,
  `audit_success` bit(1) NOT NULL,
  `granting` bit(1) NOT NULL,
  `mask` int(11) NOT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  `sid` bigint(20) NOT NULL,
  `acl_object_identity` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acl_object_identity` (`acl_object_identity`,`ace_order`),
  KEY `FK5302D47DC9975936` (`acl_object_identity`),
  KEY `FK5302D47D9A4DE79D` (`sid`),
  CONSTRAINT `FK5302D47D9A4DE79D` FOREIGN KEY (`sid`) REFERENCES `acl_sid` (`id`),
  CONSTRAINT `FK5302D47DC9975936` FOREIGN KEY (`acl_object_identity`) REFERENCES `acl_object_identity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21776 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_object_identity`
--

DROP TABLE IF EXISTS `acl_object_identity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_object_identity` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `object_id_identity` bigint(20) NOT NULL,
  `object_id_identity_num` int(11) DEFAULT NULL,
  `entries_inheriting` bit(1) NOT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  `object_id_class` bigint(20) NOT NULL,
  `owner_sid` bigint(20) DEFAULT NULL,
  `parent_object` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `object_id_class` (`object_id_class`,`object_id_identity`),
  KEY `FK2A2BB009BDC00DA1` (`parent_object`),
  KEY `FK2A2BB0092458F1A3` (`object_id_class`),
  KEY `FK2A2BB0099B5E7811` (`owner_sid`),
  CONSTRAINT `FK2A2BB0092458F1A3` FOREIGN KEY (`object_id_class`) REFERENCES `acl_class` (`id`),
  CONSTRAINT `FK2A2BB0099B5E7811` FOREIGN KEY (`owner_sid`) REFERENCES `acl_sid` (`id`),
  CONSTRAINT `FK2A2BB009BDC00DA1` FOREIGN KEY (`parent_object`) REFERENCES `acl_object_identity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17072 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_sid`
--

DROP TABLE IF EXISTS `acl_sid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_sid` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `principal` tinyint(1) NOT NULL,
  `sid` varchar(255) NOT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sid` (`sid`,`principal`)
) ENGINE=InnoDB AUTO_INCREMENT=4561 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `annotationbundles`
--

DROP TABLE IF EXISTS `annotationbundles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `annotationbundles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bundle` longtext NOT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  `workgroup_fk` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKAA5FD222F54443B2` (`workgroup_fk`),
  CONSTRAINT `FKAA5FD222F54443B2` FOREIGN KEY (`workgroup_fk`) REFERENCES `workgroups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcements` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `announcement` text NOT NULL,
  `timestamp` datetime NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `curnits`
--

DROP TABLE IF EXISTS `curnits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curnits` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OPTLOCK` int(11) DEFAULT NULL,
  `sds_curnit_fk` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sds_curnit_fk` (`sds_curnit_fk`),
  KEY `FK4329FBBA1B78E061` (`sds_curnit_fk`),
  CONSTRAINT `FK4329FBBA1B78E061` FOREIGN KEY (`sds_curnit_fk`) REFERENCES `sds_curnits` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `diyprojectcommunicators`
--

DROP TABLE IF EXISTS `diyprojectcommunicators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diyprojectcommunicators` (
  `diyportalhostname` varchar(255) DEFAULT NULL,
  `previewdiyprojectsuffix` varchar(255) DEFAULT NULL,
  `id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK83FA9ED96FC1637F` (`id`),
  CONSTRAINT `FK83FA9ED96FC1637F` FOREIGN KEY (`id`) REFERENCES `projectcommunicators` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `externalprojects`
--

DROP TABLE IF EXISTS `externalprojects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `externalprojects` (
  `external_id` bigint(20) DEFAULT NULL,
  `id` bigint(20) NOT NULL,
  `projectcommunicator_fk` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKD8238145E48A3C0A` (`id`),
  KEY `FKD8238145CE9C471A` (`projectcommunicator_fk`),
  CONSTRAINT `FKD8238145CE9C471A` FOREIGN KEY (`projectcommunicator_fk`) REFERENCES `projectcommunicators` (`id`),
  CONSTRAINT `FKD8238145E48A3C0A` FOREIGN KEY (`id`) REFERENCES `projects` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `granted_authorities`
--

DROP TABLE IF EXISTS `granted_authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `granted_authorities` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `authority` varchar(255) NOT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `authority` (`authority`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  `parent_fk` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKB63DD9D4E696E7FF` (`parent_fk`),
  CONSTRAINT `FKB63DD9D4E696E7FF` FOREIGN KEY (`parent_fk`) REFERENCES `groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17650 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groups_related_to_users`
--

DROP TABLE IF EXISTS `groups_related_to_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups_related_to_users` (
  `group_fk` bigint(20) NOT NULL,
  `user_fk` bigint(20) NOT NULL,
  PRIMARY KEY (`group_fk`,`user_fk`),
  KEY `FK3311F7E3895EAE0A` (`group_fk`),
  KEY `FK3311F7E356CA53B6` (`user_fk`),
  CONSTRAINT `FK3311F7E356CA53B6` FOREIGN KEY (`user_fk`) REFERENCES `users` (`id`),
  CONSTRAINT `FK3311F7E3895EAE0A` FOREIGN KEY (`group_fk`) REFERENCES `groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jnlps`
--

DROP TABLE IF EXISTS `jnlps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jnlps` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OPTLOCK` int(11) DEFAULT NULL,
  `sds_jnlp_fk` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sds_jnlp_fk` (`sds_jnlp_fk`),
  KEY `FK6095FABA532A941` (`sds_jnlp_fk`),
  CONSTRAINT `FK6095FABA532A941` FOREIGN KEY (`sds_jnlp_fk`) REFERENCES `sds_jnlps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `message_recipient`
--

DROP TABLE IF EXISTS `message_recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_recipient` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `recipient_fk` bigint(20) NOT NULL,
  `isRead` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `originalMessage` bigint(20) DEFAULT NULL,
  `date` datetime NOT NULL,
  `sender` bigint(20) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messages_related_to_message_recipients`
--

DROP TABLE IF EXISTS `messages_related_to_message_recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages_related_to_message_recipients` (
  `messages_fk` bigint(20) NOT NULL,
  `recipients_fk` bigint(20) NOT NULL,
  PRIMARY KEY (`messages_fk`,`recipients_fk`),
  UNIQUE KEY `recipients_fk` (`recipients_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modules` (
  `authors` varchar(255) DEFAULT NULL,
  `computer_time` bigint(20) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `grades` varchar(255) DEFAULT NULL,
  `tech_reqs` varchar(255) DEFAULT NULL,
  `topic_keywords` varchar(255) DEFAULT NULL,
  `total_time` bigint(20) DEFAULT NULL,
  `id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK492927875E6F3BA6` (`id`),
  CONSTRAINT `FK492927875E6F3BA6` FOREIGN KEY (`id`) REFERENCES `curnits` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `modules_related_to_owners`
--

DROP TABLE IF EXISTS `modules_related_to_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modules_related_to_owners` (
  `module_fk` bigint(20) NOT NULL,
  `owners_fk` bigint(20) NOT NULL,
  PRIMARY KEY (`module_fk`,`owners_fk`),
  KEY `FKE09C9839A4B723` (`module_fk`),
  KEY `FKE09C9860AA7F41` (`owners_fk`),
  CONSTRAINT `FKE09C9839A4B723` FOREIGN KEY (`module_fk`) REFERENCES `modules` (`id`),
  CONSTRAINT `FKE09C9860AA7F41` FOREIGN KEY (`owners_fk`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `newsitem`
--

DROP TABLE IF EXISTS `newsitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newsitem` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `news` text NOT NULL,
  `title` varchar(255) NOT NULL,
  `owner` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK532D646665E358B0` (`owner`),
  CONSTRAINT `FK532D646665E358B0` FOREIGN KEY (`owner`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `offerings`
--

DROP TABLE IF EXISTS `offerings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offerings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OPTLOCK` int(11) DEFAULT NULL,
  `sds_offering_fk` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sds_offering_fk` (`sds_offering_fk`),
  KEY `FK73F0F12DAB4F6201` (`sds_offering_fk`),
  CONSTRAINT `FK73F0F12DAB4F6201` FOREIGN KEY (`sds_offering_fk`) REFERENCES `sds_offerings` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=372 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Table structure for table `portal`
--

DROP TABLE IF EXISTS `portal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `google_map_key` varchar(255) DEFAULT NULL,
  `sendmail_on_exception` bit(1) DEFAULT NULL,
  `portalname` varchar(255) DEFAULT NULL,
  `sendmail_properties` tinyblob,
  `OPTLOCK` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `premadecommentlists`
--

DROP TABLE IF EXISTS `premadecommentlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `premadecommentlists` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) NOT NULL,
  `owner` bigint(20) DEFAULT NULL,
  `run` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKF237B2CEF4421937` (`run`),
  KEY `FKF237B2CE65E358B0` (`owner`),
  CONSTRAINT `FKF237B2CE65E358B0` FOREIGN KEY (`owner`) REFERENCES `users` (`id`),
  CONSTRAINT `FKF237B2CEF4421937` FOREIGN KEY (`run`) REFERENCES `runs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `premadecomments`
--

DROP TABLE IF EXISTS `premadecomments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `premadecomments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `comment` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `owner` bigint(20) DEFAULT NULL,
  `run` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7786D42CF4421937` (`run`),
  KEY `FK7786D42C65E358B0` (`owner`),
  CONSTRAINT `FK7786D42C65E358B0` FOREIGN KEY (`owner`) REFERENCES `users` (`id`),
  CONSTRAINT `FK7786D42CF4421937` FOREIGN KEY (`run`) REFERENCES `runs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `premadecomments_related_to_premadecommentlists`
--

DROP TABLE IF EXISTS `premadecomments_related_to_premadecommentlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `premadecomments_related_to_premadecommentlists` (
  `premadecommentslist_fk` bigint(20) NOT NULL,
  `premadecomments_fk` bigint(20) NOT NULL,
  PRIMARY KEY (`premadecommentslist_fk`,`premadecomments_fk`),
  KEY `FK6958FC11C8153CF5` (`premadecomments_fk`),
  KEY `FK6958FC112FC6E4D5` (`premadecommentslist_fk`),
  CONSTRAINT `FK6958FC112FC6E4D5` FOREIGN KEY (`premadecommentslist_fk`) REFERENCES `premadecommentlists` (`id`),
  CONSTRAINT `FK6958FC11C8153CF5` FOREIGN KEY (`premadecomments_fk`) REFERENCES `premadecomments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_metadata`
--

DROP TABLE IF EXISTS `project_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_metadata` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `author` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `grade_range` varchar(255) DEFAULT NULL,
  `total_time` bigint(20) DEFAULT NULL,
  `comp_time` bigint(20) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `tech_reqs` varchar(255) DEFAULT NULL,
  `lesson_plan` blob,
  `keywords` varchar(255) DEFAULT NULL,
  `project_fk` bigint(20) DEFAULT NULL,
  `version_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projectcommunicators`
--

DROP TABLE IF EXISTS `projectcommunicators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projectcommunicators` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `baseurl` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `familytag` int(11) DEFAULT NULL,
  `iscurrent` bit(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `projecttype` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  `curnit_fk` bigint(20) DEFAULT NULL,
  `jnlp_fk` bigint(20) DEFAULT NULL,
  `run_fk` bigint(20) DEFAULT NULL,
  `ispublic` bit(1) DEFAULT b'0',
  `datecreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `run_fk` (`run_fk`),
  KEY `FKC479187ABD6D05A5` (`run_fk`),
  KEY `FKC479187A9568F016` (`jnlp_fk`),
  KEY `FKC479187A7F08E576` (`curnit_fk`),
  CONSTRAINT `FKC479187A7F08E576` FOREIGN KEY (`curnit_fk`) REFERENCES `curnits` (`id`),
  CONSTRAINT `FKC479187A9568F016` FOREIGN KEY (`jnlp_fk`) REFERENCES `jnlps` (`id`),
  CONSTRAINT `FKC479187ABD6D05A5` FOREIGN KEY (`run_fk`) REFERENCES `runs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects_related_to_bookmarkers`
--

DROP TABLE IF EXISTS `projects_related_to_bookmarkers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects_related_to_bookmarkers` (
  `projects_fk` bigint(20) NOT NULL,
  `bookmarkers` bigint(20) NOT NULL,
  PRIMARY KEY (`projects_fk`,`bookmarkers`),
  KEY `FK5AA350A531C3B66D` (`bookmarkers`),
  KEY `FK5AA350A5AC92FD99` (`projects_fk`),
  CONSTRAINT `FK5AA350A531C3B66D` FOREIGN KEY (`bookmarkers`) REFERENCES `users` (`id`),
  CONSTRAINT `FK5AA350A5AC92FD99` FOREIGN KEY (`projects_fk`) REFERENCES `projects` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects_related_to_owners`
--

DROP TABLE IF EXISTS `projects_related_to_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects_related_to_owners` (
  `projects_fk` bigint(20) NOT NULL,
  `owners_fk` bigint(20) NOT NULL,
  PRIMARY KEY (`projects_fk`,`owners_fk`),
  KEY `FKDACF56CB60AA7F41` (`owners_fk`),
  KEY `FKDACF56CBAC92FD99` (`projects_fk`),
  CONSTRAINT `FKDACF56CB60AA7F41` FOREIGN KEY (`owners_fk`) REFERENCES `users` (`id`),
  CONSTRAINT `FKDACF56CBAC92FD99` FOREIGN KEY (`projects_fk`) REFERENCES `projects` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects_related_to_shared_owners`
--

DROP TABLE IF EXISTS `projects_related_to_shared_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects_related_to_shared_owners` (
  `projects_fk` bigint(20) NOT NULL,
  `shared_owners_fk` bigint(20) NOT NULL,
  PRIMARY KEY (`projects_fk`,`shared_owners_fk`),
  KEY `FK19A2B02FDB63ABE7` (`shared_owners_fk`),
  KEY `FK19A2B02FAC92FD99` (`projects_fk`),
  CONSTRAINT `FK19A2B02FAC92FD99` FOREIGN KEY (`projects_fk`) REFERENCES `projects` (`id`),
  CONSTRAINT `FK19A2B02FDB63ABE7` FOREIGN KEY (`shared_owners_fk`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects_related_to_tags`
--

DROP TABLE IF EXISTS `projects_related_to_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects_related_to_tags` (
  `project_fk` bigint(20) NOT NULL,
  `tag_fk` bigint(20) NOT NULL,
  PRIMARY KEY (`project_fk`,`tag_fk`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `runs`
--

DROP TABLE IF EXISTS `runs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `runs` (
  `end_time` datetime DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `run_code` varchar(255) NOT NULL,
  `start_time` datetime NOT NULL,
  `id` bigint(20) NOT NULL,
  `project_fk` bigint(20) NOT NULL,
  `maxWorkgroupSize` int(11) DEFAULT NULL,
  `archive_reminder` datetime DEFAULT NULL,
  `extras` text,
  `loggingLevel` int(11) DEFAULT NULL,
  `postLevel` int(11) DEFAULT NULL,
  `versionId` varchar(255) DEFAULT NULL,
  `timesRun` int(11) DEFAULT NULL,
  `lastRun` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `run_code` (`run_code`),
  KEY `FK3597481834F8D3` (`id`),
  KEY `FK3597486F1ED29A` (`project_fk`),
  CONSTRAINT `FK3597481834F8D3` FOREIGN KEY (`id`) REFERENCES `offerings` (`id`),
  CONSTRAINT `FK3597486F1ED29A` FOREIGN KEY (`project_fk`) REFERENCES `projects` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `runs_related_to_announcements`
--

DROP TABLE IF EXISTS `runs_related_to_announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `runs_related_to_announcements` (
  `runs_fk` bigint(20) NOT NULL,
  `announcements_fk` bigint(20) NOT NULL,
  PRIMARY KEY (`runs_fk`,`announcements_fk`),
  UNIQUE KEY `announcements_fk` (`announcements_fk`),
  KEY `FKEDEF47F33BC1BEB5` (`announcements_fk`),
  KEY `FKEDEF47F350B193C8` (`runs_fk`),
  CONSTRAINT `FKEDEF47F33BC1BEB5` FOREIGN KEY (`announcements_fk`) REFERENCES `announcements` (`id`),
  CONSTRAINT `FKEDEF47F350B193C8` FOREIGN KEY (`runs_fk`) REFERENCES `runs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `runs_related_to_groups`
--

DROP TABLE IF EXISTS `runs_related_to_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `runs_related_to_groups` (
  `runs_fk` bigint(20) NOT NULL,
  `groups_fk` bigint(20) NOT NULL,
  PRIMARY KEY (`runs_fk`,`groups_fk`),
  UNIQUE KEY `groups_fk` (`groups_fk`),
  KEY `FK6CD673CD50B193C8` (`runs_fk`),
  KEY `FK6CD673CD12D98E95` (`groups_fk`),
  CONSTRAINT `FK6CD673CD12D98E95` FOREIGN KEY (`groups_fk`) REFERENCES `groups` (`id`),
  CONSTRAINT `FK6CD673CD50B193C8` FOREIGN KEY (`runs_fk`) REFERENCES `runs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `runs_related_to_owners`
--

DROP TABLE IF EXISTS `runs_related_to_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `runs_related_to_owners` (
  `runs_fk` bigint(20) NOT NULL,
  `owners_fk` bigint(20) NOT NULL,
  PRIMARY KEY (`runs_fk`,`owners_fk`),
  KEY `FK7AC2FE1950B193C8` (`runs_fk`),
  KEY `FK7AC2FE1960AA7F41` (`owners_fk`),
  CONSTRAINT `FK7AC2FE1950B193C8` FOREIGN KEY (`runs_fk`) REFERENCES `runs` (`id`),
  CONSTRAINT `FK7AC2FE1960AA7F41` FOREIGN KEY (`owners_fk`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `runs_related_to_shared_owners`
--

DROP TABLE IF EXISTS `runs_related_to_shared_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `runs_related_to_shared_owners` (
  `runs_fk` bigint(20) NOT NULL,
  `shared_owners_fk` bigint(20) NOT NULL,
  PRIMARY KEY (`runs_fk`,`shared_owners_fk`),
  KEY `FKBD30D521DB63ABE7` (`shared_owners_fk`),
  KEY `FKBD30D52150B193C8` (`runs_fk`),
  CONSTRAINT `FKBD30D52150B193C8` FOREIGN KEY (`runs_fk`) REFERENCES `runs` (`id`),
  CONSTRAINT `FKBD30D521DB63ABE7` FOREIGN KEY (`shared_owners_fk`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scenario`
--

DROP TABLE IF EXISTS `scenario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scenario` (
  `primKey` varchar(55) NOT NULL DEFAULT '',
  `name` varchar(250) DEFAULT NULL,
  `description` text,
  `timeCreated` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`primKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sds_curnits`
--

DROP TABLE IF EXISTS `sds_curnits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sds_curnits` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `curnit_id` bigint(20) NOT NULL,
  `url` varchar(255) NOT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `curnit_id` (`curnit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sds_jnlps`
--

DROP TABLE IF EXISTS `sds_jnlps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sds_jnlps` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `jnlp_id` bigint(20) NOT NULL,
  `url` varchar(255) NOT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jnlp_id` (`jnlp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sds_offerings`
--

DROP TABLE IF EXISTS `sds_offerings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sds_offerings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `sds_curnitmap` longtext,
  `offering_id` bigint(20) NOT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  `sds_curnit_fk` bigint(20) NOT NULL,
  `sds_jnlp_fk` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `offering_id` (`offering_id`),
  KEY `FK242EBD70A532A941` (`sds_jnlp_fk`),
  KEY `FK242EBD701B78E061` (`sds_curnit_fk`),
  CONSTRAINT `FK242EBD701B78E061` FOREIGN KEY (`sds_curnit_fk`) REFERENCES `sds_curnits` (`id`),
  CONSTRAINT `FK242EBD70A532A941` FOREIGN KEY (`sds_jnlp_fk`) REFERENCES `sds_jnlps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sds_users`
--

DROP TABLE IF EXISTS `sds_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sds_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3177 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sds_workgroups`
--

DROP TABLE IF EXISTS `sds_workgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sds_workgroups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `workgroup_id` bigint(20) NOT NULL,
  `sds_sessionbundle` longtext,
  `OPTLOCK` int(11) DEFAULT NULL,
  `sds_offering_fk` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `workgroup_id` (`workgroup_id`),
  KEY `FK440A0C42AB4F6201` (`sds_offering_fk`),
  CONSTRAINT `FK440A0C42AB4F6201` FOREIGN KEY (`sds_offering_fk`) REFERENCES `sds_offerings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sds_workgroups_related_to_sds_users`
--

DROP TABLE IF EXISTS `sds_workgroups_related_to_sds_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sds_workgroups_related_to_sds_users` (
  `sds_workgroup_fk` bigint(20) NOT NULL,
  `sds_user_fk` bigint(20) NOT NULL,
  PRIMARY KEY (`sds_workgroup_fk`,`sds_user_fk`),
  KEY `FKA31D36785AAC23E7` (`sds_workgroup_fk`),
  KEY `FKA31D3678F342C661` (`sds_user_fk`),
  CONSTRAINT `FKA31D36785AAC23E7` FOREIGN KEY (`sds_workgroup_fk`) REFERENCES `sds_workgroups` (`id`),
  CONSTRAINT `FKA31D3678F342C661` FOREIGN KEY (`sds_user_fk`) REFERENCES `sds_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student_user_details`
--

DROP TABLE IF EXISTS `student_user_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_user_details` (
  `accountanswer` varchar(255) NOT NULL,
  `accountquestion` varchar(255) NOT NULL,
  `birthday` datetime NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `gender` int(11) NOT NULL,
  `lastlogintime` datetime DEFAULT NULL,
  `lastname` varchar(255) NOT NULL,
  `numberoflogins` int(11) NOT NULL,
  `signupdate` datetime NOT NULL,
  `id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKC5AA2952D1D25907` (`id`),
  CONSTRAINT `FKC5AA2952D1D25907` FOREIGN KEY (`id`) REFERENCES `user_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teacher_user_details`
--

DROP TABLE IF EXISTS `teacher_user_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher_user_details` (
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) NOT NULL,
  `curriculumsubjects` tinyblob NOT NULL,
  `displayname` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastlogintime` datetime DEFAULT NULL,
  `lastname` varchar(255) NOT NULL,
  `numberoflogins` int(11) NOT NULL,
  `schoollevel` int(11) NOT NULL,
  `schoolname` varchar(255) NOT NULL,
  `signupdate` datetime NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `id` bigint(20) NOT NULL,
  `isEmailValid` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`),
  KEY `FKAC84070BD1D25907` (`id`),
  CONSTRAINT `FKAC84070BD1D25907` FOREIGN KEY (`id`) REFERENCES `user_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `urlmodules`
--

DROP TABLE IF EXISTS `urlmodules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `urlmodules` (
  `module_url` varchar(255) DEFAULT NULL,
  `id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKC83237389627A0C6` (`id`),
  CONSTRAINT `FKC83237389627A0C6` FOREIGN KEY (`id`) REFERENCES `modules` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_details`
--

DROP TABLE IF EXISTS `user_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_not_expired` bit(1) NOT NULL,
  `account_not_locked` bit(1) NOT NULL,
  `credentials_not_expired` bit(1) NOT NULL,
  `email_address` varchar(255) DEFAULT NULL,
  `enabled` bit(1) NOT NULL,
  `password` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `OPTLOCK` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5913 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_details_related_to_roles`
--

DROP TABLE IF EXISTS `user_details_related_to_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_details_related_to_roles` (
  `user_details_fk` bigint(20) NOT NULL,
  `granted_authorities_fk` bigint(20) NOT NULL,
  PRIMARY KEY (`user_details_fk`,`granted_authorities_fk`),
  KEY `FKE6A5FBDEE3B038C2` (`user_details_fk`),
  KEY `FKE6A5FBDE44F8149A` (`granted_authorities_fk`),
  CONSTRAINT `FKE6A5FBDE44F8149A` FOREIGN KEY (`granted_authorities_fk`) REFERENCES `granted_authorities` (`id`),
  CONSTRAINT `FKE6A5FBDEE3B038C2` FOREIGN KEY (`user_details_fk`) REFERENCES `user_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OPTLOCK` int(11) DEFAULT NULL,
  `sds_user_fk` bigint(20) DEFAULT NULL,
  `user_details_fk` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_details_fk` (`user_details_fk`),
  UNIQUE KEY `sds_user_fk` (`sds_user_fk`),
  KEY `FK6A68E08E3B038C2` (`user_details_fk`),
  KEY `FK6A68E08F342C661` (`sds_user_fk`),
  CONSTRAINT `FK6A68E08E3B038C2` FOREIGN KEY (`user_details_fk`) REFERENCES `user_details` (`id`),
  CONSTRAINT `FK6A68E08F342C661` FOREIGN KEY (`sds_user_fk`) REFERENCES `sds_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5913 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wiseworkgroups`
--

DROP TABLE IF EXISTS `wiseworkgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiseworkgroups` (
  `externalId` bigint(20) DEFAULT NULL,
  `is_teacher_workgroup` bit(1) DEFAULT NULL,
  `id` bigint(20) NOT NULL,
  `period` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKF16C83C9F309B437` (`id`),
  KEY `FKF16C83C93013AD46` (`period`),
  CONSTRAINT `FKF16C83C93013AD46` FOREIGN KEY (`period`) REFERENCES `groups` (`id`),
  CONSTRAINT `FKF16C83C9F309B437` FOREIGN KEY (`id`) REFERENCES `workgroups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `workgroups`
--

DROP TABLE IF EXISTS `workgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workgroups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OPTLOCK` int(11) DEFAULT NULL,
  `group_fk` bigint(20) NOT NULL,
  `offering_fk` bigint(20) NOT NULL,
  `sds_workgroup_fk` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sds_workgroup_fk` (`sds_workgroup_fk`),
  KEY `FKEC8E5025895EAE0A` (`group_fk`),
  KEY `FKEC8E50255AAC23E7` (`sds_workgroup_fk`),
  KEY `FKEC8E502553AE0756` (`offering_fk`),
  CONSTRAINT `FKEC8E502553AE0756` FOREIGN KEY (`offering_fk`) REFERENCES `offerings` (`id`),
  CONSTRAINT `FKEC8E50255AAC23E7` FOREIGN KEY (`sds_workgroup_fk`) REFERENCES `sds_workgroups` (`id`),
  CONSTRAINT `FKEC8E5025895EAE0A` FOREIGN KEY (`group_fk`) REFERENCES `groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16574 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-07-14  0:55:36
