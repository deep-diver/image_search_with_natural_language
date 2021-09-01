[![Flutter Web Build and Deployment](https://github.com/deep-diver/image_search_with_natural_language/actions/workflows/main.yml/badge.svg)](https://github.com/deep-diver/image_search_with_natural_language/actions/workflows/main.yml) 

# Image Search with Natural Language Queries

<div align="center">
  <a href=https://cloud.google.com/blog/topics/developers-practitioners/image-search-natural-language-queries>Blog Post</a> | <a href=https://colab.research.google.com/github/deep-diver/image_search_with_natural_language/blob/main/notebooks/Image_Search_CLIP.ipynb>Colab Notebook</a>
</div>

<br>

This project shows how to build an image search utility using natural language queries. Our aim is to use different and related serverless GCP services to demonstrate this. At the core of our project is [OpenAI's CLIP model](https://openai.com/blog/clip/). It makes use of two encoders - one for images and one for texts. Each encoder is trained to learn representations such that similar images and text embeddings are projected as close as possible. 

<br>

For details, please refer to this blog post: [Image search with natural language queries](https://cloud.google.com/blog/topics/developers-practitioners/image-search-natural-language-queries).

Following depicts the architecture design of our application:

<p align="center">
<img width="800" alt="figure" src="https://i.ibb.co/qxdPdJd/architecture-diagram.png">
</p><br>

Here's a live application demo:


https://user-images.githubusercontent.com/22957388/124558759-926c6e00-de58-11eb-8d3a-88e919655ca5.mp4


You can visit this URL for interacting with the application: http://deep-diver.github.io/image_search_with_natural_language/. You can also check out this [Colab Notebook](https://colab.research.google.com/github/deep-diver/image_search_with_natural_language/blob/main/notebooks/Image_Search_CLIP.ipynb) that accompanies this project.

## Participants

- ML GDE, [Chansung Park](https://twitter.com/algo_diver)
- ML GDE, [Paul Sayak](https://twitter.com/RisingSayak)

## Acknowledgements

[ML-GDE program](https://developers.google.com/programs/experts/) for providing GCP credits that supported this project. Thanks to Karl Weinmeister and Soonson Kwon of Google for reviewing the initial draft of this post. 

<div align="center">
  <img src="https://github.com/margaretmz/Cartoonizer-with-TFLite/raw/master/images/made-by-ml-gdes.png" width='100' height='100'/>
</div>
