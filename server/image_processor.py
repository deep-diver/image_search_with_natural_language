from torchvision.transforms import Compose, Resize, CenterCrop, ToTensor, Normalize
from PIL import Image
import torch


MEAN = torch.tensor([0.48145466, 0.4578275, 0.40821073])
STD = torch.tensor([0.26862954, 0.26130258, 0.27577711])


def preprocess_image(image):
	"""
	Preprocess an image.
	:param image: PIL image.
	:return: Preprocessed image.
	"""
	preprocessor = Compose([
		Resize(224, interpolation=Image.BICUBIC),
		CenterCrop(224),
		ToTensor(),
		Normalize(MEAN, STD)
	])
	return preprocessor(image)

