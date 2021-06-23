[![Flutter Web Build and Deployment](https://github.com/deep-diver/image_search_with_natural_language/actions/workflows/main.yml/badge.svg)](https://github.com/deep-diver/image_search_with_natural_language/actions/workflows/main.yml) [![Deploy an App Engine app](https://github.com/deep-diver/image_search_with_natural_language/actions/workflows/deploy.yml/badge.svg)](https://github.com/deep-diver/image_search_with_natural_language/actions/workflows/deploy.yml)

# Image Search with Natural Language in GCP environment

This project shows how to build an image search utility using natural language queries. Our aim is to use different and related serverless GCP services to demonstrate this. At the core of our project is [OpenAI's CLIP model](https://openai.com/blog/clip/). It makes use of two encoders - one for images and one for texts. Each encoder is trained to learn representations such that similar images and text embeddings are projected as close as possible. 

Following depicts the base architecture design of our application:

<p align="center">
<img width="659" alt="figure" src="https://user-images.githubusercontent.com/26025527/122719991-e0ef0980-d2a9-11eb-9ab0-e5b99e6f99f8.png">
</p>

We will add a demo GIF later. 

## Planning (1st phase)

**Model Serving**
- [ ] Exposing RestAPI endpoint
- [ ] Loading [OpenAI CLIP model](https://github.com/openai/CLIP) or [HuggingFace CLIP model](https://huggingface.co/transformers/model_doc/clip.html)
- [ ] Calculating Cosine Similarities Based on a Given Text Query
- [ ] Sending the Most Similar Pictures (Top-K, Configurable via RestAPI) to the Client

**Flutter Client Application**
- [ ] UI Design
- [ ] Connection to RestAPI Server
- [ ] Sending query / Receiving Resulting Pictures
- [ ] Displaying the Received Resulting PIctures

## Participants

- ML GDE, Paul Sayak (spsayakpaul@gmail.com)
- ML GDE, Chansung Park (deep.diver.csp@gmail.com)
