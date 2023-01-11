*** Settings ***
Documentation     Read Message
Suite Setup       Add Needed Image Path
Test Setup        startWA
Test Teardown     closeWA
Library           SikuliLibrary

*** Variables ***
${IMAGE_DIR_WFH}    C:\\Sikuli\\WasteApp\\WFH
${IMAGE_DIR}      C:\\Sikuli\\WasteApp\\img
${testWorkflow}    WAworkflow
${wait2}          2
${wait5}          5
${wait10}         10
${wait15}         15
${wait20}         20
${wait30}         30
${one}            1
${LoadTime}       99
${LiftTime}       3
${EOM}            True
${I}              None
${TMP}            None
${kbdTMP}         1
${disposalTMP}    0
${counterStops}    0
${kgX}            250
${kgY}            30
${wegthX}         -330
${wegthY}         690
${old-wegthX}     -330
${old-wegthY}     690
${WFH_wegthX}     -280
${WFH_wegthY}     550
${completedX}     -290
${completedY}     682
${notOutX}        -120
${notOutY}        660
${exceptionX}     30
${exceptionY}     660
${countExtra}     0
${exstraX}        0
${exstraY}        610
${messageNoteX}    0
${messageNoteY}    200
${labelWeightExtraX}    180
${exstraConfirmX}    -300
${exstraConfirmY}    610
${exceptionConfirmX}    -300
${exceptionConfirmY}    660
${exceptionAUDX}    -60
${exceptionAUDY}    660
${WaudX}          -320
${LaudX}          -150
${HaudX}          0
${WLHaudY}        540
${disposalX}      150
${confirmAuditingX}    -150
${confirmAuditingY}    680
${old-completedX}    -250
${old-completedY}    680
${WFH_completedX}    -190
${WFH_completedY}    540
@{menuActivities}    menuGateCrossing    menuBreak    menuMeal    menuWaiting    menuMechanicalInspection    menuRefueling    menuBreakdown    menuGarage    menuYardWork    menuContainerDropOff    menuAdministrative
@{exMX}           -200    0    -200    0    -200    0    -200
@{exMY}           350    350    450    450    520    520    610

*** Test Cases ***
WAworkflow
    StartRoute
    selectCalls
    selectManualConfirm
    ExecuteStops

Disposal
    StartRoute
    selectDisposal
    ExecuteDisposal

Extra
    StartRoute
    selectCalls
    selectManualConfirm
    StopsExtra

Exceptions
    StartRoute
    selectCalls
    selectManualConfirm
    StopsException

Activities
    StartRoute
    selectActivities
    ExecuteActivities

ReadMesage
    StartRoute
    selectReadMessage
    ReadMessages

SendMesage
    StartRoute
    selectSendMessage
    SendMessage

NotOut
    StartRoute
    selectCalls
    selectManualConfirm
    StopsNotOut

ZcloseRoute
    StartRoute
    closeRoute

tmpTest
    argTest

*** Keywords ***
argTest
    ${TMP}    Get Length    ${exMX}
    Log    Test
    FOR    ${I}    IN RANGE    ${TMP}
        Log Many    I    ${I}    X    ${exMX}[${I}]    Y    ${exMY}[${I}]
    END

StartRoute
    LogonDriver
    selectRoute

Add Needed Image Path
        Add Image Path    ${IMAGE_DIR}
        Log    ${IMAGE_DIR}
        Set Min Similarity    0.6

startWA
        ${is_10exists}    Exists    shortcutWA10    ${wait5}
        ${is_7exists}    Exists    shortcutWA7    ${wait5}
        WHILE    True    limit=33
            IF    ${is_10exists}
                Wait for Image    shortcutWA10    \    ${wait10}
                Double Click    shortcutWA10
                BREAK
            END
            IF    ${is_7exists}
                Wait for Image    shortcutWA7    \    ${wait10}
                Double Click    shortcutWA7
                BREAK
            END
    END

