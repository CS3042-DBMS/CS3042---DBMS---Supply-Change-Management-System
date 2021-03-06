-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 14, 2021 at 05:43 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.2




SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";






/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs3042-dbms`
--
-- --------------------------------------------------------
CREATE TABLE `railway` (
  `train_name` varchar(30) NOT NULL,
  `max_capacity` int(5) NOT NULL CHECK (`max_capacity` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



CREATE TABLE `railway_schedule` (
  `train_name` varchar(30) NOT NULL,
  `time_schedule` datetime NOT NULL,
  `available_capacity` int(5) NOT NULL CHECK (`available_capacity` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;




CREATE TABLE `Product` (
  `product_id` int(10) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(50) NOT NULL unique,
  `product_type` varchar(50) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `unit_capacity` int(100) NOT NULL CHECK (`unit_capacity` > 0),
  `unit_price` numeric(8,2) NOT NULL CHECK (`unit_price` > 0),
  PRIMARY KEY (`product_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Cart` (
  `customer_id` int(10) NOT NULL ,
  `product_id` int(10) NOT NULL,
  `quantity` int(10) NOT NULL CHECK (`quantity` > 0),
  PRIMARY KEY (`customer_id`, `product_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `Order` (
  `order_id` int(10) NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) NOT NULL,
  `route_id` int(10) NOT NULL,
  `state` varchar(30) NOT NULL,
  `date_and_time_of_placement` datetime NOT NULL,
  `delivery_address` varchar(1000) NOT NULL,
  `price` numeric(8,2)  NOT NULL,
  `capacity` int(100) not null,
  PRIMARY KEY (`order_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Order_Addition` (
  `order_id` int(10) NOT NULL ,
  `product_id` int(10) NOT NULL,
  `quantity` int(10) NOT NULL CHECK (`quantity` > 0),
  PRIMARY KEY (`order_id`, `product_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Order_Schedule` (
   `order_id` int(10) NOT NULL,
  `schedule_id` int(10) NOT NULL,
  PRIMARY KEY (`order_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Customer` (
  `customer_id` int(10) NOT NULL AUTO_INCREMENT,
  `customer_type` varchar(30) NOT NULL,
  `customer_name` varchar(50) NOT NULL,
  `email` varchar(300) NOT NULL,
  `contact_number` varchar(50) NOT NULL,
  PRIMARY KEY (`customer_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- newly added tables

-- driver rosters
CREATE TABLE `driver_rosters` (
  `driver_id` int(10) NOT NULL,
  `schedule_id` int(10) DEFAULT NULL,
  `worked_hours` int(10) DEFAULT 0,
  `working_hours` int(10) DEFAULT 0,
  PRIMARY KEY (`driver_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- assistant rosters
CREATE TABLE `assistant_rosters` (
  `assistant_id` int(10) NOT NULL,
  `schedule_id` int(10) DEFAULT NULL,
  `worked_hours` int(10) DEFAULT 0,
  `consecutive_schedules` int(10) DEFAULT 0,
  `working_hours` int(100) DEFAULT 0,
  PRIMARY KEY (`assistant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `User` (
  `email` varchar(100) NOT NULL ,
  `password` TEXT NOT NULL,
  `type` varchar(10) NOT NULL,
  PRIMARY KEY (`email`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



CREATE TABLE `Manager` (
  `manager_id` int(10) NOT NULL AUTO_INCREMENT,
  `manager_name` varchar(30) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_number` int(10) NOT NULL,
  PRIMARY KEY (`manager_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Store_Manager` (
  `store_manager_id` int(10) NOT NULL AUTO_INCREMENT,
  `store_manager_name` varchar(30) NOT NULL,
  `store_id` int(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_number` int(10) NOT NULL,
  PRIMARY KEY (`store_manager_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Driver` (
  `driver_id` int(10) NOT NULL AUTO_INCREMENT,
  `store_id` int(10) NOT NULL,
  `driver_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_number` varchar(10) NOT NULL,
  PRIMARY KEY (`driver_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Driver_Assistant` (
  `assistant_id` int(10) NOT NULL AUTO_INCREMENT,
  `store_id` int(10) NOT NULL,
  `assistant_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_number` int(10) NOT NULL,
  PRIMARY KEY (`assistant_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Store` (
  `store_id` int(10) NOT NULL AUTO_INCREMENT,
  `branch` varchar(30) NOT NULL,
  `store_address` varchar(300) NOT NULL,
  `contact_number` int(10) NOT NULL,
  PRIMARY KEY (`store_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- altered tables
-- truck schedule
CREATE TABLE `truck_schedule` (
  `schedule_id` int(10) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `departure_time` datetime NOT NULL,
  `truck_id` int(10) NOT NULL,
  `assistant_id` int(10) NOT NULL,
  `driver_id` int(10) NOT NULL,
  `route_id` int(10) NOT NULL,
  `store_id` int(10) NOT NULL,
  PRIMARY KEY (`schedule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1014 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `route` (
  `route_id` int(10) NOT NULL AUTO_INCREMENT,
  `store_id` int(10) NOT NULL,
  `route_name` varchar(30) NOT NULL,
  `description` varchar(2000) NOT NULL,
  `trip_time` time NOT NULL,
  PRIMARY KEY (`route_id`),
  KEY `Route_ibfk_1` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4;



CREATE TABLE `Truck` (
  `truck_id` int(10) NOT NULL AUTO_INCREMENT,
  `store_id` int(10) NOT NULL,
  `licence_number` varchar(30) NOT NULL,
  PRIMARY KEY (`truck_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



CREATE TABLE `Order_Assign` (
  `order_id` int(10) NOT NULL,
  `train_name` varchar(30) NOT NULL,
  `time_schedule` datetime NOT NULL,
  PRIMARY KEY (`order_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `quarterly_sales_report` (
  `product_id` int(10) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `total` decimal(8,2) DEFAULT NULL,
  `date_and_time_of_placement` int(1) NOT NULL,
  `unit_price` decimal(40,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


ALTER TABLE `railway`
  ADD PRIMARY KEY (`train_name`);

ALTER TABLE `railway_schedule`
  ADD PRIMARY KEY (`train_name`,`time_schedule`);



ALTER TABLE `quarterly_sales_report`
  ADD PRIMARY KEY (`product_id`,`product_name`);



ALTER TABLE `Customer`
  ADD CONSTRAINT `Customer_ibfk_1` FOREIGN KEY (`email`) REFERENCES `User` (`email`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `Manager`
  ADD CONSTRAINT `Manager_ibfk_1` FOREIGN KEY (`email`) REFERENCES `User` (`email`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `Route`
  ADD CONSTRAINT `Route_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `Store` (`store_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `Truck`
  ADD CONSTRAINT `Truck_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `Store` (`store_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `Driver`
  ADD CONSTRAINT `Driver_ibfk_1` FOREIGN KEY (`email`) REFERENCES `User` (`email`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `Driver_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `Store` (`store_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `Driver_Assistant`
  ADD CONSTRAINT `Driver_Assistant_ibfk_1` FOREIGN KEY (`email`) REFERENCES `User` (`email`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `Driver_Assistant_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `Store` (`store_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `Store_Manager`
  ADD CONSTRAINT `Store_Manager_ibfk_1` FOREIGN KEY (`email`) REFERENCES `User` (`email`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `Store_Manager_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `store`(`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE `Order`
  ADD CONSTRAINT `Order_ibfk_1` FOREIGN KEY (`route_id`) REFERENCES `Route` (`route_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `Truck_Schedule` 
  ADD CONSTRAINT `Truck_Schedule_ibfk_1` FOREIGN KEY (`assistant_id`) REFERENCES `Driver_Assistant`(`assistant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Truck_Schedule_ibfk_2` FOREIGN KEY (`route_id`) REFERENCES `Route` (`route_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Truck_Schedule_ibfk_3` FOREIGN KEY (`truck_id`) REFERENCES `Truck` (`truck_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Truck_Schedule_ibfk_4` FOREIGN KEY (`driver_id`) REFERENCES `Driver` (`driver_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Order_Schedule`
  ADD CONSTRAINT `Order_Schedule_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Order` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    ADD CONSTRAINT `Order_Schedule__ibfk_2` FOREIGN KEY (`schedule_id`) REFERENCES `Truck_Schedule` (`schedule_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `driver_rosters`
  ADD CONSTRAINT `driver_rosters_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `Driver` (`driver_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `assistant_rosters`
 ADD CONSTRAINT `assistant_rosters_ibfk_1` FOREIGN KEY (`assistant_id`) REFERENCES `Driver_Assistant` (`assistant_id`) ON DELETE CASCADE ON UPDATE CASCADE;


    
-- getting trip full fill time
SELECT TIMESTAMPADD(HOUR,HOUR(trip_time),TIMESTAMPADD(MINUTE,MINUTE(trip_time),TIMESTAMPADD(SECOND,SECOND (trip_time),departure_time))) FROM `cs3042-dbms`.truck_schedule NATURAL JOIN route;


-- event
DELIMITER
$$
CREATE or replace DEFINER=`root`@`localhost` EVENT `e_weekly` ON SCHEDULE EVERY 7 DAY STARTS '2021-02-08 00:00:00' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'Clear weekly worked hours of drivers and assitants' DO BEGIN
        UPDATE `assistant_rosters` SET `worked_hours`= 0 WHERE 1;
        UPDATE `driver_rosters` SET `worked_hours`= 0 WHERE 1;
      END
$$

DELIMITER
$$
CREATE or replace DEFINER=`root`@`localhost` EVENT `e_train` ON SCHEDULE EVERY 1 DAY STARTS '2021-02-27 10:25:58' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
UPDATE `railway_schedule` SET `time_schedule` = `time_schedule` + interval 1 day WHERE 1;
END
$$

DELIMITER $$
DROP EVENT IF EXISTS `e_train` $$
CREATE EVENT `e_train`
ON SCHEDULE EVERY 1 DAY STARTS '2021-02-27 10:25:58' ON COMPLETION NOT PRESERVE ENABLE
DO
BEGIN
UPDATE `railway_schedule` SET `time_schedule` = `time_schedule` + interval 1 day WHERE 1;
END
$$
