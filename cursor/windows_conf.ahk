#InstallKeybdHook
#UseHook
#SingleInstance force

SetCapsLockState, AlwaysOff

; ====== Cursor Movement Behaviour =====
initSpeed := 15
increment := 15
step := 0.1
maxSeconds := 3

wHeld := false, aHeld := false, sHeld := false, dHeld := false
wStart := 0, aStart := 0, sStart := 0, dStart := 0

eHeld := false, xHeld := false
eStart := 0, xStart := 0
scrollAccum := 0.0

SetTimer, MoveMouse, 10
return

!w::
wHeld := true
if (wStart = 0)
    wStart := A_TickCount
return
!w up::
wHeld := false
wStart := 0
return

!a::
aHeld := true
if (aStart = 0)
    aStart := A_TickCount
return
!a up::
aHeld := false
aStart := 0
return

!s::
sHeld := true
if (sStart = 0)
    sStart := A_TickCount
return
!s up::
sHeld := false
sStart := 0
return

!d::
dHeld := true
if (dStart = 0)
    dStart := A_TickCount
return
!d up::
dHeld := false
dStart := 0
return

; ====== Scrolling Behaviour =====
!e::
eHeld := true
if (eStart = 0)
    eStart := A_TickCount
return
!e up::
eHeld := false
eStart := 0
scrollAccum := 0.0
return

!x::
xHeld := true
if (xStart = 0)
    xStart := A_TickCount
return
!x up::
xHeld := false
xStart := 0
scrollAccum := 0.0
return

MoveMouse:
dx := 0
dy := 0
if (wHeld)
    dy -= GetSpeed(wStart)
if (sHeld)
    dy += GetSpeed(sStart)
if (aHeld)
    dx -= GetSpeed(aStart)
if (dHeld)
    dx += GetSpeed(dStart)

if (dx != 0 or dy != 0)
    MouseMove, dx, dy, 0, R

if (eHeld or xHeld) {
    if (eHeld)
        scrollAccum += GetSpeed(eStart) / 150
    if (xHeld)
        scrollAccum += GetSpeed(xStart) / 150

    while (scrollAccum >= 1) {
        if (eHeld)
            Send {WheelUp}
        if (xHeld)
            Send {WheelDown}
        scrollAccum -= 1
    }
}
return

GetSpeed(startTime) {
    global initSpeed, increment, step, maxSeconds
    elapsed := (A_TickCount - startTime) / 1000
    if (elapsed > maxSeconds)
        elapsed := maxSeconds
    steps := Floor(elapsed / step)
    return initSpeed + (steps * increment)
}

; ====== Left Click and Right Click Behaviour =====
CapsLock::Click
CapsLock & Space::Click, Right
