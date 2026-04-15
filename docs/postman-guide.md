# Postman Guide

## Purpose

This guide describes how the marketplace API can be tested in Postman or similar API tools.

## Recommended Collection Groups

- Authentication
- Products
- Orders
- Inventory
- Delivery
- Suppliers
- Categories
- Reporting

## Example Requests

### Login
**POST** `/api/auth/login`

```json
{
  "username": "admin",
  "password": "demo-password"
}

## Get Products

**GET**  `/api/products/`

## Create Order

**POST**  `/api/orders/`

{
  "order_id": 1001,
  "partner_id": 2001,
  "order_number": "ORD-2026-0001",
  "delivery_city_id": 101,
  "currency_code": "USD"
}

##Add Order Item

**POST**  `/api/order-items/`

{
  "order_id": 1001,
  "product_id": 5001,
  "ordered_quantity": 20
}

##Check Inventory Availability

**POST** `/api/inventory/availability`

{
  "product_id": 5001,
  "requested_quantity": 20
}

##Get KPI Summary

**GET**   `/api/reporting/kpi`


