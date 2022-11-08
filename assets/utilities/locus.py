import pyautogui as ptg
from time import sleep

def locateCenterScreen(file: str,infinity: bool = True) -> tuple[int,int]:
    while True:
        try:
            x,y = ptg.locateCenterOnScreen(file)
            if not (infinity or x != None and y != None):
                break
        except:
            pass
    return (x,y)

def clickImgScreen(file: str, infinity: bool = True) -> tuple[int,int]:
    x,y = locateCenterScreen(file,infinity)
    return (x,y)

def listClickScreen(imgs: list[str], infinity: bool = True, clicks: bool = True) -> list[list[int,int]]:
    cords = [clickImgScreen(i,infinity) if clicks else locateCenterScreen(i,infinity) for i in imgs]
    return cords

def sequentialPosClick(positions: list[list[int,int]],button,interval) -> bool:
    for i in positions:
        ptg.click(i,button=button)
        sleep(interval)
    return True

def sequentialPosClickTimed(positions: list[list[int,int]],button,intervals: list) -> bool:
    for i,j in zip(positions,intervals):
        ptg.click(i,button=button)
        sleep(j)
    return True

