from random import choice
from PIL import Image
import cv2, os
path = [i for i in os.listdir("opt")]
name = choice(path)
img = "opt\\"+name
img = Image.open(img)
new_img = img.resize((475//2,475//2))
new_img.save(f"{name.strip('.png')}_new.png")