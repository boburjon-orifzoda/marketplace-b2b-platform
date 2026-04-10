# Data Model

## Core Domains

The marketplace data model is organized into the following core domains:

- Master data
- Product catalog
- Inventory and warehouse operations
- Customer order processing
- Delivery execution
- KPI and reporting
- Audit and traceability

## Main Master Tables

- `regions`
- `cities`
- `suppliers`
- `business_partners`
- `product_categories`
- `brands`
- `products`
- `warehouses`
- `couriers`

## Main Transaction Tables

- `inventory_balance`
- `customer_orders`
- `customer_order_items`
- `delivery_orders`
- `order_status_history`
- `inventory_movements`

## Audit and Logging Tables

- `audit_log`
- `api_request_log`

## Key Relationships

### Product and Supplier
Each product is linked to:
- one supplier
- one category
- optionally one brand

### Inventory
Inventory is maintained by:
- warehouse
- product

This allows regional stock visibility and fulfillment allocation.

### Orders
Each customer order is linked to:
- one business partner
- one delivery city
- multiple order items

### Delivery
Each delivery record is linked to:
- one customer order
- one warehouse
- optionally one courier

## Design Goals

The data model was designed to support:

- regional warehouse allocation
- product-level inventory visibility
- delivery orchestration
- operational KPI reporting
- auditability of critical business actions
