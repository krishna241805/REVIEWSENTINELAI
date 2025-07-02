from sentiment_api import app

if __name__ == "__main__":
    # Run the Flask app on host 0.0.0.0 to make it accessible from other devices
    app.run(host="0.0.0.0", port=5000, debug=False)