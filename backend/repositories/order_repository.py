from typing import Any, Dict, List


class OrderRepository:
    def get_all_orders(self) -> List[Dict[str, Any]]:
        return [
            {
                "order_id": 1001,
                "order_number": "ORD-2026-0001",
                "partner_id": 2001,
                "delivery_city_id": 101,
                "currency_code": "USD",
                "status": "draft"
            }
        ]

    def save_order(self, payload: Dict[str, Any]) -> Dict[str, Any]:
        return {
            "order_id": payload.get("order_id", 1001),
            "partner_id": payload["partner_id"],
            "order_number": payload["order_number"],
            "delivery_city_id": payload["delivery_city_id"],
            "currency_code": payload["currency_code"],
            "status": "draft"
        }
