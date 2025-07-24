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
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `car_id` int NOT NULL,
  `price` double NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `customer_email` varchar(100) NOT NULL,
  `customer_phone` varchar(15) NOT NULL,
  `customer_address` text NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `card_number` varchar(20) DEFAULT NULL,
  `expiry_date` varchar(10) DEFAULT NULL,
  `cvv` varchar(4) DEFAULT NULL,
  `bank` varchar(100) DEFAULT NULL,
  `upi_id` varchar(100) DEFAULT NULL,
  `down_payment` double DEFAULT NULL,
  `emi_plan` varchar(50) DEFAULT NULL,
  `booking_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Pending',
  `image_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `car_id_idx` (`id`),
  KEY `fk_user_id` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `username` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,2,1500000,'pankaj','pkaloal7@gamil.com','98784512165','VADODARA','EMI','','','','sbi','',10000,'6','2025-03-26 18:30:00',NULL,'Completed',NULL),(2,3,200000,'pankaj','pkaloal7@gamil.com','98784512165','B44, Near Reva Park\r\ngurukul char rasta','EMI','','','','sbi','',1500,'3','2025-03-26 18:30:00',NULL,'Pending',NULL),(3,2,1500000,'pankaj','pkaloal7@gamil.com','98784512165','B44, Near Reva Park\r\ngurukul char rasta','EMI','','','','sbi','',20000,'3','2025-03-27 18:30:00',NULL,'Pending',NULL),(4,3,200000,'pankaj','pkaloal7@gamil.com','98784512165','VADODARA','EMI','','','','sbi','meet@sbi',50000,'3','2025-03-27 18:30:00',NULL,'Pending',NULL),(5,2,1500000,'pankaj','pkaloal7@gamil.com','98784512165','VADODARA','EMI','','','','sbi','',200000,'3','2025-03-27 18:30:00',NULL,'Pending',NULL),(6,9,200000,'pankaj','pkaloal7@gamil.com','98784512165','VADODARA','EMI','','','','sbi','',200000,'6','2025-03-28 18:30:00',NULL,'Delivered',NULL),(7,3,200000,'Mistry Ashish','mistryashish1702@gmail.com','08347362996','A-301 Coral Wood Tasrail Market Tasrail Vadodara.','EMI','','','','sbi','',10000,'3','2025-03-31 18:30:00',NULL,'Pending',NULL);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
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
