CREATE PROCEDURE sp_assign_courier
    @delivery_id         INT,
    @courier_id          INT,
    @changed_by          VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @old_courier_id INT;
    DECLARE @order_id INT;

    SELECT
        @old_courier_id = courier_id,
        @order_id = order_id
    FROM delivery_orders
    WHERE delivery_id = @delivery_id;

    UPDATE delivery_orders
    SET courier_id = @courier_id,
        delivery_status = 'assigned'
    WHERE delivery_id = @delivery_id;

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
        'assignment',
        CONCAT('courier_id=', ISNULL(CAST(@old_courier_id AS VARCHAR(20)), 'NULL')),
        CONCAT('courier_id=', CAST(@courier_id AS VARCHAR(20))),
        @changed_by,
        GETDATE(),
        'marketplace-db'
    );

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
        'allocated',
        @changed_by,
        GETDATE(),
        'Courier assigned to delivery'
    );
END;
