*** Settings ***
Documentation     Read Message Test Setup startWA Test Teardown closeWA
Suite Setup       Add Needed Image Path
Library           SikuliLibrary
Library           String
Library           Collections
Library           Screenshot
Library           DateTime

*** Variables ***
${LibraryAutoIt}    pyautogui
${IMAGE_DIR_WFH}    C:\\Sikuli\\WasteApp\\WFH
${IMAGE_DIR}      C:\\Sikuli\\WasteApp\\img
${SCREENSHOT_DIR}    C:\\WA\\SCREENSHOT
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
${Simage}         \
${Stime}          5
${Sx}             \
${Sy}             \
${screenTrek}     0
${screenVDS}      1
@{speed}          10    60    210    180
${speedZero}      0.0
${Kmh}            Km/h
${maxWeight}      20000
${truckWeight}    9000
${disposalWeight}    \

${KG}             KG
${k}              k
${highestPrecision}    1
${regularPrecision}    0.6
${activityPrecision}    0.85
${LF}             \n
${COLON}          :
${ticketNumber}    1
${MT}             \
${unitKg}         Kg
${ticketNumber}    \



































*** Test Cases ***
setLiftArm
    openLiftArm

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
    ExecuteDisposal    ${disposalWeight}

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
    ticketNumber

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
    SikuliLibrary.Click    signatureStart
    Drag And Drop    signatureStart    signatureEnd

StartRoute
    LogonDriver
    selectRoute

Add Needed Image Path
        Add Image Path    ${IMAGE_DIR}
        Log    ${IMAGE_DIR}
        Set Min Similarity    ${regularPrecision}

startWA
        ${is_10exists}    Exists    shortcutWA10    ${wait5}
        ${is_7exists}    Exists    shortcutWA7    ${wait5}
        WHILE    True    limit=33
            IF    ${is_10exists}
                Wait for Image    shortcutWA10    \    ${wait10}
                SikuliLibrary.Double Click    shortcutWA10
                BREAK
            END
            IF    ${is_7exists}
                Wait for Image    shortcutWA7    \    ${wait10}
                SikuliLibrary.Double Click    shortcutWA7
                BREAK
            END
    END

LogonDriver
    WHILE    True    limit=13
        ${existsbuttonBack}    Exists    buttonBack    ${wait5}
        IF    ${existsbuttonBack}
            SikuliLibrary.Click    buttonBack
        END
        ${existsbuttonLogon}    Exists    buttonLogon    ${wait5}
        IF    ${existsbuttonLogon}
            SikuliLibrary.Click    buttonLogon
            BREAK
        END
    END

selectRoute_fromWork
        Wait For Image    headerRouteList    \    ${wait10}
        SikuliLibrary.Click    headerRouteList    0    200
        SikuliLibrary.Click    headerRouteList    0    160    # WFH
        SikuliLibrary.Click    buttonBlueYes

selectRoute
        Wait For Image    tagRoute    \    ${wait5}
        SikuliLibrary.Click    tagRoute    0    25
        SikuliLibrary.Click    buttonOK

selectReadMessage
        Wait For Image    buttonReadMessage    \    ${LoadTime}
        SikuliLibrary.Click    buttonReadMessage

selectSendMessage
        Wait For Image    buttonSendMessage    \    ${LoadTime}
        SikuliLibrary.Click    buttonSendMessage

SendMessageScreen
        Log    SendMessageScreen
        Wait For Image    headerSendMessage    \    ${LoadTime}
        SikuliLibrary.Click    Cart    ${messageNoteX}    ${messageNoteY}
        Press Special Key    DOWN
        SikuliLibrary.Click    headerSendMessage
        SikuliLibrary.Click    buttonSendMessage

ReadMessages
        Log    ${EOM}
        SikuliLibrary.Click    buttonPrevious
        SikuliLibrary.Click    buttonNext
        WHILE    ${EOM}    limit=99
            ${EOM}    Exists    bodyMessage    ${wait5}
            Log    ${EOM}
            IF    ${EOM}==True
                SikuliLibrary.Click    buttonDelete
            ELSE
                BREAK
            END
        END
        ${EOM}    Set Variable    True
        Log    ${EOM}
        SikuliLibrary.Click    buttonBack

selectCalls
        Wait For Image    buttonCalls    \    ${wait15}
        SikuliLibrary.Click    buttonCalls

selectManualConfirm
        Wait For Image    Cart    \    ${wait15}
        SikuliLibrary.Click    Cart    40    80

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
            SikuliLibrary.Click    buttonExceptionSelect
    #
            ${existsbuttonAuditException}    Exists    buttonAuditException    ${wait5}
            IF    ${existsbuttonAuditException}
    # provide W-L-H
                ${exI}    Evaluate    9
                SikuliLibrary.Click    Cart    ${WaudX}    ${WLHaudY}
                clickKbd    ${exI}
                SikuliLibrary.Click    buttonKbdDone
                SikuliLibrary.Click    Cart    ${LaudX}    ${WLHaudY}
                clickKbd    ${exI}
                SikuliLibrary.Click    buttonKbdDone
                SikuliLibrary.Click    Cart    ${HaudX}    ${WLHaudY}
                clickKbd    ${exI}
                SikuliLibrary.Click    buttonKbdDone
                SikuliLibrary.Click    buttonAuditException
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
            SikuliLibrary.Click    buttonExceptionSelect
            ${existsbuttonAuditException}    Exists    buttonAuditException    ${wait5}
            IF    ${existsbuttonAuditException}
    # provide W-L-H
                ${exI}    Evaluate    6
                SikuliLibrary.Click    Cart    ${WaudX}    ${WLHaudY}
                clickKbd    ${exI}
                SikuliLibrary.Click    buttonKbdDone
                SikuliLibrary.Click    Cart    ${LaudX}    ${WLHaudY}
                clickKbd    ${exI}
                SikuliLibrary.Click    buttonKbdDone
                SikuliLibrary.Click    Cart    ${HaudX}    ${WLHaudY}
                clickKbd    ${exI}
                SikuliLibrary.Click    buttonKbdDone
                SikuliLibrary.Click    buttonAuditException
            END
            clickExtra    ${countExtra}
            CONTINUE
        END
        BREAK
    END
    SikuliLibrary.Click    buttonBack

