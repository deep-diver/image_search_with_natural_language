import os
from similarity_utils import SimilarityUtil
from pixabay_utils import fetch_images_tag
from direct_redis import DirectRedis

redis_host = os.environ.get('REDISHOST', 'localhost')
redis_port = int(os.environ.get('REDISPORT', 6379))
redis_client = DirectRedis(host=redis_host, port=redis_port)

class Searcher:
    def __init__(self):
        self.similarity_model = SimilarityUtil()

    def get_similar_images(self, keyword, semantic_query, pixabay_max, top_k):
        """
        Finds semantically similar images.
        :param keyword: Keyword to search with on Pixabay.
        :param semantic_query: Query to find semantically similar images retrieved from Pixabay.
        :param pixabay_max: Number of maximum images to retrieve from Pixabay.
        :param top_k: Top-k images to return.
        :return: Tuple of top_k URLs and the similarity scores of the images present inside the URLs.
        """
        images_redis_key = keyword + "_images"
        urls_redis_key = keyword + "_urls"
        
        if redis_client.exists(images_redis_key) and redis_client.exists(urls_redis_key):
            keyword_images = redis_client.get(images_redis_key)
            keyword_image_urls = redis_client.get(urls_redis_key)
        else:
            (keyword_images, keyword_image_urls) = fetch_images_tag(keyword, pixabay_max)
            redis_client.set(images_redis_key, keyword_images)
            redis_client.set(urls_redis_key, keyword_image_urls)        

        (top_indices, top_scores) = self.similarity_model.perform_sim_search(
            keyword_images, semantic_query, top_k
        )

        top_urls = [keyword_image_urls[index] for index in top_indices]

        return (top_urls, top_scores)
