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
${maxWeight}      40000
${truckWeight}    9000
${disposalWeight}    \
${grossWeight}    \
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
${TRUCK}          Truck
${lenSpeed4zero}    4
${len4ticketNumber}    4
${len3weightRndm}    3

*** Test Cases ***
setLiftArm
    openLiftArm

AcloseRoute
    mainMenu
    closeRoute

WAworkflow
    mainMenu
    #${grossWeight}=    grossWeight
    selectCalls
    selectSequenceList
    selectManualConfirm
    copyWADictionary
    StopsExecute

Disposal
    mainMenu
    selectDisposal
    ExecuteDisposal    ${grossWeight}

Extra
    mainMenu
    selectCalls
    selectManualConfirm
    StopsExtra

Exceptions
    mainMenu
    selectCalls
    selectManualConfirm
    StopsException

Activities
    mainMenu
    selectActivities
    ExecuteActivities

ReadMesage
    mainMenu
    selectReadMessage
    ReadMessages

SendMessage
    mainMenu
    selectSendMessage
    SendMessageScreen

NotOut
    mainMenu
    selectCalls
    selectSequenceList
    selectManualConfirm
    copyNotOutDictionary
    StopsExecute

ZcloseRoute
    mainMenu
    closeRoute

ReadMesageRoutLess
    logonDriver
    clickEnvelope
    ReadMessages
    FinishMainMenu

WAworkflow24aug
    #mainMenu
    selectCalls
    selectSequenceList
    selectManualConfirm
    copyWADictionary
    StopsExecute

tmpTest
    logonDriver
    selectRoute
    mainMenuEngine

tmpZ
    #vdsListCompleted
    #stopListCompleted
    # getStopNumber
    # stopNumberCollectSize2
    vdsStopNumber

*** Keywords ***
Add Needed Image Path
        Add Image Path    ${IMAGE_DIR}
        Log    ${IMAGE_DIR}
        Set Min Similarity    ${regularPrecision}

Complete
    Log    Complete
    SikuliLibrary.Click    buttonComplete

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

ExecuteDisposal
    [Arguments]    ${grossWeight}
    Log Many    ${grossWeight}    ${maxWeight}
    WHILE    True
        ${existsvillaYard}    Exists    villaYard
        IF    ${existsvillaYard}
                SikuliLibrary.Click    villaYard
        END
        ${existscityOfClovisLandfill}    Exists    cityOfClovisLandfill
        IF    ${existscityOfClovisLandfill}
                SikuliLibrary.Click    cityOfClovisLandfill
        END
        ${existsbuttonSelect}    Exists    buttonSelect
        IF    ${existsbuttonSelect}
                SikuliLibrary.Click    buttonSelect
                BREAK
        END
    END
    #Log To Console    String test for Disposal
    #Log To Console    Fill the ticket fields
    Sleep    ${wait2}
    ${existsAutomatedFacility}    Exists    AutomatedFacility
    IF    ${existsAutomatedFacility}
        Log To Console    Automated Facility Warning
    ELSE
    ${grossWeight}=    grossWeight
    ${disposalWeight}=    Evaluate    ${grossWeight}-${truckWeight}
    Log Many    ${grossWeight}    ${disposalWeight}    ${truckWeight}
    ${ticketNumberTMP}=    Generate Random String    ${len4ticketNumber}    [NUMBERS]
    ${ticketNumber}=    Replace String    ${ticketNumberTMP}    0    1    ${len4ticketNumber}
    #ticketNumber
    Log To Console    ${ticketNumber}
    SikuliLibrary.Click    labelTicket    ${disposalX}
    SikuliLibrary.Click    buttonKbdDone
    SikuliLibrary.Paste Text    labelTicket    ${disposalWeight}
    #SikuliLibrary.Paste Text    labelTicket    ${ticketNumber}
    #disposalWeight
    #
    #bandAid !!!! can't do ${disposalWeight} replacing it with a ${ticketNumber} !!!
    #${disposalWeight}=    Evaluate    ${ticketNumber}
    #
    Log To Console    ${disposalWeight}
    SikuliLibrary.Click    labelQuantity    ${disposalX}
    SikuliLibrary.Click    buttonKbdDone
    SikuliLibrary.Paste Text    labelQuantity    ${disposalWeight}
    #
    #BuiltIn.Sleep    ${wait5}
    #weightUnitKg
    SikuliLibrary.Click    ${unitKg}
    END
        WHILE    True
        ${existsbuttonArrive}    Exists    buttonArrive
        SikuliLibrary.Click    buttonArrive    #Depart button
        BREAK
    END
    Log To Console    Second Arrive Button
    WHILE    True
        ${existsbuttonArrive}    Exists    buttonArrive
        SikuliLibrary.Click    buttonArrive    #Depart button
        BREAK
    END
    #washing wheels pop-up    #Warning pop-up
    WHILE    True
        ${existsbuttonBlueYes}    Exists    buttonBlueYes
            SikuliLibrary.Click    buttonBlueYes
            BREAK
    END

