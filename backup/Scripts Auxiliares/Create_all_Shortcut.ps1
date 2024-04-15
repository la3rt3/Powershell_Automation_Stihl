
$path = "\\10.208.160.23\clientsupdates$\SuporteMES\Configuração\Processos_TESTE"
$files = Get-ChildItem -path $path
$WshShell = New-Object -ComObject WScript.Shell
foreach ($file in $files){
    $filelnk = $file.BaseName+".lnk"
    Write-Host "\\10.208.160.23\clientsupdates$\SuporteMES\Configuração\shortcut_TESTE\$filelnk" 
    $Shortcut = $WshShell.CreateShortcut("\\10.208.160.23\clientsupdates$\SuporteMES\Configuração\shortcut_TESTE\$filelnk")

    $Shortcut.TargetPath = "powershell.exe"

    Write-Host "\\10.208.160.23\clientsupdates$\SuporteMES\Configuração\Processos_TESTE\$file"
    $Shortcut.Arguments = "-ExecutionPolicy Bypass -File `"\\10.208.160.23\clientsupdates$\SuporteMES\Configuração\Processos_TESTE\$file`""
    Write-Host "`n"

    $Shortcut.Save()
}
