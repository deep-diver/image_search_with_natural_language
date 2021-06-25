We use [OpenAI's CLIP model](https://arxiv.org/abs/2103.00020) to retrieve the images most _semantically_ similar to a given search query. OpenAI released [a few 
pretrained checkpoints](https://github.com/openai/CLIP/blob/main/model-card.md). Amongst those we use the one based on a [Vision Transformer](https://arxiv.org/abs/2010.11929).

Hugging Face [provides](https://huggingface.co/transformers/model_doc/clip.html) an easy to use interface to consume the checkpoint and in our application we use that. 
