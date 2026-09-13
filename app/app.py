from flask import Flask, jsonify, send_from_directory
from orders import create_order

app = Flask(__name__)


@app.route("/")
def home():
    return send_from_directory(".", "index.html")


@app.route("/health")
def health():
    return jsonify({"status": "healthy"})


@app.route("/orders", methods=["POST"])
def orders():
    order = create_order()
    return jsonify(order)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