FinishMainMenu
    SikuliLibrary.Click    buttonSwitchDriverRoute

LiftArmUpDown
    sikuliClick    labelGPI1    80    0
    BuiltIn.sleep    ${wait5}
    sikuliClick    labelGPI1    80    0

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

ManualPhoto
    SikuliLibrary.Click    buttonManualPhoto

ManualVideo
    SikuliLibrary.Click    buttonManualVideo

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

MessedUP-clickExecute
        SikuliLibrary.Click    Cart    ${completedX}    ${completedY}
        ${existsHeaderAudinting}    Exists    headerAuditingYellowOnBlue    ${wait5}
        IF    ${existsHeaderAudinting}
            SikuliLibrary.Click    Cart    ${confirmAuditingX}    ${confirmAuditingY}
        END
        selectManualConfirm

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

SendMessageScreen
        Log    SendMessageScreen
        Wait For Image    headerSendMessage    \    ${LoadTime}
        SikuliLibrary.Click    Cart    ${messageNoteX}    ${messageNoteY}
        Press Special Key    DOWN
        SikuliLibrary.Click    headerSendMessage
        SikuliLibrary.Click    buttonSendMessage

Signature
    Log    Signature
    WHILE    True
        generateSignature
        BREAK
    END
    #

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

StopsExecute
    Log    ${TEST_NAME}
    WHILE    True
        callVDS    ${grossWeight}
        ManualPhoto
        ManualVideo
    # \ \ \ fillWeightKG-96
    #${grossWeight}=    grossWeight
    # \ \ \ \ \ \ \ Log Many \ \ \ disposalWeight-disposalWeight \ \ \ ${disposalWeight}
    #readWaWeight
    SikuliLibrary.Click    Cart    ${CartManualConfirmX}    ${CartManualConfirmY}
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

UnknownAddress
    ${existsheaderUnknownAddress}    Exists    UnknownAddress    ${wait5}
    SikuliLibrary.Click    buttonBack

callVDS
    [Arguments]    ${grossWeight}
    #${grossWeight}=    grossWeight
    Change Screen Id    ${screenVDS}
    Log Many    ${grossWeight}    <<grossWeight>>    ${maxWeight}    <<maxWeight>>    at callVDS
    SikuliLibrary.Click    SEQ    0    24    #go to the top-first record on the stops list
    IF    ${grossWeight}>=${maxWeight}    #Does truck Overloaded or Not ; Select Home or End stop
    Log Many    go To Disposal Site location address on the stops list    ${grossWeight}    is bigger than 9000    expected place on the map waiste feeld
        Key Down    END
        Key Up    END
        Sleep    ${wait2}
    ELSE
    Log Many    ${grossWeight}    is smaller than maxWeigh
        Key Down    HOME
        Key Up    HOME
    END
    Log Many    #point Truck to the selected stop on the map    callVDS truck located
    #Sleep    ${wait10}
    WHILE    True
    Sleep    ${wait2}
    #${existsVDSblueDot}    Exists    VDSblueDot    ${wait2}
        ${existsVDSyellowTriangle}    Exists    VDSyellowTriangle    #${wait2}
    #Log Many    Triangle    ${existsVDSyellowTriangle}
        IF    ${existsVDSyellowTriangle}
            SikuliLibrary.Right Click    VDSyellowTriangle
            SikuliLibrary.Click    VDSGoThere    ${wait2}
            BREAK
        END
        ${existsVDStruck}    Exists    VDStruck    ${wait2}
    #Log Many    Dot    ${existsVDStruck}
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
    #SikuliLibrary.Click    VDSGoThere    ${wait2}    \    # go to triangle, truck or top left corner
    #speedZeroNew
    #Log Many    Move truck; report speed until Zero
    readSpeed    #move truck until speed zero
    SikuliLibrary.Click    SEQ    0    24    #check top address
    Key Down    HOME
    Key Up    HOME
    #
    IF    ${grossWeight}>=${maxWeight}
        Log Many    Disposal Site stop! do not remove it!
    ELSE
        Log Many    remove current regular stop
        SikuliLibrary.Click    buttonRemoveAssignment
    END
    Change Screen Id    ${screenTrek}    #back to the Trek screen
    RETURN
    #Orphan part after RETURN
    #close VDS if/when we done
    ${existsVDSempty}    Exists    VDSempty    ${wait2}
    IF    ${existsVDSempty}
        closeVDS
        Change Screen Id    ${screenTrek}
        RETURN
    END

