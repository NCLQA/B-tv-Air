*** Settings ***
Library    AppiumLibrary
Library    Process
Library    OperatingSystem
Library    DateTime

Resource    B tv air.resource
Suite Setup    앱 실행
Test Setup    앱 종료 후 재진입


*** Test Cases ***

29432 OCEAN / 카테고리 / 무료
    #1. 앱 실행 > "OCEAN" 진입    /    1. '새로 들어온 영화' 블록 노출 확인
    #2. "카테고리" 진입    /    2. '이용꿀팁' 버튼 노출 확인
    #3. "무료" 진입    /    3. '모바일 B tv 무료영화관' 블록 노출 확인 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="OCEAN"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="새로 들어온 영화"]

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="카테고리"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="이용꿀팁"]

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="무료"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="모바일 B tv 무료영화관"]

29476 카테고리 구성 확인
    #1. 앱 실행 > "카테고리" 진입    /    1. 공개예정, TV다시보기, 영화/시리즈, ZEM, 애니메이션, LIFE+, 해피시니어, 성인, 클립 메뉴 노출 확인
    #2. 하단 이벤트 버튼 선택    /    2. 이벤트 타이틀 노출 확인
    #3. 상단 Back 버튼 선택
    #4. 하단 이용꿀팁 버튼 선택    /    4. 이용꿀팁 타이틀 노출 확인 

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="카테고리"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="공개예정"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="TV다시보기"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="영화/시리즈"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="ZEM"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="애니메이션"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="LIFE+"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="해피시니어"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="성인"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="클립"]

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="이벤트"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc.air:id/title
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/icBack

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="이용꿀팁"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="B 이용 꿀팁"]

29490 카테고리 > 공개예정 화면 확인
    #1. 앱 실행 > "카테고리" > "공개예정" 진입 후 화면 확인    /    1. 플레이어, 타이틀, 공개예정일, 줄거리 영역 노출 확인  
    #2. 상단 닫기(X) 버튼 선택    /    2. 이전 화면 노출 확인 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="카테고리"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="공개예정"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.RelativeLayout[@resource-id="com.skb.smartrc.air:id/player"]    #플레이어 영역
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.LinearLayout[@resource-id="com.skb.smartrc.air:id/title_container"]    #타이틀 영역
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.RelativeLayout[@resource-id="com.skb.smartrc.air:id/info_container"]    #공개예정일
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc.air:id/overview"]    #줄거리 영역

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageButton[@content-desc="닫기"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="이용꿀팁"]

29526 App 종료 확인
    #1. 앱 실행 > 이전 키 1회 입력    /    '앱 종료 안내' 토스트 팝업 로그(toast) 출력 및 채널 노출 유지 확인
    #2. 이전 키 2회 입력    /    앱 종료 확인

    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="채널"]
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    Press Keycode    4    #이전 키 
    Sleep    1
    ${log}    Run Process    adb logcat -d 5 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    Toast
    Sleep    1
    Page Should Contain Element    Xpath=//android.widget.TextView[@text="채널"]

    Press Keycode    4
    Press Keycode    4
    Sleep    2
    Page Should Not Contain Element    Xpath=//android.widget.TextView[@text="채널"]

29581 홈 메인 타이틀 기능 확인 (MY,ZEM키즈,검색,편성표)
    #1. 앱 실행 > 상단 "MY" 버튼 선택    /    1. MY 페이지 이동 확인
    #2. 상단 "ZEM" 버튼 선택    /    2. ZEM 페이지 이동 확인
    #3. 상단 "검색" 버튼 선택    /    3. 검색 페이지 이동 확인
    #4. 상단 "편성표" 버튼 선택    /    4. 편성표 이동 확인 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="MY"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="MY"]
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageButton[@content-desc="이전"]

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageButton[@content-desc="젬키즈"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="ZEM"]
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageButton[@content-desc="이전"]
    
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageButton[@content-desc="검색"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.EditText[@content-desc="검색어 입력"]
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageButton[@content-desc="이전"]

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageButton[@content-desc="편성표"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="편성표"]

29580 홈 메인 타이틀 상단/하단 스크롤 동작 확인_이용유도 배너 X
    #1. 앱 실행 > 하단 스크롤    /    1. 상단 메뉴바(MY) 미 노출 확인
    #2. 최상단 이동 버튼 클릭    /    2. 상단 메뉴바(MY) 노출 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.ImageView[@content-desc="MY"]
    Swipe By Percent    50    90    50    10
    Sleep    1
    Page Should Not Contain Element    Xpath=//android.widget.ImageView[@content-desc="MY"]
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="최상단 이동"]
    Wait Until Element Is Visible    Xpath=//android.widget.ImageView[@content-desc="MY"]

