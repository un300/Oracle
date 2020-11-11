from selenium import webdriver


path = './chrome_Driver/chromedriver.exe'
driver = webdriver.Chrome(path)
driver.get("https://instagram.com")

b = driver.find_elements_by_css_selector('div.gr27e > div.EPjEi > form.HmktE > div > div.-MzZI')



print(type(b))
print(len(b))
print(b)