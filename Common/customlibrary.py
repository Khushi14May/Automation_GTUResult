# custom_library.py
from browsermobproxy import Server
from selenium import webdriver

def start_browsermob_proxy_and_capture_har():
    server = Server("C:/Users/158421/OneDrive - Arrow Electronics, Inc/Desktop/GTU-result-Robot/browsermob-proxy-2.1.4/bin/browsermob-proxy",options={'port': 8081})
    server.start()
    proxy = server.create_proxy()

    chrome_options = webdriver.ChromeOptions()
    proxy_address = proxy.proxy
    chrome_options.add_argument(f'--proxy-server={proxy_address}')
    driver = webdriver.Chrome(chrome_options=chrome_options)

    proxy.new_har("gtu")
    driver.get("https://www.gturesults.in/")
    har = proxy.har

    proxy.stop()
    driver.quit()

    return har