CREATE PROCEDURE sp_complete_delivery
    @delivery_id          INT,
    @completed_by         VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @order_id INT;
    DECLARE @warehouse_id INT;

    SELECT
        @order_id = order_id,
        @warehouse_id = warehouse_id
    FROM delivery_orders
    WHERE delivery_id = @delivery_id;

    UPDATE delivery_orders
    SET delivery_status = 'delivered',
        delivered_time = GETDATE()
    WHERE delivery_id = @delivery_id;

    UPDATE customer_orders
    SET order_status = 'delivered'
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
        'shipped',
        'delivered',
        @completed_by,
        GETDATE(),
        'Delivery completed successfully'
    );

    INSERT INTO audit_log (
        audit_id,
        entity_name,
        entity_id,
        action_type,
        old_value,
        new_value,
        changed_by,
        changed_at,
        source_system
    )
    VALUES (
        ABS(CHECKSUM(NEWID())),
        'delivery_orders',
        @delivery_id,
        'status_change',
        'delivery_status=shipped',
        'delivery_status=delivered',
        @completed_by,
        GETDATE(),
        'marketplace-db'
    );

    INSERT INTO notification_log (
        notification_id,
        entity_name,
        entity_id,
        notification_type,
        recipient_address,
        message_body,
        delivery_status,
        created_at,
        sent_at
    )
    VALUES (
        ABS(CHECKSUM(NEWID())),
        'delivery_orders',
        @delivery_id,
        'sms',
        NULL,
        CONCAT('Delivery ', @delivery_id, ' has been completed successfully.'),
        'sent',
        GETDATE(),
        GETDATE()
    );
END;
