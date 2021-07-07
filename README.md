[![Flutter Web Build and Deployment](https://github.com/deep-diver/image_search_with_natural_language/actions/workflows/main.yml/badge.svg)](https://github.com/deep-diver/image_search_with_natural_language/actions/workflows/main.yml) 

# Image Search with Natural Language Queries

This project shows how to build an image search utility using natural language queries. Our aim is to use different and related serverless GCP services to demonstrate this. At the core of our project is [OpenAI's CLIP model](https://openai.com/blog/clip/). It makes use of two encoders - one for images and one for texts. Each encoder is trained to learn representations such that similar images and text embeddings are projected as close as possible. 

Following depicts the architecture design of our application:

<p align="center">
<img width="800" alt="figure" src="https://i.ibb.co/qxdPdJd/architecture-diagram.png">
</p><br>

Here's a live application demo:


https://user-images.githubusercontent.com/22957388/124558759-926c6e00-de58-11eb-8d3a-88e919655ca5.mp4


You can also visit this URL for interacting with the application: http://deep-diver.github.io/image_search_with_natural_language/.


For details, please refer to this blog post (link to be updated.)

## Participants

- ML GDE, [Chansung Park](https://twitter.com/algo_diver)
- ML GDE, [Paul Sayak](https://twitter.com/RisingSayak)

## Acknowledgements

[ML-GDE program](https://developers.google.com/programs/experts/) for providing GCP credits that supported this project. 

<div align="center">
  <img src="https://github.com/margaretmz/Cartoonizer-with-TFLite/raw/master/images/made-by-ml-gdes.png" width='100' height='100'/>
</div>
