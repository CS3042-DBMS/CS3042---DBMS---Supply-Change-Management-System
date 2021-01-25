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
  `cart_id` int(10) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `customer_id` int(10) NOT NULL,
  `purchased` boolean NOT NULL,
  PRIMARY KEY (`cart_id`)
--   FOREIGN KEY (`customer_id`) REFERENCES `Customer` ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Cart_Addition` (
  `cart_id` int(10) NOT NULL ,
  `product_id` int(10) NOT NULL,
  `quantity` int(10) NOT NULL CHECK (`quantity` > 0),
  PRIMARY KEY (`cart_id`, `product_id`)
--   FOREIGN KEY (`cart_id`) REFERENCES `Cart` ON DELETE CASCADE ON UPDATE CASCADE,
--   FOREIGN KEY ( `product_id`) REFERENCES `Product` ON DELETE CASCADE ON UPDATE CASCADE

)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;





CREATE TABLE `Order` (
  `order_id` int(10) NOT NULL AUTO_INCREMENT,
  `cart_id` int(10) NOT NULL,
  `route_id` int(10) NOT NULL,
  `schedule_id` int(10) NOT NULL,
  `date_and_time_of_placement` datetime NOT NULL,
  `date_delivered` datetime NOT NULL,
  `state` varchar(10) NOT NULL,
  `delivery_address` varchar(1000) NOT NULL,
  PRIMARY KEY (`order_id`)
--   FOREIGN KEY (`cart_id`) REFERENCES `Cart`,`Cart_Addition` ON DELETE CASCADE ON UPDATE CASCADE,
--   FOREIGN KEY (`route_id`) REFERENCES `Route` ON DELETE CASCADE ON UPDATE CASCADE,
--   FOREIGN KEY (`schedule_id`) REFERENCES `Truck_Schedule` ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Customer` (
  `customer_id` int(10) NOT NULL AUTO_INCREMENT,
  `customer_type` varchar(30) NOT NULL,
  `customer_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_number` int(10) NOT NULL,
  PRIMARY KEY (`customer_id`)
--   FOREIGN KEY(`email`) REFERENCES `User` ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `User` (
  `email` varchar(100) NOT NULL ,
  `password` varchar(30) NOT NULL,
  `type` varchar(10) NOT NULL,
  PRIMARY KEY (`email`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



CREATE TABLE `Manager` (
  `manager_id` int(10) NOT NULL AUTO_INCREMENT,
  `manager_name` varchar(30) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_number` int(10) NOT NULL,
  PRIMARY KEY (`manager_id`)
--   FOREIGN KEY (`email`) REFERENCES `User` ON DELETE CASCADE ON UPDATE CASCADE

)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Store_Manager` (
  `store_manager_id` int(10) NOT NULL AUTO_INCREMENT,
  `store_manager_name` varchar(30) NOT NULL,
  `store_id` int(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_number` int(10) NOT NULL,
  PRIMARY KEY (`store_manager_id`)
--   FOREIGN KEY (`email`) REFERENCES `User` ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Driver` (
  `driver_id` int(10) NOT NULL AUTO_INCREMENT,
  `store_id` int(10) NOT NULL,
  `driver_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_number` varchar(10) NOT NULL,
  PRIMARY KEY (`driver_id`)
--   FOREIGN KEY (`store_id`) REFERENCES `store` ON DELETE CASCADE ON UPDATE CASCADE,
--   FOREIGN KEY (`email`) REFERENCES `User` ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Driver_Assistant` (
  `assitant_id` int(10) NOT NULL AUTO_INCREMENT,
  `store_id` int(10) NOT NULL,
  `assistant_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_number` int(10) NOT NULL,
  PRIMARY KEY (`assitant_id`)
--   FOREIGN KEY (`store_id`) REFERENCES `store` ON DELETE CASCADE ON UPDATE CASCADE,
--    FOREIGN KEY (`email`) REFERENCES `User` ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Store` (
  `store_id` int(10) NOT NULL AUTO_INCREMENT,
  `branch` varchar(30) NOT NULL,
  `store_address` varchar(300) NOT NULL,
  `contact_number` int(10) NOT NULL,
  PRIMARY KEY (`store_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Truck_Schedule` (
  `schedule_id` int(10) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `departure_time` datetime NOT NULL,
  `truck_id` int(10) NOT NULL,
  `assistant_id` int(10) NOT NULL,
  `driver_id` int(10) NOT NULL,
  `route_id` int(10) NOT NULL,
  PRIMARY KEY (`schedule_id`)
--   FOREIGN KEY (`truck_id`) REFERENCES `Truck` ON DELETE CASCADE ON UPDATE CASCADE,
--   FOREIGN KEY (`assistant_id`) REFERENCES `Driver_Assistant` ON DELETE CASCADE ON UPDATE CASCADE ,
--   FOREIGN KEY (`driver_id`) REFERENCES `Driver` ON DELETE CASCADE ON UPDATE CASCADE,
--   FOREIGN KEY (`route_id`) REFERENCES `Route`ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Route` (
  `route_id` int(10) NOT NULL AUTO_INCREMENT,
  `store_id` int(10) NOT NULL,
  `route_name` varchar(30) NOT NULL,
  `description` varchar(2000) NOT NULL,
  PRIMARY KEY (`route_id`)
--   FOREIGN KEY (`store_id`) REFERENCES `Store` ON  UPDATE CASCADE ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Truck` (
  `truck_id` int(10) NOT NULL AUTO_INCREMENT,
  `store_id` int(10) NOT NULL,
  `licence_number` varchar(30) NOT NULL,
  PRIMARY KEY (`truck_id`)
--   FOREIGN KEY (`store_id`) REFERENCES `Store` ON DELETE CASCADE ON UPDATE CASCADE
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
--   FOREIGN KEY (`train_name`) REFERENCES `Railway` ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `Order_Assign` (
  `order_id` int(10) NOT NULL AUTO_INCREMENT,
  `train_name` varchar(30) NOT NULL,
  `time_schedule` datetime NOT NULL,
  PRIMARY KEY (`order_id`)
--   FOREIGN KEY (`train_name`,`time_schedule`) REFERENCES `Railway_schedule` ON DELETE CASCADE ON UPDATE CASCADE
  
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `Cart`
  ADD FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `Cart_Addition`
   ADD CONSTRAINT `Cart_Addition_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `Cart` (`cart_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `Cart_Addition_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

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

ALTER TABLE `Railway_schedule`
  ADD CONSTRAINT `Railway_schedule_ibfk_1` FOREIGN KEY (`train_name`) REFERENCES `Railway` (`train_name`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `Order_Assign`
  ADD CONSTRAINT `Order_Assign_schedule_ibfk_1` FOREIGN KEY (`train_name`,`time_schedule`) REFERENCES `Railway_schedule` (`train_name`,`time_schedule`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `Order`
  ADD CONSTRAINT `Order_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `Cart` (`cart_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `Order_ibfk_2` FOREIGN KEY (`cart_id`) REFERENCES `Cart_Addition` (`cart_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `Order_ibfk_3` FOREIGN KEY (`route_id`) REFERENCES `Route` (`route_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `Order_ibfk_4` FOREIGN KEY (`schedule_id`) REFERENCES `Truck_Schedule` (`schedule_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `Truck_Schedule` 
  ADD CONSTRAINT `Truck_Schedule_ibfk_1` FOREIGN KEY (`assistant_id`) REFERENCES `Driver_Assistant`(`assitant_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `Truck_Schedule_ibfk_2` FOREIGN KEY (`route_id`) REFERENCES `Route` (`route_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `Truck_Schedule_ibfk_3` FOREIGN KEY (`truck_id`) REFERENCES `Truck` (`truck_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `Truck_Schedule_ibfk_4` FOREIGN KEY (`driver_id`) REFERENCES `Driver` (`driver_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;


insert into `Product`(`product_name`,`product_type`,`description`,`unit_capacity`,`unit_price`) VALUES('promate single rule CR pages 80','stationary','available book types are single rule, double rule, square rule: no of pages 40,80,120,160:CR and exercise:promate and atlas',15,115);
insert into `Product`(`product_name`,`product_type`,`description`,`unit_capacity`,`unit_price`) VALUES('promate double rule CR pages 80','stationary','available book types are single rule, double rule, square rule: no of pages 40,80,120,160:CR and exercise:promate and atlas',15,115);
insert into `Product`(`product_name`,`product_type`,`description`,`unit_capacity`,`unit_price`) VALUES('promate square rule CR pages 80','stationary','available book types are single rule, double rule, square rule: no of pages 40,80,120,160:CR and exercise:promate and atlas',15,115);




