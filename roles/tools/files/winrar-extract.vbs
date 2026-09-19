Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

If WScript.Arguments.Count > 0 Then
    zipPath = WScript.Arguments(0)
    If fso.FileExists(zipPath) Then
        parentFolder = fso.GetParentFolderName(zipPath)
        baseName = fso.GetBaseName(zipPath)
        If parentFolder = "" Then
            destFolder = baseName
        Else
            destFolder = parentFolder & "\" & baseName
        End If

        winrarPath = "C:\Program Files\WinRAR\WinRAR.exe"
        If Not fso.FileExists(winrarPath) Then
            winrarPath = "C:\Program Files (x86)\WinRAR\WinRAR.exe"
        End If

        cmd = """" & winrarPath & """ x -ibck """ & zipPath & """ """ & destFolder & "\"""
        ret = shell.Run(cmd, 0, True)

        If ret = 0 Then
            shell.Run "explorer.exe """ & destFolder & """", 1, False
        End If
    End If
End If
