from perform_search import Searcher
from flask import Flask, jsonify, request


app = Flask(__name__)
searcher = Searcher()

MAX_PIXABAY_SEARCH = 30

@app.route("/search", methods=["GET"])
def get_images():
    tag = request.args.get("t")
    query = request.args.get("s_query")
    top_k = request.args.get("k")

    (top_urls, top_scores) = searcher.get_similar_images(tag, query, MAX_PIXABAY_SEARCH, int(top_k))

    return jsonify({"top_urls": top_urls, "top_scores": top_scores})

@app.route("/test", methods=["GET"])
def test():
    return jsonify({"result": "good to go"})

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8080, debug=True)
