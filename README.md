# Image Search with Natural Language in GCP environment

This project is about demonstrating the way of leveraging GCP technologies for training and deploying a deep learning model. The main focus is about the deep learning related things, and it is enough for the front-end applications to show a minimum functionalities to interact with the deployed deep learning model.

The choice of deep learning model is Natural Language Image Search with Dual Encoder which is one of Keras' official examples. The model is built on top of two pretrained BERT’s encoders from TensorFlow Hub. Each encoder is responsible to build an embedding space for image and natural languages to combine different sources of information. 

<img width="659" alt="figure" src="https://user-images.githubusercontent.com/26025527/122719991-e0ef0980-d2a9-11eb-9ab0-e5b99e6f99f8.png">

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
