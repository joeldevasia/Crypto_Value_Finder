from selenium import webdriver
from selenium.webdriver.common.by import By

driver = webdriver.Edge(executable_path="msedgedriver.exe")
driver.get("http://www.google.com")


driver.get('https://www.saucedemo.com')
driver.find_element(By.XPATH, '//*[@id="user-name"]').send_keys('standard_user')
driver.find_element(By.XPATH, '//*[@id="password"]').send_keys('secret_sauce')

driver.find_element(By.XPATH, '//*[@id="login-button"]').click()

if driver.current_url == 'https://www.saucedemo.com/inventory.html':
    print('Login was Successful')
