from typing import Any, Dict, List


class SupplierRepository:
    def get_all_suppliers(self) -> List[Dict[str, Any]]:
        return [
            {
                "supplier_id": 1001,
                "supplier_name": "Aqua Industrial Supply",
                "city_id": 101,
                "is_active": True
            },
            {
                "supplier_id": 1002,
                "supplier_name": "PipeFlow Distribution",
                "city_id": 102,
                "is_active": True
            }
        ]
