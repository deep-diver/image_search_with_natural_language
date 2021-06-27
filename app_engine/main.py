from flask import Flask, jsonify, request
from flask_cors import CORS
import redis_utils
import requests
import json


app = Flask(__name__)
cors = CORS(
    app,
    resources={
        r"/search/*": {"origin": "*"},
        r"/test/*": {"origin": "*"},
    },
)

redis_connection = redis_utils.RedisConnect()
client = redis_connection.get_client()


@app.route("/search", methods=["GET"])
def get_images():
    tag = request.args.get("t")
    query = request.args.get("s_query").lower()
    top_k = request.args.get("k")

    if client.get(query):
        result = json.loads(client.get(query))
        top_urls = result["top_urls"]
        top_scores = result["top_scores"]
        return jsonify({"top_urls": top_urls, "top_scores": top_scores})

    else:
        parameters = {"t": tag, "s_query": query, "k": top_k}
        response = requests.get("https://mlgde.com/search", params=parameters)

        if response.status_code == 200:
            json_response = response.json()
            top_urls = json_response["top_urls"]
            top_scores = json_response["top_scores"]
            results = {"top_urls": top_urls, "top_scores": top_scores}

            with client.pipeline() as pipe:
                pipe.set(query, json.dumps(results).encode("utf-8"))
                pipe.execute()

            return jsonify({"top_urls": top_urls, "top_scores": top_scores})

        elif response.status_code != 200:
            return jsonify({"error": str(response.status_code)})


@app.route("/test", methods=["GET"])
def test():
    return jsonify({"result": "good to go."})


if __name__ == "__main__":
    app.run(port=8080, debug=True)