clickExtra
        [Arguments]    ${countExtra}
        SikuliLibrary.Click    Cart    ${exceptionX}    ${exceptionY}
    #BuiltIn.Sleep    ${wait5}
    Wait For Image    buttonPicture    \    ${wait20}
    #Wait For Image    buttonBack    \    ${wait20}
        SikuliLibrary.Click    Cart    ${exstraX}    ${exstraY}
        Wait For Image    labelWeightExtra    \    ${wait20}
        SikuliLibrary.Click    labelWeightExtra    ${labelWeightExtraX}
        clickKbd    ${countExtra}
        SikuliLibrary.Click    buttonKbdDone
        SikuliLibrary.Click    labelWeightExtra
        Wait For Image    buttonConfirm    \    ${wait20}
        SikuliLibrary.Click    buttonConfirm
    #BuiltIn.Sleep    ${wait5}
    Wait For Image    buttonExceptionCallNote    \    ${wait20}
        SikuliLibrary.Click    Cart    ${exstraConfirmX}    ${exstraConfirmY}
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
                SikuliLibrary.Click    Cart    ${completedX}    ${completedY}
                Wait For Image    headerAuditingYellowOnBlue    \    ${wait20}
    # provide W-L-H
                ${tmp}    Evaluate    1
                SikuliLibrary.Click    Cart    ${WaudX}    ${WLHaudY}
                clickKbd    ${tmp}
                SikuliLibrary.Click    buttonKbdDone
                SikuliLibrary.Click    Cart    ${LaudX}    ${WLHaudY}
                clickKbd    ${tmp}
                SikuliLibrary.Click    buttonKbdDone
                SikuliLibrary.Click    Cart    ${HaudX}    ${WLHaudY}
                clickKbd    ${tmp}
                SikuliLibrary.Click    buttonKbdDone
                SikuliLibrary.Click    Cart    ${exceptionAUDX}    ${exceptionAUDY}
                Wait For Image    buttonExceptionCallNote    \    ${wait20}
                clickException    ${exceptionTmpX}    ${exceptionTmpY}
                CONTINUE
            END
    #
            BREAK
        END
        SikuliLibrary.Click    buttonBack

clickException
    [Arguments]    ${exceptionTmpX}    ${exceptionTmpY}
    Log    clickException
        ${existsbuttonException}    Exists    buttonException    ${wait5}
        ${existsbuttonExceptionSelect}    Exists    buttonExceptionSelect    ${wait5}
        IF    ${existsbuttonException}
            SikuliLibrary.Click    buttonException
        ELSE IF    ${existsbuttonExceptionSelect}
            SikuliLibrary.Click    buttonExceptionSelect
            ${existsbuttonAuditException}    Exists    buttonAuditException    ${wait5}
            IF    ${existsbuttonAuditException}
    # provide W-L-H
                ${exI}    Evaluate    6
                SikuliLibrary.Click    Cart    ${WaudX}    ${WLHaudY}
                clickKbd    ${exI}
                SikuliLibrary.Click    buttonKbdDone
                SikuliLibrary.Click    Cart    ${LaudX}    ${WLHaudY}
                clickKbd    ${exI}
                SikuliLibrary.Click    buttonKbdDone
                SikuliLibrary.Click    Cart    ${HaudX}    ${WLHaudY}
                clickKbd    ${exI}
                SikuliLibrary.Click    buttonKbdDone
                SikuliLibrary.Click    buttonAuditException
            END
        END
    #SikuliLibrary.Click    Cart    ${exceptionX}    ${exceptionY}
        ${existsbuttonExceptionCallNote}    Exists    buttonExceptionCallNote    ${wait5}
        Wait For Image    buttonExceptionCallNote    \    ${wait15}
        SikuliLibrary.Click    Cart    ${exceptionTmpX}    ${exceptionTmpY}
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
        SikuliLibrary.Click    buttonBack

clickNotOut
        SikuliLibrary.Click    Cart    ${notOutX}    ${notOutY}
        selectManualConfirm

