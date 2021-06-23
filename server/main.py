from perform_search import Searcher
from flask import Flask, jsonify, request


app = Flask(__name__)
searcher = Searcher()


@app.route("/search", methods=["GET"])
def get_images():
    tag = request.get("t")
    query = request.get("s_query")
    top_k = request.get("k")

    (top_urls, top_scores) = searcher.get_similar_images(tag, query, top_k)

    return jsonify({"top_urls": top_urls, "top_scores": top_scores})

@app.route("/test", methods=["GET"])
def get_images():
    return jsonify({"result": "good to go"})

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8080, debug=True)