*** Settings ***
Documentation     Read Message
Suite Setup       Add Needed Image Path
Test Setup        startWA
Test Teardown     closeWA
Library           SikuliLibrary
Library           String
Library           Collections
Library           Offpyautogui

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
${inspectionMarkX}    -70
${inspectionMarkY}    0
${nextPageX}      0
${nextPageY}      -570
${DLVselectCartX}    50
${DLVselectCartY}    690
${DLVabelFirstCartX}    0
${DLVabelFirstCartY}    80
${DLVfirstCartX}    0
${DLVfirstCartY}    500
${DLVarriveAtCustomerX}    -300
${DLVarriveAtCustomerY}    450
${DLVstartServiceX}    -155
${DLVstartServiceY}    450
${DLVendServiceX}    -155
${DLVendServiceY}    620
${DLVdepartFromCustomerX}    -300
${DLVdepartFromCustomerY}    620
${old-completedX}    -250
${old-completedY}    680
${WFH_completedX}    -190
${WFH_completedY}    540
${CartManualConfirmX}    40
${CartManualConfirmY}    80
${buttonBackShX}    111
@{menuActivities}    menuGateCrossing    menuBreak    menuMeal    menuWaiting    menuMechanicalInspection    menuRefueling    menuBreakdown    menuGarage    menuYardWork    menuContainerDropOff    menuAdministrative
@{exMX}           -200    0    -200    0    -200    0    -200
@{exMY}           350    350    450    450    520    520    610
&{tName}          WAworkflow=StopsExecute    Extra=StopsExtra    Exception=StopsException
&{WAworkflow}     WeightKG=clickExecute    headerAuditingYellowOnBlue=clickExecuteAUD    headerDeliveryYellow=clickExecuteDLV
&{NotOut}         WeightKG=clickNotOut    headerAuditingYellowOnBlue=clickNotOut    headerDeliveryYellow=clickNotOut
&{buttonRoffBbackX}    WAworkflow=100    NotOut=250    Exceptions=370




*** Test Cases ***
AcloseRoute
    StartRoute
    closeRoute

WAworkflow
    StartRoute
    selectCalls
    selectSequenceList
    selectManualConfirm
    copyWADictionary
    StopsExecute

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

SendMessage
    StartRoute
    selectSendMessage
    SendMessageScreen

NotOut
    StartRoute
    selectCalls
    selectSequenceList
    selectManualConfirm
    copyNotOutDictionary
    StopsExecute

ZcloseRoute
    StartRoute
    closeRoute

tmpTest
    LogTestName

ReadMesageRoutLess
    LogonDriver
    clickEnvelope
    ReadMessages
    FinishMainMenu

*** Keywords ***
OLDNotOut
    StartRoute
    selectCalls
    selectManualConfirm
    StopsNotOut

tmpNameTest
    LogTestName

generateSignature
    Click    signatureStart
    Drag And Drop    signatureStart    signatureEnd

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

SendMessageScreen
        Log    SendMessageScreen
        Wait For Image    headerSendMessage    \    ${LoadTime}
        Click    Cart    ${messageNoteX}    ${messageNoteY}
        Press Special Key    DOWN
        Click    headerSendMessage
        Click    buttonSendMessage

