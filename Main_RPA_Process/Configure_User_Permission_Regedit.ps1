try{
	Write-host "Aguarde, este processo pode demorar um pouco!`n"
	Write-host "Importando modulo de seguranca..."
	# Importando o módulo necessário
	Import-Module Microsoft.PowerShell.Security
	separador
	
	$regPath = "HKLM:\SOFTWARE"
	$permission = "FullControl"
	
	# Obtendo o objeto de segurança da chave do registro
	$regKey = Get-Acl -Path $regPath
	# Criando uma nova regra de acesso
	$rule = New-Object System.Security.AccessControl.RegistryAccessRule("Users", $permission, "ContainerInherit, ObjectInherit", "None", "Allow")
	
	Write-host "Adicionando regras de acesso..."
	# Adicionando a regra de acesso ao objeto de segurança
	$regKey.AddAccessRule($rule)
	separador
	
	Write-host "Alterando permissoes da chave de registro..."
	# Definindo as permissões modificadas na chave do registro
	Set-Acl -Path $regPath -AclObject $regKey
	separador
	
	Write-Host "Alteracoes concluidas com exito!"
	
}catch{
	Write-Host "Erro: $_"
}

try{
	Write-Host $endMessage
	Read-Host 
}catch{
	write-Host "Necessario realizar atualizacao de profile para executar este script"
	write-Host "caminho: \\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\profile"
	read-host
} 