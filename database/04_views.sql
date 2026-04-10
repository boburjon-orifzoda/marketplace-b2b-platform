CREATE VIEW vw_order_summary
AS
SELECT
    o.order_id,
    o.order_number,
    o.order_date,
    o.order_status,
    o.payment_status,
    o.total_amount,
    o.currency_code,
    bp.partner_name,
    c.city_name AS delivery_city,
    o.created_by,
    o.created_at
FROM customer_orders o
INNER JOIN business_partners bp
    ON o.partner_id = bp.partner_id
INNER JOIN cities c
    ON o.delivery_city_id = c.city_id;
GO

CREATE VIEW vw_inventory_availability
AS
SELECT
    ib.inventory_balance_id,
    w.warehouse_name,
    p.product_name,
    p.sku_code,
    ib.quantity_on_hand,
    ib.quantity_reserved,
    (ib.quantity_on_hand - ib.quantity_reserved) AS quantity_available,
    ib.last_updated_at
FROM inventory_balance ib
INNER JOIN warehouses w
    ON ib.warehouse_id = w.warehouse_id
INNER JOIN products p
    ON ib.product_id = p.product_id;
GO

CREATE VIEW vw_delivery_tracking
AS
SELECT
    d.delivery_id,
    o.order_number,
    w.warehouse_name,
    c.courier_name,
    d.delivery_status,
    d.qr_tracking_code,
    d.gps_tracking_url,
    d.dispatch_time,
    d.delivered_time,
    d.created_at
FROM delivery_orders d
INNER JOIN customer_orders o
    ON d.order_id = o.order_id
INNER JOIN warehouses w
    ON d.warehouse_id = w.warehouse_id
LEFT JOIN couriers c
    ON d.courier_id = c.courier_id;
GO

CREATE VIEW vw_partner_sales
AS
SELECT
    bp.partner_id,
    bp.partner_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_sales_value
FROM business_partners bp
LEFT JOIN customer_orders o
    ON bp.partner_id = o.partner_id
GROUP BY
    bp.partner_id,
    bp.partner_name;
GO