ReadMessages
        Log    ${EOM}
        Click    buttonPrevious
        Click    buttonNext
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
        ${existbuttonExceptionSelect}    Exists    buttonExceptionSelect    ${wait5}
        IF    ${existbuttonExceptionSelect}
            Log    buttonExceptionSelect
            Click    buttonExceptionSelect
    #
            ${existsbuttonAuditException}    Exists    buttonAuditException    ${wait5}
            IF    ${existsbuttonAuditException}
    # provide W-L-H
                ${exI}    Evaluate    9
                Click    Cart    ${WaudX}    ${WLHaudY}
                clickKbd    ${exI}
                Click    buttonKbdDone
                Click    Cart    ${LaudX}    ${WLHaudY}
                clickKbd    ${exI}
                Click    buttonKbdDone
                Click    Cart    ${HaudX}    ${WLHaudY}
                clickKbd    ${exI}
                Click    buttonKbdDone
                Click    buttonAuditException
            END
    #
            clickExtra    ${countExtra}
            CONTINUE
        END
        IF    ${existstagWeightKG}
            clickExtra    ${countExtra}
            CONTINUE
        END
        IF    ${existslabelSIZEselected}
            clickExtra    ${countExtra}
            CONTINUE
        END
        ${existsbuttonExceptionSelect}    Exists    buttonExceptionSelect    ${wait5}
        IF    ${existsbuttonExceptionSelect}
            Click    buttonExceptionSelect
            ${existsbuttonAuditException}    Exists    buttonAuditException    ${wait5}
            IF    ${existsbuttonAuditException}
    # provide W-L-H
                ${exI}    Evaluate    6
                Click    Cart    ${WaudX}    ${WLHaudY}
                clickKbd    ${exI}
                Click    buttonKbdDone
                Click    Cart    ${LaudX}    ${WLHaudY}
                clickKbd    ${exI}
                Click    buttonKbdDone
                Click    Cart    ${HaudX}    ${WLHaudY}
                clickKbd    ${exI}
                Click    buttonKbdDone
                Click    buttonAuditException
            END
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
                ${tmp}    Evaluate    1
                Click    Cart    ${WaudX}    ${WLHaudY}
                clickKbd    ${tmp}
                Click    buttonKbdDone
                Click    Cart    ${LaudX}    ${WLHaudY}
                clickKbd    ${tmp}
                Click    buttonKbdDone
                Click    Cart    ${HaudX}    ${WLHaudY}
                clickKbd    ${tmp}
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
    Log    clickException
        ${existsbuttonException}    Exists    buttonException    ${wait5}
        ${existsbuttonExceptionSelect}    Exists    buttonExceptionSelect    ${wait5}
        IF    ${existsbuttonException}
            Click    buttonException
        ELSE IF    ${existsbuttonExceptionSelect}
            Click    buttonExceptionSelect
            ${existsbuttonAuditException}    Exists    buttonAuditException    ${wait5}
            IF    ${existsbuttonAuditException}
    # provide W-L-H
                ${exI}    Evaluate    6
                Click    Cart    ${WaudX}    ${WLHaudY}
                clickKbd    ${exI}
                Click    buttonKbdDone
                Click    Cart    ${LaudX}    ${WLHaudY}
                clickKbd    ${exI}
                Click    buttonKbdDone
                Click    Cart    ${HaudX}    ${WLHaudY}
                clickKbd    ${exI}
                Click    buttonKbdDone
                Click    buttonAuditException
            END
        END
    #Click    Cart    ${exceptionX}    ${exceptionY}
        ${existsbuttonExceptionCallNote}    Exists    buttonExceptionCallNote    ${wait5}
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

prowideAUDwlh
    Log    provide Audit W-L-H
    WHILE    True
        ${existsauditingEmptyMeasurementField}    Exists    auditingEmptyMeasurementField
        IF    ${existsauditingEmptyMeasurementField}
            ${measurement}    Generate Random String    2    [NUMBERS]
            Click    auditingEmptyMeasurementField
            Wait For Image    buttonKbdDone    \    ${wait15}
            Click    buttonKbdDone
            Paste text    \    ${measurement}
        ELSE
            BREAK
        END
    END

tmpTMP
        WHILE    True
            ${existsheaderAuditingYellowOnBlue}    Exists    headerAuditingYellowOnBlue    ${wait5}
            IF    ${existsheaderAuditingYellowOnBlue}==True
                Log    AUDit
                clickExecuteAUD
                CONTINUE
            END
    #
            ${existsheaderDeliveryYellow}    Exists    headerDeliveryYellow    ${wait5}
            IF    ${existsheaderDeliveryYellow}
                Log    Delivery
                clickExecuteDLV
                CONTINUE
            END
    #
            ${existstagWeightKG}    Exists    tagWeightKG    ${wait15}
            IF    ${existstagWeightKG}
                ${counterStops}    Evaluate    ${counterStops}+1
                ${kbdTMP}    Evaluate    ${counterStops} % 10
                Log Many    ${counterStops}    ${kbdTMP}    tagWeightKG
                Click    tagWeightKG
                clickKbd    ${kbdTMP}
                Click    buttonKbdDone
                clickExecute
                CONTINUE
            END
    #
            ${existslabelSIZEselected}    Exists    labelSIZEselected    ${wait5}
            IF    ${existslabelSIZEselected}
                Click    buttonManualVideo
                Click    buttonManualPhoto
                clickExecute
                CONTINUE
            END
        END

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
        prowideAUDwlh
        Click    buttonAUDconfirm
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
        IF    ${existsshortcutCloseWA10}
            Double Click    shortcutCloseWA10
        END
        ${existsshortcutCloseWA7}    Exists    shortcutCloseWA7    ${wait10}
        IF    ${existsshortcutCloseWA7}
            Double Click    shortcutCloseWA7
        END

selectActivities
    WHILE    True
        ${existsbuttonActivities}    Exists    buttonActivities    ${wait5}
        IF    ${existsbuttonActivities}
            BREAK
        END
    END
    Click    buttonActivities

