from typing import Any, Dict, List
from repositories.order_repository import OrderRepository


class OrderService:
    def __init__(self) -> None:
        self.order_repository = OrderRepository()

    def get_orders(self) -> List[Dict[str, Any]]:
        return self.order_repository.get_all_orders()

    def create_order(self, payload: Dict[str, Any]) -> Dict[str, Any]:
        required_fields = ["partner_id", "order_number", "delivery_city_id", "currency_code"]

        missing_fields = [field for field in required_fields if field not in payload or payload[field] in (None, "")]
        if missing_fields:
            raise ValueError(f"Missing required fields: {', '.join(missing_fields)}")

        return self.order_repository.save_order(payload)
