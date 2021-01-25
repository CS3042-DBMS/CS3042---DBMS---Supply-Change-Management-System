create function get_max_cart_id()
 returns integer
  return
   (select max(cart_id) from Cart);