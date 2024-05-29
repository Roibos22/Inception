# import os
# from flask import Flask

# app = Flask(__name__)

# @app.route("/")
# def hello():
#     # Get the DOMAIN_NAME from environment variables (if it exists)
#     domain_name = os.environ.get('DOMAIN_NAME', 'localhost')  # Set a default value
#     return f"hi welt from {domain_name}"

# if __name__ == "__main__":
#     app.run(host="0.0.0.0", port=5000)