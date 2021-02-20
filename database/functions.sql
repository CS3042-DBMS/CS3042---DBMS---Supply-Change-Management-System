DELIMITER //
create function get_max_order_id(id int(10))
 returns integer
  return
   (select max(order_id) from `Order` where customer_id=id);
 //

DELIMITER //
CREATE FUNCTION create_cus(
	email varchar(100),
	contact_number varchar(50),
    password varchar(300),
	customer_type varchar(30),
	customer_name varchar(50)
  )
  RETURNS BOOL
  DETERMINISTIC
  BEGIN
  IF customer_type = 'wholesaler' OR  customer_type = 'retailer' OR customer_type = 'end customer' THEN 
		INSERT INTO `User`(`email`,`password`,`type`) VALUES ( email, password ,"customer");
		INSERT INTO `Customer`(`email`,`customer_type`,`customer_name`,`contact_number`) VALUES ( `email`,`customer_type`,`customer_name`,`contact_number`);
		RETURN TRUE;
  END IF;
  RETURN FALSE;
  END
//

DELIMITER //
create function quant_price(email varchar(100))
 returns integer
  return
   (select sum(Product.unit_price*Cart.quantity) as total_price from Cart left join Product on Cart.product_id=Product.product_id where Cart.customer_id in (select customer_id from Customer where Customer.email=email));
//

DELIMITER //
create function quant_capacity(email varchar(100))
 returns integer
  return
   (select sum(Product.unit_capacity*Cart.quantity) as total_price from Cart left join Product on Cart.product_id=Product.product_id where Cart.customer_id in (select customer_id from Customer where Customer.email=email));
//


