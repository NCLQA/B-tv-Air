*** Settings ***
Library    AppiumLibrary
Library    Process
Library    OperatingSystem
Library    DateTime

Resource    B tv air.resource
Suite Setup    앱 실행
Test Setup    앱 종료 후 재진입


*** Test Cases ***

Firmware Ver. 확인
    #1. 앱 실행 > "MY" > "설정" 진입    /    1. 버전 정보가 ex)2.0.5(127) 형식과 일치 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="MY"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/icSetting    
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="도움말 및 버전 정보"]
    FOR  ${i}  IN RANGE    0    3    #버전 정보 노출시점까지 스크롤
        Swipe By Percent    50    90    50    10
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    com.skb.smartrc.air:id/settings_app_version
        Exit For Loop If    ${pass}
    END
    ${version}    Get Text    com.skb.smartrc.air:id/settings_app_version
    Should Match Regexp    ${version}    ^\\d\\.\\d\\.\\d\\(\\d+\\)$ 

검색 및 검색결과 동작 확인
    #1. 앱 실행 > "검색" > 검색어 입력    /    1. 검색결과 문구 및 VOD, 회차, 코너, 실시간 채널, 인물 블록 노출 확인
    #2. Top 버튼 선택    /    2. Top 버튼 페이지 내 미 존재 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/icSearch
    Sleep    1
    Wait Until Element Is Visible    com.skb.smartrc.air:id/top_search_bar
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc.air:id/top_search_bar    바람
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '바람']
    Sleep    3

    ${text}    Get Text    com.skb.smartrc.air:id/search_result_title
    Should Match Regexp    ${text}    ^바람에 대한\n검색결과가 \\d+건 있습니다.$


    ${vod}    Get Text    Xpath=//hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.FrameLayout/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.FrameLayout/android.view.ViewGroup[2]/android.view.ViewGroup[2]/androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[1]/android.view.ViewGroup/android.widget.TextView[1]
    Should Match Regexp    ${vod}    ^VOD \\d+$
    
    ${회차}    Get Text    Xpath=//hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.FrameLayout/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.FrameLayout/android.view.ViewGroup[2]/android.view.ViewGroup[2]/androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[2]/android.view.ViewGroup/android.widget.TextView[1]
    Should Match Regexp    ${회차}    ^회차 \\d+$

    FOR  ${i}  IN RANGE    0    10    #코너 블록 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.FrameLayout/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.FrameLayout/android.view.ViewGroup[2]/android.view.ViewGroup[2]/androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[3]/android.view.ViewGroup/android.widget.TextView[1]
        Exit For Loop If    ${pass}
    END
    ${코너}    Get Text    Xpath=//hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.FrameLayout/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.FrameLayout/android.view.ViewGroup[2]/android.view.ViewGroup[2]/androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[3]/android.view.ViewGroup/android.widget.TextView[1]
    Should Match Regexp    ${코너}    ^코너 \\d+$

    FOR  ${i}  IN RANGE    0    10    #실시간 채널 블록 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.FrameLayout/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.FrameLayout/android.view.ViewGroup[2]/android.view.ViewGroup[2]/androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[4]/android.view.ViewGroup/android.widget.TextView[1]
        Exit For Loop If    ${pass}
    END
    ${실시간채널}    Get Text    Xpath=//hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.FrameLayout/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.FrameLayout/android.view.ViewGroup[2]/android.view.ViewGroup[2]/androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[4]/android.view.ViewGroup/android.widget.TextView[1]
    Should Match Regexp    ${실시간채널}    ^실시간 채널 \\d+$

    FOR  ${i}  IN RANGE    0    10    #인물 블록 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.FrameLayout/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.FrameLayout/android.view.ViewGroup[2]/android.view.ViewGroup[2]/androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[5]/android.view.ViewGroup/android.widget.TextView
        Exit For Loop If    ${pass}
    END
    ${인물}    Get Text    Xpath=//hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.FrameLayout/android.widget.RelativeLayout/android.view.ViewGroup/android.widget.FrameLayout/android.view.ViewGroup[2]/android.view.ViewGroup[2]/androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[5]/android.view.ViewGroup/android.widget.TextView
    Should Match Regexp    ${인물}    ^인물 \\d+$

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/go_to_top
    Sleep    2        
    Page Should Not Contain Element    com.skb.smartrc.air:id/go_to_top

