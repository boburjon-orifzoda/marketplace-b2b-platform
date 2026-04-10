CREATE PROCEDURE sp_calculate_kpi
    @start_date DATETIME,
    @end_date   DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(o.total_amount) AS total_order_value,
        SUM(CASE WHEN o.order_status = 'delivered' THEN 1 ELSE 0 END) AS delivered_orders,
        SUM(CASE WHEN o.order_status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
        SUM(CASE WHEN d.delivery_status = 'delivered' THEN 1 ELSE 0 END) AS successful_deliveries,
        SUM(CASE WHEN d.delivery_status = 'failed' THEN 1 ELSE 0 END) AS failed_deliveries,
        CAST(
            100.0 * SUM(CASE WHEN o.order_status = 'delivered' THEN 1 ELSE 0 END)
            / NULLIF(COUNT(DISTINCT o.order_id), 0)
            AS DECIMAL(10,2)
        ) AS order_delivery_rate_pct
    FROM customer_orders o
    LEFT JOIN delivery_orders d
        ON o.order_id = d.order_id
    WHERE o.order_date >= @start_date
      AND o.order_date < DATEADD(DAY, 1, @end_date);
END;
