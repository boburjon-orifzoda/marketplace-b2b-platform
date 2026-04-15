

```md
# Sequence Flows

## 1. Customer Order Creation Flow

1. Business partner submits marketplace order
2. Order is created in `customer_orders`
3. Order items are added into `customer_order_items`
4. Total amount is recalculated
5. Order status is recorded in `order_status_history`

## 2. Inventory Allocation Flow

1. Confirmed order enters allocation process
2. System checks `inventory_balance`
3. Available warehouse is selected
4. Reserved quantity is updated
5. Inventory reservation is logged in `inventory_movements`
6. Order status changes to `allocated`

## 3. Delivery Execution Flow

1. Delivery record is created in `delivery_orders`
2. Courier is assigned
3. QR tracking code is generated
4. Delivery status changes to `assigned`
5. Delivery status changes to `in_transit`
6. Delivery status changes to `delivered`

## 4. KPI Flow

1. Orders and delivery events are captured
2. Warehouse and courier activity is aggregated
3. KPI procedures and reporting views calculate results
4. KPI output is exposed through reporting endpoints

## 5. Notification Flow

1. Business event occurs
2. Notification procedure is triggered
3. Notification is recorded in `notification_log`
4. Delivery status of the message is tracked
