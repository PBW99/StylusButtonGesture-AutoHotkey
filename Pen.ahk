; StylusButtonGesture-AutoHotkey
;https://github.com/PBW99/StylusButtonGesture-AutoHotkey
;
;Forked From Surface Pro 3 AutoHotkey
; https://github.com/jonathanyip/Surface-Pro-3-AutoHotkey



; Set up our pen constants
global PEN_NOT_HOVERING := 0x0      ; Pen is moved away from screen.
global PEN_HOVERING := 0x1          ; Pen is hovering above screen.
global PEN_TOUCHING := 0x3          ; Pen is touching screen.
global PEN_1ST_BTN_HOVERING := 0x9  ; 1st button is pressed.
global PEN_1ST_BTN_TOUCHING := 0x11 ; 1st button is pressed, pen is touching screen.
global PEN_2ND_BTN_HOVERING := 0x5  ; 2nd button is pressed.
global PEN_2ND_BTN_TOUCHING := 0x7  ; 3nd button is pressed, pen is touching screen.

global RPressed := false
global MPressed := false

global G_PEN_COORD_WIDTH = 4034.0
global G_PEN_COORD_HEIGHT = 2754.0
global G_X_Ratio = A_ScreenWidth / G_PEN_COORD_WIDTH
global G_Y_Ratio = A_ScreenHeight / G_PEN_COORD_HEIGHT

global g_penX
global g_penY

global g_oldX
global g_oldY

global g_PressNum := 0

; Create the array, initially empty:
global g_Array := [] 

; Input Check
global g_llastInput


CvtPenCrd_To_MouseCrd(ByRef mouseX, ByRef mouseY){
    mouseX := g_penX * G_X_Ratio
    mouseY := g_penY * G_Y_Ratio
}

; Respond to the pen inputs
; Fill this section with your favorite AutoHotkey scripts!
; lastInput is the last input that was detected before a state change.
PenCallback(input, lastInput) {
    OutputDebug, input---%input%, last %lastInput%

    if (input = PEN_NOT_HOVERING) {
        if(RPressed){
            mouX :=0
            mouY :=0
            CvtPenCrd_To_MouseCrd(mouX,mouY)
            OutputDebug, newmouse---%mouX%, %mouY%
            MouseClick, right,mouX,mouY, 1, 0, U  ;
        
        g_PressNum:=0
        RPressed := false
        }
    }

    if (input = PEN_HOVERING) {

    }

    if (input = PEN_TOUCHING) {
     
    }

    if (input = PEN_1ST_BTN_HOVERING) {
    }

    if (input = PEN_1ST_BTN_TOUCHING) {

    }
    
    if (input = PEN_2ND_BTN_TOUCHING) {
        if(RPressed){
            MouseClick, right,g_oldX,g_oldY, 1, 0, U  ;
        }
        g_PressNum:=0
        RPressed := false
        g_Array := []
        return
    }

    if (input = PEN_2ND_BTN_HOVERING AND g_llastInput != PEN_2ND_BTN_TOUCHING) {
        mouX :=0
        mouY :=0
        CvtPenCrd_To_MouseCrd(mouX,mouY)
        if (RPressed = false){

            RPressed := true

            g_oldX := mouX
            g_oldY := mouY
            MouseClick, right,g_oldX,g_oldY, 1, 0, D  ;
            OutputDebug, oldmouse---%g_oldX%, %g_oldY%
            
        }else{
            
            newPos := {}
            newPos.x := mouX
            newPos.y := mouY
            MouseMove, mouX,mouY,0
            OutputDebug, mid---%x%, %y%
            g_Array.Push(newPos)
        }
    }else {
        if(RPressed = true){
            mouX :=0
            mouY :=0
            CvtPenCrd_To_MouseCrd(mouX,mouY)
            OutputDebug, newmouse---%mouX%, %mouY%
            MouseClick, right,mouX,mouY, 1, 0, U  ;
            RPressed := false
            g_Array := []

            ; Mulitple Click
            if g_PressNum > 0 ; SetTimer already started, so we log the keypress instead.
            {
                g_PressNum += 1
                if(g_PressNum > 1){
                
                ; 2BTN double Clicked
                    Send, #{Tab}
                    g_PressNum = 0
                }
            }else{
                ; Otherwise, this is the first press of a new series. Set count to 1 and start
                ; the timer:
                g_PressNum := 1
                SetTimer, KeyWinC, -300 ;
            }
        }
    }


}

; Include AHKHID
#include AHKHID.ahk

; Set up other constants
; USAGE_PAGE and USAGE might change on different devices...
WM_INPUT := 0xFF
USAGE_PAGE := 13
USAGE := 2

; Set up AHKHID constants
AHKHID_UseConstants()

; Register the pen
AHKHID_AddRegister(1)
AHKHID_AddRegister(USAGE_PAGE, USAGE, A_ScriptHwnd, RIDEV_INPUTSINK)
AHKHID_Register()

; Intercept WM_INPUT
OnMessage(WM_INPUT, "InputMsg")

; Callback for WM_INPUT
; Isolates the bits responsible for the pen states from the raw data.
InputMsg(wParam, lParam) {
    Local type, inputInfo, inputData, raw, proc
    Critical

    type := AHKHID_GetInputInfo(lParam, II_DEVTYPE)

    if (type = RIM_TYPEHID) {
        inputInfo := AHKHID_GetInputInfo(lParam, II_DEVHANDLE)
        flag := AHKHID_GetInputInfo(lParam,II_MSE_FLAGS)
        inputData := AHKHID_GetInputData(lParam, uData)
        
        ; Get X,Y Coord
        g_penX := (NumGet(uData, 0, "UInt") & 0xffff0000) >> 16
        g_penY := (NumGet(uData, 4, "UInt") & 0x0000ffff)

        raw := NumGet(uData, 0, "UInt")
        proc := (raw >> 8) & 0x1F

        LimitPenCallback(proc)
    }
}

; Limits the callback only to when the pen changes state.
; This stop the repetitive firing that goes on when the pen moves around.
LimitPenCallback(input) {
    static lastInput := PEN_NOT_HOVERING
    static passNum := 0

    passNum+=1
   if (input != lastInput) {
        g_llastInput := lastInput
        PenCallback(input, lastInput)
        lastInput := input
   }else if (Mod(passNum,10) = 0){
        PenCallback(input, lastInput)
    }
}


KeyWinC:
; Regardless of which action above was triggered, reset the count to
; prepare for the next series of presses:
g_PressNum := 0
return

