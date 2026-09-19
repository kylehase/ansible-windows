#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook True

SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.
A_MenuMaskKey := "vkE8"  ; Prevents Windows Start Menu from popping up when Win key is released

; Alt shortcuts mapped to Ctrl (Mac Cmd key position)
!c::Send("^c")
!v::Send("^v")
!x::Send("^x")
!f::Send("^f")
!z::Send("^z")
!+z::Send("^+z")
!a::Send("^a")
!s::Send("^s")
!w::Send("^w")
!t::Send("^t")

; Copilot key (sends Shift+Win+F23) or standalone F23 key to launch Antigravity (not the IDE)
*F23::Run('"' EnvGet("LOCALAPPDATA") '\Programs\antigravity\Antigravity.exe"')



