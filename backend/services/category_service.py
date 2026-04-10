from typing import Any, Dict, List
from repositories.category_repository import CategoryRepository


class CategoryService:
    def __init__(self) -> None:
        self.category_repository = CategoryRepository()

    def get_categories(self) -> List[Dict[str, Any]]:
        return self.category_repository.get_all_categories()
