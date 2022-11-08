from urllib import response
from urllib.request import Request, urlopen
from bs4 import BeautifulSoup
from selenium import webdriver
import os, requests

header = {
    "User-Agent":"Mozilla/5.0"
}

def collect_html(url: str,headers: dict = header) -> BeautifulSoup:
    response = urlopen(Request(url=url,headers=headers))
    bs = BeautifulSoup(response,"html.parser")
    return bs

def str_to_html(text: str) -> BeautifulSoup:
    html = BeautifulSoup(text)
    return html

def html_to_str(bs: BeautifulSoup) -> str:
    bs = str(bs).encode("utf-8")
    str_html = rf"{bs}"[2:-1]
    return str_html

def download_img(nome: str, url: str, path: str) -> str:
    with open(f"{path}\\{nome}","wb") as f:
        im = requests.get(url)
        f.write(im.content)
    return path + nome

def collect_hrefs(bs: BeautifulSoup) -> list[str]:
    hrefs = [i.attrs["href"] for i in bs.find_all("a")]
    return hrefs

def collect_imgs(bs: BeautifulSoup) -> dict:
    imgs = {}
    [imgs.update({i.attrs["alt"]:i.attrs["src"]}) for i in bs.find_all("img")]
    return imgs

def setup_driver(options: list[str]) -> webdriver:
    driver_opt = webdriver.ChromeOptions()
    [driver_opt.add_argument(i) for i in options]
    driver = webdriver.Chrome(options=driver_opt)
    return driver

