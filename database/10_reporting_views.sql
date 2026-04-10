CREATE VIEW vw_daily_order_kpi
AS
SELECT
    CAST(o.order_date AS DATE) AS order_day,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_order_value,
    SUM(CASE WHEN o.order_status = 'delivered' THEN 1 ELSE 0 END) AS delivered_orders,
    SUM(CASE WHEN o.order_status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_orders
FROM customer_orders o
GROUP BY CAST(o.order_date AS DATE);
GO

CREATE VIEW vw_warehouse_fulfillment_kpi
AS
SELECT
    w.warehouse_id,
    w.warehouse_name,
    COUNT(DISTINCT d.delivery_id) AS total_delivery_orders,
    SUM(CASE WHEN d.delivery_status = 'delivered' THEN 1 ELSE 0 END) AS delivered_count,
    SUM(CASE WHEN d.delivery_status = 'failed' THEN 1 ELSE 0 END) AS failed_count
FROM warehouses w
LEFT JOIN delivery_orders d
    ON w.warehouse_id = d.warehouse_id
GROUP BY
    w.warehouse_id,
    w.warehouse_name;
GO

CREATE VIEW vw_courier_performance
AS
SELECT
    c.courier_id,
    c.courier_name,
    COUNT(DISTINCT d.delivery_id) AS assigned_deliveries,
    SUM(CASE WHEN d.delivery_status = 'delivered' THEN 1 ELSE 0 END) AS completed_deliveries,
    SUM(CASE WHEN d.delivery_status = 'failed' THEN 1 ELSE 0 END) AS failed_deliveries
FROM couriers c
LEFT JOIN delivery_orders d
    ON c.courier_id = d.courier_id
GROUP BY
    c.courier_id,
    c.courier_name;
GO
