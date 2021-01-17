CREATE TABLE `Cart_Addition` (
  `cart_id` int(10),
  `product_id` int(10),
  `quantity` int(10),
  PRIMARY KEY (`cart_id`, `product_id`)
);

CREATE TABLE `Cart` (
  `cart_id` int(10),
  `date_created` datetime,
  `customer_id` varchar(6),
  `purchased` boolean,
  PRIMARY KEY (`cart_id`),
  FOREIGN KEY (`customer_id`) REFERENCES `Customer`
);

CREATE TABLE `Order` (
  `order_id` int(10),
  `cart_id` int(10),
  `route_id` int(10),
  `schedule_id` int(10),
  `date_and_time_of_placement` datetime,
  `date_delivered` datetime,
  `state` varchar(10),
  `delivery_address` varchar(1000),
  PRIMARY KEY (`order_id`)
);

CREATE TABLE `Customer` (
  `customer_id` int(10),
  `customer_type` varchar(30),
  `customer_name` varchar(50),
  `email` varchar(100),
  `contact_number` int(10),
  PRIMARY KEY (`customer_id`)
  FOREIGN KEY(`email`) REFERENCES `User`
);

CREATE TABLE `User` (
  `email` varchar(100),
  `password` varchar(30),
  `type` varchar(10),
  PRIMARY KEY (`email`)
);

CREATE TABLE `Product` (
  `product_id` int(10),
  `product_name` varchar(30),
  `product_type` varchar(50),
  `description` varchar(1000),
  `unit_capacity` int(100),
  `unit_price` numeric(8,2),
  PRIMARY KEY (`product_id`)
);

CREATE TABLE `Manager` (
  `manager_id` int(10),
  `manager_name` varchar(30),
  `email` varchar(100)
  `contact_number` int(10),
  PRIMARY KEY (`manager_id`),
  FOREIGN KEY (`email`) REFERENCES `User`

);

CREATE TABLE `Store_Manager` (
  `store_manager_id` int(10),
  `store_manager_name` varchar(30),
  `store_id` int(10),
  `email` varchar(100),
  `contact_number` init(10),
  PRIMARY KEY (`store_manager_id`),
  FOREIGN KEY (`email`) REFERENCES `User`
);

CREATE TABLE `Driver` (
  `driver_id` int(10),
  `store_id` int(10),
  `driver_name` varchar(50),
  `email` varchar(100),
  `contact_number` varchar(10),
  PRIMARY KEY (`driver_id`)
  FOREIGN KEY (`store_id`) REFERENCES `store`
);

CREATE TABLE `Driver_Assistant` (
  `assitant_id` int(10),
  `store_id` int(10),
  `assistant_name` varchar(50),
  `email` varchar(100),
  `contact_number` int(10),
  PRIMARY KEY (`assitant_id`),
   FOREIGN KEY (`email`) REFERENCES `User`
);

CREATE TABLE `Store` (
  `store_id` int(10),
  `branch` varchar(30),
  `store_address` varchar(300),
  `contact_number` int(10),
  PRIMARY KEY (`store_id`)
);

CREATE TABLE `Truck_Schedule` (
  `schedule_id` int(10),
  `date` datetime,
  `departure_time` datetime,
  `truck_id` int(10),
  `assistant_id` int(10),
  `driver_id` int(10),
  `route_id` int(10),
  PRIMARY KEY (`schedule_id`)
  FOREIGN KEY (`truck_id`) REFERENCES `Truck`,
  FOREIGN KEY (`assistant_id`) REFERENCES `Driver_Assistant`,
  FOREIGN KEY (`driver_id`) REFERENCES `Driver`,
  FOREIGN KEY (`route_id`) REFERENCES `Route`
);

CREATE TABLE `Route` (
  `route_id` int(10),
  `store_id` int(10),
  `route_name` varchar(30),
  `description` varchar(2000),
  PRIMARY KEY (`route_id`),
  FOREIGN KEY (`store_id`) REFERENCES `Store`
);

CREATE TABLE `Truck` (
  `truck_id` int(10),
  `store_id` int(10),
  `licence_number` varchar(30),
  PRIMARY KEY (`truck_id`),
  FOREIGN KEY (`store_id`) REFERENCES `Store`
);

CREATE TABLE `Railway` (
  `train_id` int(10),
  `train_name` varchar(30),
  `time_schedule` datetime,
  `max_capacity` int(5),
  `available_capacity` int(5),
  PRIMARY KEY (`train_id`, `time_schedule`)
);

CREATE TABLE `Order_Assign` (
  `order_id` int(10),
  `train_id` int(10),
  `time_schedule` datetime,
  PRIMARY KEY (`order_id`)
  FOREIGN KEY (`train_id`,`time_schedule`) REFERENCES `Railway`,
  
);

