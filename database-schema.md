# Database Schema

## Core Domains
- Products
- Categories
- Customers
- Orders
- Order Items
- Warehouses
- Inventory
- Deliveries
- Couriers
- KPI Metrics
- Employees

## Example Logical Structure
- Product belongs to Category
- Inventory is stored by Warehouse
- Order contains multiple Order Items
- Delivery is linked to Order
- Courier is assigned to Delivery
- KPI records are linked to Employee

## Design Principles
- normalized transactional design
- regional inventory visibility
- scalable order tracking structure
- support for analytics and KPI reporting
- operational status history for fulfillment lifecycle
