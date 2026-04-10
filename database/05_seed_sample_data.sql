INSERT INTO regions (region_id, region_name, country_name, is_active, created_at)
VALUES
(1, 'Tashkent Region', 'Uzbekistan', 1, GETDATE()),
(2, 'Samarkand Region', 'Uzbekistan', 1, GETDATE());

INSERT INTO cities (city_id, region_id, city_name, is_active, created_at)
VALUES
(101, 1, 'Tashkent', 1, GETDATE()),
(102, 2, 'Samarkand', 1, GETDATE());

INSERT INTO suppliers (supplier_id, supplier_name, tax_identifier, phone_number, email_address, city_id, is_active, created_at)
VALUES
(1001, 'Aqua Industrial Supply', 'SUP-1001', '+998901112233', 'supply@aqua.uz', 101, 1, GETDATE()),
(1002, 'PipeFlow Distribution', 'SUP-1002', '+998901112244', 'sales@pipeflow.uz', 102, 1, GETDATE());

INSERT INTO business_partners (partner_id, partner_name, partner_type, tax_identifier, phone_number, email_address, city_id, is_active, created_at)
VALUES
(2001, 'Orient Trade Solutions', 'distributor', 'BP-2001', '+998907770011', 'procurement@orient.uz', 101, 1, GETDATE()),
(2002, 'Samarkand Build Group', 'contractor', 'BP-2002', '+998907770022', 'orders@sbg.uz', 102, 1, GETDATE());

INSERT INTO product_categories (category_id, parent_category_id, category_name, category_code, is_active, created_at)
VALUES
(3001, NULL, 'Plumbing', 'PLUMB', 1, GETDATE()),
(3002, 3001, 'Pipes', 'PIPES', 1, GETDATE()),
(3003, 3001, 'Valves', 'VALVES', 1, GETDATE());

INSERT INTO brands (brand_id, brand_name, country_of_origin, is_active, created_at)
VALUES
(4001, 'AquaPro', 'Turkey', 1, GETDATE()),
(4002, 'FlowTech', 'Germany', 1, GETDATE());

INSERT INTO products (
    product_id, supplier_id, category_id, brand_id, sku_code, product_name,
    product_description, uom, unit_price, currency_code, weight_kg, is_active, created_at
)
VALUES
(5001, 1001, 3002, 4001, 'SKU-P-001', 'PVC Pipe 20mm', 'Industrial grade PVC pipe 20mm', 'pcs', 4.50, 'USD', 0.750, 1, GETDATE()),
(5002, 1001, 3003, 4002, 'SKU-V-001', 'Pressure Valve X1', 'Pressure control valve for water systems', 'pcs', 15.75, 'USD', 0.420, 1, GETDATE());

INSERT INTO warehouses (
    warehouse_id, warehouse_name, region_id, city_id, warehouse_type, address_line, is_active, created_at
)
VALUES
(6001, 'Tashkent Central Warehouse', 1, 101, 'central', 'Industrial Zone A, Tashkent', 1, GETDATE()),
(6002, 'Samarkand Fulfillment Hub', 2, 102, 'fulfillment', 'Warehouse District 3, Samarkand', 1, GETDATE());

INSERT INTO couriers (
    courier_id, courier_name, phone_number, vehicle_type, region_id, is_active, created_at
)
VALUES
(7001, 'Courier One', '+998909991111', 'van', 1, 1, GETDATE()),
(7002, 'Courier Two', '+998909992222', 'truck', 2, 1, GETDATE());

INSERT INTO inventory_balance (
    inventory_balance_id, warehouse_id, product_id, quantity_on_hand, quantity_reserved, last_updated_at
)
VALUES
(8001, 6001, 5001, 1000, 50, GETDATE()),
(8002, 6001, 5002, 500, 20, GETDATE()),
(8003, 6002, 5001, 350, 10, GETDATE());
