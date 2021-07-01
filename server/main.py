from perform_search import Searcher
from flask import Flask, jsonify, request
from flask_cors import CORS
from flask_healthz import healthz
from flask_healthz import HealthError

app = Flask(__name__)
app.register_blueprint(healthz, url_prefix="/")

cors = CORS(
    app,
    resources={
        r"/search/*": {"origin": "*"},
        r"/test/*": {"origin": "*"},
    },
)

def printok():
    print("Everything is fine")

def liveness():
    try:
        printok()
    except Exception:
        raise HealthError("Can't connect to the file")

def readiness():
    try:
        printok()
    except Exception:
        raise HealthError("Can't connect to the file")

app.config.update(
    HEALTHZ = {
        "alive": "main.liveness",
        "ready": "main.readiness",
    }
)

searcher = Searcher()

MAX_PIXABAY_SEARCH = 30

@app.route("/search", methods=["GET"])
def get_images():
    tag = request.args.get("t").lower()
    query = request.args.get("s_query").lower()
    top_k = request.args.get("k")

    (top_urls, top_scores) = searcher.get_similar_images(
        tag, query, MAX_PIXABAY_SEARCH, int(top_k)
    )

    return jsonify({"top_urls": top_urls, "top_scores": top_scores})


@app.route("/test", methods=["GET"])
def test():
    return jsonify({"result": "good to go"})


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080, debug=True)