prowideAUDwlh
    Log    provide Audit W-L-H
    WHILE    True
        ${existsauditingEmptyMeasurementField}    Exists    auditingEmptyMeasurementField
        IF    ${existsauditingEmptyMeasurementField}
            ${measurement}    Generate Random String    2    [NUMBERS]
            SikuliLibrary.Click    auditingEmptyMeasurementField
            Wait For Image    buttonKbdDone    \    ${wait15}
            SikuliLibrary.Click    buttonKbdDone
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
                SikuliLibrary.Click    tagWeightKG
                clickKbd    ${kbdTMP}
                SikuliLibrary.Click    buttonKbdDone
                clickExecute
                CONTINUE
            END
    #
            ${existslabelSIZEselected}    Exists    labelSIZEselected    ${wait5}
            IF    ${existslabelSIZEselected}
                SikuliLibrary.Click    buttonManualVideo
                SikuliLibrary.Click    buttonManualPhoto
                clickExecute
                CONTINUE
            END
        END

clickKbd
        [Arguments]    ${kbdTMP}
        Wait For Image    buttonKbdDone    \    ${wait15}
        SikuliLibrary.Click    buttonKbdClear
        ${tmpLenght}=    Get Length    ${kbdTMP}
        IF    ${tmpLenght}==0    RETURN
        IF    ${kbdTMP}==1    SikuliLibrary.Click    buttonKbd1
        IF    ${kbdTMP}==2    SikuliLibrary.Click    buttonKbd2
        IF    ${kbdTMP}==3    SikuliLibrary.Click    buttonKbd3
        IF    ${kbdTMP}==4    SikuliLibrary.Click    buttonKbd4
        IF    ${kbdTMP}==5    SikuliLibrary.Click    buttonKbd5
        IF    ${kbdTMP}==6    SikuliLibrary.Click    buttonKbd6
        IF    ${kbdTMP}==7    SikuliLibrary.Click    buttonKbd7
        IF    ${kbdTMP}==8    SikuliLibrary.Click    buttonKbd8
        IF    ${kbdTMP}==9    SikuliLibrary.Click    buttonKbd9
        IF    ${kbdTMP}==0    SikuliLibrary.Click    buttonKbd0

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
        SikuliLibrary.Click    buttonBack

clickExecuteAUD
        prowideAUDwlh
        SikuliLibrary.Click    buttonAUDconfirm
        selectManualConfirm

clickExecute
        SikuliLibrary.Click    Cart    ${completedX}    ${completedY}
        selectManualConfirm

clickExecuteWeight
        SikuliLibrary.Click    Cart    ${completedX}    ${completedY}
        selectManualConfirm

MessedUP-clickExecute
        SikuliLibrary.Click    Cart    ${completedX}    ${completedY}
        ${existsHeaderAudinting}    Exists    headerAuditingYellowOnBlue    ${wait5}
        IF    ${existsHeaderAudinting}
            SikuliLibrary.Click    Cart    ${confirmAuditingX}    ${confirmAuditingY}
        END
        selectManualConfirm

closeRoute
        Log    CloseRoute
        BuiltIn.Sleep    ${wait5}
        Wait For Image    buttonSwitchDriverRoute    \    ${wait15}
        SikuliLibrary.Click    buttonSwitchDriverRoute
        ${existsButtonCloseroute}    Exists    buttonCloseroute    ${wait15}
        SikuliLibrary.Click    buttonCloseroute
        selectRoute_fromWork

closeWA
        Log    CloseWA
        BuiltIn.Sleep    ${wait5}
        Wait For Image    buttonSwitchDriverRoute    \    ${wait15}
        SikuliLibrary.Click    buttonSwitchDriverRoute
        Wait For Image    buttonSwRouteDriver    \    ${wait15}
        SikuliLibrary.Click    buttonSwRouteDriver
        Wait For Image    buttonSwitchDriver    \    ${wait15}
        SikuliLibrary.Click    buttonSwitchDriver
        Wait For Image    buttonDesktop    \    ${wait15}
        SikuliLibrary.Click    buttonDesktop
        Wait For Image    buttonBlueYes    \    ${wait15}
        SikuliLibrary.Click    buttonBlueYes
        ${existsshortcutCloseWA10}    Exists    shortcutCloseWA10    ${wait10}
        IF    ${existsshortcutCloseWA10}
            SikuliLibrary.Double Click    shortcutCloseWA10
        END
        ${existsshortcutCloseWA7}    Exists    shortcutCloseWA7    ${wait10}
        IF    ${existsshortcutCloseWA7}
            SikuliLibrary.Double Click    shortcutCloseWA7
        END

selectActivities
    WHILE    True
        ${existsbuttonActivities}    Exists    buttonActivities    ${wait5}
        IF    ${existsbuttonActivities}
            BREAK
        END
    END
    SikuliLibrary.Click    buttonActivities

ExecuteActivities
    Log    ExecuteActivities
    SikuliLibrary.Click    @{menuActivities}[2:3]
    ${menuLength}    Get Length    ${menuActivities}
    FOR    ${I}    IN    @{menuActivities}
        ${menuLength}    Evaluate    ${menuLength}-1
        SikuliLibrary.Click    ${I}
        SikuliLibrary.Click    buttonSelect
        Comment    Gate Crossing Do Not need buttonActivityEnd
        ${existsbuttonActivities}    Exists    buttonActivities    ${wait5}
        IF    ${existsbuttonActivities}
            Log    Gate Crossing
            selectActivities
            CONTINUE
        END
        ${existsButtonActivityEnd}    Exists    buttonActivityEnd    ${wait5}
        IF    ${existsButtonActivityEnd}
            SikuliLibrary.Click    buttonActivityEnd
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
                    SikuliLibrary.Click    buttonBack
                    BREAK
                END
            END
    # \ \ \ \ \ \ \ BuiltIn.Sleep \ \ \ ${one}
            selectActivities
            CONTINUE
        END
        ${existsheaderActivityContainerDropOff}    Exists    headerActivityContainerDropOff    ${wait5}
        IF    ${existsheaderActivityContainerDropOff}
            Log    TBD-ActivityContainerDropOff
            SikuliLibrary.Click    buttonCancel
            selectActivities
            CONTINUE
        END
        IF    ${menuLength}==0
            BREAK
        END
    END

