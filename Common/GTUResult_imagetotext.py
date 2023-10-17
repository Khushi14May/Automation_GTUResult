import cv2
from PIL import Image, ImageCms, ImageFilter
basic_path="C:/Users/158421/OneDrive - Arrow Electronics, Inc/Desktop/GTU-result-Robot/Automation_GTUResult/images/"
# convert to inverted mask and save img_temp
im = cv2.imread(basic_path+"cropped.png")
gray = cv2.cvtColor(im, cv2.COLOR_BGR2GRAY)
thresh = cv2.threshold(gray, 0, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)[1]
horizontal_kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (25, 1))
Mask = cv2.morphologyEx(thresh, cv2.MORPH_OPEN,horizontal_kernel, iterations=2)
#Mask = cv2.bitwise_not(Mask)
cv2.imwrite(basic_path+"old.png", Mask)

# open img_temp and reinvert mask
img = Image.open(basic_path+"old.png")
img = img.convert("RGBA")
datas = img.getdata()
newData = []
for item in datas:
    if item[0] == 0 and item[1] == 0 and item[2] == 0:
        newData.append((255, 255, 255, 0))
    else:
        newData.append(item)
img.putdata(newData)

# paste mask on img and save new_temp_img
background = Image.open(basic_path+"cropped.png")
background = background.convert("RGBA")
background.paste(img,mask=img)
background.save(basic_path+"new.png","png")

import easyocr
reader = easyocr.Reader(['en'])
result = reader.readtext(basic_path+'new.png', detail = 0)
str1=""
for i in result:
     str1+=i

print(str1)
