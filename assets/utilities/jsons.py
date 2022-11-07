import json

def save_json(js: dict, name: str) -> str:
    file = open(name,"w")
    json.dump(js,file)
    file.close()
    return name

def read_json(name: str) -> dict:
    js = open(name).read()
    js = json.loads(js)
    return js