LogonDriver
    WHILE    True    limit=13
        ${existsbuttonBack}    Exists    buttonBack    ${wait5}
        IF    ${existsbuttonBack}
            Click    buttonBack
            BREAK
        END
        ${existsbuttonLogon}    Exists    buttonLogon    ${wait5}
        IF    ${existsbuttonLogon}
            Click    buttonLogon
            BREAK
        END
    END

selectRoute_fromWork
        Wait For Image    headerRouteList    \    ${wait10}
        Click    headerRouteList    0    200
        Click    headerRouteList    0    160    # WFH
        Click    buttonBlueYes

selectRoute
        Wait For Image    tagRoute    \    ${wait5}
        Click    tagRoute    0    25
        Click    buttonOK

selectReadMessage
        Wait For Image    buttonReadMessage    \    ${LoadTime}
        Click    buttonReadMessage

selectSendMessage
        Wait For Image    buttonSendMessage    \    ${LoadTime}
        Click    buttonSendMessage

SendMessage
        Log    SendMessage
        Wait For Image    headerSendMessage    \    ${LoadTime}
        Click    Cart    ${messageNoteX}    ${messageNoteY}
        Press Special Key    DOWN
        Double Click    buttonSendMessage

ReadMessages
        Log    ${EOM}
        WHILE    ${EOM}    limit=99
            ${EOM}    Exists    bodyMessage    ${wait5}
            Log    ${EOM}
            IF    ${EOM}==True
                Click    buttonDelete
            ELSE
                BREAK
            END
        END
        ${EOM}    Set Variable    True
        Log    ${EOM}
        Click    buttonBack

selectCalls
        Wait For Image    buttonCalls    \    ${wait15}
        Click    buttonCalls

selectManualConfirm
    #Wait For Image    buttonBack    \    ${wait15}
        Wait For Image    Cart    \    ${wait15}
        Click    Cart    40    80

StopsExtra
        WHILE    True
        ${countExtra}    Evaluate    ${countExtra}+1
        ${countExtra}    Evaluate    ${countExtra} % 10
        IF    ${countExtra}==0
            ${countExtra}    Set Variable    1
        END
            ${existstagWeightKG}    Exists    tagWeightKG    ${wait5}
            ${existslabelSIZEselected}    Exists    labelSIZEselected    ${wait5}
            IF    ${existstagWeightKG}==True
                clickExtra    ${countExtra}
                CONTINUE
            END
            IF    ${existslabelSIZEselected}==True
                clickExtra    ${countExtra}
                CONTINUE
            END
            BREAK
        END
        Click    buttonBack

clickExtra
        [Arguments]    ${countExtra}
        Click    Cart    ${exceptionX}    ${exceptionY}
    #Sleep    ${wait5}
    Wait For Image    buttonPicture    \    ${wait20}
    #Wait For Image    buttonBack    \    ${wait20}
        Click    Cart    ${exstraX}    ${exstraY}
        Wait For Image    labelWeightExtra    \    ${wait20}
        Click    labelWeightExtra    ${labelWeightExtraX}
        clickKbd    ${countExtra}
        Click    buttonKbdDone
        Click    labelWeightExtra
        Wait For Image    buttonConfirm    \    ${wait20}
        Click    buttonConfirm
    #Sleep    ${wait5}
    Wait For Image    buttonExceptionCallNote    \    ${wait20}
        Click    Cart    ${exstraConfirmX}    ${exstraConfirmY}
        selectManualConfirm

