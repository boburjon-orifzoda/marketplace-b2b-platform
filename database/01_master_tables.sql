CREATE TABLE regions (
    region_id            INT PRIMARY KEY,
    region_name          VARCHAR(100) NOT NULL,
    country_name         VARCHAR(100) NOT NULL,
    is_active            BIT NOT NULL DEFAULT 1,
    created_at           DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE cities (
    city_id              INT PRIMARY KEY,
    region_id            INT NOT NULL,
    city_name            VARCHAR(100) NOT NULL,
    is_active            BIT NOT NULL DEFAULT 1,
    created_at           DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fk_cities_region
        FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE suppliers (
    supplier_id          INT PRIMARY KEY,
    supplier_name        VARCHAR(200) NOT NULL,
    tax_identifier       VARCHAR(50) NULL,
    phone_number         VARCHAR(50) NULL,
    email_address        VARCHAR(150) NULL,
    city_id              INT NULL,
    is_active            BIT NOT NULL DEFAULT 1,
    created_at           DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fk_suppliers_city
        FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

CREATE TABLE business_partners (
    partner_id           INT PRIMARY KEY,
    partner_name         VARCHAR(200) NOT NULL,
    partner_type         VARCHAR(50) NOT NULL, -- distributor / reseller / contractor / corporate
    tax_identifier       VARCHAR(50) NULL,
    phone_number         VARCHAR(50) NULL,
    email_address        VARCHAR(150) NULL,
    city_id              INT NULL,
    is_active            BIT NOT NULL DEFAULT 1,
    created_at           DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fk_business_partners_city
        FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

CREATE TABLE product_categories (
    category_id          INT PRIMARY KEY,
    parent_category_id   INT NULL,
    category_name        VARCHAR(150) NOT NULL,
    category_code        VARCHAR(50) NOT NULL,
    is_active            BIT NOT NULL DEFAULT 1,
    created_at           DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fk_product_categories_parent
        FOREIGN KEY (parent_category_id) REFERENCES product_categories(category_id)
);

CREATE TABLE brands (
    brand_id             INT PRIMARY KEY,
    brand_name           VARCHAR(150) NOT NULL,
    country_of_origin    VARCHAR(100) NULL,
    is_active            BIT NOT NULL DEFAULT 1,
    created_at           DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE products (
    product_id           INT PRIMARY KEY,
    supplier_id          INT NOT NULL,
    category_id          INT NOT NULL,
    brand_id             INT NULL,
    sku_code             VARCHAR(100) NOT NULL UNIQUE,
    product_name         VARCHAR(250) NOT NULL,
    product_description  VARCHAR(1000) NULL,
    uom                  VARCHAR(20) NOT NULL, -- pcs, box, meter, set
    unit_price           DECIMAL(18,2) NOT NULL,
    currency_code        VARCHAR(10) NOT NULL DEFAULT 'USD',
    weight_kg            DECIMAL(18,3) NULL,
    is_active            BIT NOT NULL DEFAULT 1,
    created_at           DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fk_products_supplier
        FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id) REFERENCES product_categories(category_id),
    CONSTRAINT fk_products_brand
        FOREIGN KEY (brand_id) REFERENCES brands(brand_id)
);

CREATE TABLE warehouses (
    warehouse_id         INT PRIMARY KEY,
    warehouse_name       VARCHAR(150) NOT NULL,
    region_id            INT NOT NULL,
    city_id              INT NOT NULL,
    warehouse_type       VARCHAR(50) NOT NULL, -- central / regional / fulfillment
    address_line         VARCHAR(250) NULL,
    is_active            BIT NOT NULL DEFAULT 1,
    created_at           DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fk_warehouses_region
        FOREIGN KEY (region_id) REFERENCES regions(region_id),
    CONSTRAINT fk_warehouses_city
        FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

CREATE TABLE couriers (
    courier_id           INT PRIMARY KEY,
    courier_name         VARCHAR(150) NOT NULL,
    phone_number         VARCHAR(50) NULL,
    vehicle_type         VARCHAR(50) NULL,
    region_id            INT NULL,
    is_active            BIT NOT NULL DEFAULT 1,
    created_at           DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fk_couriers_region
        FOREIGN KEY (region_id) REFERENCES regions(region_id)
);