callVDSplus
    [Arguments]    ${grossWeight}
    ${grossWeight}=    grossWeight
    Change Screen Id    ${screenVDS}
    Log Many    ${grossWeight}    <<grossWeight>>    ${maxWeight}
    SikuliLibrary.Click    SEQ
    Key Down    CTRL
    IF    ${grossWeight}>=${maxWeight}
        Log Many    go To Disposal Site
        Press Special Key    END
    ELSE
        Log Many    execute regular stop
        Press Special Key    HOME
    END
    Key Up    CTRL
    #BuiltIn.Sleep    ${wait2}
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
    IF    ${grossWeight}>=${maxWeight}
        Log Many    Disposal Site ! do not remove !
    ELSE
        Log Many    remove current regular stop
        SikuliLibrary.Click    buttonRemoveAssignment
    END
    Change Screen Id    ${screenTrek}

clickEnvelope
    ${existlabelEnvelopeWhite}    Exists    labelEnvelopeWhite    ${wait5}
    IF    ${existlabelEnvelopeWhite}
        SikuliLibrary.Click    Cart    444    0
    END

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

clickExecute
        SikuliLibrary.Click    Cart    ${completedX}    ${completedY}
        selectManualConfirm

clickExecuteAUD
        prowideAUDwlh
        SikuliLibrary.Click    buttonAUDconfirm
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

clickExecuteWeight
        SikuliLibrary.Click    Cart    ${completedX}    ${completedY}
        selectManualConfirm

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

clickNone
    No Operation

clickNotOut
        SikuliLibrary.Click    Cart    ${notOutX}    ${notOutY}
        selectManualConfirm

closeRoute
        Log    CloseRoute
        BuiltIn.Sleep    ${wait5}
        Wait For Image    buttonSwitchDriverRoute    \    ${wait15}
        SikuliLibrary.Click    buttonSwitchDriverRoute
        ${existsButtonCloseroute}    Exists    buttonCloseroute    ${wait15}
        SikuliLibrary.Click    buttonCloseroute
        selectRoute_fromWork

closeVDS
    #SikuliLibrary.Double Click    headerVDS    -50    0
    Log Many    close VDS    ${PREV TEST NAME}    ${TEST NAME}

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

copyNotOutDictionary
    &{shallow_copy}=    Copy Dictionary    ${NotOut}    deepcopy=False
    ${buttonBackShX}    Evaluate    ${buttonRoffBbackX.NotOut}
    Set Suite Variable    ${buttonBackShX}

copyWADictionary
    &{shallow_copy}=    Copy Dictionary    ${WAworkflow}    deepcopy=False
    ${buttonBackShX}    Evaluate    ${buttonRoffBbackX.WAworkflow}
    Set Suite Variable    ${buttonBackShX}
    Set Suite Variable    &{shallow_copy}

