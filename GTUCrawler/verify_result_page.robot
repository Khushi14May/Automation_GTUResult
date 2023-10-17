*** Settings ***
Resource    ../Common/GTUResult_resources.robot
Suite Setup    Open The Browser
Suite Teardown    Close Browser
#author:khushi shah

*** Test Cases ***
Fetching All Results
    FOR    ${enroll_number}    IN RANGE    ${startenrolln}    ${endenrolln}  
        Select From List By Label    ${GtuSessionDropDown}    ${SessionSelection}
        Select From List By Label    ${GtuExamSelectionDropdown}    ${ExamSelection}
        Basic Actions    EnrollNo=${enroll_number}
        Crop Image Process
        Captcha Process
        ${AvaibiltyOfData}=    Get Element Count    ${DataNotFound}
        IF  ${AvaibiltyOfData}>0
            ${DataNotFoundText}=    Get Text    ${DataNotFound}
            IF    '${DataNotFoundText}'=='${DataNotFoundTxt}'
                @{Data}=    Create List    _ _    ${enroll_number}    _ _    _ _    _ _    _ _    _ _    _ _    _ _    _ _
                Enter Data Excel    list_data=@{Data}
                Continue For Loop
            END
        END
        Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
        ${StudentName}=    Get Text    locator=${DataStudentName}
        ${SeatNo}=    Get Text    locator=${DataEnrollNoNew}
        ${BranchName}=    Get Text    locator=${Branch}
        ${CurrentBacklogOfStudent}=    Get Text    locator=${CurrentBacklog}
        ${TotalBacklogOfStudent}=    Get Text    locator=${TotalBacklog}
        ${AvaibiltyOfPoints}=    Get Element Count    ${100points}
        IF  ${AvaibiltyOfPoints}>0
            ${CummilativePoints}=    Get Text    ${100points}
        ELSE
            ${CummilativePoints}=   Set Variable    _ _
        END
        ${SPIOfStudent}=    Get Text    locator=${SPI}
        ${CPIOfStudent}=    Get Text    locator=${CPI}
        ${CGPAOfStudent}=    Get Text    locator=${CGPA}   
        IF    ${CurrentBacklogOfStudent}>0
            ${ResultOfStudent}=    Set Variable    ${Fail}
        ELSE
            ${ResultOfStudent}=    Set Variable    ${Pass}
        END
        @{Data}=    Create List    ${StudentName}    ${SeatNo}    ${BranchName}    ${CPIOfStudent}    ${SPIOfStudent}    ${CGPAOfStudent}    ${CummilativePoints}    ${CurrentBacklogOfStudent}    ${TotalBacklogOfStudent}    ${ResultOfStudent}
        Enter Data Excel    list_data=${Data}
    END
    Sort Excel
    Fill Color
#    ${data}=    New Har    dataofhar
#    Stop Server
#    ${har}=    Get Har
#    Save Har    ${har}    dataofhar.har

