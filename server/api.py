from perform_search import Searcher
from flask import Flask, jsonify, request
from base64 import encodebytes
import logging
import io


app = Flask(__name__)
searcher = Searcher()


def get_response_image(pil_img):
    """
    Converts a PIL image to byte array and encode as base64.
    :param pil_img: PIl image.
    :return: base64 encoding of the image.
    """
    byte_arr = io.BytesIO()
    pil_img.save(byte_arr, format="PNG")
    encoded_img = encodebytes(byte_arr.getvalue()).decode("ascii")
    return encoded_img


@app.route("/search", methods=["GET"])
def get_images():
    tag = request.get("t")
    query = request.get("s_query")
    top_k = request.get("k")

    results = searcher.get_similar_images(tag, query, top_k)
    encoded_imges = []

    for result in results:
        encoded_imges.append(get_response_image(result))

    return jsonify({"result": encoded_imges})


if __name__ == "__main__":
    app.run(host="localhost", port=8080, debug=True)
