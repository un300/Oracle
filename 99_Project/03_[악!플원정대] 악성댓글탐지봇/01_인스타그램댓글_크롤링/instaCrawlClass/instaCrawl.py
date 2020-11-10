from selenium import webdriver
from bs4 import BeautifulSoup

import time
import pandas as pd
import numpy as pd

class InstaCrawling():
    def __init__(self):
        path = './chrome_Driver/chromedriver.exe'
        self.driver = webdriver.Chrome(path)
        self.driver.get("https://instagram.com")

    def login(self, my_ID, my_PWD):
        # 로그인입력란 패스워드입력란 찾기
        id_input_temp  = self.driver.find_elements_by_css_selector('div.gr27e > div.EPjEi > form.HmktE > div > div.-MzZI')[0]
        pwd_input_temp = self.driver.find_elements_by_css_selector('div.gr27e > div.EPjEi > form.HmktE > div > div.-MzZI')[1]

        id_input = id_input_temp.find_element_by_css_selector('div > label')
        pwd_input = pwd_input_temp.find_element_by_css_selector('div > label')

        # ID, PWD 입력
        id_input.send_keys(my_ID)
        pwd_input.send_keys(my_PWD)

        # ID, PWD 제출
        pwd_input.submit()

        time.sleep(4)

    def find_id(self, star_id):
        find_id = self.driver.find_element_by_css_selector('nav > div._8MQSO > div > div > div.LWmhU > input')
        find_id.send_keys(star_id)

        for_click = self.driver.find_element_by_css_selector('nav > div._8MQSO > div > div > div.LWmhU > div > div.drKGC > div > a')
        for_click.click()
        time.sleep(4)