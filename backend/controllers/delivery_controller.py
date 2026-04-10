from flask import Blueprint, jsonify
from services.delivery_service import DeliveryService

delivery_blueprint = Blueprint("delivery", __name__)
delivery_service = DeliveryService()


@delivery_blueprint.route("/", methods=["GET"])
def get_deliveries():
    data = delivery_service.get_deliveries()
    return jsonify({
        "message": "Deliveries retrieved successfully",
        "data": data
    })
