# Business Rules

## Product Search
Users can search products by:
- keyword
- category
- product attributes
- image-based search

## Fulfillment Logic
Orders are routed based on:
- nearest warehouse or plant
- stock availability
- delivery feasibility
- regional coverage

## Delivery Logic
Once an order is confirmed:
- courier receives dispatch request
- pickup point is selected from nearest available stock location
- order status is tracked during delivery lifecycle

## QR-Based Tracking
Each delivered item can be tracked using QR-based status updates.

Delivery process example:
- item is prepared for dispatch
- courier scans QR code when receiving the item
- courier transports item to destination
- recipient confirmation updates delivery status
- final handoff can be validated through QR scan workflow

## Delivery Status Management
Order / shipment statuses may include:
- pending
- ready for dispatch
- picked up
- in transit
- delivered
- awaiting confirmation

## GPS Tracking
Shipments are tracked using GPS-based monitoring to improve delivery control and reduce loss or theft risks.

## KPI Rules
KPI logic was designed for:
- sales employees
- managers
- couriers

## Sales Manager Incentive Logic
Sales managers may receive performance-based percentages for:
- direct product sales
- achieved sales volume
- new client acquisition
- repeat commercial activity

## Courier Incentive Logic
If a courier delivers more than a defined daily threshold, an additional percentage-based incentive may be applied.

## Department Rule Ownership
Certain KPI percentages, thresholds, and incentive policies are controlled by business / marketing department rules.