fillWeightKG
    Log    fillWeightKG
    ${existsButton}    Exists    buttonScaleRandom
    IF    ${existsButton}
        ${WeightKGrndm}    Generate Random String    3    [NUMBERS]
        ${WeightKGrndm}=    Replace String    ${WeightKGrndm}    0    1    ${len3weightRndm}
        IF    ${WeightKGrndm}>500
            SikuliLibrary.Click    buttonScaleRandom
        ELSE
            SikuliLibrary.Click    buttonScale500
        END
    #Builtin.Sleep    ${wait2}
        RETURN
    END
    ${WeightKG}    Generate Random String    2    [NUMBERS]
    SikuliLibrary.Click    tagWeightKG
    Wait For Image    buttonKbdDone    \    ${wait15}
    SikuliLibrary.Click    buttonKbdDone
    Paste text    \    ${WeightKG}
    #Builtin.Sleep    ${wait2}

fillWeightKG-96
    Log    fillWeightKG-96
    ${existsButton}    Exists    buttonScaleRandom
    IF    ${existsButton}
        ${WeightKGrndm}    Generate Random String    3    [NUMBERS]
        ${WeightKGrndm}=    Replace String    ${WeightKGrndm}    0    1    3
        IF    ${WeightKGrndm}>500
            SikuliLibrary.Click    buttonScaleRandom
        ELSE
            SikuliLibrary.Click    buttonScale500
        END
    #Builtin.Sleep    ${wait2}
        RETURN
    END

generateSignature
    SikuliLibrary.Click    signatureStart
    Drag And Drop    signatureStart    signatureEnd

goToDisposalSite

grossWeight
    #Set Global Variable    ${grossWeight}
    ${region}=    Get Extended Region From Image    Cart    right    5
    #Highlight Region    ${region}    12
    ${regionWeight}=    Get Extended Region From Region    ${region}    right    2
    #Highlight Region    ${regionWeight}    10
    ${grossWeight}=    Read Text From Region    ${regionWeight}
    Log to Console    ${grossWeight}
    ${grossWeight}=    Fetch From Left    ${grossWeight}    ${KG}
    ${grossWeight}=    Remove String    ${grossWeight}    ${k}
    ${grossWeight}=    Strip String    ${grossWeight}    mode=both
    RETURN    ${grossWeight}

logonDriver
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

mainMenu
    logonDriver
    selectRoute

mainMenuEngine
    #Logon page. Click logon button
    #RoueList. Select route click OK
    #Main Menu. Check car weight;
    Log Many    @mainMenuEngine
    WHILE    True
        ${grossWeight}=    grossWeight
    ${tmp}=    Evaluate    ${grossWeight}>=${maxWeight}
    Log Many    ${grossWeight}    == grossWeight Weight    @mainMenuEngine    ${tmp}    ==tmp
        IF    ${grossWeight}>=${maxWeight}
            Log Many    fat truck disposal time    ${grossWeight}    ${maxWeight}
            ${numberOfScreens}=    Get number of screens
            IF    ${numberOfScreens}>1
                Log Many    *locateDisposalSite*    ${grossWeight}    ${numberOfScreens}    == screens    callVDS keyword
                callVDS    ${grossWeight}
            END
            Log Many    selectDisposal    ExecuteDisposal    ${grossWeight}
            selectDisposal
            ExecuteDisposal    ${grossWeight}
        END
        Log Many    good boy do Calls
        Sleep    ${wait2}
        mmWAworkflow
    END

mmStopsExecute
    Log    ${TEST_NAME}
    WHILE    True
        ${grossWeight}=    grossWeight
        IF    ${grossWeight}>=${maxWeight}
            ${existsbuttonBack}    Exists    buttonBack    ${wait2}
            IF    ${existsbuttonBack}
                Click    buttonBack
            RETURN
            END
        END
        ${waListISempty}=    stopListCompleted
        Log Many    @${waListISempty}    ${waListISempty}
        IF    ${waListISempty}>0
    #CONTINUE
                No Operation
        ELSE
            Change Screen Id    ${screenVDS}
            closeVDS
            Change Screen Id    ${screenTrek}
            Click    buttonBack
            closeWA
    #Click    buttonSwitchDriverRoute
    #FinishMainMenu
    #Click    buttonSwRouteDriver
    #Click    buttonSwitchDriver
    #BREAK
        END
        callVDS    ${grossWeight}
        ManualPhoto
        ManualVideo
        fillWeightKG-96
    #${grossWeight}=    grossWeight
    # \ \ \ \ \ \ \ Log Many \ \ \ disposalWeight-disposalWeight \ \ \ ${disposalWeight}
    #readWaWeight
    SikuliLibrary.Click    Cart    ${CartManualConfirmX}    ${CartManualConfirmY}
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
        ${existsbuttonBack}=    Exists    buttonBack
        IF    ${existsbuttonBack}
            SikuliLibrary.Click    buttonBack
        END

