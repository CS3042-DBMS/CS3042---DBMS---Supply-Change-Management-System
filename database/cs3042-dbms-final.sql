-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 04, 2021 at 05:24 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs3042-dbms`
--

DELIMITER $$
--
-- Procedures
--

-- get list of orders corresponding to his store 
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_orders`(email VARCHAR(100))
BEGIN
    
    select * from `order` join `route` using (route_id) natural left outer join `order_schedule` where store_id in (select `store_id` from store_manager where `email` = email);
    
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_to_cart` (`product_id` INT(10), `quantity` INT(10))  BEGIN
    set AUTOCOMMIT = 0;
    INSERT INTO `Cart` (`customer_id`,`product_id`,`quantity`) VALUES 
    (5,product_id,quantity);
    commit;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_order` (`route_id` INT(10), `address` VARCHAR(1000))  BEGIN
     DECLARE total_price numeric;
     DECLARE total_capacity int;
    set AUTOCOMMIT = 0;
    select sum(prod_price) INTO total_price from quant_price;
    select sum(prod_capacity) INTO total_capacity from quant_capacity;
    INSERT INTO `Order` (`customer_id`,`route_id`,`state`,`date_and_time_of_placement`,`delivery_address`,`price`,`capacity`) VALUES 
    (5,route_id,'new',now(),address,total_price,total_capacity);
    INSERT INTO `Order_Addition` (order_id,product_id,quantity) SELECT get_max_order_id(),Cart.product_id,Cart.quantity from `Cart`;
    DELETE  from `Cart`;
    commit;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getcart` ()  BEGIN 
    SELECT Cart.product_id, Product.product_name, Product.unit_price, Cart.quantity FROM Cart LEFT JOIN Product on Product.product_id= Cart.product_id; END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getMenu` ()  BEGIN 
   SELECT  * FROM  Product;END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getRoutes` ()  BEGIN 
   SELECT  route_id,route_name FROM `Route`;END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `removeCartItem` (`product` INT(10))  BEGIN 
   DELETE FROM Cart where Cart.product_id= product LIMIT 1; END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `totalPrice` ()  BEGIN 
     select sum(prod_price) as total_price from quant_price; END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `User` (IN `email` VARCHAR(100))  BEGIN
        IF EXISTS (SELECT user.email FROM user 
        WHERE user.email = email) THEN
			SELECT password,type FROM user WHERE user.email = email;
		ELSE 
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'No such User in the database';
		END IF;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewOrders` ()  BEGIN 
	SELECT * FROM `order`;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `create_cus` (`email` VARCHAR(100), `contact_number` VARCHAR(50), `password` VARCHAR(300), `customer_type` VARCHAR(30), `customer_name` VARCHAR(50)) RETURNS TINYINT(1) BEGIN
  IF customer_type = 'wholesaler' OR  customer_type = 'retailer' OR customer_type = 'end customer' THEN 
		INSERT INTO `User`(`email`,`password`,`type`) VALUES ( email, password ,"customer");
		INSERT INTO `Customer`(`email`,`customer_type`,`customer_name`,`contact_number`) VALUES ( `email`,`customer_type`,`customer_name`,`contact_number`);
		RETURN TRUE;
  END IF;
  RETURN FALSE;
  END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_max_order_id` () RETURNS INT(11) return
   (select max(order_id) from `Order`)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `customer_id` int(10) NOT NULL,
  `product_id` int(10) NOT NULL,
  `quantity` int(10) NOT NULL CHECK (`quantity` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(10) NOT NULL,
  `customer_type` varchar(30) NOT NULL,
  `customer_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_number` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `customer_type`, `customer_name`, `email`, `contact_number`) VALUES
(5, 'customer', 'customer1', 'c@gmail.com', 912243998),
(6, 'retailer', 'vinoja', 'vtr@gmail.com', 912223919),
(7, 'wholesaler', 'cus2', 'ka@gmail.com', 91224566),
(8, 'wholesaler', 'cus4', 'cus4@gmail.com', 912223919),
(9, 'wholesaler', 'cus5', 'cus5@gmail.com', 918854762),
(10, 'end customer', 'cus7', 'customer7@gmail.com', 918876544),
(11, 'end customer', 'name', 'customer8@gmail.com', 2147483647),
(12, 'wholesaler', 'cus9', 'cus9@gmail.com', 918877666);

-- --------------------------------------------------------

--
-- Table structure for table `driver`
--

CREATE TABLE `driver` (
  `driver_id` int(10) NOT NULL,
  `store_id` int(10) NOT NULL,
  `driver_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_number` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `driver`
--

INSERT INTO `driver` (`driver_id`, `store_id`, `driver_name`, `email`, `contact_number`) VALUES
(1, 1, 'driver1', 'd@gmail.com', '0912243998');

-- --------------------------------------------------------

--
-- Table structure for table `driver_assistant`
--

CREATE TABLE `driver_assistant` (
  `assitant_id` int(10) NOT NULL,
  `store_id` int(10) NOT NULL,
  `assistant_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_number` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `driver_assistant`
--

INSERT INTO `driver_assistant` (`assitant_id`, `store_id`, `assistant_name`, `email`, `contact_number`) VALUES
(1, 1, 'assistant1', 'a@gmail.com', 912243998);

-- --------------------------------------------------------

--
-- Table structure for table `manager`
--

CREATE TABLE `manager` (
  `manager_id` int(10) NOT NULL,
  `manager_name` varchar(30) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_number` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `manager`
