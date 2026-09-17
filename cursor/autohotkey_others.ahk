#SingleInstance Force
#Persistent
SetBatchLines, -1

; ===== Volume Control =====
^]::Send {Volume_Up}
return

^[::Send {Volume_Down}
return

; ===== Brightness Control =====
^!]::
Brightness := GetBrightness() + 10
if (Brightness > 100)
    Brightness := 100
SetBrightness(Brightness)
ShowOSD("Brightness", Brightness)
return

^![::
Brightness := GetBrightness() - 10
if (Brightness < 0)
    Brightness := 0
SetBrightness(Brightness)
ShowOSD("Brightness", Brightness)
return

; ===== Media Control =====
^!;::Send {Media_Play_Pause}
return

^!.::Send {Media_Next}
return

^!,::Send {Media_Prev}
return

; ===== Brightness Functions =====
SetBrightness(level) {
    for monitor in ComObjGet("winmgmts:\\.\root\wmi").ExecQuery("SELECT * FROM WmiMonitorBrightnessMethods")
        monitor.WmiSetBrightness(1, level)
}

GetBrightness() {
    for monitor in ComObjGet("winmgmts:\\.\root\wmi").ExecQuery("SELECT * FROM WmiMonitorBrightness")
        return monitor.CurrentBrightness
}

; ===== OSD Popup (brightness only) =====
ShowOSD(label, percent) {
    DisplayText := label . ": " . percent . "%"
    Gui, OSD:Destroy
    Gui, OSD:+AlwaysOnTop -Caption +ToolWindow +Border
    Gui, OSD:Color, 202020
    Gui, OSD:Font, s11 cWhite, Segoe UI
    Gui, OSD:Add, Text, x20 y12 w200 h20 Center, %DisplayText%
    Gui, OSD:Add, Progress, x20 y36 w200 h16 cWhite Background333333, %percent%
    Gui, OSD:Show, w240 h70 NoActivate, OSD
    SetTimer, CloseOSD, -1200
    return
}

CloseOSD:
Gui, OSD:Destroy
return
