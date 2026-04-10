CREATE TABLE warehouse_kpi_daily (
    warehouse_kpi_id         INT PRIMARY KEY,
    warehouse_id             INT NOT NULL,
    kpi_date                 DATE NOT NULL,
    total_orders_allocated   INT NOT NULL DEFAULT 0,
    total_orders_shipped     INT NOT NULL DEFAULT 0,
    total_orders_delivered   INT NOT NULL DEFAULT 0,
    total_failed_deliveries  INT NOT NULL DEFAULT 0,
    fulfillment_rate_pct     DECIMAL(10,2) NULL,
    created_at               DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fk_warehouse_kpi_daily_warehouse
        FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

CREATE TABLE employee_kpi_daily (
    employee_kpi_id          INT PRIMARY KEY,
    employee_code            VARCHAR(50) NOT NULL,
    employee_name            VARCHAR(150) NOT NULL,
    employee_role            VARCHAR(100) NOT NULL, -- warehouse_operator / courier / sales / dispatcher
    region_id                INT NULL,
    warehouse_id             INT NULL,
    kpi_date                 DATE NOT NULL,
    orders_processed         INT NOT NULL DEFAULT 0,
    deliveries_completed     INT NOT NULL DEFAULT 0,
    failed_deliveries        INT NOT NULL DEFAULT 0,
    incentive_amount         DECIMAL(18,2) NOT NULL DEFAULT 0,
    created_at               DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fk_employee_kpi_daily_region
        FOREIGN KEY (region_id) REFERENCES regions(region_id),
    CONSTRAINT fk_employee_kpi_daily_warehouse
        FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);
