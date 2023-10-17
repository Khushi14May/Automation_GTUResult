*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String


*** Test Cases ***
Run Python Script from Command Prompt
    Open Browser    https://www.gturesults.in/Default.aspx?ext=archive    Chrome
    Maximize Browser Window
    # Select From List By Label    css=select[name="ddlsession"]    Winter 2022
    # Select From List By Label     css=select[id='ddlbatch']    .....BE SEM 7 - Regular (DEC 2022)
    # Input Text    css=input[id="txtenroll"]    190320107110
    # Sleep    15
    # Click Button    locator=css=input[name="btnSearch"]
    # ${result}=    Run Keyword An    Page Should Contain Element    css=span[class="Result NF"]
    TRY
        Page Should Contain Element    css=span[class="Result NF"]
    EXCEPT
        Page Should Contain Element    css=span[class="error"]
    ELSE
        Page Should Contain Element    css=span[id="lblmsg"]
    END
    # Log    ${result}[0]