StopsException
        ${exLength}    Get Length    ${exMX}
        ${exI}    Set Variable    -1
        WHILE    True
            ${existstagWeightKG}    Exists    tagWeightKG    ${wait5}
            ${existslabelSIZEselected}    Exists    labelSIZEselected    ${wait5}
            ${existslabelAUD-SIZE}    Exists    labelAUD-SIZE    ${wait5}
            ${exI}    Evaluate    ${exI}+1
            ${exI}    Evaluate    ${exI} % ${exLength}
            ${exceptionTmpX}    Evaluate    ${exMX}[${exI}]
            ${exceptionTmpY}    Evaluate    ${exMY}[${exI}]
    #
            IF    ${existstagWeightKG}==True
                clickException    ${exceptionTmpX}    ${exceptionTmpY}
                CONTINUE
            END
            IF    ${existslabelSIZEselected}==True
                clickException    ${exceptionTmpX}    ${exceptionTmpY}
                CONTINUE
            END
    #
            IF    ${existslabelAUD-SIZE}==True
                Log    AUDit
                Click    Cart    ${completedX}    ${completedY}
                Wait For Image    headerAuditingYellowOnBlue    \    ${wait20}
    # provide W-L-H
                Click    Cart    ${WaudX}    ${WLHaudY}
                clickKbd    ${exI}
                Click    buttonKbdDone
                Click    Cart    ${LaudX}    ${WLHaudY}
                clickKbd    ${exI}
                Click    buttonKbdDone
                Click    Cart    ${HaudX}    ${WLHaudY}
                clickKbd    ${exI}
                Click    buttonKbdDone
                Click    Cart    ${exceptionAUDX}    ${exceptionAUDY}
                Wait For Image    buttonExceptionCallNote    \    ${wait20}
                clickException    ${exceptionTmpX}    ${exceptionTmpY}
                CONTINUE
            END
    #
            BREAK
        END
        Click    buttonBack

clickException
    [Arguments]    ${exceptionTmpX}    ${exceptionTmpY}
        Click    Cart    ${exceptionX}    ${exceptionY}
        Wait For Image    buttonExceptionCallNote    \    ${wait15}
        Click    Cart    ${exceptionTmpX}    ${exceptionTmpY}
        WHILE    True
            ${existsbuttonExceptionCallNote}    Exists    buttonExceptionCallNote    ${wait5}
            IF    ${existsbuttonExceptionCallNote}
                CONTINUE
            ELSE
                BREAK
            END
        END
        selectManualConfirm

StopsNotOut
        No Operation
        WHILE    True
            ${existstagWeightKG}    Exists    tagWeightKG    ${wait5}
            ${existslabelSIZEselected}    Exists    labelSIZEselected    ${wait5}
            IF    ${existstagWeightKG}==True
                clickNotOut
                CONTINUE
            END
            IF    ${existslabelSIZEselected}==True
                clickNotOut
                CONTINUE
            END
            BREAK
        END
        Click    buttonBack

clickNotOut
        Click    Cart    ${notOutX}    ${notOutY}
        selectManualConfirm

TBD-last-ExecuteStops
        WHILE    True
            ${existstagWeightKG}    Exists    tagWeightKG    ${wait5}
            IF    ${existstagWeightKG}==True
                Log    Weight
                Click    tagWeightKG
                Wait For Image    buttonKbdDone    \    ${wait15}
                Click    buttonKbd1
                Click    buttonKbdDone
                clickExecuteWeight
                CONTINUE
            END
    #
            ${existslabelSIZEselected}    Exists    labelSIZEselected    ${wait5}
            IF    ${existslabelSIZEselected}==True
                Log    LabelSize
                clickExecute
                CONTINUE
            END
    #
            ${existsheaderCallsWhite}    Exists    headerCallsWhite    ${wait5}
            IF    ${existsheaderCallsWhite}==True
                Log    HeaderCallsWhite
                clickExecute
                CONTINUE
            END
    #
            Log    BREAK
            BREAK
        END
        Log    ClickButtonBACK
        Click    buttonBack

ExecuteStops
        WHILE    True
    #
            ${existsheaderAuditingYellowOnBlue}    Exists    headerAuditingYellowOnBlue    ${wait5}
            IF    ${existsheaderAuditingYellowOnBlue}==True
                Log    AUDit
                clickExecuteAUD
                CONTINUE
            END
    #
            ${existstagWeightKG}    Exists    tagWeightKG    ${wait5}
            IF    ${existstagWeightKG}==True
                ${counterStops}    Evaluate    ${counterStops}+1
                ${kbdTMP}    Evaluate    ${counterStops} % 10
                Log Many    ${counterStops}    ${kbdTMP}
                Click    tagWeightKG
                clickKbd    ${kbdTMP}
                Click    buttonKbdDone
                clickExecute
                CONTINUE
            END
    #
            ${existslabelSIZEselected}    Exists    labelSIZEselected    ${wait5}
            IF    ${existslabelSIZEselected}==True
                clickExecute
                CONTINUE
            END
    #
            BREAK
        END
        Click    buttonBack

