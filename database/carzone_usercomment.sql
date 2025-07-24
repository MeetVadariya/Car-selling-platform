-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: carzone
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `usercomment`
--

DROP TABLE IF EXISTS `usercomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usercomment` (
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phoneno` varchar(14) NOT NULL,
  `message` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usercomment`
--

LOCK TABLES `usercomment` WRITE;
/*!40000 ALTER TABLE `usercomment` DISABLE KEYS */;
INSERT INTO `usercomment` VALUES ('abc','abc@gmail.com','84562138','hello'),('abc','abc@gmail.com','84562138','hello'),('hii','12@gmail.com','84562138','hello'),('hii','12@gmail.com','84562138','hello'),('Test','test@example.com','9876543210','This is a test message.'),('Meet Vadariya','rajrajray1122@gmail.com','9328205826','hello'),('arsh','arsh@gmail.com','546982347','car'),('arsh','arsh@gmail.com','546982347','wgduyw'),('samir','s@gmail.com','7545989351','hiii'),('samir','s@gmail.com','7545989351','hiii'),('samir','s@gmail.com','7545989351','hiii'),('riya','R@gmail.com','74461113955','hello!!'),('riya','R@gmail.com','74461113955','hello!!'),('bholu','bholu@gmail.com','8765454562','Hello!!'),('bholu','bholu@gmail.com','8765454562','Hello!!'),('1M','M@gmail.com','46598165','car'),('1M','M@gmail.com','46598165','sport car'),('abc','ab@gmail.com','14566316','abc'),('abc','ab@gmail.com','14566316','sport car'),('abc','ab@gmail.com','14566316','jkhh'),('abc','ab@gmail.com','14566316','jkhh'),('dog','dog@gmail.com','965138946','hiii'),('cat','cat@gmail.com','45132','cat'),('Meet','cat@gmail.com','45132','hiiii'),('arsh','arsh@gmail.com','546982347','hello'),('arsh','arsh@gmail.com','546982347','car'),('Meet Vadariya','meet@gmail.com','09328205826','hello!!!!'),('ujwala','uj@gmail.com','1234567898','fdfffdf\r\ndfdfdfdf\r\ndfdfdfdf\r\ndfdf\r\nfdfdfdfd'),('ujwala','uj@gmail.com','12345','ddgf\r\nfgfgf\r\ngfgfg\r\nfgfg\r\n');
/*!40000 ALTER TABLE `usercomment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-24 14:45:45
