CREATE TABLE inventory_balance (
    inventory_balance_id INT PRIMARY KEY,
    warehouse_id         INT NOT NULL,
    product_id           INT NOT NULL,
    quantity_on_hand     DECIMAL(18,2) NOT NULL DEFAULT 0,
    quantity_reserved    DECIMAL(18,2) NOT NULL DEFAULT 0,
    quantity_available   AS (quantity_on_hand - quantity_reserved),
    last_updated_at      DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fk_inventory_balance_warehouse
        FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id),
    CONSTRAINT fk_inventory_balance_product
        FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE customer_orders (
    order_id             INT PRIMARY KEY,
    partner_id           INT NOT NULL,
    order_number         VARCHAR(50) NOT NULL UNIQUE,
    order_date           DATETIME NOT NULL DEFAULT GETDATE(),
    order_status         VARCHAR(50) NOT NULL, -- draft / confirmed / allocated / shipped / delivered / cancelled
    payment_status       VARCHAR(50) NOT NULL DEFAULT 'pending',
    delivery_city_id     INT NOT NULL,
    total_amount         DECIMAL(18,2) NOT NULL DEFAULT 0,
    currency_code        VARCHAR(10) NOT NULL DEFAULT 'USD',
    created_by           VARCHAR(100) NULL,
    created_at           DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fk_customer_orders_partner
        FOREIGN KEY (partner_id) REFERENCES business_partners(partner_id),
    CONSTRAINT fk_customer_orders_city
        FOREIGN KEY (delivery_city_id) REFERENCES cities(city_id)
);

CREATE TABLE customer_order_items (
    order_item_id        INT PRIMARY KEY,
    order_id             INT NOT NULL,
    product_id           INT NOT NULL,
    ordered_quantity     DECIMAL(18,2) NOT NULL,
    unit_price           DECIMAL(18,2) NOT NULL,
    line_total           DECIMAL(18,2) NOT NULL,
    allocated_warehouse_id INT NULL,
    allocated_quantity   DECIMAL(18,2) NOT NULL DEFAULT 0,
    created_at           DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fk_customer_order_items_order
        FOREIGN KEY (order_id) REFERENCES customer_orders(order_id),
    CONSTRAINT fk_customer_order_items_product
        FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT fk_customer_order_items_warehouse
        FOREIGN KEY (allocated_warehouse_id) REFERENCES warehouses(warehouse_id)
);

CREATE TABLE delivery_orders (
    delivery_id          INT PRIMARY KEY,
    order_id             INT NOT NULL,
    warehouse_id         INT NOT NULL,
    courier_id           INT NULL,
    delivery_status      VARCHAR(50) NOT NULL, -- pending / assigned / in_transit / delivered / failed
    qr_tracking_code     VARCHAR(100) NULL,
    gps_tracking_url     VARCHAR(500) NULL,
    dispatch_time        DATETIME NULL,
    delivered_time       DATETIME NULL,
    created_at           DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fk_delivery_orders_order
        FOREIGN KEY (order_id) REFERENCES customer_orders(order_id),
    CONSTRAINT fk_delivery_orders_warehouse
        FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id),
    CONSTRAINT fk_delivery_orders_courier
        FOREIGN KEY (courier_id) REFERENCES couriers(courier_id)
);

CREATE TABLE order_status_history (
    history_id           INT PRIMARY KEY,
    order_id             INT NOT NULL,
    old_status           VARCHAR(50) NULL,
    new_status           VARCHAR(50) NOT NULL,
    changed_by           VARCHAR(100) NULL,
    changed_at           DATETIME NOT NULL DEFAULT GETDATE(),
    comments             VARCHAR(500) NULL,
    CONSTRAINT fk_order_status_history_order
        FOREIGN KEY (order_id) REFERENCES customer_orders(order_id)
);

CREATE TABLE inventory_movements (
    movement_id          INT PRIMARY KEY,
    warehouse_id         INT NOT NULL,
    product_id           INT NOT NULL,
    movement_type        VARCHAR(50) NOT NULL, -- inbound / outbound / reservation / release / adjustment
    quantity             DECIMAL(18,2) NOT NULL,
    reference_type       VARCHAR(50) NULL, -- purchase / order / manual / transfer
    reference_id         INT NULL,
    movement_time        DATETIME NOT NULL DEFAULT GETDATE(),
    created_by           VARCHAR(100) NULL,
    CONSTRAINT fk_inventory_movements_warehouse
        FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id),
    CONSTRAINT fk_inventory_movements_product
        FOREIGN KEY (product_id) REFERENCES products(product_id)
);
