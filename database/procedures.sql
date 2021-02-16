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

-- get list of orders corresponding to his store 
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_orders`(email VARCHAR(100))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `assignOrders`(IN `id` INT(10), IN `train_name` VARCHAR(30), IN `time_schedule` DATETIME)
BEGIN 
INSERT INTO order_assign VALUES(id,train_name,time_schedule);
UPDATE `order` set state='Assigned' WHERE order_id=id;
UPDATE railway_schedule SET available_capacity = available_capacity - (SELECT capacity FROM `order` WHERE order_id = id);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMenu`()
BEGIN 
   SELECT  * FROM  product;END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `viewOrders`()
    DETERMINISTIC
BEGIN 
	SELECT order_id, route_id, date_and_time_of_placement, date_delivered, delivery_address, state FROM `order`;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `viewTrain`()
    DETERMINISTIC
BEGIN 
	SELECT * FROM `railway_schedule`;
END$$
DELIMITER ;
-- geting eligible assistants for the next job
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_assistants`(`r_id` INT(10),`d_time` DATETIME, `st_id` INT(10) )
BEGIN
	DECLARE round_trip_time TIME;
    SET AUTOCOMMIT = 0;
    SELECT trip_time INTO round_trip_time FROM route WHERE route_id = r_id;
    WITH departure_times_of_assistants AS
    (SELECT assistant_rosters.assistant_id,departure_time,route_id,worked_hours,consecutive_schedules,schedule_id,store_id FROM assistant_rosters LEFT OUTER JOIN truck_schedule USING(schedule_id)),
    assistant_for_next_job AS
    (SELECT assistant_id,worked_hours,consecutive_schedules,schedule_id,
    TIMESTAMPADD(HOUR,HOUR(trip_time),TIMESTAMPADD(MINUTE,MINUTE(trip_time),departure_time)) AS trip_fullfill_time,
    TIMEDIFF(d_time,TIMESTAMPADD(HOUR,HOUR(trip_time),TIMESTAMPADD(MINUTE,MINUTE(trip_time),departure_time)) )   
    AS time_to_next_trip,departure_times_of_assistants.store_id,
    worked_hours + HOUR(round_trip_time) 
	AS new_weekly_working_hrs
    FROM departure_times_of_assistants 
    LEFT OUTER JOIN route USING(route_id))
    SELECT * FROM assistant_for_next_job WHERE (schedule_id IS NULL ) OR (    time_to_next_trip > '00:00:00' 
    AND  worked_hours + HOUR(round_trip_time)  < 60
    AND consecutive_schedules < 3 AND assistant_for_next_job.store_id = st_id) OR (    time_to_next_trip > '06:00:00' 
    AND assistant_for_next_job.store_id = st_id
    AND  worked_hours + HOUR(round_trip_time)  < 60
    );
    
    commit;
END$$
DELIMITER
-- geting eligible drivers for the next job
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_drivers`( `r_id` INT(10),`d_time` DATETIME , `st_id` INT(10) )
BEGIN
	DECLARE round_trip_time TIME;
    SET AUTOCOMMIT = 0;
    SELECT trip_time INTO round_trip_time FROM route WHERE route_id = r_id;
    WITH departure_times_of_drivers AS
    (SELECT driver_rosters.driver_id,departure_time,route_id,worked_hours,schedule_id,store_id FROM driver_rosters LEFT OUTER JOIN truck_schedule USING(schedule_id))
    SELECT driver_id,worked_hours,schedule_id,route_id,
		TIMESTAMPADD(HOUR,HOUR(trip_time),TIMESTAMPADD(MINUTE,MINUTE(trip_time),departure_time)) AS trip_fullfill_time,
		TIMEDIFF(  d_time , TIMESTAMPADD(HOUR,HOUR(trip_time),TIMESTAMPADD(MINUTE,MINUTE(trip_time),departure_time)) )   
    AS time_to_next_trip,
		worked_hours + HOUR(round_trip_time)
	AS new_weekly_working_hrs
    FROM departure_times_of_drivers 
		LEFT OUTER JOIN route USING(route_id)
		WHERE  (schedule_id IS NULL) OR TIMEDIFF( d_time ,TIMESTAMPADD(HOUR,HOUR(trip_time),TIMESTAMPADD(MINUTE,MINUTE(trip_time),departure_time))  ) > '06:00:00' 
		AND departure_times_of_drivers.store_id = s_id  AND  worked_hours + HOUR(round_trip_time) < 40;
    commit;
END$$
DELIMITER

