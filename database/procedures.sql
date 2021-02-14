DELIMITER $$
CREATE OR REPLACE PROCEDURE `add_to_cart`(`email` VARCHAR (100) ,`product_id` int(10),`quantity` int(10))
BEGIN
    DECLARE id int;
    set AUTOCOMMIT = 0;
    SELECT customer_id into id from Customer where Customer.email=email;
    INSERT INTO `Cart` (`customer_id`,`product_id`,`quantity`) VALUES 
    (id,product_id,quantity);
    commit;
END$$



DELIMITER
$$
 CREATE OR REPLACE  PROCEDURE getcart()
   BEGIN 
    SELECT Cart.product_id, Product.product_name, Product.unit_price, Cart.quantity FROM Cart LEFT  JOIN Product on Product.product_id= Cart.product_id; END
$$



DELIMITER $$
CREATE OR REPLACE PROCEDURE `create_order`(`email` VARCHAR (100) ,`route_id` int(10),`address` varchar(1000))
BEGIN
    DECLARE id int;
    set AUTOCOMMIT = 0;

    SELECT customer_id into id from Customer where Customer.email=email;
    INSERT INTO `Order` (`customer_id`,`route_id`,`state`,`date_and_time_of_placement`,`delivery_address`,`price`,`capacity`) VALUES 
    (id,route_id,'Not Assigned',now(),address,quant_price(email),quant_capacity(email));
    INSERT INTO `Order_Addition` (order_id,product_id,quantity) SELECT get_max_order_id(id),Cart.product_id,Cart.quantity from `Cart`where Cart.customer_id=id;
    DELETE  from `Cart` where customer_id=id;

    commit;
END$$

-- get list of orders corresponding to his store 
DELIMITER //
CREATE OR REPLACE DEFINER=`root`@`localhost` PROCEDURE `view_orders`(email VARCHAR(100))
BEGIN
    
    select * from `order` join `route` using (route_id) natural left outer join `order_schedule` where store_id in (select `store_id` from store_manager where `email` = email);
    
END
//

-- check user existense and if exist return pw and type
DELIMITER // 
CREATE OR REPLACE PROCEDURE User(  IN email VARCHAR(100))
	BEGIN
        IF EXISTS (SELECT user.email FROM user 
        WHERE user.email = email) THEN
			SELECT password,type FROM user WHERE user.email = email;
		ELSE 
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'No such User in the database';
		END IF;
    END
//

DELIMITER
$$
 CREATE OR REPLACE  PROCEDURE getMenu()
   BEGIN 
   SELECT  * FROM  Product;
   END
$$

DELIMITER
$$

 CREATE OR REPLACE  PROCEDURE gettruckschedule()
   BEGIN 
   SELECT  * FROM  truck_schedule;END
 $$                                                   

 DELIMITER
$$                                                   
 CREATE OR REPLACE  PROCEDURE getcart(email VARCHAR (100))
   BEGIN 
    SELECT Cart.product_id, Product.product_name, Product.unit_price, Cart.quantity FROM Cart LEFT  JOIN Product on Product.product_id= Cart.product_id where Cart.customer_id in (select customer_id from Customer where Customer.email=email); END

$$





DELIMITER
$$
 CREATE OR REPLACE  PROCEDURE totalPrice(email VARCHAR (100))
   BEGIN 
    select sum(Product.unit_price*Cart.quantity) as total_price from Cart left join Product on Cart.product_id=Product.product_id where Cart.customer_id in (select customer_id from Customer where Customer.email=email); END
$$

DELIMITER
$$
 CREATE OR REPLACE  PROCEDURE removeCartItem(email VARCHAR (100),product int(10))
   BEGIN 
   DELETE FROM Cart where Cart.customer_id in (select customer_id from Customer where Customer.email=email) and Cart.product_id= product LIMIT 1; END
$$




DELIMITER
$$
 CREATE OR REPLACE  PROCEDURE getRoutes()
   BEGIN 
   SELECT  route_id,route_name FROM `Route`;END
$$

DELIMITER
$$
 CREATE OR REPLACE  PROCEDURE getcustomer_order_report()
   BEGIN 
   SELECT  Order.state,Order.order_id,Order.customer_id,substring(Order.date_and_time_of_placement,1,10) as date_of_placement,Order.route_id,Order.price,order.capacity,Order_Addition.product_id,Order_Addition.quantity FROM `Order`,`Order_Addition` where Order.order_id=Order_Addition.order_id ORDER BY Order.state;END
$$


DELIMITER
$$
 CREATE OR REPLACE  PROCEDURE items_with_most_orders()
   BEGIN 
   SELECT Product.product_name,Order_Addition.product_id,count(Order_Addition.product_id) as number_of_orders from Product,Order_Addition WHERE Product.product_id=Order_Addition.product_id group by Order_Addition.product_id ORDER by number_of_orders desc limit 10;END
