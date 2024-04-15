# #  importa Programas (.msi e outros) - Import_Programs_MSI.PS1 
$sourceDir = "\\10.208.160.23\clientsupdates`$\TMP\Windows 10\Programas"
$destinationDir = "C:\Program Files (x86)\Softwares MES"

try {
	# Verifica se o diretorio de destino existe
	if (!(Test-Path $destinationDir)) {
		# Cria o diretorio de destino caso nao exista
		New-Item -ItemType Directory -Path $destinationDir | Out-Null
	}

	# Copia todo o conteudo do diretorio de origem para o diretorio de destino
	Copy-Item -Path $sourceDir\* -Destination $destinationDir -Recurse -Force -ErrorAction Stop

	Write-Host "conteudo copiado com sucesso do diretorio '$sourceDir' para o diretorio '$destinationDir'."
} catch {
	Write-Host "Ocorreu um erro ao copiar o conteudo: $_"
};

try{
	Write-Host $endMessage
	Read-Host 
}catch{
	write-Host "Necessário executar atualizacao de profile e executar novamente"
	write-Host "caminho: \\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\profile"
}

# INVOCA OS ATALHOS 
#  pergunta se quer executar Tutorial_MSI_Installation
$localPath = '\\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\All_RPA_Process'
$list = @("Tutorial_MSI_Installation.lnk")
executaAtalho -path $localPath -list $list