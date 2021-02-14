CREATE INDEX orders_index ON `order`(order_id);
SELECT *
FROM `order`;

CREATE INDEX products_index ON product(product_id);
SELECT *
FROM product;

CREATE INDEX orderPrice_index ON `order`(order_id);
SELECT order_id,route_id,price
FROM `order`;