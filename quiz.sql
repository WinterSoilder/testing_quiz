-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: quiz
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `_prisma_migrations`
--

DROP TABLE IF EXISTS `_prisma_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text COLLATE utf8mb4_unicode_ci,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `applied_steps_count` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_prisma_migrations`
--

LOCK TABLES `_prisma_migrations` WRITE;
/*!40000 ALTER TABLE `_prisma_migrations` DISABLE KEYS */;
INSERT INTO `_prisma_migrations` VALUES ('3bc01fa3-13e1-4e05-a3e7-8678e95a5413','42bfbc792d94e45dd5e24a7ece50eac7f346caabff62fd1744ef2d7a493cc223','2022-03-27 18:59:06.234','20220327185905_quiz1',NULL,NULL,'2022-03-27 18:59:05.882',1),('b9f94962-24a5-4b6e-958e-f8a7e930e0a4','070163babf90b2ddbb24259f411b577f4f25d59b12e4919e0c3fd3859d0818b8','2022-03-27 21:26:39.057','20220327212638_quiz_2',NULL,NULL,'2022-03-27 21:26:38.933',1);
/*!40000 ALTER TABLE `_prisma_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `option_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Answer_question_id_key` (`question_id`),
  UNIQUE KEY `Answer_option_id_key` (`option_id`),
  CONSTRAINT `Answer_option_id_fkey` FOREIGN KEY (`option_id`) REFERENCES `option` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Answer_question_id_fkey` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES (5,1,1),(6,2,5),(7,3,12),(8,4,15),(9,5,20),(10,6,30),(11,7,33),(12,8,36),(13,9,40),(14,10,46),(15,11,47),(16,12,52),(17,13,55),(18,14,61),(19,15,63);
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `level`
--

DROP TABLE IF EXISTS `level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `level` (
  `id` int NOT NULL AUTO_INCREMENT,
  `level` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Level_level_key` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `level`
--

LOCK TABLES `level` WRITE;
/*!40000 ALTER TABLE `level` DISABLE KEYS */;
INSERT INTO `level` VALUES (1,'easy'),(3,'hard'),(2,'medium');
/*!40000 ALTER TABLE `level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `option`
--

DROP TABLE IF EXISTS `option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `option` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `option` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Option_question_id_fkey` (`question_id`),
  CONSTRAINT `Option_question_id_fkey` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `option`
--

LOCK TABLES `option` WRITE;
/*!40000 ALTER TABLE `option` DISABLE KEYS */;
INSERT INTO `option` VALUES (1,1,'Each test stage has a different purpose.'),(2,1,'It is easier to manage testing in stages.'),(3,1,'We can run different tests in different environments.'),(4,1,'The more stages we have, the better the testing.'),(5,2,'Regression testing'),(6,2,'Integration testing'),(7,2,'System testing'),(8,2,'User acceptance testing'),(9,3,'A minimal test set that achieves 100% LCSAJ coverage will also achieve 100% branch coverage.'),(10,3,'A minimal test set that achieves 100% path coverage will also achieve 100% statement'),(11,3,'A minimal test set that achieves 100% path coverage will generally detect more faults than one'),(12,3,'A minimal test set that achieves 100% statement coverage will generally detect more faults'),(13,4,'The system shall be user friendly.'),(14,4,'The safety-critical parts of the system shall contain 0 faults.'),(15,4,'The response time shall be less than one second for the specified design load.'),(16,4,'The system shall be built to be portable.'),(17,5,'Metrics from previous similar projects'),(18,5,'Discussions with the development team'),(19,5,'Time allocated for regression testing'),(20,5,'a & b'),(21,6,'It states that modules are tested against user requirements.'),(28,6,'It only models the testing phase.'),(29,6,'It specifies the test techniques to be used.'),(30,6,'It includes the verification of designs.'),(31,7,'Test coverage criteria can be measured in terms of items exercised by a test suite.'),(32,7,'A measure of test coverage criteria is the percentage of user requirements covered.'),(33,7,'A measure of test coverage criteria is the percentage of faults found.'),(34,7,'Test coverage criteria are often used when specifying test completion criteria.'),(35,8,'find as many faults as possible.'),(36,8,'test high risk areas.'),(37,8,'obtain good test coverage.'),(38,8,'test whatever is easiest to test.'),(39,9,'They are used to support multi-user testing.'),(40,9,'They are used to capture and animate user requirements.'),(41,9,'They are the most frequently purchased types of CAST tool.'),(42,9,'They capture aspects of user behavior'),(43,10,'System tests are often performed by independent teams.'),(44,10,'Functional testing is used more than structural testing.'),(45,10,'Faults found during system tests can be very expensive to fix.'),(46,10,'End-users should be involved in system tests.'),(47,11,'Incidents should always be fixed.'),(48,11,'An incident occurs when expected and actual results differ.'),(49,11,'Incidents can be analyzed to assist in test process improvement.'),(50,11,'An incident can be raised against documentation.'),(51,12,'time runs out.'),(52,12,'the required level of confidence has been achieved.'),(53,12,'no more faults are found.'),(54,12,'the users won’t find any serious faults.'),(55,13,'Incident resolution is the responsibility of the author of the software under test.'),(56,13,'Incidents may be raised against user requirements.'),(57,13,'Incidents require investigation and/or correction.'),(58,13,'Incidents are raised when expected and actual results differ.'),(59,14,'syntax testing'),(60,14,'equivalence partitioning'),(61,14,'stress testing'),(62,14,'modified condition/decision coverage'),(63,15,'In a system two different failures may have different severities.'),(64,15,'A system is necessarily more reliable after debugging for the removal of a fault.'),(65,15,'A fault need not affect the reliability of a system.'),(66,15,'Undetected errors may lead to faults and eventually to incorrect behavior.');
/*!40000 ALTER TABLE `option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Question_level_id_fkey` (`level_id`),
  CONSTRAINT `Question_level_id_fkey` FOREIGN KEY (`level_id`) REFERENCES `level` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,'We split testing into distinct stages primarily because:',1),(2,'Which of the following is likely to benefit most from the use of test tools providing test capture',1),(3,'Which of the following statements is NOT correct?',1),(4,'Which of the following requirements is testable?',1),(5,'How would you estimate the amount of re-testing likely to be required?',1),(6,'Which of the following is true of the V-model?',2),(7,'Which of the following is NOT true of test coverage criteria?',2),(8,'In prioritizing what to test, the most important objective is to',2),(9,'Which one of the following statements, about capture-replay tools, is NOT correct?',2),(10,'Which one of the following statements about system testing is NOT true?',2),(11,'Which of the following is false?',3),(12,'Enough testing has been performed when:',3),(13,'Which of the following is NOT true of incidents?',3),(14,'Which of the following is not described in a unit test standard?',3),(15,'Which of the following is false?',3);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `User_username_key` (`username`),
  UNIQUE KEY `User_password_key` (`password`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-28 22:05:13
