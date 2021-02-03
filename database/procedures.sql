DELIMITER $$
CREATE OR REPLACE PROCEDURE `add_to_cart`(`product_id` int(10),`quantity` int(10))
BEGIN
    set AUTOCOMMIT = 0;
    INSERT INTO `Cart` (`customer_id`,`product_id`,`quantity`) VALUES 
    (5,product_id,quantity);
    commit;
END$$


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

