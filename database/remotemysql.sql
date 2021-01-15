CREATE TABLE `Store_Manager` (
  `store_manager_id` VARCHAR(100),
  `store_manager_name` VARCHAR(100),
  primary key(`store_manager_id`)
);

CREATE TABLE `Assistant` (
  `assistant_id` VARCHAR(100),
  `assistant_name` VARCHAR(100),
  `day_work_hours` VARCHAR(100),
  `latest_truck_schedule` VARCHAR(100)
  primary key(`assistant_id`)
);

CREATE TABLE `Store` (
  `store_id` VARCHAR(100),
  `branch` VARCHAR(100),
  `store_address` VARCHAR(100),
  `telephone_non` VARCHAR(100)
);

CREATE TABLE `Product` (
  `product_id` VARCHAR(100),
  `product_name` VARCHAR(100),
  `product_type` VARCHAR(100),
  `product_price` VARCHAR(100)
);

CREATE TABLE `Order` (
  `order_id` VARCHAR(100),
  `order_type` VARCHAR(100),
  `delivery_date` VARCHAR(100),
   `order_price` VARCHAR(100)
);

CREATE TABLE `Truck` (
  `truck_id` VARCHAR(100),
  `license_number` VARCHAR(100)
);

CREATE TABLE `Truck_Schedule` (
  `schedule_id` VARCHAR(100),
  `date` VARCHAR(100),
  `departure_time` VARCHAR(100)
);

CREATE TABLE `Railway` (
  `train_id` VARCHAR(100),
  `time_scedule` VARCHAR(100),
  `train_name` VARCHAR(100),
  `capacity` VARCHAR(100),
  `end_locations` VARCHAR(100)
);

CREATE TABLE `Manager` (
  `manager_id` VARCHAR(100),
  `manager_name` VARCHAR(100)
);

CREATE TABLE `Route` (
  `route_id` VARCHAR(100),
  `route_name` VARCHAR(100),
  `max_time` VARCHAR(100)
);

CREATE TABLE `Customer` (
  `customer_id` VARCHAR(100),
  `customer_name` VARCHAR(100),
  `cutomer_type` VARCHAR(100),
  `customer_address` VARCHAR(100),
  `city` VARCHAR(100)
);

CREATE TABLE `Driver` (
  `driver_id` VARCHAR(100),
  `driver_name` VARCHAR(100),
  `day_work_hours` VARCHAR(100),
  `latest_truck_schedule` VARCHAR(100)
);

