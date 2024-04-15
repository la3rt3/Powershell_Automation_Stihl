# 8 - SDB - Install_SDB.ps1
try {
    sdbinst "C:\Program Files (x86)\Softwares MES\SQOServerMainW10.sdb"
    Write-Host "Fim da etapa SDBInstall.`n"
} catch {
    Write-Host "Ocorreu um erro durante a instalacao do arquivo .sdb: $_`n"
};
try{
	Write-Host $endMessage
	Read-Host 
}catch{
	write-Host "Necessario realizar atualizacao de profile para executar este script"
	write-Host "caminho: \\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\profile"
	read-host
}  