clickKbd
        [Arguments]    ${kbdTMP}
        Wait For Image    buttonKbdDone    \    ${wait15}
        Click    buttonKbdClear
        IF    ${kbdTMP} == 1    Click    buttonKbd1
        IF    ${kbdTMP}==2    Click    buttonKbd2
        IF    ${kbdTMP}==3    Click    buttonKbd3
        IF    ${kbdTMP}==4    Click    buttonKbd4
        IF    ${kbdTMP}==5    Click    buttonKbd5
        IF    ${kbdTMP}==6    Click    buttonKbd6
        IF    ${kbdTMP}==7    Click    buttonKbd7
        IF    ${kbdTMP}==8    Click    buttonKbd8
        IF    ${kbdTMP}==9    Click    buttonKbd9
        IF    ${kbdTMP}==0    Click    buttonKbd0

NoWeight-works-ExecuteStops
    ${testName}    Set Variable    ${TEST_NAME}
        WHILE    True
            ${existslabelSIZEselected}    Exists    labelSIZEselected    ${wait5}
            IF    ${existslabelSIZEselected}==True
                clickExecute
                CONTINUE
            END
    #
            ${existstagWeightKG}    Exists    tagWeightKG    ${wait5}
            IF    ${existstagWeightKG}==True
                clickExecute
                CONTINUE
            END
    #
            BREAK
        END
        Click    buttonBack

clickExecuteAUD
        Click    Cart    ${completedX}    ${completedY}
        Sleep    ${one}
        Click    Cart    ${confirmAuditingX}    ${confirmAuditingY}
        selectManualConfirm

clickExecute
        Click    Cart    ${completedX}    ${completedY}
        selectManualConfirm

clickExecuteWeight
        Click    Cart    ${completedX}    ${completedY}
        selectManualConfirm

MessedUP-clickExecute
        Click    Cart    ${completedX}    ${completedY}
        ${existsHeaderAudinting}    Exists    headerAuditingYellowOnBlue    ${wait5}
        IF    ${existsHeaderAudinting}
            Click    Cart    ${confirmAuditingX}    ${confirmAuditingY}
        END
        selectManualConfirm

closeRoute
        Log    CloseRoute
        Sleep    ${wait5}
        Wait For Image    buttonSwitchDriverRoute    \    ${wait15}
        Click    buttonSwitchDriverRoute
        ${existsButtonCloseroute}    Exists    buttonCloseroute    ${wait15}
        Click    buttonCloseroute
        selectRoute_fromWork

closeWA
        Log    CloseWA
        Sleep    ${wait5}
        Wait For Image    buttonSwitchDriverRoute    \    ${wait15}
        Click    buttonSwitchDriverRoute
        Wait For Image    buttonSwRouteDriver    \    ${wait15}
        Click    buttonSwRouteDriver
        Wait For Image    buttonSwitchDriver    \    ${wait15}
        Click    buttonSwitchDriver
        Wait For Image    buttonDesktop    \    ${wait15}
        Click    buttonDesktop
        Wait For Image    buttonBlueYes    \    ${wait15}
        Click    buttonBlueYes
        ${existsshortcutCloseWA10}    Exists    shortcutCloseWA10    ${wait10}
        ${existsshortcutCloseWA7}    Exists    shortcutCloseWA7    ${wait10}
        IF    ${existsshortcutCloseWA10}
            Double Click    shortcutCloseWA10
        ELSE
            Double Click    shortcutCloseWA7
        END

selectActivities
        Wait For Image    buttonActivities    \    ${wait10}
        Click    buttonActivities

