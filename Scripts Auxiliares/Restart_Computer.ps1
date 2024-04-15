# #	reinicialização Restart_Computer.ps1
Write-Host "Nesta etapa iremos reinicializar a MCM para aplicar as configuracoes realizadas."
$confirmation = Read-Host "Confirmar reinicializacao? (S/N)"
if ($confirmation -eq "S" -or $confirmation -eq "s") {                                                                                     	
	try {
		Write-Host "reiniciando...`n";
		Restart-Computer;
		break
	} catch {
		Write-Host "Ocorreu um erro ao reiniciar: $_ `n`nPara reiniciar manualmente execute o comando 'Restart-Computer'`n"
		break
	}
}else{
	write-Host "`nVoce escolheu nao reiniciar o computador!`n`nPara reiniciar manualmente execute o comando 'Restart-Computer'`n"
};