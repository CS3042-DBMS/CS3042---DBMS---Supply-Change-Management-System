DELIMITER $$
CREATE OR REPLACE PROCEDURE `add_to_cart`()
BEGIN
    set AUTOCOMMIT = 0;
    INSERT INTO `Cart` (`date_created`,`customer_id`,`purchased`) VALUES 
    (now(),1,false);
    commit;
END$$


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

DELIMITER $$
CREATE OR REPLACE PROCEDURE `add_to_cartAddition` (
 `product_id` int(10),
  `quantity` int(10)
  )
BEGIN
    set AUTOCOMMIT = 0;
    INSERT INTO `Cart_Addition` (`cart_id`,`product_id`,`quantity`) VALUES 
    (get_max_cart_id(),product_id,quantity);
    commit;
END$$



DELIMITER
$$
 CREATE OR REPLACE  PROCEDURE getMenu()
   BEGIN 
   SELECT  * FROM  Product;END
$$
