CREATE PROCEDURE sp_send_notification
    @entity_name          VARCHAR(100),
    @entity_id            INT,
    @notification_type    VARCHAR(50),
    @recipient_address    VARCHAR(200),
    @message_body         VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

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
        @entity_name,
        @entity_id,
        @notification_type,
        @recipient_address,
        @message_body,
        'sent',
        GETDATE(),
        GETDATE()
    );
END;
