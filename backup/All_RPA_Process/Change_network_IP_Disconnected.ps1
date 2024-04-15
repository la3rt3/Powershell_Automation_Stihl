$aboutIP = @"
Padrao
	IP: 192.168.1.200
	Mascara de sub-rede: 255.255.255.0
	Salvos nas situacoes de abaixo:

IP da Ethernet 2 do terminal
Coquilhas:
Celula 3 e 4:
	COQ003: 192.168.1.201
	COQ004: 192.168.1.200

Celula 5 e 6:
	COQ005: 192.168.1.201
	COQ006: 192.168.1.200

Celula 7 e 8:
	COQ007: 192.168.1.201
	COQ008: 192.168.1.200

Celula 9 e 10:
	COQ009: 192.168.1.201
	COQ010: 192.168.1.200

Linha Sabres:
	EMB004_SRG004: 192.168.1.200
	REB001_PIN001_CAB029: 192.168.1.201
	
IP das Injetoras:
	INJ068: 192.168.3.1
	INJ070: 192.168.3.1
	INJ072: 192.168.3.1
	INJ079: 192.168.3.1
	INJ101: 192.168.3.1
	INJ102: 192.168.3.1
	INJ008: 192.168.3.1

IP das maquinas REB:
	192.168.1.200

O endereco de IP pode variar caso mais de uma MCM esteja na mesma sub-rede do PLC/Maquina.
Nesse caso utilizar o IP: 192.168.1.201 para a segunda MCM.
link com as informacoes mais recentes: https://confluence01.com.stihlgroup.net/pages/viewpage.action?pageId=139134156
"@
$processName = "IPV4"

function changeIPV4 {
	# Configuracao das portas de rede - change_network_ip_disconnected.ps1
	# Obter informacoes sobre todos os adaptadores de rede
	Write-Host " "
	Write-Host "Configurando as portas de rede."
	
	$networkadapters = Get-NetAdapter
	
	# Variaveis para armazenar o nome e o status do adaptador a ser configurado
	$adapternametoconfigure = $null
	$adapterstatustoconfigure = $null
	
	# Filtrar apenas os adaptadores com status "disconnected"
	$disconnectedadapters = $networkadapters | Where-Object { $_.Status -eq "Disconnected" }
	
	# Encontrar o primeiro adaptador com status "disconnected"
	foreach ($adapter in $disconnectedadapters) {
		$adapternametoconfigure = $adapter.Name
		$adapterstatustoconfigure = $adapter.Status
		break  # Encerrar o loop apos encontrar o primeiro adaptador com status "disconnected"
	}
	
	# Verificar se um adaptador com status "disconnected" foi encontrado
	if ($adapternametoconfigure -ne $null) {
		Write-Host "Nome do adaptador a ser configurado: $adapternametoconfigure"
		Write-Host "Status do adaptador a ser configurado: $adapterstatustoconfigure"
		separador
	
		# Obter informacoes do endereco IPv4 e da mascara de sub-rede antes da alteracao
		$ipInfoBefore = Get-NetIPAddress -InterfaceIndex $adapter.InterfaceIndex -AddressFamily IPv4
		$ipv4Before = $ipInfoBefore.IPAddress -notmatch '169.254'
		$subMaskBefore = $ipInfoBefore.PrefixLength -notmatch '16'
		
		Write-Host "Configuracao Atual (Antes):"
		Write-Host "Nome: $adapternametoconfigure"
		Write-Host "Endereco IPv4: $ipv4Before"
		Write-Host "Mascara de Sub-rede: $($subMaskBefore)"
		separador
	
		# Etapa 6: Configurar o protocolo IP versao 4 (TCP/IPv4) com o IP e mascara de sub-rede especificados
		$subnetmask = "255.255.255.0"
	
		# Configurar o protocolo IP versao 4 (TCP/IPv4) usando o comando "netsh"
		$command = "netsh interface ipv4 set address name='$adapternametoconfigure' static $ipv4address $subnetmask"
		Invoke-Expression $command
	
		# Obter informacoes do endereco IPv4 e da mascara de sub-rede apos a alteracao
		$ipInfoAfter = Get-NetIPAddress -InterfaceIndex $adapter.InterfaceIndex -AddressFamily IPv4
		$ipv4After = $ipInfoAfter.IPAddress
		$subMaskAfter = $ipInfoBefore.PrefixLength -notmatch '16'
		
		Write-Host "Configuracao Atual (Depois):"
		Write-Host "Nome: $adapternametoconfigure"
		Write-Host "Endereco IPv4: $ipv4After"
		Write-Host "Mascara de Sub-rede: $($ipInfoAfter.PrefixLength)"
		separador
	
		Write-Host "Configuracao do protocolo IP versao 4 (TCP/IPv4) concluida com sucesso para o adaptador '$adapternametoconfigure'."
		separador
		
	} else {
		Write-Host "Nenhum adaptador de rede com status 'Disconnected' encontrado. Necessario formatacao da TI ou verificar se ha 2 portas de rede."
		ncpa.cpl
		Write-Host "Tutorial de como alterar o IP de rede:"
		Write-Host '1 - Entre nas propriedades da porta Ethernet 2 ou a que estiver desconectada e que nao tenha descricao igual a "root.dir";'
		Write-Host '2 - Selecione o "Protocolo IP Versao 4 (TCP/IPV4)" e clique em propriedade IPVA;'
		Write-Host '3 - selecione a segunda check-box e atribua ao "Endereco de IP": $ipv4address e para a "Mascara de sub-rede": $subnetmask e clique em OK'
	}
}

do {
    $answer = Read-Host @"
Escolha uma das opcoes abaixo:
1 - 192.168.1.200 (Padrao);
2 - 192.168.1.201;
3 - 192.168.3.1;
4 - Outro IP;
5 - Nao realizar mais alteracoes;
6 - Ajuda (sobre IP).
Digite o valor desejado
"@
    separador
    switch ($answer) {
        1 {
            $ipv4address = "192.168.1.200" 
            changeIPV4
            $modified = 0
        }
        2 {
            $ipv4address = "192.168.1.201"
            changeIPV4
            $modified = 0
        }
        3 {
            $ipv4address = "192.168.3.1"
            changeIPV4
            $modified = 0
        }
        4 {
			$ipv4address = confirmaValor $processName
			changeIPV4
            Write-Host " "
            $modified = 0
        }
		5 {
            Write-Host "Voce escolheu sair!"
            $modified = 1

        }
		6 {
			Write-Host " "
            Write-Host $aboutIP
			$modified = 0
			
        }
        default {
            Write-Host "`nEscolha invalida! Por favor, digite uma opcao valida.`n"
            $modified = 0
        }
    }
	try{
		
		Write-Host $endMessage
		Read-Host 
		separador
	}catch{
		write-Host "Necessario realizar atualizacao de profile para executar este script"
		write-Host "caminho: \\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\profile"
		read-host
	}
} while ($modified -ne 1)