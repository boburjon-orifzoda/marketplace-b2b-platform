from typing import Any, Dict, List


class CategoryRepository:
    def get_all_categories(self) -> List[Dict[str, Any]]:
        return [
            {
                "category_id": 3001,
                "parent_category_id": None,
                "category_name": "Plumbing",
                "category_code": "PLUMB"
            },
            {
                "category_id": 3002,
                "parent_category_id": 3001,
                "category_name": "Pipes",
                "category_code": "PIPES"
            },
            {
                "category_id": 3003,
                "parent_category_id": 3001,
                "category_name": "Valves",
                "category_code": "VALVES"
            }
        ]