VOD 월정액 콘텐츠 재생 시 LGS 로그의 ppm_ids 정보 확인
    #0. CJ ENM 가입 / 검증 콘텐츠 <아라문의 검>
    #1. 앱 실행 > "검색" > 가입된 월정액에 포함된 콘텐츠 검색 > 재생    /    1. ppm_ids 로그 전송 시 pass  

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/icSearch
    Sleep    1
    Wait Until Element Is Visible    com.skb.smartrc.air:id/top_search_bar
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc.air:id/top_search_bar    아라문의검
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '아라문의 검']
    Sleep    3
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="아라문의 검"]/android.view.ViewGroup/android.widget.ImageView[1]
    Sleep    10
    ${log}    Run Process    adb shell logcat -t 50000 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    "ppm_ids":"1649234"

VOD 재생 > LGS 로그의 pid 정보 확인
    #0. OCEAN 미 가입 / ppv <드림> 구매 상태
    #1. 앱 실행 > "검색" > 미가입 월정액에 포함된 콘텐츠 검색 > 재생    /    1. pid 로그 전송 시 pass  

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/icSearch
    Sleep    1
    Wait Until Element Is Visible    com.skb.smartrc.air:id/top_search_bar
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc.air:id/top_search_bar    드림
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '드림']
    Sleep    3
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="드림"]/android.view.ViewGroup/android.widget.ImageView[1]
    Sleep    10
    ${log}    Run Process    adb shell logcat -t 50000 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    "pid":"413252574"
    Should Contain    ${String}    "ppm_ids":""

패키지 게이트웨이 진입 확인
    #0. 검증 콘텐츠 : 미구매 패키지 <트랜스포머 전편 소장 패키지>, 구매 패키지 <엘리멘탈 자막+더빙 소장 패키지>
    #1. 앱 실행 > "카테고리" > "영화/시리즈" > "할인&패키지" 진입
    #2. 미구매 패키지 <트랜스포머 전편 소장 패키지> 진입    /    2. 구매버튼 노출 확인
    #3. 뒤로가기
    #4. 구매 패키지 <엘리멘탈 자막+더빙 소장 패키지> 진입    /    4. 구매버튼 미 노출 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '카테고리']
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '영화/시리즈']
    Sleep    3
    FOR  ${i}  IN RANGE    0    5    #할인&패키지 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.view.ViewGroup[@content-desc="할인 & 패키지"]/android.widget.ImageView
        Exit For Loop If    ${pass}
    END
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="할인 & 패키지"]/android.widget.ImageView
    Sleep    2

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="트랜스포머 전편 소장 패키지"]
    Wait Until Element Is Visible    com.skb.smartrc.air:id/btn_purchase
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/iv_back
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="엘리멘탈 자막+더빙 소장 패키지"]
    Sleep    3
    Page Should Not Contain Element    com.skb.smartrc.air:id/btn_purchase

무료 VOD 재생 확인
    #0. 검증 콘텐츠 <고스트 라이더>
    #1. 앱 실행 > "검색" > 무료 콘텐츠 검색 후 진입    /    1. 재생 로그 전송 및 '무료 시청 가능' 문구 노출 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/icSearch
    Sleep    1
    Wait Until Element Is Visible    com.skb.smartrc.air:id/top_search_bar
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc.air:id/top_search_bar    고스트 라이더
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '고스트 라이더']
    Sleep    3
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="고스트 라이더"]/android.view.ViewGroup/android.widget.ImageView
    Sleep    35
    ${log}    Run Process    adb shell logcat -t 100000 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    "event_type":"3"
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text = '무료 시청 가능']

