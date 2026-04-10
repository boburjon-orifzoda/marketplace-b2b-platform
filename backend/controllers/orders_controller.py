from flask import Blueprint, jsonify, request
from services.order_service import OrderService

orders_blueprint = Blueprint("orders", __name__)
order_service = OrderService()


@orders_blueprint.route("/", methods=["GET"])
def get_orders():
    data = order_service.get_orders()
    return jsonify({
        "message": "Orders retrieved successfully",
        "data": data
    })


@orders_blueprint.route("/", methods=["POST"])
def create_order():
    payload = request.get_json() or {}

    try:
        created_order = order_service.create_order(payload)
        return jsonify({
            "message": "Order created successfully",
            "data": created_order
        }), 201
    except ValueError as exc:
        return jsonify({
            "message": "Validation error",
            "error": str(exc)
        }), 400
