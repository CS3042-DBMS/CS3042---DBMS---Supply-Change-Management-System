DELIMITER $$
CREATE OR REPLACE PROCEDURE `add_to_cart`(`product_id` int(10),`quantity` int(10))
BEGIN
    set AUTOCOMMIT = 0;
    INSERT INTO `Cart` (`customer_id`,`product_id`,`quantity`) VALUES 
    (5,product_id,quantity);
    commit;
END$$

DELIMITER $$
CREATE OR REPLACE PROCEDURE `create_order`(`route_id` int(10),`address` varchar(1000))
BEGIN
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

-- get list of orders corresponding to his store 
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_orders`(email VARCHAR(100))
BEGIN
    
    select * from `order` join `route` using (route_id) natural left outer join `order_schedule` where store_id in (select `store_id` from store_manager where `email` = email);
    
END
//

-- check user existense and if exist return pw and type
DELIMITER // 
CREATE PROCEDURE User(  IN email VARCHAR(100))
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
   SELECT  * FROM  Product;END
$$

DELIMITER
$$
 CREATE OR REPLACE  PROCEDURE getcart()
   BEGIN 
    SELECT Cart.product_id, Product.product_name, Product.unit_price, Cart.quantity FROM Cart LEFT  JOIN Product on Product.product_id= Cart.product_id; END
$$

DELIMITER
$$
 CREATE OR REPLACE  PROCEDURE totalPrice()
   BEGIN 
     select sum(prod_price) as total_price from quant_price; END
$$

DELIMITER
$$
 CREATE OR REPLACE  PROCEDURE removeCartItem(product int(10))
   BEGIN 
   DELETE FROM Cart where Cart.product_id= product LIMIT 1; END
$$


DELIMITER
$$
 CREATE OR REPLACE  PROCEDURE getRoutes()
   BEGIN 
   SELECT  route_id,route_name FROM `Route`;END
$$

