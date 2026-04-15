import os


class Config:
    APP_NAME = "Marketplace Platform API"
    DEBUG = os.getenv("APP_DEBUG", "true").lower() == "true"
    HOST = os.getenv("APP_HOST", "127.0.0.1")
    PORT = int(os.getenv("APP_PORT", "5000"))
    SECRET_KEY = os.getenv("SECRET_KEY", "demo-secret-key")
