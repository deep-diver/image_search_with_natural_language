from similarity_utils import SimilarityUtil
from pixabay_utils import fetch_images_tag


def get_similar_images(keyword, semantic_query, pixabay_max, top_k):
    """
    Finds semantically similar images.
    :param keyword: Keyword to search with on Pixabay.
    :param semantic_query: Query to find semantically similar images retrieved from Pixabay.
    :param pixabay_max: Number of maximum images to retrieve from Pixabay.
    :param top_k: Top-k images to return.
    :return: List of top-k PIL images.
    """
    similarity_model = SimilarityUtil()
    keyword_images = fetch_images_tag(keyword, pixabay_max)

    (top_images, top_scores) = similarity_model.perform_sim_search(
        semantic_query, keyword_images, top_k
    )

    return (top_images, top_scores)
