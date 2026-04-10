from typing import Any, Dict


class AuthService:
    def login(self, username: str, password: str) -> Dict[str, Any]:
        if not username or not password:
            raise ValueError("Username and password are required")

        return {
            "access_token": "demo-token-123",
            "token_type": "Bearer",
            "username": username
        }
