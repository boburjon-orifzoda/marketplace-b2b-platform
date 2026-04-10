from typing import Any, Dict, List


class ProductRepository:
    def get_all_products(self) -> List[Dict[str, Any]]:
        return [
            {
                "product_id": 5001,
                "sku_code": "SKU-P-001",
                "product_name": "PVC Pipe 20mm",
                "category_name": "Pipes",
                "unit_price": 4.50,
                "currency_code": "USD",
                "is_active": True
            },
            {
                "product_id": 5002,
                "sku_code": "SKU-V-001",
                "product_name": "Pressure Valve X1",
                "category_name": "Valves",
                "unit_price": 15.75,
                "currency_code": "USD",
                "is_active": True
            }
        ]
