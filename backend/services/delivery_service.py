from typing import Any, Dict, List


class DeliveryService:
    def get_deliveries(self) -> List[Dict[str, Any]]:
        return [
            {
                "delivery_id": 9001,
                "order_id": 1001,
                "warehouse_id": 6001,
                "courier_id": 7001,
                "delivery_status": "assigned",
                "qr_tracking_code": "QR-9001-123456"
            }
        ]
