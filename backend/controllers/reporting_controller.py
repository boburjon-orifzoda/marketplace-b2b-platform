from flask import Blueprint, jsonify

reporting_blueprint = Blueprint("reporting", __name__)


@reporting_blueprint.route("/kpi", methods=["GET"])
def get_kpi():
    return jsonify({
        "message": "KPI report retrieved successfully",
        "data": {
            "total_orders": 1250,
            "delivered_orders": 1180,
            "failed_deliveries": 25,
            "delivery_rate_pct": 94.40
        }
    })
