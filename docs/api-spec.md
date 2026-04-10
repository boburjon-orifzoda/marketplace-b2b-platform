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
```

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

## Inventory

### GET /api/inventory/
Returns inventory balances.

### POST /api/inventory/availability
Checks requested product availability.

Example request:

```json
{
  "product_id": 501,
  "requested_quantity": 20
}
```

Example response:

```json
{
  "product_id": 501,
  "available_qty": 250,
  "is_available": true
}
```

## Delivery

### GET /api/delivery/
Returns delivery records.

Example response:

```json
{
  "data": [
    {
      "delivery_id": 9001,
      "order_id": 1001,
      "status": "In Transit"
    }
  ]
}
```

## Partners

### GET /api/partners/
Returns registered marketplace partners.

Example response:

```json
{
  "data": [
    {
      "partner_id": 2001,
      "partner_name": "Global Electronics Ltd"
    }
  ]
}
```

## Delivery

### GET /api/delivery/
Returns delivery records.

Example response:

```json
{
  "data": [
    {
      "delivery_id": 9001,
      "order_id": 1001,
      "status": "In Transit"
    }
  ]
}
```

## Partners

### GET /api/partners/
Returns registered marketplace partners.

Example response:

```json
{
  "data": [
    {
      "partner_id": 2001,
      "partner_name": "Global Electronics Ltd"
    }
  ]
}
```

## Authentication

### POST /api/auth/login
Authenticates user and returns access token.

Example request:

```json
{
  "email": "admin@marketplace.com",
  "password": "secure_password"
}
```

Example response:

```json
{
  "access_token": "jwt_token_here",
  "expires_in": 3600
}
```
