[![Flutter Web Build and Deployment](https://github.com/deep-diver/image_search_with_natural_language/actions/workflows/main.yml/badge.svg)](https://github.com/deep-diver/image_search_with_natural_language/actions/workflows/main.yml) 

# Image Search with Natural Language Queries

This project shows how to build an image search utility using natural language queries. Our aim is to use different and related serverless GCP services to demonstrate this. At the core of our project is [OpenAI's CLIP model](https://openai.com/blog/clip/). It makes use of two encoders - one for images and one for texts. Each encoder is trained to learn representations such that similar images and text embeddings are projected as close as possible. 

Following depicts the architecture design of our application:

<p align="center">
<img width="800" alt="figure" src="https://i.ibb.co/qxdPdJd/architecture-diagram.png">
</p><br>

Here's a live application demo:

https://i.ibb.co/t2PGbV5/with-memorystore2-only-CPU.gif

For details, please refer to this blog post (link to be updated.)

## Participants

- ML GDE, [Chansung Park](https://twitter.com/algo_diver)
- ML GDE, [Paul Sayak](https://twitter.com/RisingSayak)
