"""
References:
	* https://towardsdatascience.com/beyond-tags-and-entering-the-semantic-search-era-on-images-with-openai-clip-1f7d629a9978
"""

from io import BytesIO
from PIL import Image
import requests
import logging
import time
import os

ORIGINAL_API = "https://pixabay.com/api/?key="
API_KEY = os.environ["PIXABAY_API_KEY"]
PIXABAY_API = ORIGINAL_API + API_KEY


def fetch_images_tag(pixabay_search_keyword, num_images):
    """
    Fetches images from Pixabay w.r.t a keyword.
    :param pixabay_search_keyword: Keyword to perform the search on Pixabay.
    :param num_images: Number of images to retrieve.
    :return: List of PIL images.
    """
    query = (
        PIXABAY_API
        + "&q="
        + pixabay_search_keyword.lower()
        + "&image_type=photo&safesearch=true&per_page="
        + str(num_images)
    )
    logging.info(
        f"Making request to Pixabay for {num_images} images to fetch with {pixabay_search_keyword} keyword."
    )

    start_time = time.time()
    response = requests.get(query)
    end_time = time.time() - start_time
    logging.info(f"Fetched search results in {end_time:.3f} seconds.")
    output = response.json()

    all_images = []
    start_time = time.time()
    for each in output["hits"]:
        imageurl = each["webformatURL"]
        response = requests.get(imageurl)
        image = Image.open(BytesIO(response.content)).convert("RGB")
        all_images.append(image)

    end_time = time.time() - start_time
    logging.info(f"Fetched individual results in {end_time:.3f} " f"seconds.")

    return all_images