-- assign assitnt and driver to a job
DELIMITER$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `assign_driver_and_assistant`(`s_id` INT(10),`r_id` INT(10),`d_time` DATETIME, `date` DATETIME,`t_id` INT(10), `a_id` INT(10),`d_id` INT(10),`st_id` INT(10) )
BEGIN

	DECLARE id_of_new_schedule INT(10);
    DECLARE round_trip_time TIME;
    DECLARE is_consecutive TIME;
    
    SET AUTOCOMMIT = 0;
    
    INSERT INTO truck_schedule(route_id,departure_time,date,truck_id,store_id,assistant_id,driver_id)
    VALUES(r_id,d_time,date,t_id,st_id,a_id, d_id );
    
    SELECT trip_time INTO round_trip_time FROM route WHERE route_id = r_id;
    
    WITH roster_of_assistant AS
		(SELECT schedule_id,worked_hours,consecutive_schedules 
		FROM assistant_rosters 
		WHERE assistant_rosters.assistant_id = a_id ),
    
    
    schedule_details_of_assistant AS
		(SELECT * 
			FROM roster_of_assistant 
            LEFT OUTER JOIN truck_schedule 
            USING(schedule_id)
            ),
            
	get_next_trip_time AS	
		(SELECT consecutive_schedules,schedule_id,worked_hours,
		TIMESTAMPADD(HOUR,HOUR(trip_time),TIMESTAMPADD(MINUTE,MINUTE(trip_time),departure_time)) AS trip_fullfill_time,
		TIMEDIFF(d_time,TIMESTAMPADD(HOUR,HOUR(trip_time),TIMESTAMPADD(MINUTE,MINUTE(trip_time),departure_time)) )   
		AS time_to_next_trip,
		worked_hours + HOUR(round_trip_time)  
		AS new_weekly_working_hrs
		FROM schedule_details_of_assistant 
		LEFT OUTER JOIN route 
        USING(route_id))
    
    SELECT time_to_next_trip
    INTO is_consecutive 
    FROM get_next_trip_time;
    
    IF  ( is_consecutive < '06:00:00' ) THEN
    
        IF EXISTS (SELECT assistant_id FROM assistant_rosters WHERE assistant_id = a_id) THEN
        
			UPDATE `cs3042-dbms`.`assistant_rosters`
				SET
				`assistant_id` = a_id,
				`schedule_id` = s_id,
				`worked_hours` = worked_hours + HOUR(round_trip_time),
				`working_hours` = working_hours + HOUR(round_trip_time) ,
				`consecutive_schedules` = consecutive_schedules + 1
				WHERE `assistant_id` = a_id;
         ELSE
			INSERT INTO `cs3042-dbms`.`assistant_rosters`
				(`assistant_id`,
				`schedule_id`,
				`worked_hours`,
				`working_hours`
				)
				VALUES
				( a_id,
				s_id,
				HOUR(round_trip_time) ,
				HOUR(round_trip_time) 
				);

			END IF;
         IF EXISTS (SELECT driver_id FROM driver_rosters WHERE driver_id = d_id ) THEN
			UPDATE `cs3042-dbms`.`driver_rosters`
				SET
				`driver_id` = d_id,
				`schedule_id` = s_id,
				`worked_hours` = worked_hours + HOUR(round_trip_time),
				`working_hours` = working_hours  + HOUR(round_trip_time)
				WHERE `driver_id` = d_id;
		ELSE
			INSERT INTO `cs3042-dbms`.`driver_rosters`
				(`driver_id`,
				`schedule_id`,
				`worked_hours`,
				`working_hours`
				)
				VALUES
				( d_id,
				s_id,
				HOUR(round_trip_time) ,
				HOUR(round_trip_time) 
				);
        END IF;
		ELSE
        IF EXISTS (SELECT assistant_id FROM assistant_rosters WHERE assistant_id = a_id) THEN
			UPDATE `cs3042-dbms`.`assistant_rosters`
				SET
				`assistant_id` = a_id,
				`schedule_id` = s_id,
				`worked_hours` = worked_hours + HOUR(round_trip_time),
                `working_hours` = working_hours + HOUR(round_trip_time),
				`consecutive_schedules` = 0
				WHERE `assistant_id` = a_id;
       ELSE
			INSERT INTO `cs3042-dbms`.`assistant_rosters`
				(`assistant_id`,
				`schedule_id`,
				`worked_hours`,
				`working_hours`,
				`consecutive_schedules`)
				VALUES
				( a_id,
				s_id,
				HOUR(round_trip_time) ,
				HOUR(round_trip_time) ,
				0);

			END IF;         
      IF EXISTS (SELECT driver_id FROM driver_rosters WHERE driver_id = d_id ) THEN  
			UPDATE `cs3042-dbms`.`driver_rosters`
				SET
				`driver_id` = d_id,
				`schedule_id` = s_id,
				`worked_hours` = worked_hours + HOUR(round_trip_time),
				`working_hours` = working_hours  + HOUR(round_trip_time)
				WHERE `driver_id` = d_id;
                ELSE
			INSERT INTO `cs3042-dbms`.`driver_rosters`
				(`driver_id`,
				`schedule_id`,
				`worked_hours`,
                `working_hours`
				)
				VALUES
				( d_id,
				s_id,
				HOUR(round_trip_time), 
				HOUR(round_trip_time) 
				);
                
                
        END IF;
		END IF;
    

    commit;
END$$
DELIMITER