ExecuteActivities
    Log    ExecuteActivities
    Click    @{menuActivities}[2:3]
    ${menuLength}    Get Length    ${menuActivities}
    FOR    ${I}    IN    @{menuActivities}
        ${menuLength}    Evaluate    ${menuLength}-1
        Click    ${I}
        Click    buttonSelect
        Comment    Gate Crossing Do Not need buttonActivityEnd
        ${existsbuttonActivities}    Exists    buttonActivities    ${wait5}
        IF    ${existsbuttonActivities}
            Log    Gate Crossing
            selectActivities
            CONTINUE
        END
        ${existsButtonActivityEnd}    Exists    buttonActivityEnd    ${wait5}
        IF    ${existsButtonActivityEnd}
            Click    buttonActivityEnd
            IF    ${menuLength}==0
                BREAK
            END
            selectActivities
            CONTINUE
        END
        ${existsheaderInspectionHistory}    Exists    headerInspectionHistory    ${wait5}
        IF    ${existsheaderInspectionHistory}
            MechanicalInspection
            WHILE    True    limit=6
                ${existsheaderInspectionHistory}    Exists    headerInspectionHistory    ${wait5}
                IF    ${existsheaderInspectionHistory}
                    Click    buttonBack
                    BREAK
                END
            END
    # \ \ \ \ \ \ \ Sleep \ \ \ ${one}
            selectActivities
            CONTINUE
        END
        ${existsheaderActivityContainerDropOff}    Exists    headerActivityContainerDropOff    ${wait5}
        IF    ${existsheaderActivityContainerDropOff}
            Log    TBD-ActivityContainerDropOff
            Click    buttonCancel
            selectActivities
            CONTINUE
        END
        IF    ${menuLength}==0
            BREAK
        END
    END

MechanicalInspection
    Log    MechanicalInspection
    Click    buttonPre-trip
    Click    buttonPost-trip
    WHILE    True
        ${existsbuttonDone}    Exists    buttonDone    ${wait5}
        IF    ${existsbuttonDone}
            BREAK
        END
    END
    WHILE    True
        Set Min Similarity    0.85
        ${existsiconRedDot}    Exists    iconRedDot    ${wait5}
        Set Min Similarity    0.6
        ${existsbuttonClearSignature}    Exists    buttonClearSignature    ${wait5}
        IF    ${existsbuttonClearSignature}
            BREAK
        END
        IF    ${existsiconRedDot}
            Log    More Tabs Exists
        END
        ${countScreenNext}    Set Variable    0
        WHILE    True
            Log    Next Screen
            singleScreen    ${countScreenNext}
            Log    ${countScreenNext}
            singleScreenPaginator
            ${existsbuttonClearSignature}    Exists    buttonClearSignature    ${wait5}
            IF    ${existsbuttonClearSignature}
                BREAK
            END
            ${countScreenNext}    Evaluate    ${countScreenNext}+1
            IF    ${countScreenNext}>6
                BREAK
            END
        END
    END
    Log    End of the tab
    Signature
    Complete
    WHILE    True
        ${existsbuttonView}    Exists    buttonView    ${wait5}
        IF    ${existsbuttonView}
            BREAK
        END
    END

Signature
    Log    Signature
    WHILE    True
        generateSignature
        BREAK
    END
    #

Complete
    Log    Complete
    Click    buttonComplete

singleScreen
    [Arguments]    ${countScreenNext}
    Log    singleScreen
    WHILE    True    # single screen
    #Sleep    ${One}
        ${existsbuttonsPassFailInspection}    Exists    buttonsPassFailInspection    ${wait5}
        IF    ${existsbuttonsPassFailInspection}
            Click    buttonsPassFailInspection    ${inspectionMarkX}
            ${countScreenNext}    Evaluate    ${countScreenNext}+1
    #Log    one check
        ELSE
            ${countScreenNext}    Set Variable    0
            BREAK
        END
    END
    Log    we done page checks few times
    #
    Return From Keyword    ${countScreenNext}

