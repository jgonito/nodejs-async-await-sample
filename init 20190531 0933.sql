-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.13-MariaDB


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema employee
--

CREATE DATABASE IF NOT EXISTS employee;
USE employee;

--
-- Definition of table `department`
--

DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `department`
--

/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` (`id`,`name`) VALUES 
 (1,'Software Development');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;


--
-- Definition of table `designation`
--

DROP TABLE IF EXISTS `designation`;
CREATE TABLE `designation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `designation`
--

/*!40000 ALTER TABLE `designation` DISABLE KEYS */;
INSERT INTO `designation` (`id`,`name`) VALUES 
 (1,'Full Stack Developer');
/*!40000 ALTER TABLE `designation` ENABLE KEYS */;


--
-- Definition of table `employee_info`
--

DROP TABLE IF EXISTS `employee_info`;
CREATE TABLE `employee_info` (
  `emp_id` varchar(10) NOT NULL,
  `date_hired` datetime NOT NULL,
  `department_id` int(10) unsigned NOT NULL,
  `designation_id` int(10) unsigned NOT NULL,
  `schedule_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_info`
--

/*!40000 ALTER TABLE `employee_info` DISABLE KEYS */;
INSERT INTO `employee_info` (`emp_id`,`date_hired`,`department_id`,`designation_id`,`schedule_id`) VALUES 
 ('00001','2012-09-03 00:00:00',1,1,1);
/*!40000 ALTER TABLE `employee_info` ENABLE KEYS */;


--
-- Definition of table `personal_info`
--

DROP TABLE IF EXISTS `personal_info`;
CREATE TABLE `personal_info` (
  `emp_id` varchar(10) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `birthdate` datetime NOT NULL,
  `gender` varchar(1) NOT NULL DEFAULT 'M' COMMENT '''M'' or ''F''',
  PRIMARY KEY (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `personal_info`
--

/*!40000 ALTER TABLE `personal_info` DISABLE KEYS */;
INSERT INTO `personal_info` (`emp_id`,`last_name`,`first_name`,`middle_name`,`birthdate`,`gender`) VALUES 
 ('00001','Dela Cruz','Juan',NULL,'1988-05-28 00:00:00','M');
/*!40000 ALTER TABLE `personal_info` ENABLE KEYS */;


--
-- Definition of table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
CREATE TABLE `schedule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schedule`
--

/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
INSERT INTO `schedule` (`id`,`type`) VALUES 
 (1,'Regular');
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;


--
-- Definition of table `working_days`
--

DROP TABLE IF EXISTS `working_days`;
CREATE TABLE `working_days` (
  `schedule_id` int(10) unsigned NOT NULL,
  `day` int(10) unsigned NOT NULL COMMENT '1=Monday',
  `time_in` varchar(5) DEFAULT NULL,
  `time_out` varchar(5) DEFAULT NULL,
  `is_restday` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`schedule_id`,`day`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `working_days`
--

/*!40000 ALTER TABLE `working_days` DISABLE KEYS */;
INSERT INTO `working_days` (`schedule_id`,`day`,`time_in`,`time_out`,`is_restday`) VALUES 
 (1,1,'09:00','18:00',0),
 (1,2,'09:00','18:00',0),
 (1,3,'09:00','18:00',0),
 (1,4,'09:00','18:00',0),
 (1,5,'09:00','18:00',0),
 (1,6,'08:00','17:00',0),
 (1,7,NULL,NULL,1);
/*!40000 ALTER TABLE `working_days` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
