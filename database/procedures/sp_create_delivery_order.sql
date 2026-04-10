CREATE PROCEDURE sp_create_delivery_order
    @delivery_id         INT,
    @order_id            INT,
    @warehouse_id        INT,
    @created_by          VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO delivery_orders (
        delivery_id,
        order_id,
        warehouse_id,
        courier_id,
        delivery_status,
        qr_tracking_code,
        gps_tracking_url,
        dispatch_time,
        delivered_time,
        created_at
    )
    VALUES (
        @delivery_id,
        @order_id,
        @warehouse_id,
        NULL,
        'pending',
        NULL,
        NULL,
        NULL,
        NULL,
        GETDATE()
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
        'insert',
        NULL,
        CONCAT('order_id=', @order_id, '; warehouse_id=', @warehouse_id, '; delivery_status=pending'),
        @created_by,
        GETDATE(),
        'marketplace-db'
    );
END;
