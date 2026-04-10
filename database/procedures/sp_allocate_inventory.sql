CREATE PROCEDURE sp_allocate_inventory
    @order_id INT,
    @changed_by VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @product_id INT;
    DECLARE @ordered_quantity DECIMAL(18,2);
    DECLARE @warehouse_id INT;
    DECLARE @available_quantity DECIMAL(18,2);
    DECLARE @order_item_id INT;

    DECLARE order_item_cursor CURSOR FOR
        SELECT order_item_id, product_id, ordered_quantity
        FROM customer_order_items
        WHERE order_id = @order_id;

    OPEN order_item_cursor;
    FETCH NEXT FROM order_item_cursor INTO @order_item_id, @product_id, @ordered_quantity;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT TOP 1
            @warehouse_id = warehouse_id,
            @available_quantity = quantity_on_hand - quantity_reserved
        FROM inventory_balance
        WHERE product_id = @product_id
          AND (quantity_on_hand - quantity_reserved) >= @ordered_quantity
        ORDER BY quantity_on_hand - quantity_reserved DESC;

        IF @warehouse_id IS NOT NULL
        BEGIN
            UPDATE customer_order_items
            SET allocated_warehouse_id = @warehouse_id,
                allocated_quantity = @ordered_quantity
            WHERE order_item_id = @order_item_id;

            UPDATE inventory_balance
            SET quantity_reserved = quantity_reserved + @ordered_quantity,
                last_updated_at = GETDATE()
            WHERE warehouse_id = @warehouse_id
              AND product_id = @product_id;

            INSERT INTO inventory_movements (
                movement_id,
                warehouse_id,
                product_id,
                movement_type,
                quantity,
                reference_type,
                reference_id,
                movement_time,
                created_by
            )
            VALUES (
                ABS(CHECKSUM(NEWID())),
                @warehouse_id,
                @product_id,
                'reservation',
                @ordered_quantity,
                'order',
                @order_id,
                GETDATE(),
                @changed_by
            );
        END

        FETCH NEXT FROM order_item_cursor INTO @order_item_id, @product_id, @ordered_quantity;
    END

    CLOSE order_item_cursor;
    DEALLOCATE order_item_cursor;

    UPDATE customer_orders
    SET order_status = 'allocated'
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
        'confirmed',
        'allocated',
        @changed_by,
        GETDATE(),
        'Inventory allocated'
    );
END;
