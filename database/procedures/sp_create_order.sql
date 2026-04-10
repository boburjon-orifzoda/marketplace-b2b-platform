CREATE PROCEDURE sp_create_order
    @order_id            INT,
    @partner_id          INT,
    @order_number        VARCHAR(50),
    @delivery_city_id    INT,
    @currency_code       VARCHAR(10),
    @created_by          VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO customer_orders (
        order_id,
        partner_id,
        order_number,
        order_date,
        order_status,
        payment_status,
        delivery_city_id,
        total_amount,
        currency_code,
        created_by,
        created_at
    )
    VALUES (
        @order_id,
        @partner_id,
        @order_number,
        GETDATE(),
        'draft',
        'pending',
        @delivery_city_id,
        0,
        @currency_code,
        @created_by,
        GETDATE()
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
        'draft',
        @created_by,
        GETDATE(),
        'Order created'
    );
END;
