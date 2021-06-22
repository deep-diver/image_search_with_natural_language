from similarity_utils import SimilarityUtil
from pixabay_utils import fetch_images_tag


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
        :return: List of top-k PIL images.
        """
        keyword_images, keyword_image_urls = fetch_images_tag(keyword, pixabay_max)

        (top_indicies, top_scores) = self.similarity_model.perform_sim_search(
            semantic_query, keyword_images, top_k
        )

        top_urls = [keyword_image_urls[index] for index in top_indicies]

        return (top_urls, top_scores)