MechanicalInspection
    Log    MechanicalInspection
    SikuliLibrary.Click    buttonPre-trip
    SikuliLibrary.Click    buttonPost-trip
    WHILE    True
        ${existsbuttonDone}    Exists    buttonDone    ${wait5}
        IF    ${existsbuttonDone}
            BREAK
        END
    END
    WHILE    True
        Set Min Similarity    ${activityPrecision}
        ${existsiconRedDot}    Exists    iconRedDot    ${wait5}
        Set Min Similarity    ${regularPrecision}
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
    SikuliLibrary.Click    buttonComplete

singleScreen
    [Arguments]    ${countScreenNext}
    Log    singleScreen
    WHILE    True    # single screen
    #BuiltIn.Sleep    ${One}
        ${existsbuttonsPassFailInspection}    Exists    buttonsPassFailInspection    ${wait5}
        IF    ${existsbuttonsPassFailInspection}
            SikuliLibrary.Click    buttonsPassFailInspection    ${inspectionMarkX}
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
            SikuliLibrary.Click    buttonDown
            Log    next screen
            BuiltIn.Sleep    ${wait5}
            ${existsbuttonsPassFailInspection}    Exists    buttonsPassFailInspection    ${wait15}
            IF    ${existsbuttonsPassFailInspection}
                BREAK
            END
        END
    #
        Log    TBD DEBUG SikuliLibrary.Click(inspectionArea.offset(120,0))    # next \ inspection area
        SikuliLibrary.Click    buttonDone    ${nextPageX}    ${nextPageY}
        ${existsbuttonsPassFailInspection}    Exists    buttonsPassFailInspection    ${wait15}
        IF    ${existsbuttonsPassFailInspection}
            BREAK
        END
    #
        Set Min Similarity    ${activityPrecision}
        ${existsiconRedDot}    Exists    iconRedDot    ${wait5}
        Set Min Similarity    ${regularPrecision}
        IF    ${existsiconRedDot}
            SikuliLibrary.Click    iconRedDot
            Log    tab exists
            ${countScreenNext}    Set Variable    ${one}
            BREAK
        END
        ${existsbuttonDone}    Exists    buttonDone    ${wait5}
        IF    ${existsbuttonDone}
            SikuliLibrary.Click    buttonDone
            ${countScreenNext}    Set Variable    ${LoadTime}
            BREAK
        END
    END
    Log    end of the screen
    Return From Keyword    ${countScreenNext}
    #

selectDisposal
        Wait For Image    buttonDisposal    \    ${wait15}
        SikuliLibrary.Click    buttonDisposal

ExecuteDisposal
        [Arguments]    ${disposalWeight}
        Log Many    ExecuteDisposal    ${disposalWeight}
        ${disposalTMP}    Evaluate    ${disposalTMP}+1
        ${disposalTMP}    Evaluate    ${disposalTMP} % 10
        IF    ${disposalTMP}==0
            ${disposalTMP}    Set Variable    1
        END
    WHILE    True
        ${existscityOfClovisLandfill}    Exists    cityOfClovisLandfill
        IF    ${existscityOfClovisLandfill}
                SikuliLibrary.Click    cityOfClovisLandfill
        END
        ${existsvillaYard}    Exists    villaYard
        IF    ${existsvillaYard}
                SikuliLibrary.Click    villaYard
        END
        ${existsbuttonSelect}    Exists    buttonSelect
            IF    ${existsbuttonSelect}
                SikuliLibrary.Click    buttonSelect
                BREAK
            END
    END
    Log To Console    String test for Disposal
    Log To Console    Fill the ticket fields
    ${ticketNumberTMP}=    Generate Random String    4    [NUMBERS]
    ${ticketNumber}=    Replace String    ${ticketNumberTMP}     0    ${EMPTY}    1
    #ticketNumber
    Log To Console    ${ticketNumber}
    SikuliLibrary.Click    labelTicket    ${disposalX}
    SikuliLibrary.Click    buttonKbdDone
    SikuliLibrary.Paste Text    labelTicket    ${ticketNumber}
    #disposalWeight
    #
    #bandAid !!!! can't do ${disposalWeight} replacing it with a ${ticketNumber} !!!
    ${disposalWeight}=    Evaluate    ${ticketNumber}
    #
    Log To Console    ${disposalWeight}
    SikuliLibrary.Click    labelQuantity    ${disposalX}
    SikuliLibrary.Click    buttonKbdDone
    SikuliLibrary.Paste Text    labelQuantity    ${disposalWeight}
    #
    BuiltIn.Sleep    ${wait5}
    #weightUnitKg
    SikuliLibrary.Click    ${unitKg}
        Log To Console    Second Arrive Button
        WHILE    True
            Wait For Image    buttonArrive    \    ${wait10}
            SikuliLibrary.Click    buttonArrive    #Depart button
    #Warning pop-up
            ${existsheaderWarning}    Exists    headerWarning
            IF    ${existsheaderWarning}
                Wait For Image    headerWarning    \    ${wait15}
                SikuliLibrary.Click    buttonBlueYes
                BREAK
            END
        END

