from flask import Blueprint, jsonify
from services.supplier_service import SupplierService

suppliers_blueprint = Blueprint("suppliers", __name__)
supplier_service = SupplierService()


@suppliers_blueprint.route("/", methods=["GET"])
def get_suppliers():
    data = supplier_service.get_suppliers()
    return jsonify({
        "message": "Suppliers retrieved successfully",
        "data": data
    })
