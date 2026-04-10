from typing import Any, Dict, List
from repositories.product_repository import ProductRepository


class ProductService:
    def __init__(self) -> None:
        self.product_repository = ProductRepository()

    def get_products(self) -> List[Dict[str, Any]]:
        return self.product_repository.get_all_products()
