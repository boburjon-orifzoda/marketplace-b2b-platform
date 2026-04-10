from flask import Blueprint, jsonify
from services.category_service import CategoryService

categories_blueprint = Blueprint("categories", __name__)
category_service = CategoryService()


@categories_blueprint.route("/", methods=["GET"])
def get_categories():
    data = category_service.get_categories()
    return jsonify({
        "message": "Categories retrieved successfully",
        "data": data
    })
