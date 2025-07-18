--low stock view :
CREATE OR REPLACE VIEW low_stock AS SELECT
 p.product_id,p.product_name,c.category_name,p.stock_quantity FROM
 products p JOIN categories c ON p.category_id=c.category_id WHERE
 stock_quantity<5;

--vip customers view:
CREATE OR REPLACE VIEW vip_customers AS SELECT c.cust_id,c.first_name, c.last_name,
 c.email, COUNT(o.order_id) AS no_of_orders
 FROM customers c JOIN orders o ON c.cust_id = o.customer_id GROUP BY c.cust_id, c.first_name, c.last_name,
 c.email HAVING COUNT(o.order_id) > 6;

--stored procedure daily_sales:
create or replace procedure daily_sales(revenue_date date)
 language plpgsql as $$ begin  SELECT categories.category_id,
 categories.category_name, sum(order_items.quantity *
 order_items.unit_price) as totalRevenue from orders join
 order_items on order_items.order_id=orders.order_id join
 products on order_items.product_id=products.product_id join
 categories on products.category_id=categories.category_id
 where orders.order_date=revenue_date group by
 categories.category_name,categories.category_id; end;$$;

--get_daily_sales function:
CREATE OR REPLACE FUNCTION get_daily_sales(revenue_date date)
RETURNS TABLE (
    category_id int,
    category_name varchar(100),
    total_revenue numeric(15,5)
) AS $$ BEGIN RETURN QUERY
    SELECT categories.category_id, categories.category_name, SUM(order_items.quantity * order_items.unit_price) AS total_revenue
    FROM orders 
    JOIN order_items ON order_items.order_id = orders.order_id
    JOIN products ON order_items.product_id = products.product_id
    JOIN categories ON products.category_id = categories.category_id
    WHERE orders.order_date = revenue_date GROUP BY categories.category_id, categories.category_name; END; $$ LANGUAGE plpgsql;

--log_inventory trigger:
CREATE OR REPLACE FUNCTION log_inventory_trigger() RETURNS TRIGGER LANGUAGE plpgsql
 AS $$ BEGIN INSERT INTO
 log_inventory(order_id,product_id,stock_quantity_before,stock_quantity_after) VALUES
 ( NEW.order_id,NEW.product_id, (SELECT stock_quantity FROM products WHERE
 products.product_id=NEW.product_id limit 1),( (SELECT stock_quantity FROM products
 WHERE products.product_id=NEW.product_id limit 1 ) - NEW.quantity ) ); RETURN NEW; END;$$;
--creating trigger:
CREATE TRIGGER log_trigger
 AFTER INSERT ON order_items
 FOR EACH ROW
 EXECUTE FUNCTION log_inventory_trigger();
