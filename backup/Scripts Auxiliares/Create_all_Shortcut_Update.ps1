$destinationDir = "\\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\Main_RPA_Process"
$sourceDir= "\\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\Main_RPA_Process"

$files = Get-ChildItem -path $sourceDir -Filter *.ps1
$WshShell = New-Object -ComObject WScript.Shell

foreach ($file in $files){
    $filelnk = $file.BaseName+".lnk"

    Write-Host "\\10.208.160.23\clientsupdates$\SuporteMES\Configuração\shortcut_TESTE\$filelnk" 
    $Shortcut = $WshShell.CreateShortcut("$destinationDir\$filelnk")

    $Shortcut.TargetPath = "powershell.exe"

    Write-Host "\\10.208.160.23\clientsupdates$\SuporteMES\Configuração\Processos_TESTE\$file"
    $Shortcut.Arguments = "-ExecutionPolicy Bypass -File `"$destinationDir\$file`""
    Write-Host "`n"

    $Shortcut.Save()
}