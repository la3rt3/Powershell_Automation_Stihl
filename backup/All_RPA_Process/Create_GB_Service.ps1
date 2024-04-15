# GB - Create_GB_Service.ps1 (VERIFICAR A NECESSIDADE DE INSTALAÇÃO, QUANDO FOR OPC)
$serviceName = "Sequor Service GB Driver CLP"
$binPath = "C:\Program Files (x86)\Sequor\Sequor Service GB Driver CLP\WMachine.GlobalVariables.Service.exe"

if (Get-Service $serviceName -ErrorAction SilentlyContinue) {
	Write-Host "O servico '$serviceName' ja existe!"
}ELSE{
	try {
		Write-Host "Criando servico 'Sequor Service GB Driver CLP'...`n"
		New-Service -Name $serviceName -BinaryPathName $binPath -StartupType Automatic # verificar necessidade de ser automatico
		Write-Host "Servico 'Sequor Service GB Driver CLP' criado com sucesso.`n"
	} catch {
		Write-Host "erro ao criar servico 'Sequor Service GB Driver CLP': $_"
		}
	};

try{
	Write-Host $endMessage
	Read-Host 
}catch{
	write-Host "Necessario realizar atualizacao de profile para executar este script"
	write-Host "caminho: \\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\profile"
	read-host
}