홈 호출 반복 간 화면 이상유무 확인
    #1. 앱 실행 > half player 진입 > 뒤로가기 10회 반복    /    1. 채널 GNB와, half player 진입 시 채널 정보와 프로그램 정보 노출 시 pass

    FOR  ${i}  IN RANGE    0    10
        Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text= '채널']
        Sleep    1
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/player_ui_component
        Sleep    1
        Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc.air:id/live_detail_epg_channel_info    #채널 정보
        Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc.air:id/view    #프로그램 정보
        Wait Until Keyword Succeeds    1 min    3 sec    Press Keycode    4    #뒤로가기
    END
    
예고편, 미리보기 동작 확인
    #0. 검증 콘텐츠 <타겟> 미구매 상태
    #1. 앱 실행 > "검색" > 미구매 콘텐츠 검색 > 재생    /    1. 미리보기 로그(processPreviewStart) 출력 확인

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/icSearch
    Sleep    1
    Wait Until Element Is Visible    com.skb.smartrc.air:id/top_search_bar
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc.air:id/top_search_bar    타겟
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '타겟']
    Sleep    3
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="타겟"]/android.view.ViewGroup/android.widget.ImageView
    Sleep    5
    ${log}    Run Process    adb shell logcat -t 100000 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    processPreviewStart

가입된 월정액 VOD 재생 확인
    #0. CJ ENM 가입 / 검증 콘텐츠 <유퀴즈 온 더 블럭>
    #1. 앱 실행 > "검색" > 가입된 월정액에 포함된 콘텐츠 검색 > 재생    /    1. 본편 재생 로그("event_type":"3") 출력 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/icSearch
    Sleep    1
    Wait Until Element Is Visible    com.skb.smartrc.air:id/top_search_bar
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc.air:id/top_search_bar    유퀴즈 온 더 블럭
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '유 퀴즈 온 더 블럭']
    Sleep    3
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="유 퀴즈 온 더 블럭"]/android.view.ViewGroup/android.widget.ImageView[1]
    Sleep    5
    ${log}    Run Process    adb shell logcat -t 7000 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    "event_type":"3"
    
성인 인증 번호 동작 확인
    #1. 앱 실행 > "MY" > "설정" 진입 > 시청 연령 제한 설정 ON    
    #2. "VOD" > "검색" > 19세 콘텐츠 검색 > 콘텐츠 선택
    #3. 인증번호 오입력(0000)    /    3. '인증 번호가 일치하지 않습니다.' 문구 노출 확인
    #4. 인증번호 정상입력(1111)    /    4. 정상 인증 및 VOD 재생 로그 출력 시 pass
    #5. "채널" > 하단 스크롤 > 성인 채널 진입
    #6. 인증번호 오입력(0000)    /    6. '비밀번호를 재확인 해주세요.' 문구 노출 확인
    #7. 인증번호 정상입력(1111)    /    7. 정상 인증 및 프로그램명 '제목없음' 노출 시 pass
    
    #19세 VOD
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="MY"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/icSetting
    Sleep    1
    ${Check}    Get Element Attribute    com.skb.smartrc.air:id/settings_auth_adult_auth_chk    Checked       
    IF    '${Check}' == 'false'   
        Click Element    com.skb.smartrc.air:id/settings_auth_adult_auth_chk
        비밀번호 입력 (1111)
        Sleep    1
        Click Element    com.skb.smartrc.air:id/btn_right
    ELSE IF    '${Check}' == 'true'
        log     pass
    END
    Sleep    1

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = 'VOD']
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/icSearch
    Sleep    1
    Wait Until Element Is Visible    com.skb.smartrc.air:id/top_search_bar
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc.air:id/top_search_bar    사탄의 인형
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '사탄의 인형']
    Sleep    3
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="사탄의 인형 4: 처키의 신부"]/android.view.ViewGroup/android.widget.ImageView[1]
    Sleep    1
    비밀번호 입력 (0000)    #비밀번호 오입력
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Element Text Should Be    com.skb.smartrc.air:id/dialog_password_error    인증 번호가 일치하지 않습니다.
    Click Element    Xpath=//hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.LinearLayout/android.widget.RelativeLayout/android.widget.LinearLayout    #비밀번호 입력 필드
    Run Process    adb logcat -c    shell=True    #이전 로그파일 삭제
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    비밀번호 입력 (1111)
    Sleep    7
    ${log}    Run Process    adb shell logcat -t 10000 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    play_start
    Sleep    1
    
    #19세 채널
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '채널']
    Sleep    3
    FOR  ${i}  IN RANGE    0    5    #성인채널 블록 노출시점까지 스크롤
        Swipe By Percent    50    90    50    10
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text = '청소년 보호 프로그램']
        Exit For Loop If    ${pass}
    END
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '플레이보이TV']
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/rating_password_edittext
    Sleep    1
    FOR    ${I}    IN RANGE    0    4    #비밀번호 오입력(0000)
        Sleep    1
        Press Keycode    7
    END
    Sleep    2
    Element Text Should Be    com.skb.smartrc.air:id/rating_err_msg_textview    비밀번호를 재확인 해주세요.
    Sleep    1
    FOR    ${I}    IN RANGE    0    4    #비밀번호 정상입력(1111)
        Sleep    1
        Press Keycode    8
    END
    Sleep    3
    Element Should Be Visible    Xpath=//android.widget.TextView[@text = '제목없음']