TBD-OLD-clickExecuteDLV
    Comment    SikuliLibrary.Click    Cart    ${completedX}    ${completedY}
        Wait For Image    headerDeliveryYellow    \    ${wait10}
        SikuliLibrary.Click    Cart    ${DLVDLVselectCartX}    ${DLVDLVselectCartY}
        Wait For Image    labelDLVpleaseSelectCart    \    ${wait10}
        SikuliLibrary.Click    Cart    ${DLVfirstCartX}    ${DLVfirstCartY}
        Wait For Image    buttonDLVarriveAtCustomer    \    ${wait10}
        SikuliLibrary.Click    Cart    ${DLVarriveAtCustomerX}    ${DLVarriveAtCustomerY}
        Wait For Image    labelDLVarrived    \    ${wait10}
        SikuliLibrary.Click    Cart    ${DLVstartServiceX}    ${DLVstartServiceY}
        Wait For Image    labelDLVstarted    \    ${wait10}
        SikuliLibrary.Click    Cart    ${DLVendServiceX}    ${DLVendServiceY}
        Wait For Image    labelDLVended    \    ${wait10}
        SikuliLibrary.Click    Cart    ${DLVdepartFromCustomerX}    ${DLVdepartFromCustomerY}
        Wait For Image    headerCallsWhite    \    ${wait15}
        selectManualConfirm

clickExecuteDLV
    Comment    SikuliLibrary.Click    Cart    ${completedX}    ${completedY}
        Wait For Image    headerDeliveryYellow    \    ${wait10}
    #SikuliLibrary.Click    Cart    ${DLVDLVselectCartX}    ${DLVDLVselectCartY}
        SikuliLibrary.Click    buttonDLVselectCart
        Wait For Image    labelDLVpleaseSelectCart    \    ${wait10}
        SikuliLibrary.Click    labelDLVpleaseSelectCart    ${DLVabelFirstCartX}    ${DLVabelFirstCartY}
        Wait For Image    buttonDLVarriveAtCustomer    \    ${wait10}
    #SikuliLibrary.Click    Cart    ${DLVarriveAtCustomerX}    ${DLVarriveAtCustomerY}
        SikuliLibrary.Click    buttonDLVarriveAtCustomer
        Wait For Image    labelDLVarrived    \    ${wait10}
    #SikuliLibrary.Click    Cart    ${DLVstartServiceX}    ${DLVstartServiceY}
        SikuliLibrary.Click    buttonDLVstartService
        Wait For Image    labelDLVstarted    \    ${wait10}
    #SikuliLibrary.Click    Cart    ${DLVendServiceX}    ${DLVendServiceY}
        SikuliLibrary.Click    buttonDLVendService
        Wait For Image    labelDLVended    \    ${wait10}
    #SikuliLibrary.Click    Cart    ${DLVdepartFromCustomerX}    ${DLVdepartFromCustomerY}
        SikuliLibrary.Click    buttonDLVdepartFromCustomer
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
                SikuliLibrary.Click    Cart    ${completedX}    ${completedY}
                Wait For Image    headerAuditingYellowOnBlue    \    ${wait20}
    # provide W-L-H
                SikuliLibrary.Click    Cart    ${WaudX}    ${WLHaudY}
                clickKbd    ${exI}
                SikuliLibrary.Click    buttonKbdDone
                SikuliLibrary.Click    Cart    ${LaudX}    ${WLHaudY}
                clickKbd    ${exI}
                SikuliLibrary.Click    buttonKbdDone
                SikuliLibrary.Click    Cart    ${HaudX}    ${WLHaudY}
                clickKbd    ${exI}
                SikuliLibrary.Click    buttonKbdDone
                SikuliLibrary.Click    Cart    ${exceptionAUDX}    ${exceptionAUDY}
                Wait For Image    buttonExceptionCallNote    \    ${wait20}
                clickException    ${exceptionTmpX}    ${exceptionTmpY}
                CONTINUE
            END
    #
            BREAK
        END
        SikuliLibrary.Click    buttonBack

clickExceptionOLDworks
    [Arguments]    ${exceptionTmpX}    ${exceptionTmpY}
        SikuliLibrary.Click    Cart    ${exceptionX}    ${exceptionY}
        Wait For Image    buttonExceptionCallNote    \    ${wait15}
        SikuliLibrary.Click    Cart    ${exceptionTmpX}    ${exceptionTmpY}
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
        SikuliLibrary.Click    Cart    444    0
    END

selectSequenceList
    Log    selectSequenceList
    Wait For Image    headerCallsWhite    \    ${wait15}
    SikuliLibrary.Click    Cart    -350    80

FinishMainMenu
    SikuliLibrary.Click    buttonSwitchDriverRoute

