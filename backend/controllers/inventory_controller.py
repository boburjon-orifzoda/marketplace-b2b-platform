from flask import Blueprint, jsonify, request
from services.inventory_service import InventoryService

inventory_blueprint = Blueprint("inventory", __name__)
inventory_service = InventoryService()


@inventory_blueprint.route("/", methods=["GET"])
def get_inventory():
    data = inventory_service.get_inventory_balances()
    return jsonify({
        "message": "Inventory balances retrieved successfully",
        "data": data
    })


@inventory_blueprint.route("/availability", methods=["POST"])
def check_availability():
    payload = request.get_json() or {}

    try:
        result = inventory_service.check_product_availability(
            product_id=int(payload["product_id"]),
            requested_quantity=float(payload["requested_quantity"])
        )
        return jsonify({
            "message": "Availability checked successfully",
            "data": result
        })
    except KeyError:
        return jsonify({
            "message": "Validation error",
            "error": "product_id and requested_quantity are required"
        }), 400
    except ValueError as exc:
        return jsonify({
            "message": "Validation error",
            "error": str(exc)
        }), 400
