# # Cria pastas "ReferenciasWsqolean", "Projetos" e "Sequor" - Import_Software_Path.ps1

$referenciasWsqoleanSource = "\\10.208.160.23\clientsupdates$\TMP\Windows 10\ReferenciasWsqolean"
# $referenciasWsqoleanSource = "\\10.208.160.23\clientsupdates$\Atualizador\ReferenciasWsqolean"
$projetosSource = "\\10.208.160.23\clientsupdates$\TMP\Windows 10\Projetos"
$sequorSource = "\\10.208.160.23\clientsupdates$\TMP\Windows 10\Sequor"

$referenciasWsqoleanDestination = "C:\"
$projetosDestination = "C:\Program Files (x86)\"
$sequorDestination = "C:\Program Files (x86)\"

#referenciasWsqolean
	try{
		Copy-Item -Path $referenciasWsqoleanSource -Destination $referenciasWsqoleanDestination -Recurse -Force -ErrorAction Stop
	Write-Host "Pasta 'ReferenciasWsqolean' criada e conteudo copiado com sucesso.`n"
	}catch{
		Write-Host "erro ao criar pasta referenciaWsqolean.`n"
	}	
	
#projetos
if (Test-Path $projetosDestination) {
	try{
		Write-Host "A pasta 'Projetos' ja existe."
		Remove-Item –path $projetosDestination –recurse -Force -ErrorAction Stop
		Write-Host "Atualizando conteudo de Projetos..."
	}catch{
		Write-Host "erro ao deletar pasta Projetos"
	}
	Copy-Item -Path $projetosSource -Destination $projetosDestination -Recurse -Force -ErrorAction Stop
	Write-Host "Pasta 'Projetos' criada e conteudo copiado do servidor com sucesso.`n"
	
} else {
	
	Copy-Item -Path $projetosSource -Destination $projetosDestination -Recurse -Force -ErrorAction Stop
	Write-Host "Pasta 'Projetos' atualizada.`n"	
}

#sequor
if (Test-Path $sequorDestination) {
	try{
		Write-Host "A pasta 'Sequor' ja existe."
		Remove-Item –path $sequorDestination –recurse -Force -ErrorAction Stop
		Write-Host "Atualizando conteudo de Sequor..."
	}catch{
		Write-Host "erro ao deletar pasta Sequor"
	}
	Copy-Item -Path $sequorSource -Destination $sequorDestination -Recurse -Force -ErrorAction Stop
	Write-Host "Pasta 'Sequor' Atualizada.`n"
	
} else {
	Copy-Item -Path $sequorSource -Destination $sequorDestination -Recurse -Force -ErrorAction Stop
	Write-Host "Pasta 'Sequor' criada e conteudo copiado com sucesso.`n"
};

try{
	Write-Host $endMessage
	Read-Host 
}catch{
	write-Host "Necessário executar atualizacao de profile e executar novamente"
	write-Host "caminho: \\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\profile"
}

$localPath = "\\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\All_RPA_Process"
$list = @("Apply_Permission_For_Paths.lnk", "Alter_IPCLP_Tag.lnk")
executaAtalho -path $localPath -list $list	