UnknownAddress
    ${existsheaderUnknownAddress}    Exists    UnknownAddress    ${wait5}
    SikuliLibrary.Click    buttonBack

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
    Log    ${TEST_NAME}
    WHILE    True
        callVDS
        ManualPhoto
        ManualVideo
        ${disposalWeight}=    readWaWeight
        Log Many    disposalWeight-disposalWeight    ${disposalWeight}
    #readWaWeight
    #SikuliLibrary.Click    Cart    ${CartManualConfirmX}    ${CartManualConfirmY}
        ${existsassignmentButtonOK}    Exists    assignmentButtonOK    ${wait10}
            IF    ${existsassignmentButtonOK}
                SikuliLibrary.Click    assignmentButtonOK
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
                SikuliLibrary.Click    buttonBack    ${buttonBackShX}    0    #SikuliLibrary.Click right of button Back 100, 0
                ${existstagWeightKG}    Exists    tagWeightKG    ${wait5}
                IF    ${existstagWeightKG}
                    fillWeightKG
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
        SikuliLibrary.Click    buttonBack

clickNone
    No Operation

fillWeightKG
    Log    fillWeightKG
    ${existsButton}    Exists    buttonScaleRandom
    IF    ${existsButton}
        SikuliLibrary.Click    buttonScaleRandom
        Builtin.Sleep    ${wait2}
        RETURN
    END
    ${WeightKG}    Generate Random String    2    [NUMBERS]
    SikuliLibrary.Click    tagWeightKG
    Wait For Image    buttonKbdDone    \    ${wait15}
    SikuliLibrary.Click    buttonKbdDone
    Paste text    \    ${WeightKG}
    Builtin.Sleep    ${wait2}

copyWADictionary
    &{shallow_copy}=    Copy Dictionary    ${WAworkflow}    deepcopy=False
    ${buttonBackShX}    Evaluate    ${buttonRoffBbackX.WAworkflow}
    Set Suite Variable    ${buttonBackShX}
    Set Suite Variable    &{shallow_copy}

copyNotOutDictionary
    &{shallow_copy}=    Copy Dictionary    ${NotOut}    deepcopy=False
    ${buttonBackShX}    Evaluate    ${buttonRoffBbackX.NotOut}
    Set Suite Variable    ${buttonBackShX}

openLiftArm
    sikuliClick    Cart    140    0
    sikuliClick    tabVehicleData    0    0
    sikuliClick    buttonBack    50    -120
    sikuliClick    cellTruck674Dev    80    0
    LiftArmUpDown

sikuliClick
    [Arguments]    ${Simage}    ${Sx}    ${Sy}
    WHILE    True
            ${existsImage}    Exists    ${Simage}
        IF    ${existsImage}
            SikuliLibrary.Click    ${Simage}    ${Sx}    ${Sy}
            BREAK
        END
    END

LiftArmUpDown
    sikuliClick    labelGPI1    80    0
    BuiltIn.sleep    ${wait5}
    sikuliClick    labelGPI1    80    0

sikuliClickIFexists
    [Arguments]    ${Simage}    ${Sx}    ${Sy}
    ${existsImage}    Exists    ${Simage}    ${wait10}
    IF    ${existsImage}
        SikuliLibrary.Click    ${Simage}    ${Sx}    ${Sy}
    END

callVDS
    Change Screen Id    ${screenVDS}
    SikuliLibrary.Click    SEQ    0    24
    ${wheelMove}    Set Variable    0
    BuiltIn.Sleep    ${wait2}
    ${existsVDSempty}    Exists    VDSempty    ${wait2}
    IF    ${existsVDSempty}
        closeVDS
        Change Screen Id    ${screenTrek}
        RETURN
    END
    WHILE    True
        ${existsVDSyellowTriangle}    Exists    VDSyellowTriangle    ${wait2}
        ${existsVDSblueDot}    Exists    VDSblueDot    ${wait2}
        Log Many    Triangle    ${existsVDSyellowTriangle}
        IF    ${existsVDSyellowTriangle}
            SikuliLibrary.Right Click    VDSyellowTriangle
            SikuliLibrary.Click    VDSGoThere    ${wait2}
            BREAK
        END
    ${existsVDStruck}    Exists    VDStruck    ${wait2}
        Log Many    Dot    ${existsVDStruck}
        IF    ${existsVDStruck}
            SikuliLibrary.Right Click    VDStruck
            SikuliLibrary.Click    VDSGoThere    ${wait2}
            BREAK
        END
        # Emegrency Exit * Triangle or blue dot are not on the screen
    # \ \ \ \ \ \ \ SikuliLibrary.Right Click \ \ \ headerVDS \ \ \ 130 \ \ \ 180
        SikuliLibrary.Right Click    VDSzeroSpeed    150    0
        SikuliLibrary.Click    VDSGoThere    ${wait2}
        BREAK
    END
    #SikuliLibrary.Wheel Up    ${wheelMove}
    #speedZeroNew
    readSpeed
    SikuliLibrary.Click    SEQ    0    24
    SikuliLibrary.Click    buttonRemoveAssignment
    Change Screen Id    ${screenTrek}

speedZeroNew
    Change Screen Id    ${screenVDS}
    #@{coordinates}=    Get Screen Coordinates
    SikuliLibrary.Click    SEQ    -200    0
    #IF    ${screenVDS}
        ${lisst}    create list    1931    68    198    115
    #ELSE
    #${lisst}    create list    11    70    196    107
    #END
    ${tmpRegion}=    Click On Region    ${lisst}
    #Highlight Region    ${lisst}    10
    SikuliLibrary.Click    logoDeviceController    800    0    # to move cursor from read text area
    Set Min Similarity    ${activityPrecision}    #set activity precision
    WHILE    True
        ${screenShotSpeed}=    SikuliLibrary.Capture Region    ${lisst}
        Builtin.Sleep    ${wait15}
        ${existsSpeed}=    Exists    ${screenShotSpeed}
        IF    ${existsSpeed}
            BREAK
        ELSE
            CONTINUE
        END
    END
    Set Min Similarity    ${regularPrecision}    #restore old precision