mmWAworkflow
    #mainMenu
    #${grossWeight}=    grossWeight
    selectCalls
    selectSequenceList
    selectManualConfirm
    copyWADictionary
    mmStopsExecute

openLiftArm
    sikuliClick    Cart    140    0
    sikuliClick    tabVehicleData    0    0
    sikuliClick    buttonBack    50    -120
    sikuliClick    cellTruck674Dev    80    0
    LiftArmUpDown

owerloadDisposal
    ${existsButtonBack}    Exists    buttonBack    ${wait2}
    IF    ${existsButtonBack}
        SikuliLibrary.Click    buttonBack
        selectDisposal
        ExecuteDisposal    ${grossWeight}
        selectCalls
    END

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
    IF    ${lenSpeed}==${lenSpeed4zero}
        ${resultSpeed}=    Fetch From Left    ${resultSpeed}    ${speedZero}
        ${resultSpeed}=    Strip String    ${resultSpeed}    mode=both
        ${lenSpeed}=    Get Length    ${resultSpeed}
        IF    ${lenSpeed}==0
            RETURN
        END
    #ELSE
    #CONTINUE
    END
    CONTINUE
    #${resultSpeed}=    Remove String    ${resultSpeed}    ${TRUCK}
    #${lenSpeed}=    Get Length    ${resultSpeed}
    #IF    ${lenSpeed}==0
    # \ \ BREAK
    #END
    #${resultSpeedNum}=    Convert To Number    ${resultSpeed}
    #Log Many    ${resultSpeedNum}
    #RETURN
    #${tmp}=    Evaluate    (${resultSpeedNum}>=${activityPrecision} )
    #IF    (${resultSpeedNum}>=${activityPrecision} )
    #IF    ${tmp}
    #Log Many    Truck moves    ${resultSpeedNum}
    #ELSE
    #Log Many    Truck stopped    ${resultSpeedNum}
    #BREAK
    #END
    END

readWaSize96
    #Set Global Variable    ${disposalWeight}
    ${region}=    Get Extended Region From Image    Cart    left    13
    Highlight Region    ${region}    2
    ${regionWeight96}=    Get Extended Region From Region    ${region}    below    6
    Highlight Region    ${regionWeight96}    2
    ${tmpText}=    Read Text From Region    ${regionWeight96}
    Log to Console    ${tmpText}
    #${resultWeight}=    Fetch From Left    ${tmpText}    ${KG}
    #${resultWeight}=    Fetch From Left    ${resultWeight}    ${k}
    #${resultWeight}=    Fetch From Left    ${resultWeight}    ${SPACE}
    #Log to Console    ${resultWeight}
    ${region}=    Get Extended Region From Image    Cart    right    16
    Highlight Region    ${region}    3
    ${regionWeight96}=    Get Extended Region From Region    ${region}    below    6
    Highlight Region    ${regionWeight96}    10
    ${tmpText}=    Read Text From Region    ${regionWeight96}
    Log to Console    ${tmpText}

selectActivities
    WHILE    True
        ${existsbuttonActivities}    Exists    buttonActivities    ${wait5}
        IF    ${existsbuttonActivities}
            BREAK
        END
    END
    SikuliLibrary.Click    buttonActivities

selectCalls
    ${existsbuttonCalls}    Exists    buttonCalls    ${wait2}
    IF    ${existsbuttonCalls}
        SikuliLibrary.Click    buttonCalls
    END

selectDisposal
    WHILE    True
        ${existsbuttonDisposal}    Exists    buttonDisposal
        SikuliLibrary.Click    buttonDisposal
        BREAK
    END