성인 인증 번호 변경 후 동작 확인
    #1. 앱 실행 > "MY" > "설정" 진입 > 성인 인증번호(0000) 변경 및 시청 연령 제한 설정 ON
    #2. "VOD" > "검색" > 19세 콘텐츠 검색 > 콘텐츠 선택
    #3. 인증번호 오입력(1111)    /    3. '인증 번호가 일치하지 않습니다.' 문구 노출 확인
    #4. 인증번호 정상입력(0000)    /    4. 정상 인증 및 VOD 재생 로그 출력 시 pass
    #5. "채널" > 하단 스크롤 > 성인 채널 진입
    #6. 인증번호 오입력(1111)    /    6. '비밀번호를 재확인 해주세요.' 문구 노출 확인
    #7. 인증번호 정상입력(0000)    /    7. 정상 인증 및 프로그램명 '제목없음' 노출 시 pass
    #8. "MY" > "설정" 진입 > 성인 인증번호 디폴트로 재 변경(1111)

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="MY"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/icSetting
    Sleep    1
    Click Element    com.skb.smartrc.air:id/settings_auth_adult_change_btn
    Sleep    1
    비밀번호 입력 (1111)
    Sleep    1
    FOR    ${I}    IN RANGE    0    4    #새로운 성인 인증번호 입력(0000)
        Sleep    1
        Press Keycode    7
    END
    Sleep    1
    FOR    ${I}    IN RANGE    0    4    #새로운 성인 인증번호 확인 입력(0000)
        Sleep    1
        Press Keycode    7
    END
    Sleep    1
    Click Element    com.skb.smartrc.air:id/password_change_ok_btn
    Sleep    1
    Click Element    com.skb.smartrc.air:id/btn_right
    Sleep    1
    ${Check}    Get Element Attribute    com.skb.smartrc.air:id/settings_auth_adult_auth_chk    Checked       
    IF    '${Check}' == 'false'   
        Click Element    com.skb.smartrc.air:id/settings_auth_adult_auth_chk
        비밀번호 입력 (0000)
        Sleep    1
        Click Element    com.skb.smartrc.air:id/btn_right
    ELSE IF    '${Check}' == 'true'
        log     pass
    END
    Sleep    1
    
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = 'VOD']
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/icSearch
    Sleep    1
    Wait Until Element Is Visible    com.skb.smartrc.air:id/top_search_bar
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc.air:id/top_search_bar    사탄의 인형
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '사탄의 인형']
    Sleep    3
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="사탄의 인형 4: 처키의 신부"]/android.view.ViewGroup/android.widget.ImageView[1]
    Sleep    1
    비밀번호 입력 (1111)    #비밀번호 오입력
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Element Text Should Be    com.skb.smartrc.air:id/dialog_password_error    인증 번호가 일치하지 않습니다.
    Click Element    Xpath=//hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.LinearLayout/android.widget.RelativeLayout/android.widget.LinearLayout    #비밀번호 입력 필드
    Run Process    adb logcat -c    shell=True    #이전 로그파일 삭제
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    비밀번호 입력 (0000)    #비밀번호 정상입력
    Sleep    7
    ${log}    Run Process    adb shell logcat -t 10000 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    play_start
    Sleep    1
    
    #19세 채널
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '채널']
    Sleep    3
    FOR  ${i}  IN RANGE    0    5    #성인채널 블록 노출시점까지 스크롤
        Swipe By Percent    50    90    50    10
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text = '청소년 보호 프로그램']
        Exit For Loop If    ${pass}
    END
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '플레이보이TV']
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/rating_password_edittext
    Sleep    1
    FOR    ${I}    IN RANGE    0    4    #비밀번호 오입력(1111)
        Sleep    1
        Press Keycode    8
    END
    Sleep    2
    Element Text Should Be    com.skb.smartrc.air:id/rating_err_msg_textview    비밀번호를 재확인 해주세요.
    Sleep    1
    FOR    ${I}    IN RANGE    0    4    #비밀번호 정상입력(0000)
        Sleep    1
        Press Keycode    7
    END
    Sleep    3
    Element Should Be Visible    Xpath=//android.widget.TextView[@text = '제목없음']
    Sleep    1
    
    #비밀번호 디폴트로 재 변경(1111)
    Press Keycode    4
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="MY"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/icSetting
    Sleep    1
    Click Element    com.skb.smartrc.air:id/settings_auth_adult_change_btn
    Sleep    1
    비밀번호 입력 (0000)
    Sleep    1
    FOR    ${I}    IN RANGE    0    4    #새로운 성인 인증번호 입력(1111)
        Sleep    1
        Press Keycode    8
    END
    Sleep    1
    FOR    ${I}    IN RANGE    0    4    #새로운 성인 인증번호 확인 입력(1111)
        Sleep    1
        Press Keycode    8
    END
    Sleep    1
    Click Element    com.skb.smartrc.air:id/password_change_ok_btn

