
from flask import Flask, request, jsonify
import os

app = Flask(__name__)

LOG_FILE = "/app/logs/app.log"

PORT = int(os.environ.get("APP_PORT", 5000))
GREETING = os.environ.get("APP_GREETING", "Welcome to the custom app")
LOG_LEVEL = os.environ.get("APP_LOG_LEVEL", "INFO")

@app.route('/', methods=['GET'])
def welcome():
    return GREETING

@app.route('/status', methods=['GET'])
def status():
    return jsonify({"status": "ok"})

@app.route('/log', methods=['POST'])
def log_message():
    data = request.get_json()
    message = data['message']
    with open(LOG_FILE, 'a') as f:
        f.write(f"{message}\n")
    return jsonify({"status": "logged"}), 201

@app.route('/logs', methods=['GET'])
def get_logs():
    with open(LOG_FILE, 'r') as f:
        return f.read(), 200

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=PORT)
