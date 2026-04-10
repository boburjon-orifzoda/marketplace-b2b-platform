from flask import Blueprint, jsonify

products_blueprint = Blueprint("products", __name__)

@products_blueprint.route("/", methods=["GET"])
def get_products():
    return jsonify({
        "message": "Products endpoint works",
        "data": []
    })