T커머스 채널 내 서비스 이용
    #1. 앱 실행 > half player > DCA > 17번(SK 스토아) 입력 및 진입    /    1. L바 노출 확인
    #2. 화면 탭    /    2. L바 미 노출 확인
    #3. 타 채널(18번) 진입 후 17번(SK 스토아) 재 진입    /    3. L바 재 노출 확인 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/player_ui_component
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/live_detail_btn_dca    #DCA
    Sleep    2
    Click Element    com.skb.smartrc.air:id/dialog_dca_btn_1
    Sleep    1
    Click Element    com.skb.smartrc.air:id/dialog_dca_btn_7
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/view_dialog_dca_channel_logo
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Element Should Be Visible    com.skb.smartrc.air:id/commerce_launch_button    #L바 내 바로가기 버튼 노출 확인
    Click Element    com.skb.smartrc.air:id/player_ui_component    #화면 탭
    Sleep    3
    Page Should Not Contain Element    com.skb.smartrc.air:id/commerce_launch_button    #L바 미 노출 확인

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/live_detail_btn_dca    #DCA
    Sleep    2
    Click Element    com.skb.smartrc.air:id/dialog_dca_btn_1
    Sleep    1
    Click Element    com.skb.smartrc.air:id/dialog_dca_btn_8
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/view_dialog_dca_channel_logo
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/live_detail_btn_dca    #DCA
    Sleep    2
    Click Element    com.skb.smartrc.air:id/dialog_dca_btn_1
    Sleep    1
    Click Element    com.skb.smartrc.air:id/dialog_dca_btn_7
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/view_dialog_dca_channel_logo
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Element Should Be Visible    com.skb.smartrc.air:id/commerce_launch_button    #L바 내 바로가기 버튼 재노출 확인
