from utilities import scrapy
from threading import Thread
import json,os,math

file = open("new_pokedex.json")
js = json.loads(file.read())
def download_pokemons():
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


def get_moves():
    moves_list = [js[i]["moves"] for i in js]
    refined = {}
    for i in moves_list:
        refined.update(i)
    moves_list = refined

    for i in moves_list:
        link = moves_list[i]
        bs = scrapy.collect_html(link)
        bs = json.loads(str(bs))
        effect = [j for j in bs["effect_entries"] if "'name': 'en'" in str(j)][0]
        move = {
            # "min hits":bs["min_hits"] if bs["min_hits"] != None else 0,
            # "min turns":bs["min_turns"] if bs["min_turns"] != None else 0,
            # "max hits":bs["max_hits"] if bs["max_hits"] != None else 0,
            # "max turns":bs["max_turns"] if bs["max_turns"] != None else 0,
            # "flinch chance":bs["flinch_chance"],
            # "category":bs["category"]["name"],
            # "critical rate":bs["crit_rate"],
            # "stat chance":bs["stat_chance"],
            # "healing":bs["healing"],
            # "drain":bs["drain"],
            "power":bs["power"] if bs["power"] != None else 0,
            "flavor text entries":[j for j in bs["flavor_text_entries"] if "'name': 'en'" in str(j)][0]["flavor_text"],
            # "effect entries":effect,
            "complete":effect["effect"],
            "short":effect["short_effect"],
            "effect changes":bs["effect_changes"],
            "effect chance":bs["effect_chance"],
            "damage class":bs["damage_class"]["name"],
            "target":bs["target"]["name"],
            "priority":bs["priority"],
            "type":bs["type"]["name"],
            "pp":bs['pp'],
            "id":bs["id"],
        }

        print(i,move)
        print()
get_moves()