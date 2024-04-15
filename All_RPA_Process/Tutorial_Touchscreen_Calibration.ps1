# #	Calibrar Touchscreen do terminal - Tutorial_Touchscreen_Calibration.ps1

$localPath = 'c:\ProgramData\Microsoft\Windows\Start Menu\Programs\B&R Automation\Touch'
$list = @("Touch Screen Settings.lnk")
executaAtalho -path $localPath -list $list	
Write-Host ""
Write-Host "tutorial de calibracao:"
Write-Host "1 - Selecione a opcao: 'Use Windows Touch support';"
Write-Host "2 - Aperte o botao: 'Settings...';"
Write-Host "3 - Aperte o botao: 'Calibrar...';"
Write-Host "4 - Se dirija ao terminal e manualmente clique aonde for indicado ate sair da tela de calibracao;"
Write-Host "5 - Repita o processo 3 e 4;"
Write-Host "6 - Clicar em 'aplicar' e 'ok';"

Write-Host $endMessage