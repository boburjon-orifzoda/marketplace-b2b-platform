from typing import Any, Dict, List


class InventoryService:
    def get_inventory_balances(self) -> List[Dict[str, Any]]:
        return []

    def check_product_availability(self, product_id: int, requested_quantity: float) -> Dict[str, Any]:
        if requested_quantity <= 0:
            raise ValueError("Requested quantity must be greater than zero")

        return {
            "product_id": product_id,
            "requested_quantity": requested_quantity,
            "is_available": True,
            "allocated_warehouse_id": None
        }