$$

DELIMITER $$
CREATE OR REPLACE  DEFINER=`root`@`localhost` PROCEDURE `assignOrders`(IN `id` INT(10), IN `train_name` VARCHAR(30), IN `time_schedule` DATETIME)
BEGIN 
INSERT INTO order_assign VALUES(id,train_name,time_schedule);
UPDATE `order` set state='Assigned to Train' WHERE order_id=id;
UPDATE railway_schedule SET available_capacity = available_capacity - (SELECT capacity FROM `order` WHERE order_id = id) WHERE `railway_schedule`.`train_name` = train_name AND `railway_schedule`.`time_schedule` = time_schedule;
END$$
DELIMITER ;


DELIMITER $$
CREATE OR REPLACE  DEFINER=`root`@`localhost` PROCEDURE `viewOrdersList`()
    DETERMINISTIC
BEGIN 
	SELECT order_id, route_id, date_and_time_of_placement, delivery_address, state FROM `order`;
END$$
DELIMITER ;

DELIMITER $$
CREATE OR REPLACE  DEFINER=`root`@`localhost` PROCEDURE `viewTrain`()
    DETERMINISTIC
BEGIN 
	SELECT * FROM `railway_schedule`;
END$$
DELIMITER ;

DELIMITER
$$
 CREATE OR REPLACE  PROCEDURE get_confirmed_orders(email VARCHAR (100))
   BEGIN 
   select `Order`.order_id, substring(Order.date_and_time_of_placement,1,10) as date_of_placement,substring(Order.date_and_time_of_placement,12,8) as time_of_placement, Order.route_id,Order.price,Product.product_name,Order_Addition.quantity FROM `Order` left join Order_Addition using(order_id) left join Product using(product_id) where Order.customer_id in (select Customer.customer_id from Customer where Customer.email=email) ORDER BY date_of_placement desc,time_of_placement desc;
END $$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `viewQuarterlySalesReport`(IN `select_year` INT)
    DETERMINISTIC
BEGIN

DELETE FROM quarterly_sales_report;

REPLACE INTO quarterly_sales_report (select `product`.`product_id` AS `product_id`,`product`.`product_name` AS `product_name`, (`order_addition`.`quantity`*`product`.`unit_price`) AS `total`,QUARTER(`order`.`date_and_time_of_placement`) AS `date_and_time_of_placement`,`product`.`unit_price` AS `unit_price` from ((`product` natural join `order_addition`) natural join `order`) WHERE YEAR(`date_and_time_of_placement`) = select_year);

CREATE OR REPLACE VIEW `quarter_sales` AS (select `quarterly_sales_report`.`product_id` AS `product_id`, `quarterly_sales_report`.`product_name` AS `product_name`,sum(`quarterly_sales_report`.`total`) AS `sales`,`quarterly_sales_report`.`date_and_time_of_placement` AS `quarter` from `quarterly_sales_report` group by `quarterly_sales_report`.`product_id`,`quarterly_sales_report`.`date_and_time_of_placement`);

CREATE OR REPLACE VIEW quarter1 AS SELECT * FROM quarter_sales WHERE quarter = 1;
CREATE OR REPLACE VIEW quarter2 AS SELECT * FROM quarter_sales WHERE quarter = 2;
CREATE OR REPLACE VIEW quarter3 AS SELECT * FROM quarter_sales WHERE quarter = 3;
CREATE OR REPLACE VIEW quarter4 AS SELECT * FROM quarter_sales WHERE quarter = 4;

SELECT DISTINCT quarter_sales.product_id,quarter_sales.product_name,IFNULL(quarter1.sales,0) AS quarter1 ,IFNULL(quarter2.sales,0) AS quarter2, IFNULL(quarter3.sales,0) AS quarter3, IFNULL(quarter4.sales,0) AS quarter4 FROM quarter_sales LEFT JOIN quarter1 USING (product_id) LEFT JOIN quarter2 USING (product_id) LEFT JOIN quarter3 USING (product_id) LEFT JOIN quarter4 USING (product_id);
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `viewSalesReport`()
    DETERMINISTIC
SELECT DISTINCT route_id, route_name,branch,SUM(price) AS amount FROM (route NATURAL JOIN store) LEFT JOIN `order` USING(route_id) GROUP BY route_id$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `viewSalesReportCity`()
    DETERMINISTIC
SELECT DISTINCT branch,SUM(price) AS amount FROM (route NATURAL JOIN store) LEFT JOIN `order` USING(route_id) GROUP BY branch$$
DELIMITER ;

