from utilities import scrapy
from threading import Thread
import json,os,math
file = open("new_pokedex.json")
js = json.loads(file.read())
file.close()
names = list(js.keys())
count = range(1,len(names)+1)
mini,profile = [js[i]["front"] for i in names],[js[i]["img"] for i in names]
div = math.ceil(len(profile)/32)
lines = [[i*div,(i+1)*div if i != 30 else (i+1)*div - 1] for i in range(32) if i != 31]
data = [[names[i[0]:i[1]],mini[i[0]:i[1]],profile[i[0]:i[1]]] for i in lines]
path_mini = f"{os.getcwd()}\\mini"
path_opt = f"{os.getcwd()}\\opt"

def collec(lista: list):
    for n,m,p in zip(lista[0],lista[1],lista[2]):
        print(f"{len(os.listdir('mini'))}: {n}\n{m}\n{p}\n")
        if(f"{n}.png" not in os.listdir('mini')):
            scrapy.download_img(f"{n}.png",m,path_mini)
        if(f"{n}.png" not in os.listdir('opt')):
            scrapy.download_img(f"{n}.png",p,path_opt)

thd = [Thread(target=collec,args=([j])) for j in data]
for t in thd:
    t.start()
for t in thd:
    t.join()
# for c,n,m,p in zip(count,names,mini,profile):
#     print(f"{c}: {n}\n{m}\n{p}\n")
#     scrapy.download_img(f"{n}.png",m,path)