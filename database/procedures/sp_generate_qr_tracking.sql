CREATE PROCEDURE sp_generate_qr_tracking
    @delivery_id         INT,
    @generated_by        VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @qr_tracking_code VARCHAR(100);

    SET @qr_tracking_code = CONCAT('QR-', @delivery_id, '-', ABS(CHECKSUM(NEWID())));

    UPDATE delivery_orders
    SET qr_tracking_code = @qr_tracking_code
    WHERE delivery_id = @delivery_id;

    INSERT INTO qr_tracking_events (
        qr_event_id,
        delivery_id,
        qr_tracking_code,
        scan_time,
        scan_location,
        scanned_by,
        event_type
    )
    VALUES (
        ABS(CHECKSUM(NEWID())),
        @delivery_id,
        @qr_tracking_code,
        GETDATE(),
        NULL,
        @generated_by,
        'created'
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
        'update',
        NULL,
        CONCAT('qr_tracking_code=', @qr_tracking_code),
        @generated_by,
        GETDATE(),
        'marketplace-db'
    );
END;
