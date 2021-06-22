import logging
import time

from transformers import CLIPProcessor, CLIPModel
import torch

CLIP_MODEL = "openai/clip-vit-base-patch32"
CLIP_PREPROCESSOR = "openai/clip-vit-base-patch32"


class SimilarityUtil:
    def __init__(self):
        self.model = CLIPModel.from_pretrained(CLIP_MODEL)
        self.processor = CLIPProcessor.from_pretrained(CLIP_PREPROCESSOR)
        logging.info("Model and preprocessor loaded.")

    def perform_sim_search(self, images, query_phrase, top_k=3):
        """
        Performs similarity search between the images and query.
        :param images: A list of PIL images initially retrieved with
        respect to some entity e.g. Tiger.
        :param query_phrase: A list containing a single text query,
        e.g. "Tiger drinking water".
        :param top_k: Number of top images to return from `images`.
        :return: Top-k images matching the query semantically and
        their similarity scores.
        """
        # Obtain the text-image similarity scores
        with torch.no_grad():
            inputs = self.processor(
                text=[query_phrase], images=images, return_tensors="pt", padding=True
            )
            start_time = time.time()
            outputs = self.model(**inputs)

        end_time = time.time() - start_time
        logging.info(f"Similarity search completed in {end_time:.3f} " f"seconds.")

        # Image-text similarity scores
        logits_per_image = outputs.logits_per_image

        top_indices, top_scores = self.sort_scores(logits_per_image, top_k)

        return (top_indices, top_scores)

    def sort_scores(self, scores, top_k):
        """
        Sorts the scores in a descending manner.
        :param scores: Scores to sort through.
        :param top_k: Number of top scores to return.
        :return: Top-k scores and their indices.
        """
        values, indices = scores.squeeze().topk(top_k)
        top_indices, top_scores = [], []

        for score, index in zip(values, indices):
            top_indices.append(int(index.numpy()))
            score = score.numpy().tolist()
            top_scores.append(round(score, 3))

        return (top_scores, top_indices)