ExecuteActivities
        Log    ExecuteActivities
        Click    @{menuActivities}[2:3]
        ${menuLength}    Get Length    ${menuActivities}
        Log    ${menuLength}
        FOR    ${I}    IN    @{menuActivities}
            ${menuLength}    Evaluate    ${menuLength}-1
            Log Many    ${menuLength}    ${I}
            Sleep    ${wait5}
            Click    ${I}
            Click    buttonSelect
            Comment    Gate Crossing Do Not need buttonActivityEnd
            ${existsbuttonActivities}    Exists    buttonActivities    ${wait5}
            IF    ${existsbuttonActivities}
                Log    Gate Crossing
                selectActivities
                CONTINUE
            END
    #
            ${existsButtonActivityEnd}    Exists    buttonActivityEnd    ${wait5}
            IF    ${existsButtonActivityEnd}
                Click    buttonActivityEnd
                IF    ${menuLength}==0
                    BREAK
                END
                selectActivities
                CONTINUE
            END
    #
            ${existsButtonBack}    Exists    buttonBack    ${wait5}
            IF    ${existsButtonBack}
                Click    buttonBack
                selectActivities
                CONTINUE
            END
    #
            IF    ${menuLength}==0
                BREAK
            END
    #selectActivities
        END
    #

TMP-activities
            ${existsButtonBack}    Exists    buttonBack    ${wait5}
            ${existsbuttonSelect}    Exists    buttonSelect    ${wait5}
            IF    ${existsButtonBack}
                Comment    Inspection History Screen Maybe
                Click    buttonBack
            END

DEBUG-09jan-ExecuteActivities
        Log    ExecuteActivities
        Click    @{menuActivities}[2:3]
        ${menuLength}    Get Length    ${menuActivities}
        Log    ${menuLength}
        FOR    ${I}    IN    @{menuActivities}
            ${menuLength}    Evaluate    ${menuLength}-1
            Log Many    ${menuLength}    ${I}
            Sleep    ${wait5}
            Click    ${I}
            Click    buttonSelect
            Comment    Gate Crossing Do Not need buttonActivityEnd
    # \ \ \ \ \ \ \ \ \ \ \ ${existsbuttonActivities} \ \ \ Exists \ \ \ buttonActivities \ \ \ ${wait5}
    # \ \ \ \ \ \ \ \ \ \ \ IF \ \ \ ${existsbuttonActivities}
    # \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Click \ \ \ buttonActivities
    #CONTINUE
    # \ \ \ \ \ \ \ \ \ \ \ END
    #
            ${existsButtonActivityEnd}    Exists    buttonActivityEnd    ${wait15}
            IF    ${existsButtonActivityEnd}
                Click    buttonActivityEnd
                CONTINUE
            END
            ${existsButtonBack}    Exists    buttonBack    ${wait5}
            ${existsbuttonSelect}    Exists    buttonSelect    ${wait5}
            IF    ${existsButtonBack}
                Comment    Inspection History Screen Maybe
    #Click    buttonBack
                Click    buttonPre-trip
                Click    buttonPost-trip
                MechanicalInspection
            END
            IF    ${menuLength}
                BREAK
            END
        selectActivities
        END
    #

MechanicalInspection
    Log    MechanicalInspection
    WHILE    True
    ${existsiconRedDot}    Exists    iconRedDot    ${wait5}
    ${existsbuttonClearSignature}    Exists    buttonClearSignature    ${wait5}
    IF    ${existsiconRedDot}
        Log    More Tabs Exists
    ELSE IF    ${existsbuttonClearSignature}
        BREAK
    END
    ${countScreenNext}    Set Variable    0
    Log    New Tab
    WHILE    True
        Log    Next Screen
        singleScreen
        singleScreenPaginator
        ${countScreenNext}    Evaluate    ${countScreenNext}+1
        IF    ${countScreenNext}>6
            BREAK
        END
    END
    END
    Log    End of the tab

singleScreen
    Log    singleScreen
    WHILE    True    # single screen
        Sleep    ${One}
        ${existsbuttonsPassFailInspection}    Exists    buttonsPassFailInspection    ${wait5}
        IF    ${existsbuttonsPassFailInspection}==False
            ${countScreenNext}    Set Variable    0
            BREAK
        END
        Log    TBD DEBUG click(find("buttonsPassFailInspection.png").offset(-70,0))
        Log    one check
    END
    Log    we done page checks few times
    #

