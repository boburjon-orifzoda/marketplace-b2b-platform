from flask import Blueprint, jsonify, request
from services.auth_service import AuthService

auth_blueprint = Blueprint("auth", __name__)
auth_service = AuthService()


@auth_blueprint.route("/login", methods=["POST"])
def login():
    payload = request.get_json() or {}

    try:
        result = auth_service.login(
            username=payload.get("username", ""),
            password=payload.get("password", "")
        )
        return jsonify({
            "message": "Authentication successful",
            "data": result
        })
    except ValueError as exc:
        return jsonify({
            "message": "Authentication failed",
            "error": str(exc)
        }), 400
