#Alterar AtualizacaoMesAutomatica.exe.config - Alter_IPCLP_Tag.ps1
$configFilePath = "C:\Program Files (x86)\Projetos\STIHL\Atualizador\AtualizacaoMesAutomatica.exe.config"
$key = "IPCLP"
function alterIPCLP {

	
# Verifica se a chave foi encontrada
if ($ipclpNode) {
	# Altera o valor da chave para "$value"
	$ipclpNode.value = $value

	# Salva as alterações no arquivo
	$configXml.Save($configFilePath)

	Write-Host "Valor da chave '$key' alterado para '$value' com sucesso."
} else {
	Write-Host "Chave '$key' nao encontrada no arquivo de configuracao."
}	
}

# verifica se o caminho existe
if (Test-Path $configFilePath) {
	# Carrega o conteúdo do arquivo de configuração como um objeto XML
	$configXml = [xml](Get-Content $configFilePath)

	# Procura a chave "$key" no arquivo de configuração
	$ipclpNode = $configXml.configuration.appSettings.add | Where-Object { $_.key -eq $key }
	
	Write-Host "`nNesta etapa podemos alterar a chave do $key de acordo com a sua necessidade.`n"

do {
    $answer = Read-Host @"
Escolha uma das opcoes abaixo:
1 - LocalHost
2 - 192.168.1.15
3 - 192.168.1.16
4 - NAO ALTERAR
Digite o valor desejado
"@
    
    switch ($answer) {
        1 {
            $value = "localhost" 
            alterIPCLP
            $modified = 1
        }
        2 {
            $value = "192.168.1.15"
            alterIPCLP
            $modified = 1
        }
        3 {
            $value = "192.168.1.16"
            alterIPCLP
            $modified = 1
        }
        4 {
            Write-Host "Voce escolheu sair sem realizar modificacoes!"
            $modified = 1
        }
        default {
            Write-Host "`nEscolha invalida! Por favor, digite uma opcao valida.`n"
            $modified = 0
        }
    }
} while ($modified -ne 1)

}else{
		Write-Host "Arquivo de configuracao nao encontrado em '$configFilePath'.
		obs: verificar se os arquivos de software existem, possivel erro na importacao dos arquivos."
}

Write-Host $endMessage
Read-Host



