from flask import Blueprint, jsonify, request

orders_blueprint = Blueprint("orders", __name__)

@orders_blueprint.route("/", methods=["GET"])
def get_orders():
    return jsonify({
        "message": "Orders endpoint works",
        "data": []
    })

@orders_blueprint.route("/", methods=["POST"])
def create_order():
    payload = request.get_json()
    return jsonify({
        "message": "Order received",
        "payload": payload
    }), 201
