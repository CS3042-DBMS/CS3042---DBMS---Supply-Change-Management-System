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

DELIMITER $$
CREATE OR REPLACE PROCEDURE `create_order`(`email` VARCHAR (100) ,`route_id` int(10),`address` varchar(1000))
BEGIN
    DECLARE id int;
    set AUTOCOMMIT = 0;
    SELECT customer_id into id from Customer where Customer.email=email;
    INSERT INTO `Order` (`customer_id`,`route_id`,`state`,`date_and_time_of_placement`,`delivery_address`,`price`,`capacity`) VALUES 
    (id,route_id,'new',now(),address,quant_price(email),quant_capacity(email));
    INSERT INTO `Order_Addition` (order_id,product_id,quantity) SELECT get_max_order_id(id),Cart.product_id,Cart.quantity from `Cart`where Cart.customer_id=id;
    DELETE  from `Cart` where customer_id=id;
    commit;
END$$


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
   SELECT  * FROM  Product;END
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