29628 스크롤 인터렉션
    #1. 앱 실행 > half player 진입 > 채널 목록 영역 스크롤 다운    /    1. 액션 버튼 미 노출 및 채널 Tap 영역 노출 확인
    #2. 채널 목록 영역 스크롤 업    /    2. 액션버튼/채널 Tab 영역 모두 노출 확인
    #3. Top 버튼 선택하여 최상단으로 이동    /    3. 액션버튼/채널 Tab 영역 모두 노출 확인 시 pass 
    
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text= '채널']
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/player_ui_component
    Sleep    5
    Swipe By Percent    50    80    50    20    #스크롤 다운
    Sleep    1
    Wait Until Element Is Visible    com.skb.smartrc.air:id/live_detail_tabs    #채널 탭 노출 확인
    Page Should Not Contain Element    com.skb.smartrc.air:id/live_detail_btn_dca    #액션 버튼 미 노출 확인

    Swipe By Percent    50    60    50    95    #스크롤 업
    Sleep    1
    Wait Until Element Is Visible    com.skb.smartrc.air:id/live_detail_tabs    #채널 탭 노출 확인
    Wait Until Element Is Visible    com.skb.smartrc.air:id/live_detail_btn_dca    #액션 버튼 노출 확인

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="최상단 이동"]
    Sleep    1
    Wait Until Element Is Visible    com.skb.smartrc.air:id/live_detail_tabs    #채널 탭 노출 확인
    Wait Until Element Is Visible    com.skb.smartrc.air:id/live_detail_btn_dca    #액션 버튼 노출 확인

29630 인기 채널 목록 상세 정보
    #1. 앱 실행 > half player 진입 > 인기채널 탭 선택 후 목록 상세 정보 확인    /    1. 채널로고, 번호, 프로그램명, 방영 시간 노출 확인
    #2. 선호 채널 등록    /    2. 선호 채널 등록 로그(addFavoriteChannel) 출력
    #3. 선호 채널 해제    /    3. 선호 채널 해제 로그(removeFavoriteChannel) 출력
    #4. 임의의 인기채널 선택    /    4. 선택한 채널의 채널번호와 상단 플레이어 영역의 채널번호 일치 시 pass

    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text= '채널']
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/player_ui_component
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.LinearLayout[@content-desc="인기채널"]
    Sleep    3
    Wait Until Element Is Visible    Xpath=//android.widget.ImageView[@resource-id="com.skb.smartrc.air:id/view_live_detail_item_logo_img"]    #채널로고 노출 확인
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc.air:id/view_live_detail_item_num"]    #채널번호 노출 확인
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc.air:id/view_live_detail_item_program_name"]    #프로그램명 노출 확인
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc.air:id/view_live_detail_item_program_time"]    #프로그램 시간 노출 확인

    ${time_text}=    Get Text    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc.air:id/view_live_detail_item_program_time"]
    Should Match Regexp    ${time_text}    ^\\d{2}:\\d{2}~\\d{2}:\\d{2}$    #프로그램 시간이 형식에 맞는지 확인

    #선호채널 등록 확인
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.View[@resource-id="com.skb.smartrc.air:id/view_live_detail_item_play_favorite_area"]   
    Sleep    2
    ${log}    Run Process    adb logcat -d 5 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    addFavoriteChannel

    #선호채널 해제 확인
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.View[@resource-id="com.skb.smartrc.air:id/view_live_detail_item_play_favorite_area"]    
    Sleep    2
    ${log}    Run Process    adb logcat -d 5 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    removeFavoriteChannel
    
    #인기채널 선택
    ${channel_num}=    Get Text    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc.air:id/view_live_detail_item_num"]
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc.air:id/view_live_detail_item_num"]
    Sleep    3
    ${channel_info}=    Get Text    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc.air:id/live_detail_epg_channel_info_num"]
    Should Be Equal As Strings    ${channel_num}    ${channel_info}

29648 채널 목록 영역 - 선호 채널 설정 버튼 동작 확인
    #1. 앱 실행 > half player 진입
    #2. 선호 채널 등록    /    2. 선호 채널 등록 로그(addFavoriteChannel) 출력
    #3. 선호 채널 해제    /    3. 선호 채널 해제 로그(removeFavoriteChannel) 출력 시 pass
    
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text= '채널']
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/player_ui_component

    #선호채널 등록 확인
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.View[@resource-id="com.skb.smartrc.air:id/view_live_detail_item_play_favorite_area"]   
    Sleep    2
    ${log}    Run Process    adb logcat -d 5 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    addFavoriteChannel

    #선호채널 해제 확인
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.View[@resource-id="com.skb.smartrc.air:id/view_live_detail_item_play_favorite_area"]    
    Sleep    2
    ${log}    Run Process    adb logcat -d 5 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    removeFavoriteChannel

29650 채널 목록 영역
    #1. 앱 실행 > half player 진입
    #2. 채널 영역 확인    /    2. 채널로고, 채널번호 노출 확인
    #3. 프로그램 썸네일 확인
    #4. 프로그램 정보 영역 확인    /    4. 프로그램명, 방영 시간 정보 노출 시 pass
    
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text= '채널']
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc.air:id/player_ui_component
    Sleep    3
    
    #채널 영역 확인
    Wait Until Element Is Visible    Xpath=//android.widget.ImageView[@resource-id="com.skb.smartrc.air:id/view_live_detail_item_logo_img"]    #채널로고 노출 확인
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc.air:id/view_live_detail_item_num"]    #채널번호 노출 확인

    #썸네일 확인
    Wait Until Element Is Visible    com.skb.smartrc.air:id/view_live_detail_item_stil_icon_player

    #프로그램 정보 영역 확인
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc.air:id/view_live_detail_item_program_name"]    #프로그램명 노출 확인
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc.air:id/view_live_detail_item_program_time"]    #프로그램 시간 노출 확인