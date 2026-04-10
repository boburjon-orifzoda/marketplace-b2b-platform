CREATE PROCEDURE sp_add_order_item
    @order_item_id       INT,
    @order_id            INT,
    @product_id          INT,
    @ordered_quantity    DECIMAL(18,2),
    @created_by          VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @unit_price DECIMAL(18,2);
    DECLARE @line_total DECIMAL(18,2);

    SELECT @unit_price = unit_price
    FROM products
    WHERE product_id = @product_id
      AND is_active = 1;

    IF @unit_price IS NULL
    BEGIN
        RAISERROR('Product not found or inactive.', 16, 1);
        RETURN;
    END

    SET @line_total = @ordered_quantity * @unit_price;

    INSERT INTO customer_order_items (
        order_item_id,
        order_id,
        product_id,
        ordered_quantity,
        unit_price,
        line_total,
        allocated_warehouse_id,
        allocated_quantity,
        created_at
    )
    VALUES (
        @order_item_id,
        @order_id,
        @product_id,
        @ordered_quantity,
        @unit_price,
        @line_total,
        NULL,
        0,
        GETDATE()
    );

    UPDATE customer_orders
    SET total_amount = ISNULL(total_amount, 0) + @line_total
    WHERE order_id = @order_id;

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
        'customer_order_items',
        @order_item_id,
        'insert',
        NULL,
        CONCAT('order_id=', @order_id, '; product_id=', @product_id, '; qty=', @ordered_quantity, '; line_total=', @line_total),
        @created_by,
        GETDATE(),
        'marketplace-db'
    );
END;
