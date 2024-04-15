# Defina os detalhes da regra
$ruleName = "MCM Port Forwarding 6516"
$ruleDescription = "Allow MCM Port Forwarding 6516 - INC1381981"
$localPort = 6516
$protocol = "TCP"


Write-Host "`nEtapa de criação das regras de Firewall"
Write-Host "`nAguarde, este processo pode demorar um pouco!"

#regra de entrada
$direction = "Inbound"
# Verifique se a regra ja existe
try{
	$existingRule = Get-NetFirewallRule | Where-Object { $_.DisplayName -eq $ruleName }
	separador
	if ($existingRule -eq $null) {
		Write-Host "`nCriando regra de $direction..."
		# Se a regra nao existe, crie uma nova regra
		New-NetFirewallRule -DisplayName $ruleName -Description $ruleDescription -Direction $direction -Action Allow -Protocol $protocol -LocalPort $localPort
		Write-Host "Regra $direction criada com sucesso!"
	} else {
		Write-Host "`nAtualizando regra de $direction..."
		# Se a regra ja existe, atualiza
		Set-NetFirewallRule -DisplayName $ruleName -Description $ruleDescription -Action Allow -Protocol $protocol -LocalPort $localPort
		Write-Host "Regra $direction atualizada com sucesso!"
	}
}catch{
	write-host "erro: $_"
	
}
separador
#regra de saida
$direction = "Outbound"
try{
	$existingRule = Get-NetFirewallRule | Where-Object { $_.DisplayName -eq $ruleName }
	
	if ($existingRule -eq $null) {
		Write-Host "`nCriando regra $direction..."
		# Se a regra nao existe, crie uma nova regra
		New-NetFirewallRule -DisplayName $ruleName -Description $ruleDescription -Direction $direction -Action Allow -Protocol $protocol -LocalPort $localPort
		Write-Host "Regra $direction criada com sucesso!"
	} else {
		Write-Host "`nAtualizando regra $direction..."
		# Se a regra ja existe, atualiza
		Set-NetFirewallRule -DisplayName $ruleName -Description $ruleDescription -Action Allow -Protocol $protocol -LocalPort $localPort
		Write-Host "Regra $direction atualizada com sucesso!"
	}
}catch{
	write-host "erro: $_"
}
write-host " "
separador
#configura encaminhamento de porta IPv4
try{
	Write-Host "`nconfigurando encaminhamento de porta IPv4..."
	netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=6516 connectaddress=BR00SRVAPP058R1 connectport=6516
}catch{
	write-host "erro: $_"
}

# Mostra portas disponíveis
Write-Host "Resultado da operacao acima: "
netsh interface portproxy show v4tov4
separador
#Altera inicialização do serviço Auxiliar de IP
try{
	# MELHORIA: Descobrir como fazer (atraso na inicializacao)
	$antes= Get-Service -Name iphlpsvc | Select-Object DisplayName, StartType; 
	Write-Host "Antes:`n $antes"
	#altera
	Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\iphlpsvc' -Name Start -Value 2
	
	$depois = Get-Service -Name iphlpsvc | Select-Object DisplayName, StartType; 
	Write-Host "Depois:`n $depois"
	write-host " "
	write-Host "Resultado esperado:`n @{DisplayName=Auxiliar de IP; StartType=Automatic}"
}catch{
	write-host "erro: $_"
}
separador
Write-Host $endMessage
Read-Host