readWaWeightOLD
    #Change Screen Id    ${screenTrek}
    #@{coordinates}=    Get Screen Coordinates
    #SikuliLibrary.Click    Cart    100    0
    # \ \ \ ${weightList} \ \ \ create list \ \ \ 640 \ \ \ 77 \ \ \ 140 \ \ \ 40
    #${weightList}    create list    640    77    190    40
    ${weightList}    create list    640    77    180    40
    ${tmpRegion}=    Click Region    ${weightList}
    #Highlight Region    ${weightList}    10
    SikuliLibrary.Click    Cart    40    0    # to move cursor from read text area
    ${tmpWeight}=    Read Text From Region    ${weightList}
    ${tmpWeight}=    Fetch From Left    ${tmpWeight}    ${KG}
    Log Many    >    ${tmpWeight}    <
    ${lengthWeight}=    Get Length    ${tmpWeight}
    IF    ${lengthWeight}
    #Log to Console    LongString
        ${instantWeight}=    Convert To Number    ${tmpWeight}
    ELSE
    #Log to Console    ShortString
        ${instantWeight}=    Set Variable    9000
    END
    #${instantWeight}=    Convert To Integer    ${tmpWeight}
    #Log Many    >    ${instantWeight}    <
    IF    (${instantWeight}>=${maxWeight})
        Log Many    Truck owerweighted    ${instantWeight}
        owerloadDisposal
    ELSE
        Log Many    The weight    ${instantWeight}    is OK
    END

owerloadDisposal
    ${existsButtonBack}    Exists    buttonBack    ${wait2}
    IF    ${existsButtonBack}
        SikuliLibrary.Click    buttonBack
        selectDisposal
        ExecuteDisposal    ${disposalWeight}
        selectCalls
    END

wtf
    WHILE    True
        ${tmpText}=    Read Text From Region    ${lisst}
    #Log to Console    ${tmpText}
        ${resultSpeed}=    Fetch From Left    ${tmpText}    ${Kmh}
    #Log to Console    ${resultSpeed}
        ${instantSpeed}=    Convert To Number    ${resultSpeed}
    #Log to Console    ${instantSpeed}
    #Log to Console    some speed text
    #${instantSpeed}    set variable    2.2
        ${status}=    Evaluate    ${instantSpeed} > 0.0
        IF    ${status}
            Log Many    Super high speed    ${instantSpeed}
        ELSE
    #Log Many    Zero Speed    ${instantSpeed}
            BREAK
        END
    END

closeVDS
    SikuliLibrary.Double Click    headerVDS    -50    0

ManualPhoto
    SikuliLibrary.Click    buttonManualPhoto

ManualVideo
    SikuliLibrary.Click    buttonManualVideo

whatewer
    Log To Console    Roi roks
    Set ROI    ${lisst}    4
    WHILE    True
        ${tmpROI}=    Capture ROI
        BuiltIn.Sleep    ${wait5}
        ${exists}    Exists    ${tmpROI}
        IF    ${exists}
            Log To Console    Roi exists
            BREAK
        END
        Log To Console    No Roi
    END
    #
        ${existsVDSyellowANDblue}    Evaluate    ${existsVDSyellowTriangle} or ${existsVDSblueDot}
        IF    ${existsVDSyellowANDblue}
            No Operation
        ELSE
            SikuliLibrary.Click    headerVDS    0    100
            SikuliLibrary.Wheel Down    1
            ${wheelMove}    Evaluate    ${wheelMove} + 1
            CONTINUE
        END
    #${existsVDSblueDot}    Exists    VDSblueDot    ${wait2}
        Log Many    Dot    ${existsVDSblueDot}
        IF    ${existsVDSblueDot}
            SikuliLibrary.Right Click    VDSblueDot
            SikuliLibrary.Click    VDSGoThere    ${wait2}
            BREAK
        END

t19
    SikuliLibrary.Right Click    headerVDS    130    180

Aug11
    SikuliLibrary.Change Screen Id    1
    #@{speedBox}=    SikuliLibrary.Select Region    Select region
    ${coordinatesRegion}=    Create List    1931    68    198    115
    Log    ${coordinatesRegion}
    SikuliLibrary.Highlight Region    ${coordinatesRegion}    10
    #${weightList}    create list    640    77    180    40
    ${tmpSpeed}=    Click Region    ${coordinatesRegion}
    ${screenShotSpeed}=    SikuliLibrary.Capture Region    ${coordinatesRegion}
    # \ | 1931 | 68 | 198 | 115 ]
    SikuliLibrary.Highlight Region    ${coordinatesRegion}    10
    BuiltIn.Sleep    10
    Set Min Similarity    1
    ${existsSpeed}=    Exists    ${screenShotSpeed}
    SikuliLibrary.Click    ${screenShotSpeed}
    Log    ${existsSpeed}

