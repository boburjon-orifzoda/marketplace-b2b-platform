CREATE INDEX ix_products_category_id
ON products(category_id);

CREATE INDEX ix_products_supplier_id
ON products(supplier_id);

CREATE INDEX ix_inventory_balance_product_warehouse
ON inventory_balance(product_id, warehouse_id);

CREATE INDEX ix_customer_orders_partner_id
ON customer_orders(partner_id);

CREATE INDEX ix_customer_orders_status
ON customer_orders(order_status);

CREATE INDEX ix_customer_order_items_order_id
ON customer_order_items(order_id);

CREATE INDEX ix_delivery_orders_order_id
ON delivery_orders(order_id);

CREATE INDEX ix_delivery_orders_status
ON delivery_orders(delivery_status);

CREATE INDEX ix_inventory_movements_product_time
ON inventory_movements(product_id, movement_time);
