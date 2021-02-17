create index customer_email on Customer(email);
create index dirver_email on Driver(email);
create index assistant_email on Driver_Assistant(email);

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




DELIMITER
$$
 CREATE OR REPLACE  PROCEDURE getMenu()
   BEGIN 
   SELECT  * FROM  Product;
   END
$$

DELIMITER
$$
CREATE OR REPLACE  PROCEDURE getDrivertruckschedule()
  
    SELECT truck_schedule.schedule_id,truck_schedule.date,truck_schedule.departure_time,truck_schedule.route_id,route.route_name,truck_schedule.truck_id,order_schedule.order_id,`order`.delivery_address,`order`.price from truck_schedule LEFT JOIN order_schedule USING(schedule_id) LEFT JOIN `order` USING(order_id),route where route.route_id=truck_schedule.route_id and truck_schedule.date>=now();
 $$    
 DELIMITER
$$
CREATE OR REPLACE  PROCEDURE getAssistanttruckschedule()
  
    SELECT truck_schedule.schedule_id,truck_schedule.date,truck_schedule.departure_time,truck_schedule.route_id,route.route_name,truck_schedule.truck_id,order_schedule.order_id,`order`.delivery_address,`order`.price from truck_schedule LEFT JOIN order_schedule USING(schedule_id) LEFT JOIN `order` USING(order_id),route where route.route_id=truck_schedule.route_id and truck_schedule.date>=now();
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
CREATE or replace DEFINER=`root`@`localhost` PROCEDURE `viewQuarterlySalesReport`(IN `select_year` INT)
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
-- geting eligible assistants for the next job
DELIMITER $$
CREATE OR REPLACE DEFINER=`root`@`localhost` PROCEDURE `get_assistants`(`r_id` INT(10),`d_time` DATETIME, `st_id` INT(10) )
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
CREATE OR REPLACE DEFINER=`root`@`localhost` PROCEDURE `get_drivers`( `r_id` INT(10),`d_time` DATETIME , `st_id` INT(10) )
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




DELIMITER $$
CREATE OR REPLACE DEFINER=`root`@`localhost` PROCEDURE `viewSalesReport`()
    DETERMINISTIC
SELECT DISTINCT route_id, route_name,branch,SUM(price) AS amount FROM (route NATURAL JOIN store) LEFT JOIN `order` USING(route_id) GROUP BY route_id$$
DELIMITER ;

DELIMITER $$
CREATE OR REPLACE DEFINER=`root`@`localhost` PROCEDURE `viewSalesReportCity`()
    DETERMINISTIC
SELECT DISTINCT branch,SUM(price) AS amount FROM (route NATURAL JOIN store) LEFT JOIN `order` USING(route_id) GROUP BY branch$$
DELIMITER ;

DELIMITER $$
CREATE or replace DEFINER=`root`@`localhost` PROCEDURE `User` (IN `email` VARCHAR(100))  BEGIN
        DECLARE u_type VARCHAR(10);
        DECLARE pw VARCHAR(300);
        IF EXISTS (SELECT user.email FROM user 
        WHERE user.email = email) THEN
			SELECT type INTO u_type FROM user WHERE user.email = email;
			IF ( u_type = 'S_Manager' ) THEN
				WITH general_user AS
					(SELECT * FROM user WHERE user.email = email)
                SELECT * FROM general_user NATURAL JOIN store_manager;    
			ELSEIF ( u_type = 'driver' ) THEN
				WITH general_user AS
					(SELECT *  FROM user WHERE user.email = email)
				SELECT * FROM general_user NATURAL JOIN driver;
            ELSEIF ( u_type = 'Manager' ) THEN
				WITH general_user AS
					(SELECT password,type,email FROM user WHERE user.email = email)
				SELECT * FROM general_user NATURAL JOIN manager;        
			ELSEIF ( u_type = 'assistant' ) THEN
				WITH general_user AS
					(SELECT * FROM user WHERE user.email = email)
				SELECT * FROM general_user NATURAL JOIN driver_assistant;
            ELSEIF ( u_type = 'customer' ) THEN
				WITH general_user AS
					(SELECT password,type,email FROM user WHERE user.email = email)
				SELECT * FROM general_user NATURAL JOIN customer;    
		END IF;	
		ELSE 
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'No such User in the database';
		END IF;
    END$$
DELIMITER ;
-- assign assitnt and driver to a job
DELIMITER$$
                                                                                  
CREATE OR REPLACE PROCEDURE `assign_driver_and_assistant`(`s_id` INT(10),`r_id` INT(10),`d_time` DATETIME, `date` DATETIME,`t_id` INT(10), `a_id` INT(10),`d_id` INT(10),`st_id` INT(10) )

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
DELIMITER ;