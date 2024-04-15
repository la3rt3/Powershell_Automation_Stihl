# # GB Driver Serial - Create_GBDriverSerial_On_Hostname.ps1
try {
	$processName = "hostname"
	$hostname = confirmaValor $processName
	$command = "sc \\$hostname create SequorDriverLeitor binpath=`"C:\Program Files (x86)\Sequor\Sequor Service Driver Serial\WMachine.GlobalVariables.Service.exe`""
	& cmd /c $command
	Write-Host "`nServico 'SequorDriverLeitor' criado no host '$hostname' com sucesso.`n"
	break
} catch {
	Write-Host "Ocorreu um erro ao criar o servico no host '$hostname': $_"
	break
}
	
try{
Write-Host $endMessage
Read-Host 
}catch{
	write-Host "Necessario realizar atualizacao de profile para executar este script"
	write-Host "caminho: \\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\profile"
	read-host
}