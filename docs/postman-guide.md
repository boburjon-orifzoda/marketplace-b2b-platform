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
