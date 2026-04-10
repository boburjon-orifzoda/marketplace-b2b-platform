from typing import Any, Dict, List


class OrderService:
    def get_orders(self) -> List[Dict[str, Any]]:
        return []

    def create_order(self, payload: Dict[str, Any]) -> Dict[str, Any]:
        required_fields = ["partner_id", "order_number", "delivery_city_id", "currency_code"]

        missing_fields = [field for field in required_fields if field not in payload or payload[field] in (None, "")]
        if missing_fields:
            raise ValueError(f"Missing required fields: {', '.join(missing_fields)}")

        return {
            "order_id": payload.get("order_id"),
            "partner_id": payload["partner_id"],
            "order_number": payload["order_number"],
            "delivery_city_id": payload["delivery_city_id"],
            "currency_code": payload["currency_code"],
            "status": "draft"
        }