singleScreenPaginator
    Log    singleScreenPaginator
    WHILE    True    # checking for next screen
        ${countScreenNext}    Set Variable    0
        ${existsbuttonDown}    Exists    buttonDown    ${wait5}
        IF ${existsbuttonDown}
    #x=input("buttonDown.png")
            Click    buttonDown
            Log    next screen
            Sleep    ${wait5}
            ${countScreenNext}    Evaluate    ${countScreenNext}+1
            IF    ${countScreenNext}>10
                BREAK
            END
            ${existsbuttonsPassFailInspection}    Exists    buttonsPassFailInspection    ${wait5}
            IF    ${existsbuttonsPassFailInspection}
                BREAK
            END
        END
        Log    TBD DEBUG click(inspectionArea.offset(120,0))    # next \ inspection area
        ${existsbuttonsPassFailInspection}    Exists    buttonsPassFailInspection    ${wait5}
        IF    ${existsbuttonsPassFailInspection}
                BREAK
        END
        ${existsiconRedDot}    Exists    iconRedDot    ${wait5}
        IF    ${existsiconRedDot}
            Click    iconRedDot
            Log    tab exists
            BREAK
        ELSE
            Click    buttonDone
            BREAK
        END
    END
    Log    end of the screen
    #

selectDisposal
        Wait For Image    buttonDisposal    \    ${wait15}
        Click    buttonDisposal

ExecuteDisposal
        Log    ExecuteDisposal
        ${disposalTMP}    Evaluate    ${disposalTMP}+1
        ${disposalTMP}    Evaluate    ${disposalTMP} % 10
        IF    ${disposalTMP}==0
            ${disposalTMP}    Set Variable    1
        END
        Wait For Image    buttonSelect    \    ${wait15}
        Click    buttonSelect
    #Disposal Screen
        Click    buttonArrive
    #
        Click    labelTicket    ${disposalX}
        clickKbd    ${disposalTMP}
        Click    buttonKbdDone
    #
        Click    labelQuantity    ${disposalX}
        clickKbd    ${disposalTMP}
        Click    buttonKbdDone
    # \ \ in KG removed, will continue work with metric tons
    # \ \ \ Click \ \ \ labelQuantity \ \ \ ${kgX} \ \ \ ${kgY}
    #
        Click    buttonArrive    #Depart
    #Warning pop-up
        Wait For Image    headerWarning    \    ${wait10}
        Click    buttonBlueYes

TBD-ExecuteActivities
        Log    ExecuteActivities
        Click    @{menuActivities}[2:3]
        ${menuLength}    Get Length    ${menuActivities}
        Log    ${menuLength}
        FOR    ${I}    IN    @{menuActivities}
            ${menuLength}    Evaluate    ${menuLength} - ${one}
            Log Many    ${menuLength}    ${I}
            Click    ${I}
            Click    buttonSelect
            Comment    Gate Crossing Do Not need buttonActivityEnd
            ${existsButtonActivityEnd}    Exists    buttonActivityEnd    ${wait5}
            ${existsButtonBack}    Exists    buttonBack    ${wait5}
            IF    ${existsButtonActivityEnd}==True
                Click    buttonActivityEnd
                CONTINUE
            END
            ${existsheaderInspectionHistory}    Exists    headerInspectionHistory    ${wait10}
            IF    ${existsheaderInspectionHistory}==True
                Comment    Inspection History Screen Maybe
                Click    buttonPre-trip
                ${existsheaderInspectionHistory}    Exists    headerInspectionHistory    ${wait10}
                IF    ${existsheaderInspectionHistory}
                    Log    Pre-Inspection
                    CONTINUE
                END
                Click    buttonPost-trip
                ${existsheaderInspectionHistory}    Exists    headerInspectionHistory    ${wait10}
                IF    ${existsheaderInspectionHistory}
                    Log    Post-Inspection
                    CONTINUE
                END
            END
            IF    ${menuLength}==0
                BREAK
            END
        selectActivities
        END
    #
