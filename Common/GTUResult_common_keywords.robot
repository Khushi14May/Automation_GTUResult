*** Keywords ***
Open The Browser
#    -------simple-------------
#    Open Browser    ${gtu_url}    ${gtu_launch}
#    -------browsermob-------------
#    Start Server    C:\Users\158421\OneDrive - Arrow Electronics, Inc\Desktop\GTU-result-Robot\browsermob-proxy-py
#    ${proxy}=    Create Proxy
#
#    # Configure Selenium to use the proxy
#    ${proxy_address}=    Get Proxy
#    ${chrome_options}=    Evaluate    {'--proxy-server=' + proxy_address}
#    Open Browser    ${gtu_url}      ${gtu_launch}       chrome_options=${chrome_options}
#     -------selenium grid-------------
    Open Browser    ${gtu_url}      ${gtu_launch}       remote_url=${REMOTE_URL}
    Maximize Browser Window
    Element Should Be Visible    ${GtuLogo}

Basic Actions
    [Arguments]    ${EnrollNo}
    Input Text    ${GtuEnrollNoTxtBox}    ${EnrollNo}
    Wait Until Element Is Visible    ${GtuCaptcha}
    
Crop Image Process
    Capture Page Screenshot    filename=${input_image_path}
    ${status_image}=        Crop Image    input_path=${input_image_path}    output_path=${output_image_path}    left=${crop_left}    top=${crop_top}    right=${crop_right}    bottom=${crop_bottom}
    ${output} =    Run    cmd.exe /c ${command}
    ${value}=    Get Text From Clipboard
    Input Text    locator=${CaptchaInput}    text=${value}

Captcha Process
    ${AvaibiltyOfCaptcha}=    Get Element Count     ${IncoorectCaptcha}
    ${condition}    Set Variable    True
    WHILE  ${condition}
        Exit For Loop If    ${AvaibiltyOfCaptcha}<=0
        Crop Image Process
        ${AvaibiltyOfCaptcha}=    Get Element Count     ${IncoorectCaptcha}
    END