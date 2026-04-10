from flask import Blueprint, jsonify

delivery_blueprint = Blueprint("delivery", __name__)


@delivery_blueprint.route("/", methods=["GET"])
def get_deliveries():
    return jsonify({
        "message": "Delivery endpoint works",
        "data": []
    })
