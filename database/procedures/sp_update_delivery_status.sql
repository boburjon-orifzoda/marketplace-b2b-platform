CREATE PROCEDURE sp_update_delivery_status
    @delivery_id         INT,
    @new_delivery_status VARCHAR(50),
    @changed_by          VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @order_id INT;
    DECLARE @old_delivery_status VARCHAR(50);
    DECLARE @new_order_status VARCHAR(50);

    SELECT
        @order_id = order_id,
        @old_delivery_status = delivery_status
    FROM delivery_orders
    WHERE delivery_id = @delivery_id;

    UPDATE delivery_orders
    SET delivery_status =
        CASE
            WHEN @new_delivery_status IN ('pending', 'assigned', 'in_transit', 'delivered', 'failed')
                THEN @new_delivery_status
            ELSE delivery_status
        END,
        dispatch_time =
            CASE
                WHEN @new_delivery_status = 'in_transit' AND dispatch_time IS NULL THEN GETDATE()
                ELSE dispatch_time
            END,
        delivered_time =
            CASE
                WHEN @new_delivery_status = 'delivered' THEN GETDATE()
                ELSE delivered_time
            END,
        created_at = created_at
    WHERE delivery_id = @delivery_id;

    SET @new_order_status =
        CASE
            WHEN @new_delivery_status = 'assigned' THEN 'allocated'
            WHEN @new_delivery_status = 'in_transit' THEN 'shipped'
            WHEN @new_delivery_status = 'delivered' THEN 'delivered'
            WHEN @new_delivery_status = 'failed' THEN 'allocated'
            ELSE NULL
        END;

    IF @new_order_status IS NOT NULL
    BEGIN
        UPDATE customer_orders
        SET order_status = @new_order_status
        WHERE order_id = @order_id;

        INSERT INTO order_status_history (
            history_id,
            order_id,
            old_status,
            new_status,
            changed_by,
            changed_at,
            comments
        )
        VALUES (
            ABS(CHECKSUM(NEWID())),
            @order_id,
            NULL,
            @new_order_status,
            @changed_by,
            GETDATE(),
            CONCAT('Delivery status changed from ', ISNULL(@old_delivery_status, 'null'), ' to ', @new_delivery_status)
        );
    END
END;
