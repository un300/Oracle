from selenium import webdriver


path = './chrome_Driver/chromedriver.exe'
driver = webdriver.Chrome(path)
driver.get("https://instagram.com")

a = driver.find_elements_by_css_selector('div.gr27e  ')
b = a.find_elements_by_css_selector('div.EPjEi')


print(type(b))
print(len(b))
print(b)