"""
References:
    * https://towardsdatascience.com/beyond-tags-and-entering-the-semantic-search-era-on-images-with-openai-clip-1f7d629a9978
"""

from image_processor import preprocess_image
from text_processor import SimpleTokenizer
import torch

import numpy as np
import requests
import logging
import time


CLIP_MODEL = "https://openaipublic.azureedge.net/clip/models/afeb0e10f9e5a86da6080e35cf09123aca3b358a0c3e3b6c78a7b63bc04b6762/RN50.pt"


class SimilarityUtil:
    def __init__(self):
        self.model = self.load_model()
        self.tokenizer = SimpleTokenizer()
        self.image_preprocessor = preprocess_image
        logging.info("Model and preprocessors loaded.")

    def perform_sim_search(self, images, query_phrase, top_k=3):
        """
        Performs similarity search between the images and query.
        :param images: A list of PIL images initially retrieved with
        respect to some entity e.g. Tiger.
        :param query_phrase: A list containing a single
        text query, e.g. "Tiger drinking water".
        :param top_k: Number of top images to return from `images`.
        :return: Top-k indices matching the query semantically and
         their similarity scores.
        """
        ## Images ##
        start_time = time.time()
        images = [self.image_preprocessor(im) for im in images]
        image_input = torch.tensor(np.stack(images))

        with torch.no_grad():
            image_features = self.model.encode_image(image_input).float()
        image_features /= image_features.norm(dim=-1, keepdim=True)

        ## Query phrase ##
        text_tokens = [
            self.tokenizer.encode("%s " % (query_phrase) + "<|endoftext|>")]
        text_input = torch.zeros(len(text_tokens),
                                 self.model.context_length,
                                 dtype=torch.long)
        for i, tokens in enumerate(text_tokens):
            text_input[i, :len(tokens)] = torch.tensor(tokens)

        with torch.no_grad():
            text_features = self.model.encode_text(text_input).float()
        text_features /= text_features.norm(dim=-1, keepdim=True)
        end_time = time.time() - start_time

        logging.info(f"Preprocessing and inference took {end_time:.3f} seconds.")

        ## Fetch the indices and scores ##
        similarity = text_features.numpy() @ image_features.numpy().T
        (top_indices, top_scores) = self.sort_scores(similarity[0],
                                                     top_k)

        return (top_indices, top_scores)

    def sort_scores(self, similarity_list, top_k):
        """
        Sorts the scores in a descending manner.
        :param similarity_list: Similarity scores to sort.
        :param top_k: Number of top scores to return.
        :return: Tuple of top-k scores and their indices.
        """
        results = zip(range(len(similarity_list)), similarity_list)
        results = sorted(results, key=lambda x: x[1], reverse=True)
        top_indices = []
        top_scores = []
        for (index, score) in results[:top_k]:
            top_scores.append(score)
            top_indices.append(index)
        return (top_indices, top_scores)

    def load_model(self):
        """
        Downloads and loads the CLIP model checkpoints.
        """
        r = requests.get(CLIP_MODEL)
        with open("./model.pt", "wb") as f:
            f.write(r.content)
        model = torch.jit.load("./model.pt")
        return model
