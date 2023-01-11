*** Settings ***
Library           SikuliLibrary

*** Variables ***
${IMAGE_DIR}      C:\\Sikuli\\WasteApp\\img
${wait5}          5
${LoadTime}       66
${LiftTime}       3
${EOM}            True

*** Keywords ***
Add Needed Image Path
                                                                    ${EMPTY}
...    Add Image Path    ${IMAGE_DIR}

test
                                                                    ${EMPTY}
...    Log To Console    ${IMAGE_DIR}

startWA
                                                                    ${EMPTY}
...    SikuliLibrary.Double Click    shortcutWA10

LogonDriver
                                                                    ${EMPTY}
...    \    \    \    \    Wait For Image    buttonLogon    \    ${LoadTime}
                                                                    ${EMPTY}
...    \    \    \    \    Click    buttonLogon

selectRoute
                                                                    ${EMPTY}
...    Wait For Image    headerRouteList    \    ${LoadTime}
                                                                    ${EMPTY}
...    Click    headerRouteList    0    200
                                                                    ${EMPTY}
...    Click    buttonBlueYes

selectReadMessage
                                                                    ${EMPTY}
...    Wait For Image    buttonReadMessage    \    ${LoadTime}
                                                                    ${EMPTY}
...    Click    buttonReadMessage

Read Messages
                                                                    ${EMPTY}
...    Log    ${EOM}
                                                                    ${EMPTY}
...    WHILE    ${EOM}    limit=99
                                                                    ${EMPTY}
...    \    \    \    \    ${EOM}    Exists    bodyMessage    ${wait5}
                                                                    ${EMPTY}
...    \    \    \    \    Log    ${EOM}
                                                                    ${EMPTY}
...    \    \    \    \    IF    ${EOM}==True
                                                                    ${EMPTY}
...    \    \    \    \    \    \    \    \    Click    buttonDelete
                                                                    ${EMPTY}
...    \    \    \    \    ELSE
                                                                    ${EMPTY}
...    \    \    \    \    \    \    \    \    BREAK
                                                                    ${EMPTY}
...    \    \    \    \    END
                                                                    ${EMPTY}
...    END
                                                                    ${EMPTY}
...    ${EOM}    Set Variable    True
                                                                    ${EMPTY}
...    Log    ${EOM}
                                                                    ${EMPTY}
...    Click    buttonBack

closeWA
                                                                    ${EMPTY}
...    Wait For Image    buttonSwitchDriverRoute    \    ${wait5}
                                                                    ${EMPTY}
...    Click    buttonSwitchDriverRoute
                                                                    ${EMPTY}
...    Wait For Image    buttonSwRouteDriver    \    ${wait5}
                                                                    ${EMPTY}
...    Click    buttonSwRouteDriver
                                                                    ${EMPTY}
...    Wait For Image    buttonSwitchDriver    \    ${wait5}
                                                                    ${EMPTY}
...    Click    buttonSwitchDriver
                                                                    ${EMPTY}
...    Wait For Image    buttonDesktop    \    ${wait5}
                                                                    ${EMPTY}
...    Click    buttonDesktop
                                                                    ${EMPTY}
...    Wait For Image    buttonBlueYes    \    ${wait5}
                                                                    ${EMPTY}
...    Click    buttonBlueYes
                                                                    ${EMPTY}
...    Wait For Image    shortcutCloseWA10    \    ${wait5}
                                                                    ${EMPTY}
...    Double Click    shortcutCloseWA10
