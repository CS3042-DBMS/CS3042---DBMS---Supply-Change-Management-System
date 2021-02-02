
INSERT INTO `User` (`email`, `password`, `type`) VALUES
('a@gmail.com', 'password', 'assistant'),
('c@gmail.com', 'password', 'customer'),
('d@gmail.com', 'password', 'driver'),
('m@gmail.com', 'password', 'manager');

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
( 'branch1', 'no 90,Galle', 912243998);



INSERT INTO `Driver` ( `store_id`, `driver_name`, `email`, `contact_number`) VALUES
( 1, 'driver1', 'd@gmail.com', '0912243998');

INSERT INTO `Driver_Assistant` ( `store_id`, `assistant_name`, `email`, `contact_number`) VALUES
( 1, 'assistant1', 'a@gmail.com', 912243998);

INSERT INTO `Route` (`route_id`,`store_id`, `route_name`, `description`) VALUES
( 10,1, 'galle-baddegama', 'All the addresses in this route should be covered');


INSERT INTO `Truck` ( `store_id`, `licence_number`) VALUES
( 1, '10001');

INSERT INTO `Truck_Schedule` ( `schedule_id`, `date`, `departure_time`, `truck_id`, `assistant_id`, `driver_id`, `route_id`) VALUES
(6, '2021-07-31 06:47:22', '2021-08-01 06:47:22', 1, 1, 1, 10);


INSERT INTO `Order` ( `order_id`,`customer_id`, `route_id`, `state`,`date_and_time_of_placement`, `delivery_address`) VALUES
( 20,5, 10, 'new','2021-07-27 06:47:22', 'no20,Poddala,Galle');

INSERT INTO `Order_Addition` (`order_id`, `product_id`, `quantity`) VALUES
(20, 10, 3),
(20, 11, 2);

INSERT INTO `Order_Schedule` (`order_id`, `schedule_id`) VALUES
(20,6);


INSERT INTO `Railway` (`train_name`, `max_capacity`) VALUES
('ruhunu kumari', 40000);

INSERT INTO `Railway_schedule` (`train_name`, `time_schedule`, `available_capacity`) VALUES
('ruhunu kumari', '2021-07-30 06:53:17', 40000);










