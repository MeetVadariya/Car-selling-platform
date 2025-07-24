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
-- Table structure for table `username`
--

DROP TABLE IF EXISTS `username`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `username` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `phone` varchar(14) DEFAULT NULL,
  `Isadmin` tinyint DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `username`
--

LOCK TABLES `username` WRITE;
/*!40000 ALTER TABLE `username` DISABLE KEYS */;
INSERT INTO `username` VALUES (1,'Admin','admin@gmail.com','1234','7894561230',1),(2,'Meet','meet@gmail.com','1234','9794561230',0),(3,'arsh','arsh@gmail.com','12345','12345678',0),(4,'raj','raj@gmail.com','1234','885282852',0),(5,'pankaj','p12@gmail.com','p123','98784512165',0),(6,'roy','r123@gmail.com','roy123','789465184',0),(7,'Netra','netra@gmail.com','12345','1234567890',0),(8,'abc','abc@gmail.com','8520','08745546923',0),(9,'dog','dog@gmail.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','965138946',0),(10,'samir','s@gmail.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','07545989351',0),(11,'pankaj','pkaloal7@gamil.com','5be2d113f12b33e03afcfb9620d43f9a29396ad894de202c8d77f60d842c9151','98784512165',1),(12,'Harsh','harshparmar5934@gmail.com','5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5','66551444566',0),(13,'Priyanki Panchal','bitsjin09@bitbaroda.com','5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5','9898410848',0),(14,'dhyan','dhyan@gmail.com','4f9fde2cc6d948a3db268de2db2fcf9084855cdff0dfecc052ffb55df1738dc2','9898410848',0),(15,'Saurabh Singh','singhsaurabh7080142694@gmail.com','75276fac02487c1489148daaa4d9c648908b13e70110e0119dc328bdcd999cd9','45451515',0),(16,'ujwala','uj@gmail.com','11da8494ded4c398376ab80ad1c0c43e7804786a1480896294d59bd10c33ef99','+91 1234567898',0),(17,'meet','meet25@gmail.com','34d7572f215a64af4f22ceae4649745758bb1d78f8272dc683b864603714b229','09328205826',0),(18,'arsh','arsh.katharotiya14@gmail.com','d70e914a38b32c96a97286b0edadaab9cb67a4a43b2f4eea5fabfe7c2475c85e','931219149',0),(19,'arsh','arsh.kathrotiya14@gmail.com','c157b175cde9a66d8a307e61b051319ddfa7c6cbee925e7284a62b41e3186163','931219149',0),(20,'meet','mee12t@gmail.com','af86bb709ab06bfec964940351c2d6bba179465aa9546a85de7eabb312696b91','123456789',0),(21,'Mistry Ashish','mistryashish1702@gmail.com','f73bf03ae8f7fcb55cd317c7f97f0952f83b7fd69b0a7e316d1776b22199bd28','8347362996',0),(22,'mahi','mahi@gmail.com','7d71f1a8e447717c0161321b7d9be42faeabfb990df7c403e6e0a2022c54de1e','456413+966',1);
/*!40000 ALTER TABLE `username` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-24 14:45:46
