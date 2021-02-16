INSERT INTO `User` (`email`, `password`, `type`) VALUES
('a@gmail.com', '$2b$10$ERbzmFnd8bq9VzfnNWoBAOsVjcasKv/DjbLsnpeJZW6OxxsbRfjgS', 'assistant'),
('c@gmail.com', '$2b$10$ERbzmFnd8bq9VzfnNWoBAOsVjcasKv/DjbLsnpeJZW6OxxsbRfjgS', 'customer'),
('d@gmail.com', '$2b$10$ERbzmFnd8bq9VzfnNWoBAOsVjcasKv/DjbLsnpeJZW6OxxsbRfjgS', 'driver'),
('m@gmail.com', '$2b$10$ERbzmFnd8bq9VzfnNWoBAOsVjcasKv/DjbLsnpeJZW6OxxsbRfjgS', 'Manager'),
('s@gmail.com', '$2b$10$ERbzmFnd8bq9VzfnNWoBAOsVjcasKv/DjbLsnpeJZW6OxxsbRfjgS', 'S_Manager');

INSERT INTO `Product` (`product_id`,`product_name`, `product_type`, `description`, `unit_capacity`, `unit_price`) VALUES
(10, 'promate single rule CR 80pages', 'stationary', 'available book types are single rule, double rule, square rule: no of pages 40,80,120,160:CR and exercise:promate and atlas', 15, '115.00'),
(11,'promate double rule CR 80pages', 'stationary', 'available book types are single rule, double rule, square rule: no of pages 40,80,120,160:CR and exercise:promate and atlas', 15, '115.00'),
(12,'promate square rule CR 80pages', 'stationary', 'available book types are single rule, double rule, square rule: no of pages 40,80,120,160:CR and exercise:promate and atlas', 15, '115.00');




INSERT INTO `Customer` (`customer_id`, `customer_type`, `customer_name`, `email`, `contact_number`) VALUES
(5, 'customer', 'customer1', 'c@gmail.com', 912243998);

INSERT INTO `Cart` (`customer_id`, `product_id`, `quantity`) VALUES
(5,10,3 ),
(5,11,2);

INSERT INTO `Manager` (`manager_name`, `email`, `contact_number`) VALUES
('manager1', 'm@gmail.com', 912243998);

INSERT INTO `Store` (`branch`, `store_address`, `contact_number`) VALUES
( 'Galle', 'no 90,Galle', 912243998);



INSERT INTO `Driver` ( `store_id`, `driver_name`, `email`, `contact_number`) VALUES
( 1, 'driver1', 'd@gmail.com', '0912243998');

INSERT INTO `Driver_Assistant` ( `store_id`, `assistant_name`, `email`, `contact_number`) VALUES
( 1, 'assistant1', 'a@gmail.com', 912243998);

INSERT INTO `Route` (`route_id`,`store_id`, `route_name`, `description`,`trip_time`) VALUES
( 10,1, 'galle-baddegama', 'All the addresses in this route should be covered','02:00:00');


INSERT INTO `Truck` ( `store_id`, `licence_number`) VALUES
( 1, '10001');

INSERT INTO `Truck_Schedule` ( `schedule_id`, `date`, `departure_time`, `truck_id`, `assistant_id`, `driver_id`, `route_id`) VALUES
(6, '2021-07-29 06:47:22', '06:47:22', 1, 1, 1, 10);


INSERT INTO `Order` ( `order_id`,`customer_id`, `route_id`, `state`,`date_and_time_of_placement`, `delivery_address`,`price`,`capacity`) VALUES
( 20,5, 10, 'Not Assigned','2021-07-27 06:47:22', 'no20,Poddala,Galle',575.00,75);

INSERT INTO `Order_Addition` (`order_id`, `product_id`, `quantity`) VALUES
(20, 10, 3),
(20, 11, 2);

INSERT INTO `Order_Schedule` (`order_id`, `schedule_id`) VALUES
(20,6);


INSERT INTO `Railway` (`train_name`, `max_capacity`) VALUES
('ruhunu kumari', 40000);

INSERT INTO `Railway_schedule` (`train_name`, `time_schedule`, `available_capacity`) VALUES
('ruhunu kumari', '2021-07-30 06:53:17', 40000);










