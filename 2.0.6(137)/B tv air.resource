*** Settings ***
Library    AppiumLibrary
Library    RequestsLibrary

*** Variables ***
${deviceName}    R9WW80C9CBY    #테스트대상 단말입력
${appPackage}    com.skb.smartrc.air 
${appActivity}    com.skb.smartrc.MainContainerActivity


*** Keywords ***
앱 실행
    Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=${deviceName}    appPackage=${appPackage}    appActivity=${appActivity}    automationName=UIAutomator2    noReset=true

앱 종료 후 재진입
    Wait Until Keyword Succeeds    1 min    3 sec    Terminate Application    ${appPackage}
    Sleep    3
    Wait Until Keyword Succeeds    1 min    3 sec    Activate Application    ${appPackage}
    Sleep    5

비밀번호 입력 (1111)
    FOR    ${I}    IN RANGE    0    4
        Sleep    1
        Press Keycode    8
    END
    Sleep    1
    Click Element    com.skb.smartrc.air:id/dialog_right_button

비밀번호 입력 (0000)
    FOR    ${I}    IN RANGE    0    4
        Sleep    1
        Press Keycode    7
    END
    Sleep    1
    Click Element    com.skb.smartrc.air:id/dialog_right_button