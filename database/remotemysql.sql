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










CREATE TABLE `Product` (
  `product_id` int(10) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(50) NOT NULL,
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
  `state` varchar(10) NOT NULL,
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
  `email` varchar(100) NOT NULL,
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
  PRIMARY KEY (`driver_id`),
  KEY `driver_id` (`driver_id`),
  KEY `schedule_id` (`schedule_id`),
  CONSTRAINT `driver_rosters_ibfk_2` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`driver_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- assistant rosters
CREATE TABLE `assistant_rosters` (
  `assistant_id` int(10) NOT NULL,
  `schedule_id` int(10) DEFAULT NULL,
  `worked_hours` int(10) DEFAULT 0,
  `consecutive_schedules` int(10) DEFAULT 0,
  `working_hours` int(100) DEFAULT 0,
  PRIMARY KEY (`assistant_id`),
  KEY `assistant_rosters_ibfk_2` (`schedule_id`),
  CONSTRAINT `assistant_rosters_ibfk_1` FOREIGN KEY (`assistant_id`) REFERENCES `driver_assistant` (`assitant_id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  PRIMARY KEY (`assitant_id`)
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
  PRIMARY KEY (`schedule_id`),
  KEY `Truck_Schedule_ibfk_1` (`assistant_id`),
  KEY `Truck_Schedule_ibfk_2` (`route_id`),
  KEY `Truck_Schedule_ibfk_3` (`truck_id`),
  KEY `Truck_Schedule_ibfk_4` (`driver_id`),
  CONSTRAINT `truck_schedule_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`driver_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `truck_schedule_ibfk_2` FOREIGN KEY (`route_id`) REFERENCES `route` (`route_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `truck_schedule_ibfk_3` FOREIGN KEY (`assistant_id`) REFERENCES `driver_assistant` (`assitant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `truck_schedule_ibfk_4` FOREIGN KEY (`truck_id`) REFERENCES `truck` (`truck_id`) ON DELETE CASCADE ON UPDATE CASCADE
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

CREATE TABLE `Railway` (
  `train_name` varchar(30) NOT NULL,
  `max_capacity` int(5) NOT NULL CHECK (`max_capacity` > 0),
  PRIMARY KEY (`train_name`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Railway_schedule` (
  `train_name` varchar(30) NOT NULL,
  `time_schedule` datetime NOT NULL,
  `available_capacity` int(5) NOT NULL CHECK (`available_capacity` > 0),
  PRIMARY KEY (`train_name`, `time_schedule`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `Order_Assign` (
  `order_id` int(10) NOT NULL AUTO_INCREMENT,
  `train_name` varchar(30) NOT NULL,
  `time_schedule` datetime NOT NULL,
  PRIMARY KEY (`order_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


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
  ADD CONSTRAINT `Store_Manager_ibfk_1` FOREIGN KEY (`email`) REFERENCES `User` (`email`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `store_manager` 
ADD FOREIGN KEY (`email`) REFERENCES `user`(`email`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `store_manager` 
ADD FOREIGN KEY (`store_id`) REFERENCES `store`(`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Railway_schedule`
  ADD CONSTRAINT `Railway_schedule_ibfk_1` FOREIGN KEY (`train_name`) REFERENCES `Railway` (`train_name`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `Order_Assign`
  ADD CONSTRAINT `Order_Assign_schedule_ibfk_1` FOREIGN KEY (`train_name`,`time_schedule`) REFERENCES `Railway_schedule` (`train_name`,`time_schedule`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `Order`
  ADD CONSTRAINT `Order_ibfk_1` FOREIGN KEY (`route_id`) REFERENCES `Route` (`route_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `Truck_Schedule` 
  ADD CONSTRAINT `Truck_Schedule_ibfk_1` FOREIGN KEY (`assistant_id`) REFERENCES `Driver_Assistant`(`assitant_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `Truck_Schedule_ibfk_2` FOREIGN KEY (`route_id`) REFERENCES `Route` (`route_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `Truck_Schedule_ibfk_3` FOREIGN KEY (`truck_id`) REFERENCES `Truck` (`truck_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `Truck_Schedule_ibfk_4` FOREIGN KEY (`driver_id`) REFERENCES `Driver` (`driver_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `Order_Schedule`
  ADD CONSTRAINT `Order_Schedule_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Order` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    ADD CONSTRAINT `Order_Schedule__ibfk_2` FOREIGN KEY (`schedule_id`) REFERENCES `Truck_Schedule` (`schedule_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;



CREATE DEFINER=`root`@`localhost` PROCEDURE `User`(  IN email VARCHAR(100))
BEGIN
        DECLARE u_type VARCHAR(10);
        DECLARE pw VARCHAR(300);
        IF EXISTS (SELECT user.email FROM user 
        WHERE user.email = email) THEN
			SELECT type INTO u_type FROM user WHERE user.email = email;
			IF ( u_type = 'S_Manager' ) THEN
				WITH general_user AS
					(SELECT * FROM user WHERE user.email = email)
                SELECT * FROM general_user NATURAL JOIN store_manager;    
			ELSEIF ( u_type = 'driver' ) THEN
				WITH general_user AS
					(SELECT *  FROM user WHERE user.email = email)
				SELECT * FROM general_user NATURAL JOIN driver;
            ELSEIF ( u_type = 'Manager' ) THEN
				WITH general_user AS
					(SELECT password,type,email FROM user WHERE user.email = email)
				SELECT * FROM general_user NATURAL JOIN manager;        
			ELSEIF ( u_type = 'assistant' ) THEN
				WITH general_user AS
					(SELECT * FROM user WHERE user.email = email)
				SELECT * FROM general_user NATURAL JOIN driver_assistant;
            ELSEIF ( u_type = 'customer' ) THEN
				WITH general_user AS
					(SELECT password,type,email FROM user WHERE user.email = email)
				SELECT * FROM general_user NATURAL JOIN customer;    
		END IF;	
		ELSE 
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'No such User in the database';
		END IF;
    END
    
insert into `product`(`product_name`,`product_type`,`description`,`unit_capacity`,`unit_price`) VALUES('promate single rule CR pages 80','stationary','available book types are single rule, double rule, square rule: no of pages 40,80,120,160:CR and exercise:promate and atlas',15,115);
insert into `product`(`product_name`,`product_type`,`description`,`unit_capacity`,`unit_price`) VALUES('promate double rule CR pages 80','stationary','available book types are single rule, double rule, square rule: no of pages 40,80,120,160:CR and exercise:promate and atlas',15,115);
insert into `product`(`product_name`,`product_type`,`description`,`unit_capacity`,`unit_price`) VALUES('promate square rule CR pages 80','stationary','available book types are single rule, double rule, square rule: no of pages 40,80,120,160:CR and exercise:promate and atlas',15,115);

-- getting trip full fill time
SELECT TIMESTAMPADD(HOUR,HOUR(trip_time),TIMESTAMPADD(MINUTE,MINUTE(trip_time),TIMESTAMPADD(SECOND,SECOND (trip_time),departure_time))) FROM `cs3042-dbms`.truck_schedule NATURAL JOIN route;
