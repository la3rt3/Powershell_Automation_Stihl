# 12 - iniciar a interface "netsh" que modifica configuracoes de rede do Windows via comando: - Start_Netsh_Interface.ps1
function executaScript{
	try{
		write-host " "
		Write-Host "Inicializando interface netsh..."
		$command = "netsh interface portproxy show all"
		$result = Invoke-Expression $command
		Write-Host $result
		write-host " "
		Write-Host "Interface netsh inicializada`n";
		# Executar o comando netsh dump e salvar o resultado em uma variavel
		$result = netsh dump
		
		# 13 - verifica e instala Bridges - Create_Ports.ps1
		# 13.1 - Verificar se a porta 19000 foi criada no script
		if ($result -match "add v4tov4 listenport=19000 connectaddress=192.168.1.15 connectport=19000") {
			Write-Host "A porta 19000 ja existe."
		} else {
			Write-Host "A porta 19000 nao foi encontrada."
			try{
				Write-Host "Criando a porta 19000..."
				netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=19000 connectaddress=192.168.1.15 connectport=19000;
				Write-Host "A porta 19000 foi criada."
			}catch{
				Write-Host "Nao foi possivel criar a porta 19000.`n"
			}
		}
	}catch{
		write-host "erro: $_"
	}
	
	separador
	
	# 13.2 - Verificar se a porta 19003 foi criada no script
	try{
		if ($result -match "add v4tov4 listenport=19003 connectaddress=192.168.1.15 connectport=19003") {
			Write-Host "`nA porta 19003 ja existe."
		} else {
			Write-Host "A porta 19003 nao foi encontrada."
			try{
				Write-Host "Criando a porta 19003..."
				netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=19003 connectaddress=192.168.1.15 connectport=19003;
				Write-Host "A porta 19003 foi criada."
			}catch{
				Write-Host "Nao foi possivel criar a porta 19003."
			}
		}
		
	}catch{
		write-host "erro: $_"
	}
	try{
	separador
	Write-Host $endMessage
	Read-Host 
	}catch{
		write-Host "Necessario realizar atualizacao de profile para executar este script"
		write-Host "caminho: \\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\profile"
		read-host
	}
}

#escolha
do {
    $answer = Read-Host @"
deseja executar o script configura interface?
1 - Sim
2 - Nao
Digite o valor desejado
"@
    
    switch ($answer) {
        1 { 
            executaScript
            $modified = 1
        }
        2 {
            Write-Host "Voce escolheu sair sem realizar modificacoes!"
            $modified = 1
        }
        default {
            Write-Host "`nEscolha invalida! Por favor, digite uma opcao valida.`n"
            $modified = 0
        }
    }
} while ($modified -ne 1)


# #  pergunta se quer executar Tutorial_MSI_Installation
$localPath = "\\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\All_RPA_Process"
$list = @("Add_Firewall_Rules.lnk")
executaAtalho -path $localPath -list $list

