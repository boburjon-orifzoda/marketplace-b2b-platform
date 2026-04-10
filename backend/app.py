from flask import Flask
from controllers.products_controller import products_blueprint
from controllers.orders_controller import orders_blueprint
from controllers.inventory_controller import inventory_blueprint
from controllers.delivery_controller import delivery_blueprint
from controllers.suppliers_controller import suppliers_blueprint
from controllers.categories_controller import categories_blueprint
from controllers.order_items_controller import order_items_blueprint
from controllers.auth_controller import auth_blueprint
from controllers.reporting_controller import reporting_blueprint

app = Flask(__name__)

app.register_blueprint(products_blueprint, url_prefix="/api/products")
app.register_blueprint(orders_blueprint, url_prefix="/api/orders")
app.register_blueprint(inventory_blueprint, url_prefix="/api/inventory")
app.register_blueprint(delivery_blueprint, url_prefix="/api/delivery")
app.register_blueprint(suppliers_blueprint, url_prefix="/api/suppliers")
app.register_blueprint(categories_blueprint, url_prefix="/api/categories")
app.register_blueprint(order_items_blueprint, url_prefix="/api/order-items")
app.register_blueprint(auth_blueprint, url_prefix="/api/auth")
app.register_blueprint(reporting_blueprint, url_prefix="/api/reporting")

if __name__ == "__main__":
    app.run(debug=True)
