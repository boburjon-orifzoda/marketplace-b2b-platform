# API Specification

## Base URL

`/api`

---

## Products

### GET /api/products/
Returns marketplace product list.

Response:
```json
{
  "message": "Products endpoint works",
  "data": []
}

## Orders

### GET /api/orders/
Returns customer orders.

### POST /api/orders/
Creates a new customer order.

Example request:

```json
{
  "order_id": 1001,
  "partner_id": 2001,
  "order_number": "ORD-2026-0001",
  "delivery_city_id": 301,
  "currency_code": "USD"
}
```

Example response:

```json
{
  "message": "Order created successfully",
  "data": {
    "order_id": 1001,
    "partner_id": 2001,
    "order_number": "ORD-2026-0001",
    "delivery_city_id": 301,
    "currency_code": "USD",
    "status": "draft"
  }
}
```
