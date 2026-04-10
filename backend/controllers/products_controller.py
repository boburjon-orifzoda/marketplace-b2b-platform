from flask import Blueprint, jsonify
from services.product_service import ProductService

products_blueprint = Blueprint("products", __name__)
product_service = ProductService()


@products_blueprint.route("/", methods=["GET"])
def get_products():
    data = product_service.get_products()
    return jsonify({
        "message": "Products retrieved successfully",
        "data": data
    })
