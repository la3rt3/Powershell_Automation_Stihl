# Verificar se o servico "Auxiliar de IP" existe e entao configura para inicializacao automatica - Configure_Iphlpsvc_Service.ps1
$auxServiceName = "iphlpsvc"
if (Get-Service $auxServiceName -ErrorAction SilentlyContinue) {
    Set-Service -Name $auxServiceName -StartupType Automatic
    Start-Service -Name $auxServiceName

    # Verificar se o servico "Auxiliar de IP" foi iniciado
    $auxServiceStatus = (Get-Service -Name $auxServiceName).Status
    if ($auxServiceStatus -eq "Running") {
        Write-Host "O servico '$auxServiceName' foi configurado para iniciar automaticamente e foi iniciado."
    } else {
        Write-Host "Ocorreu um erro ao iniciar o servico '$auxServiceName'. Verifique as permissoes e tente novamente."
    }
} else {
    Write-Host "O servico '$auxServiceName' nao esta instalado."
}
try{
	Write-Host $endMessage
	Read-Host 
}catch{
	write-Host "Necessario realizar atualizacao de profile para executar este script"
	write-Host "caminho: \\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\profile"
	read-host
}

