from flask import Blueprint, jsonify, request

order_items_blueprint = Blueprint("order_items", __name__)


@order_items_blueprint.route("/", methods=["POST"])
def add_order_item():
    payload = request.get_json() or {}

    required_fields = ["order_id", "product_id", "ordered_quantity"]
    missing_fields = [field for field in required_fields if field not in payload or payload[field] in (None, "")]

    if missing_fields:
        return jsonify({
            "message": "Validation error",
            "error": f"Missing required fields: {', '.join(missing_fields)}"
        }), 400

    return jsonify({
        "message": "Order item added successfully",
        "data": payload
    }), 201
