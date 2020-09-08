from flask import Flask

app = Flask(__name__, static_folder = "public", static_url_path = "")
app.config["SEND_FILE_MAX_AGE_DEFAULT"] = 0

@app.route("/")
def index():
  return app.send_static_file("index.html")

app.run(host = "localhost", port = 24235)