speedZeroOLD
    Change Screen Id    ${screenVDS}
    @{coordinates}=    Get Screen Coordinates
    SikuliLibrary.Click    SEQ    -200    0
    IF    ${screenVDS}
        ${lisst}    create list    1931    98    196    17
    ELSE
        ${lisst}    create list    11    70    196    107
    END
    ${tmpRegion}=    Click On Region    ${lisst}
    #Highlight Region    ${lisst}    10
    SikuliLibrary.Click    logoDeviceController    800    0    # to move cursor from read text area
    WHILE    True
        Builtin.Sleep    ${wait2}
        ${tmpText}=    Read Text From Region    ${lisst}
    Log to Console    ${tmpText}
        ${resultSpeed}=    Fetch From Left    ${tmpText}    ${Kmh}
        ${lengthSpeed}=    Get Length    ${resultSpeed}
        Log    ${lengthSpeed}
        Log    ${resultSpeed}
        IF    ${lengthSpeed}
    #Log to Console    LongString
            ${instantSpeed}=    Convert To Number    ${resultSpeed}
        ELSE
    #Log to Console    ShortString
            ${instantSpeed}=    Set Variable    0.0
        END
    #Log to Console    ${resultSpeed}
    #${instantSpeed}=    Convert To Number    ${resultSpeed}
    #Log to Console    ${instantSpeed}
    #Log to Console    some speed text
    #${instantSpeed}    set variable    2.2
        ${status}=    Evaluate    ${instantSpeed} > 0.0
        IF    ${status}
            Log Many    Super high speed    ${instantSpeed}
        ELSE
    #Log Many    Zero Speed    ${instantSpeed}
            BREAK
        END
    END

readWaWeight
    Set Global Variable    ${disposalWeight}
    ${region}=    Get Extended Region From Image    Cart    right    5
    #Highlight Region    ${region}    1
    ${regionWeight}=    Get Extended Region From Region    ${region}    right    2
    #Highlight Region    ${regionWeight}    1
    ${tmpText}=    Read Text From Region    ${regionWeight}
    #Log to Console    ${tmpText}
    ${resultWeight}=    Fetch From Left    ${tmpText}    ${KG}
    ${resultWeight}=    Fetch From Left    ${resultWeight}    ${k}
    ${resultWeight}=    Fetch From Left    ${resultWeight}    ${SPACE}
    #Log to Console    ${resultWeight}
    IF    (${resultWeight}>=${maxWeight})
    #Log Many    Truck owerweighted    ${instantWeight}
        ${disposalWeight}=    Evaluate    ${resultWeight}-${maxWeight}
        owerloadDisposal
    # \ \ \ ELSE
    # \ \ \ \ \ \ \ Log Many \ \ \ The weight \ \ \ ${instantWeight} \ \ \ is OK
    END
    Log Many    disposalWeight atreadwaweight    ${disposalWeight}
    RETURN    ${disposalWeight}

speedZero
    Change Screen Id    ${screenVDS}
    #@{coordinates}=    Get Screen Coordinates
    SikuliLibrary.Click    SEQ    -200    0
    #IF    ${screenVDS}
        ${lisst}    create list    1931    68    198    115
    #ELSE
    #${lisst}    create list    11    70    196    107
    #END
    ${tmpRegion}=    Click On Region    ${lisst}
    #Highlight Region    ${lisst}    10
    SikuliLibrary.Click    logoDeviceController    800    0    # to move cursor from read text area
    Set Min Similarity    ${activityPrecision}    #set activity precision
    WHILE    True
        ${screenShotSpeed}=    SikuliLibrary.Capture Region    ${lisst}
        Builtin.Sleep    ${wait15}
        ${existsSpeed}=    Exists    ${screenShotSpeed}
        IF    ${existsSpeed}
            BREAK
        ELSE
            CONTINUE
        END
    END
    Set Min Similarity    ${regularPrecision}    #restore old precision

readSpeed
    ${region}=    Get Extended Region From Image    logoDeviceController    right    5
    #Highlight Region    ${region}    1
    ${regionSpeed}=    Get Extended Region From Region    ${region}    below    2
    #Highlight Region    ${regionSpeed}    1
    WHILE    True
    ${tmpText}=    Read Text From Region    ${regionSpeed}
    Log to Console    ${tmpText}
    ${resultSpeed}=    Fetch From Left    ${tmpText}    ${Kmh}
    ${resultSpeed}=    Fetch From Right    ${resultSpeed}    ${LF}
    Log to Console    ${resultSpeed}
    ${lenSpeed}=    Get Length    ${resultSpeed}
    Log to Console    ${resultSpeed}
    IF    ${lenSpeed}>6
        CONTINUE
    END
    ${resultSpeedNum}=    Convert To Number    ${resultSpeed}
    Log Many    ${resultSpeedNum}
    #RETURN
    ${tmp}=    Evaluate    (${resultSpeedNum}>=${activityPrecision} )
    IF    (${resultSpeedNum}>=${activityPrecision} )
    #IF    ${tmp}
    Log Many    Truck moves    ${resultSpeedNum}
    ELSE
    Log Many    Truck stopped    ${resultSpeedNum}
    BREAK
    END
    END

ticketNumber
    ${time}=    Get Time
    #Log Many    ${time}
    ${resultime}=    Fetch From Right    ${time}    ${SPACE}
    ${lenTime}=    Get Length    ${resultime}
    ${ticketNumber}=    Remove String    ${resultime}    ${COLON}
    #Log Many    ${resultime}    ${lenTime}    ${ticketNumber}
    RETURN    ${ticketNumber}