--

INSERT INTO `manager` (`manager_id`, `manager_name`, `email`, `contact_number`) VALUES
(1, 'manager1', 'm@gmail.com', 912243998);

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `order_id` int(10) NOT NULL,
  `customer_id` int(10) NOT NULL,
  `route_id` int(10) NOT NULL,
  `state` varchar(10) NOT NULL,
  `date_and_time_of_placement` datetime NOT NULL,
  `delivery_address` varchar(1000) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `capacity` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`order_id`, `customer_id`, `route_id`, `state`, `date_and_time_of_placement`, `delivery_address`, `price`, `capacity`) VALUES
(1, 5, 10, 'new', '2021-02-04 21:14:24', 'No10,Elliot road,Galle', '1150.00', 150);

-- --------------------------------------------------------

--
-- Table structure for table `order_addition`
--

CREATE TABLE `order_addition` (
  `order_id` int(10) NOT NULL,
  `product_id` int(10) NOT NULL,
  `quantity` int(10) NOT NULL CHECK (`quantity` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_addition`
--

INSERT INTO `order_addition` (`order_id`, `product_id`, `quantity`) VALUES
(1, 10, 3),
(1, 11, 7);

-- --------------------------------------------------------

--
-- Table structure for table `order_assign`
--

CREATE TABLE `order_assign` (
  `order_id` int(10) NOT NULL,
  `train_name` varchar(30) NOT NULL,
  `time_schedule` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `order_schedule`
--

CREATE TABLE `order_schedule` (
  `order_id` int(10) NOT NULL,
  `schedule_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_schedule`
--

INSERT INTO `order_schedule` (`order_id`, `schedule_id`) VALUES
(20, 6);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(10) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `product_type` varchar(50) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `unit_capacity` int(100) NOT NULL CHECK (`unit_capacity` > 0),
  `unit_price` decimal(8,2) NOT NULL CHECK (`unit_price` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `product_name`, `product_type`, `description`, `unit_capacity`, `unit_price`) VALUES
(10, 'promate single rule CR 80pages', 'stationary', 'available book types are single rule, double rule, square rule: no of pages 40,80,120,160:CR and exercise:promate and atlas', 15, '115.00'),
(11, 'promate double rule CR 80pages', 'stationary', 'available book types are single rule, double rule, square rule: no of pages 40,80,120,160:CR and exercise:promate and atlas', 15, '115.00'),
(12, 'promate square rule CR 80pages', 'stationary', 'available book types are single rule, double rule, square rule: no of pages 40,80,120,160:CR and exercise:promate and atlas', 15, '115.00');

-- --------------------------------------------------------

--
-- Stand-in structure for view `quant_capacity`
-- (See below for the actual view)
--
CREATE TABLE `quant_capacity` (
`prod_capacity` bigint(66)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `quant_price`
-- (See below for the actual view)
--
CREATE TABLE `quant_price` (
`prod_price` decimal(18,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `railway`
--

CREATE TABLE `railway` (
  `train_name` varchar(30) NOT NULL,
  `max_capacity` int(5) NOT NULL CHECK (`max_capacity` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `railway`
--

INSERT INTO `railway` (`train_name`, `max_capacity`) VALUES
('ruhunu kumari', 40000);

-- --------------------------------------------------------

--
-- Table structure for table `railway_schedule`
--

CREATE TABLE `railway_schedule` (
  `train_name` varchar(30) NOT NULL,
  `time_schedule` datetime NOT NULL,
  `available_capacity` int(5) NOT NULL CHECK (`available_capacity` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `railway_schedule`
--

INSERT INTO `railway_schedule` (`train_name`, `time_schedule`, `available_capacity`) VALUES
('ruhunu kumari', '2021-07-30 06:53:17', 40000);

-- --------------------------------------------------------

--
-- Table structure for table `route`
--

CREATE TABLE `route` (
  `route_id` int(10) NOT NULL,
  `store_id` int(10) NOT NULL,
  `route_name` varchar(30) NOT NULL,
  `description` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `route`
--

INSERT INTO `route` (`route_id`, `store_id`, `route_name`, `description`) VALUES
(10, 1, 'galle-baddegama', 'All the addresses in this route should be covered');

-- --------------------------------------------------------

--
-- Table structure for table `store`
--

CREATE TABLE `store` (
  `store_id` int(10) NOT NULL,
  `branch` varchar(30) NOT NULL,
  `store_address` varchar(300) NOT NULL,
  `contact_number` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `store`
--

INSERT INTO `store` (`store_id`, `branch`, `store_address`, `contact_number`) VALUES
(1, 'branch1', 'no 90,Galle', 912243998);

-- --------------------------------------------------------

--
-- Table structure for table `store_manager`
--

CREATE TABLE `store_manager` (
  `store_manager_id` int(10) NOT NULL,
  `store_manager_name` varchar(30) NOT NULL,
  `store_id` int(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_number` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `truck`
--

CREATE TABLE `truck` (
  `truck_id` int(10) NOT NULL,
  `store_id` int(10) NOT NULL,
  `licence_number` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `truck`
--

INSERT INTO `truck` (`truck_id`, `store_id`, `licence_number`) VALUES
(1, 1, '10001');

-- --------------------------------------------------------

--
-- Table structure for table `truck_schedule`
--

CREATE TABLE `truck_schedule` (
  `schedule_id` int(10) NOT NULL,
  `date` datetime NOT NULL,
  `departure_time` datetime NOT NULL,
  `truck_id` int(10) NOT NULL,
  `assistant_id` int(10) NOT NULL,
  `driver_id` int(10) NOT NULL,
  `route_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `truck_schedule`
--

INSERT INTO `truck_schedule` (`schedule_id`, `date`, `departure_time`, `truck_id`, `assistant_id`, `driver_id`, `route_id`) VALUES
(6, '2021-07-31 06:47:22', '2021-08-01 06:47:22', 1, 1, 1, 10);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `email` varchar(100) NOT NULL,
  `password` text NOT NULL,
  `type` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`email`, `password`, `type`) VALUES
('a@gmail.com', 'password', 'assistant'),
('c@gmail.com', 'password', 'customer'),
('cus4@gmail.com', '$2b$10$/g5U2.iwlV5bMNVe/fAfduA', 'customer'),
('cus5@gmail.com', '$2b$10$Nd8wszKP7azkpLtmTaMUzeB', 'customer'),
('cus9@gmail.com', '$2b$10$h8nGJ7XKqsdl5hjnHiUKW.TvtZN8oEUrsErZgoGq1iNAhhg6PCMmm', 'customer'),
('customer7@gmail.com', '$2b$10$.Q7RS/VHosadg.2U5So6KeH', 'customer'),
('customer8@gmail.com', '$2b$10$FeuLVLJn7.5AY21QapyE8OzSA1PyczLu2c2qZz5M34ISYyTOXYJ6m', 'customer'),
('d@gmail.com', 'password', 'driver'),
('ka@gmail.com', '$2b$10$r4qwCNjeZo.sq2er1mlWSO0', 'customer'),
('m@gmail.com', 'password', 'manager'),
('vtr@gmail.com', '$2b$10$vMdBxjVaqiFMJjtAVfeOIuZ', 'customer');

-- --------------------------------------------------------

--
-- Structure for view `quant_capacity`
--
DROP TABLE IF EXISTS `quant_capacity`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `quant_capacity`  AS  select `product`.`unit_capacity` * `cart`.`quantity` AS `prod_capacity` from (`cart` left join `product` on(`cart`.`product_id` = `product`.`product_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `quant_price`
--
DROP TABLE IF EXISTS `quant_price`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `quant_price`  AS  select `product`.`unit_price` * `cart`.`quantity` AS `prod_price` from (`cart` left join `product` on(`cart`.`product_id` = `product`.`product_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`customer_id`,`product_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `Customer_ibfk_1` (`email`);

--
-- Indexes for table `driver`
--
ALTER TABLE `driver`
  ADD PRIMARY KEY (`driver_id`),
  ADD KEY `Driver_ibfk_1` (`email`),
  ADD KEY `Driver_ibfk_2` (`store_id`);

--
-- Indexes for table `driver_assistant`
--
ALTER TABLE `driver_assistant`
  ADD PRIMARY KEY (`assitant_id`),
  ADD KEY `Driver_Assistant_ibfk_1` (`email`),
  ADD KEY `Driver_Assistant_ibfk_2` (`store_id`);

--
-- Indexes for table `manager`
--
ALTER TABLE `manager`
  ADD PRIMARY KEY (`manager_id`),
  ADD KEY `Manager_ibfk_1` (`email`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `order_addition`
--
ALTER TABLE `order_addition`
  ADD PRIMARY KEY (`order_id`,`product_id`);

--
-- Indexes for table `order_assign`
--
ALTER TABLE `order_assign`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `Order_Assign_schedule_ibfk_1` (`train_name`,`time_schedule`);

--
-- Indexes for table `order_schedule`
--
ALTER TABLE `order_schedule`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `Order_Schedule__ibfk_2` (`schedule_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `railway`
--
ALTER TABLE `railway`
  ADD PRIMARY KEY (`train_name`);

--
-- Indexes for table `railway_schedule`
--
ALTER TABLE `railway_schedule`
  ADD PRIMARY KEY (`train_name`,`time_schedule`);

--
-- Indexes for table `route`
--
ALTER TABLE `route`
  ADD PRIMARY KEY (`route_id`),
  ADD KEY `Route_ibfk_1` (`store_id`);

--
-- Indexes for table `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`store_id`);

--
-- Indexes for table `store_manager`
--
ALTER TABLE `store_manager`
  ADD PRIMARY KEY (`store_manager_id`),
  ADD KEY `Store_Manager_ibfk_1` (`email`);

ALTER TABLE `store_manager` ADD FOREIGN KEY (`email`) REFERENCES `user`(`email`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `store_manager` ADD FOREIGN KEY (`store_id`) REFERENCES `store`(`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;
--
-- Indexes for table `truck`
--
ALTER TABLE `truck`
  ADD PRIMARY KEY (`truck_id`),
  ADD KEY `Truck_ibfk_1` (`store_id`);

--
-- Indexes for table `truck_schedule`
--
ALTER TABLE `truck_schedule`
  ADD PRIMARY KEY (`schedule_id`),
  ADD KEY `Truck_Schedule_ibfk_1` (`assistant_id`),
  ADD KEY `Truck_Schedule_ibfk_2` (`route_id`),
  ADD KEY `Truck_Schedule_ibfk_3` (`truck_id`),
  ADD KEY `Truck_Schedule_ibfk_4` (`driver_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `driver`
--
ALTER TABLE `driver`
  MODIFY `driver_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `driver_assistant`
--
ALTER TABLE `driver_assistant`
  MODIFY `assitant_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `manager`
--
ALTER TABLE `manager`
  MODIFY `manager_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `order_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_assign`
--
ALTER TABLE `order_assign`
  MODIFY `order_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `route`
--
ALTER TABLE `route`
  MODIFY `route_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `store`
--
ALTER TABLE `store`
  MODIFY `store_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `store_manager`
--
ALTER TABLE `store_manager`
  MODIFY `store_manager_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `truck`
--
ALTER TABLE `truck`
  MODIFY `truck_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `truck_schedule`
--
ALTER TABLE `truck_schedule`
  MODIFY `schedule_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `Customer_ibfk_1` FOREIGN KEY (`email`) REFERENCES `user` (`email`);

--
-- Constraints for table `driver`
--
ALTER TABLE `driver`
  ADD CONSTRAINT `Driver_ibfk_1` FOREIGN KEY (`email`) REFERENCES `user` (`email`),
  ADD CONSTRAINT `Driver_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`);

--
-- Constraints for table `driver_assistant`
--
ALTER TABLE `driver_assistant`
  ADD CONSTRAINT `Driver_Assistant_ibfk_1` FOREIGN KEY (`email`) REFERENCES `user` (`email`),
  ADD CONSTRAINT `Driver_Assistant_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`);

--
-- Constraints for table `manager`
--
ALTER TABLE `manager`
  ADD CONSTRAINT `Manager_ibfk_1` FOREIGN KEY (`email`) REFERENCES `user` (`email`);

--
-- Constraints for table `order_assign`
--
ALTER TABLE `order_assign`
  ADD CONSTRAINT `Order_Assign_schedule_ibfk_1` FOREIGN KEY (`train_name`,`time_schedule`) REFERENCES `railway_schedule` (`train_name`, `time_schedule`);

--
-- Constraints for table `order_schedule`
--
ALTER TABLE `order_schedule`
  ADD CONSTRAINT `Order_Schedule__ibfk_2` FOREIGN KEY (`schedule_id`) REFERENCES `truck_schedule` (`schedule_id`),
  ADD CONSTRAINT `Order_Schedule_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`);

--
-- Constraints for table `railway_schedule`
--
ALTER TABLE `railway_schedule`
  ADD CONSTRAINT `Railway_schedule_ibfk_1` FOREIGN KEY (`train_name`) REFERENCES `railway` (`train_name`);

--
-- Constraints for table `route`
--
ALTER TABLE `route`
  ADD CONSTRAINT `Route_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`);

--
-- Constraints for table `store_manager`
--
ALTER TABLE `store_manager`
  ADD CONSTRAINT `Store_Manager_ibfk_1` FOREIGN KEY (`email`) REFERENCES `user` (`email`);

--
-- Constraints for table `truck`
--
ALTER TABLE `truck`
  ADD CONSTRAINT `Truck_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`);

--
-- Constraints for table `truck_schedule`
--
ALTER TABLE `truck_schedule`
  ADD CONSTRAINT `Truck_Schedule_ibfk_1` FOREIGN KEY (`assistant_id`) REFERENCES `driver_assistant` (`assitant_id`),
  ADD CONSTRAINT `Truck_Schedule_ibfk_2` FOREIGN KEY (`route_id`) REFERENCES `route` (`route_id`),
  ADD CONSTRAINT `Truck_Schedule_ibfk_3` FOREIGN KEY (`truck_id`) REFERENCES `truck` (`truck_id`),
  ADD CONSTRAINT `Truck_Schedule_ibfk_4` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`driver_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
