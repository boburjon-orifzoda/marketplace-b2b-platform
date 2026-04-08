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
- Delivery Status History
- Couriers
- QR Tracking Records
- KPI Metrics
- Employees
- Client Acquisition Records

## Example Logical Structure
- Product belongs to Category
- Inventory is stored by Warehouse
- Order contains multiple Order Items
- Delivery is linked to Order
- Courier is assigned to Delivery
- KPI records are linked to Employee
- QR tracking events are linked to shipment / delivery lifecycle
- client acquisition records are linked to sales employees

## Design Principles
- normalized transactional design
- regional inventory visibility
- scalable order tracking structure
- support for analytics and KPI reporting
- operational status history for fulfillment lifecycle
- extensibility for future category growth
