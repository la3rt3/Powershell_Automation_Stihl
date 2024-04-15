$nome = "Configure_User_Permission_Regedit"
$destinationDir = "\\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\Main_RPA_Process"
$sourceDir= "\\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\Main_RPA_Process"

Write-Host "created: $destinationDir\$nome.lnk"
Write-Host "from: $sourceDir\$nome.ps1"

$obj = New-Object -ComObject wscript.shell
$Shortcut = $obj.CreateShortcut("$destinationDir\$nome.lnk")
$Shortcut.TargetPath = "powershell.exe"
$Shortcut.Arguments = "-ExecutionPolicy Bypass -File `"$sourceDir\$nome.ps1`""
$Shortcut.Save()