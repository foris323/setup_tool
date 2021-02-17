*** Settings ***
Library    RobotLib\\WinPVT.py
Library    RobotLib\\WinPVT2.py
Library    Buildon
*** Test Cases ***
Test1
    WinPVT.start_ui


*** Keywords ***
RRR
    Log   123

*** Variables ***
${SSS}   111


*** Settings ***
Library    RobotLib\\WinPVT.py