singleScreenPaginator
    Log    singleScreenPaginator
    ${countScreenNext}    Set Variable    0
    WHILE    True    # checking for next screen
        ${countScreenNext}    Evaluate    ${countScreenNext}+1
        IF    ${countScreenNext}>10
            BREAK
        END
        ${existsbuttonDown}    Exists    buttonDown    ${wait15}
        IF    ${existsbuttonDown}
    #x=input("buttonDown.png")
            Click    buttonDown
            Log    next screen
            Sleep    ${wait5}
            ${existsbuttonsPassFailInspection}    Exists    buttonsPassFailInspection    ${wait15}
            IF    ${existsbuttonsPassFailInspection}
                BREAK
            END
        END
    #
        Log    TBD DEBUG click(inspectionArea.offset(120,0))    # next \ inspection area
        Click    buttonDone    ${nextPageX}    ${nextPageY}
        ${existsbuttonsPassFailInspection}    Exists    buttonsPassFailInspection    ${wait15}
        IF    ${existsbuttonsPassFailInspection}
            BREAK
        END
    #
        Set Min Similarity    0.85
        ${existsiconRedDot}    Exists    iconRedDot    ${wait5}
        Set Min Similarity    0.6
        IF    ${existsiconRedDot}
            Click    iconRedDot
            Log    tab exists
            ${countScreenNext}    Set Variable    ${one}
            BREAK
        END
        ${existsbuttonDone}    Exists    buttonDone    ${wait5}
        IF    ${existsbuttonDone}
            Click    buttonDone
            ${countScreenNext}    Set Variable    ${LoadTime}
            BREAK
        END
    END
    Log    end of the screen
    Return From Keyword    ${countScreenNext}
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

TBD-OLD-clickExecuteDLV
    Comment    Click    Cart    ${completedX}    ${completedY}
        Wait For Image    headerDeliveryYellow    \    ${wait10}
        Click    Cart    ${DLVDLVselectCartX}    ${DLVDLVselectCartY}
        Wait For Image    labelDLVpleaseSelectCart    \    ${wait10}
        Click    Cart    ${DLVfirstCartX}    ${DLVfirstCartY}
        Wait For Image    buttonDLVarriveAtCustomer    \    ${wait10}
        Click    Cart    ${DLVarriveAtCustomerX}    ${DLVarriveAtCustomerY}
        Wait For Image    labelDLVarrived    \    ${wait10}
        Click    Cart    ${DLVstartServiceX}    ${DLVstartServiceY}
        Wait For Image    labelDLVstarted    \    ${wait10}
        Click    Cart    ${DLVendServiceX}    ${DLVendServiceY}
        Wait For Image    labelDLVended    \    ${wait10}
        Click    Cart    ${DLVdepartFromCustomerX}    ${DLVdepartFromCustomerY}
        Wait For Image    headerCallsWhite    \    ${wait15}
        selectManualConfirm

clickExecuteDLV
    Comment    Click    Cart    ${completedX}    ${completedY}
        Wait For Image    headerDeliveryYellow    \    ${wait10}
    #Click    Cart    ${DLVDLVselectCartX}    ${DLVDLVselectCartY}
        Click    buttonDLVselectCart
        Wait For Image    labelDLVpleaseSelectCart    \    ${wait10}
        Click    labelDLVpleaseSelectCart    ${DLVabelFirstCartX}    ${DLVabelFirstCartY}
        Wait For Image    buttonDLVarriveAtCustomer    \    ${wait10}
    #Click    Cart    ${DLVarriveAtCustomerX}    ${DLVarriveAtCustomerY}
        Click    buttonDLVarriveAtCustomer
        Wait For Image    labelDLVarrived    \    ${wait10}
    #Click    Cart    ${DLVstartServiceX}    ${DLVstartServiceY}
        Click    buttonDLVstartService
        Wait For Image    labelDLVstarted    \    ${wait10}
    #Click    Cart    ${DLVendServiceX}    ${DLVendServiceY}
        Click    buttonDLVendService
        Wait For Image    labelDLVended    \    ${wait10}
    #Click    Cart    ${DLVdepartFromCustomerX}    ${DLVdepartFromCustomerY}
        Click    buttonDLVdepartFromCustomer
        Wait For Image    headerCallsWhite    \    ${wait15}
        selectManualConfirm

StopsException-OLDworks
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

clickExceptionOLDworks
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

clickEnvelope
    ${existlabelEnvelopeWhite}    Exists    labelEnvelopeWhite    ${wait5}
    IF    ${existlabelEnvelopeWhite}
        Click    Cart    444    0
    END

selectSequenceList
    Log    selectSequenceList
    Wait For Image    headerCallsWhite    \    ${wait15}
    Click    Cart    -350    80

FinishMainMenu
    Click    buttonSwitchDriverRoute

UnknownAddress
    ${existsheaderUnknownAddress}    Exists    UnknownAddress    ${wait5}
    Click    buttonBack

