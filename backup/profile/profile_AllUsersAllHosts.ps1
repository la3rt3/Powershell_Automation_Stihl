try{
	$PSDefaultParameterValues['*:Encoding'] = 'utf8'

}catch{
	write-host "erro: $_"
}

try{
$profileConfig = @'
$allProcessPath = "\\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\All_RPA_Process"
$mainProcessPath = "\\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\Main_RPA_Process"
$configPath = "\\10.208.160.23\clientsupdates$\SuporteMES\Configuracao"

$endMessage = "`nPressione ENTER para finalizar"

#cria 45 linhas de espacamento
function limpaLinha {
    for ($i = 1; $i -le 45; $i++) {
        Write-Host " "
    }
}

function separador {
	write-host "----------------------------------------------------------"
}

#metodo pede o nome do processo em questao, solicita o valor a ser confirmado pelo usuario e retorna esse mesmo valor assim que confirmado.
function confirmaValor{
	param ([string]$processName)
	do {
		$value = Read-Host "`nDigite o $processName desejado"
		$confirmation = Read-Host "Voce digitou '$value'. Confirma? (S/N)"
		write-host ""
		if ($confirmation -eq "S" -or $confirmation -eq "s") {		
			try {
				return $value
				break
			} catch {
				Write-Host "Ocorreu um erro no retorno do '$processName': $_"				
			}
		}
		elseif ($confirmation -eq "N" -or $confirmation -eq "n") {
			Write-Host "Digite o $processName novamente."
		}
		else {
			Write-Host "Opcao invalida. Digite 'S' para confirmar ou 'N' para redefinir o $processName.`n"
		}
	}while ($true)
}

#executa um atalho do tipo .lnk
function executaAtalho {
	param (
		[string]$path,
        [array]$list
	)
	
foreach($process in $list){
	do{
		$confirmation = Read-Host "Quer executar o processo: $process (S/N)"
		if ($confirmation -eq "S" -or $confirmation -eq "s") {
			try{
				$file = Get-ChildItem -path $path -Filter $process
				Write-Host "`nExecutando: $file`n"
			try{
				Invoke-Expression $file.FullName
				Write-Host "Comando Invoke-Expression bem sucedido!"
			}catch{
				Write-Host "Comando Invoke-Expression falhou, testando Start-Process..."
				try{
					start-process $file.FullName
					Write-Host "Comando Start-Process bem sucedido!"
				}catch{
					Write-Host "Comando Start-Process falhou!"
					}
				}
			}
			catch{
				Write-Host "erro: $_`n"	
				}
			Write-Host "Pressione ENTER ao finalizar o processo: $file"
			Read-Host
			break
			}
		elseif ($confirmation -eq "N" -or $confirmation -eq "n") {
			Write-Host "Processo $process foi recusado."
			break
			}
		else{
			Write-Host "Opcao invalida. Digite 'S' para confirmar ou 'N' para recusar execucao.`n"
			}
		} while ($true)
	}
}

#menssagem
echo "Bem vindo ao Powershell IMS!"
'@
if(Test-Path $profile.AllUsersAllHosts -PathType Leaf){
	# cria e escreve no arquivo
	Remove-Item -Path $profile.AllUsersAllHosts
	new-Item $profile.AllUsersAllHosts
	Add-Content -Path $profile.AllUsersAllHosts -Value $profileConfig
}else{
	# remove, cria e Escrever no arquivo
	new-Item $profile.AllUsersAllHosts
	Add-Content -Path $profile.AllUsersAllHosts -Value $profileConfig
}
}catch{
	write-host "erro: $_"
}

$endMessage = "`nPressione ENTER para finalizar"
write-host $endMessage
read-host