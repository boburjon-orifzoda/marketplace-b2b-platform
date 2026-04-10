from flask import Flask
from controllers.products_controller import products_blueprint
from controllers.orders_controller import orders_blueprint
from controllers.inventory_controller import inventory_blueprint
from controllers.delivery_controller import delivery_blueprint

app = Flask(__name__)

app.register_blueprint(products_blueprint, url_prefix="/api/products")
app.register_blueprint(orders_blueprint, url_prefix="/api/orders")
app.register_blueprint(inventory_blueprint, url_prefix="/api/inventory")
app.register_blueprint(delivery_blueprint, url_prefix="/api/delivery")

if __name__ == "__main__":
    app.run(debug=True)