splitTest
    ${rnd} =    Generate Random String    2    [NUMBERS]
    Log Many    ${TEST_NAME}    xohoho    ${rnd}
    ${NN}    Set Variable    tmpNameTest
    Run Keyword    ${NN}
    ${PR}    Set Variable    Programmist
    ${PRlength}=    Get Length    ${PR}
    FOR    ${I}    IN RANGE    ${PRlength}
        ${II}    Evaluate    ${I}+1
        Log    ${PR}[${I}:${II}]
    END

LogTestName
    Log    ${TEST_NAME}
    Log Many    &{WAworkflow}
    ${x} =    Get From Dictionary    ${WAworkflow}    WeightKG
    Log    ${x}
    Log    ${WAworkflow.WeightKG}
    Log Many    test2    &{tName}
    ${y}=    Get From Dictionary    ${tName}    WAworkflow
    Log    ${y}
    Log    ${tName.WAworkflow}

StopsExecute
    #&{shallow_copy}=    Copy Dictionary    ${WAworkflow}    deepcopy=False
    #${shiftX}=    Get From Dictionary    ${shallow_copy}    buttonRoffBbackX
    Log    ${TEST_NAME}
    #${buttonBackShX}    Evaluate    ${buttonRoffBbackX.TEST_NAME}
    #${buttonBackShX}    Evaluate    &{buttonRoffBbackX}[TEST_NAME]
    Log Many    ${buttonBackShX}    Programmist Durak    ${buttonRoffBbackX.WAworkflow}
    WHILE    True
    #Click    Cart    ${CartManualConfirmX}    ${CartManualConfirmY}
    ${existsassignmentButtonOK}    Exists    assignmentButtonOK    ${wait10}
            IF    ${existsassignmentButtonOK}
                Click    assignmentButtonOK
            END
            selectManualConfirm
            Wait For Image    headerCallsWhite    \    ${wait15}
            ${existslabelSIZESelected}    Exists    labelSIZESelected    ${wait10}
            IF    ${existslabelSIZESelected}
                No Operation
            ELSE
                BREAK
            END
            ${existsbuttonBack}    Exists    buttonBack    ${wait15}
            IF    ${existsbuttonBack}
                Click    buttonBack    ${buttonBackShX}    0    #Click right of button Back 100, 0
                ${existstagWeightKG}    Exists    tagWeightKG    ${wait5}
                IF    ${existstagWeightKG}
                    feelWeightKG
    #${keywordName}    Get From Dictionary    ${WAworkflow}    WeightKG
    ${keywordName}=    Get From Dictionary    ${shallow_copy}    WeightKG
    #clickExecute
                    Run Keyword    ${keywordName}
                    CONTINUE
                END
                ${existsheaderAuditingYellowOnBlue}    Exists    headerAuditingYellowOnBlue    ${wait5}
                IF    ${existsheaderAuditingYellowOnBlue}==True
                    Log    AUDit
    #${keywordName}    Set Variable    ${WAworkflow.headerAuditingYellowOnBlue}
                    ${keywordName}=    Get From Dictionary    ${shallow_copy}    headerAuditingYellowOnBlue
    #clickExecuteAUD
                    Run Keyword    ${keywordName}
                    CONTINUE
                END
    # DLR carts
    # regular stop size 96> continue, last stop to check; nothing to do
            ${existsheaderDeliveryYellow}    Exists    headerDeliveryYellow    ${wait5}
                IF    ${existsheaderDeliveryYellow}
    #${keywordName}    Set Variable    ${nameMode.headerDeliveryYellow}
                    ${keywordName}=    Get From Dictionary    ${shallow_copy}    headerDeliveryYellow
    #clickExecuteDLV
                    Run Keyword    ${keywordName}
                    CONTINUE
                END
                ClickNone
                CONTINUE
            ELSE
                BREAK
            END
        END
        Click    buttonBack

clickNone
    No Operation

feelWeightKG
    Log    feelWeightKG
    ${WeightKG}    Generate Random String    2    [NUMBERS]
    Click    tagWeightKG
    Wait For Image    buttonKbdDone    \    ${wait15}
    Click    buttonKbdDone
    Paste text    \    ${WeightKG}

copyWADictionary
    &{shallow_copy}=    Copy Dictionary    ${WAworkflow}    deepcopy=False
    ${buttonBackShX}    Evaluate    ${buttonRoffBbackX.WAworkflow}
    Set Suite Variable    ${buttonBackShX}
    Set Suite Variable    &{shallow_copy}

copyNotOutDictionary
    &{shallow_copy}=    Copy Dictionary    ${NotOut}    deepcopy=False
    ${buttonBackShX}    Evaluate    ${buttonRoffBbackX.NotOut}
    Set Suite Variable    ${buttonBackShX}