selectManualConfirm
        Wait For Image    Cart    \    ${wait15}
        SikuliLibrary.Click    Cart    40    80

selectReadMessage
        Wait For Image    buttonReadMessage    \    ${LoadTime}
        SikuliLibrary.Click    buttonReadMessage

selectRoute
        Wait For Image    tagRoute    \    ${wait5}
        SikuliLibrary.Click    tagRoute    0    25
        SikuliLibrary.Click    buttonOK

selectRoute_fromWork
        Wait For Image    headerRouteList    \    ${wait10}
        SikuliLibrary.Click    headerRouteList    0    200
        SikuliLibrary.Click    headerRouteList    0    160    # WFH
        SikuliLibrary.Click    buttonBlueYes

selectSendMessage
        Wait For Image    buttonSendMessage    \    ${LoadTime}
        SikuliLibrary.Click    buttonSendMessage

selectSequenceList
    Log    selectSequenceList
    Wait For Image    headerCallsWhite    \    ${wait15}
    SikuliLibrary.Click    Cart    -350    80

sikuliClick
    [Arguments]    ${Simage}    ${Sx}    ${Sy}
    WHILE    True
            ${existsImage}    Exists    ${Simage}
        IF    ${existsImage}
            SikuliLibrary.Click    ${Simage}    ${Sx}    ${Sy}
            BREAK
        END
    END

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

update
    #New version 2.0.7 available from https://pypi.python.org/pypi/robotframework-ride
    #See this version Release Notes
    #You can update with the command:
    #pip install -U robotframework-ride
    #See the latest development CHANGELOG

stopListCompleted
    ${region}=    Get Extended Region From Image    Cart    below    3
    #Highlight region    ${region}    15
    ${region}=    Get Extended Region From Region    ${region}    below    4
    #Highlight region    ${region}    5
    ${region}=    Get Extended Region From Region    ${region}    left    12
    #Highlight region    ${region}    5
    ${stop}=    Read Text From Region    ${region}
    ${length} =    Get Length    ${stop}
    RETURN    ${length}

vdsListCompleted
    Change Screen Id    ${screenVDS}
    #Set Global Variable    ${grossWeight}
    ${region}=    Get Extended Region From Image    SEQ    right    7
    #Highlight Region    ${region}    10
    ${regionWeight}=    Get Extended Region From Region    ${region}    below    9
    #Highlight Region    ${regionWeight}    10
    ${grossWeight}=    Read Text From Region    ${regionWeight}
    ${length} =    Get Length    ${grossWeight}
    Log Many    ${length}

getStopNumber
    Click    buttonException
    ${region}=    Get Extended Region From Image    Cart    below    8
    ${region}=    Get Extended Region From Region    ${region}    left    9
    Comment    Highlight Region    ${region}    5
    ${region}=    Get Extended Region From Region    ${region}    left    1
    ${stop}=    Read Text From Region    ${region}
    Highlight Region    ${region}    5
    Log Many    ***************************
    ${length} =    Get Length    ${stop}
    Wait For Image    buttonBackLong    \    ${wait15}
    Click    buttonBackLong
    RETURN    ${length}

stopNumberCollectSize2
    ${region}=    Get Extended Region From Image    Cart    below    9
    Highlight Region    ${region}    5
    ${region}=    Get Extended Region From Region    ${region}    right    3
    Highlight Region    ${region}    5
    ${region}=    Get Extended Region From Region    ${region}    below    1
    ${stop}=    Read Text From Region    ${region}
    Highlight Region    ${region}    5
    Log Many    ***************************
    ${length} =    Get Length    ${stop}
    RETURN    ${length}

vdsStopNumber
    Change Screen Id    ${screenVDS}
    ${region}=    Get Extended Region From Image    SEQlong    below    1
    Comment    Highlight Region    ${region}    10
    Comment    ${region}=    Get Extended Region From Region    ${region}    right    9
    Highlight Region    ${region}    10
    ${vdsStop}=    Read Text From Region    ${region}
    ${length} =    Get Length    ${vdsStop}
    Log Many    ${length}
