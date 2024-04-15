$mainPath = "\\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\Main_RPA_Process"
$profilePath = "\\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\profile"
$count = 1

$profileFile = Get-ChildItem -path $profilePath -Filter *.lnk
try{
	Write-Host "Atualizando profile..."
	Invoke-Expression $profileFile.FullName
	sleep 4
	Write-Host "Profile Atualizado!`n"
}catch{
	Write-Host "erro: _$"
}



try{
$processFiles = Get-ChildItem -path $mainPath -Filter *.lnk
}catch{
	Write-Host "erro: _$"
}
# atualiza profile (abaixo criar substituição para o invoke $PROFILE fazendo a execussão dele sem abrir um novo Host)
# $scriptProfilePath = "\\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\profile\profile_AllUsersAllHosts.ps1"
# Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File $scriptProfilePath" -WindowStyle Hidden

# looping de execussão dos Processos
foreach ($file in $processFiles){
    $name = $file.BaseName
    # looping de $confirmacao do usuario
	do{
	    $confirmation = Read-Host "Quer executar o processo: $name (S/N)" 
        if ($confirmation -eq "S" -or $confirmation -eq "s") {
            Write-Host "$count -  $name`n"
			try{
				Invoke-Expression $file.FullName
			}catch{
				Write-Host "erro: _$"
			}
            $count = $count+1
            break
        }
        elseif ($confirmation -eq "N" -or $confirmation -eq "n") {
	    	Write-Host "Voce escolheu pular o processo $count - $name.`n"
			$count = $count+1
            break
	    }
	    else{
	    	Write-Host "Opcao invalida. Digite 'S' para confirmar ou 'N' para recusar execucao.`n"
	    }
    } while ($true)
}

#REINICIAR
try{
$process = "reiniciar MCM"
do{
	    $confirmation = Read-Host "Quer executar o processo: $process (S/N)" 
        if ($confirmation -eq "S" -or $confirmation -eq "s") {
            Write-Host "Reiniciando computador dentro de 5 segundos..."
			sleep 5
            Restart-Computer
            break
        }
        elseif ($confirmation -eq "N" -or $confirmation -eq "n") {
	    	Write-Host "Voce escolheu pular o processo $process.`n"
			$count = $count+1
            break
	    }
	    else{
	    	Write-Host "Opcao invalida. Digite 'S' para confirmar ou 'N' para recusar execucao.`n"
	    }
    } while ($true)
}catch{
	Write-Host "erro: $_`n"	
}



try{
	Write-Host "O Processo chegou ao fim!"
	powershell.exec
}catch{
	Write-Host "erro: $_"
	Write-Host "O Processo chegou ao fim! Pressione ENTER para sair."
	readhost
}