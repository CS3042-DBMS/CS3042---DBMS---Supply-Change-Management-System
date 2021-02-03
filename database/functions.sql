create function get_max_order_id()
 returns integer
  return
   (select max(order_id) from Order);

