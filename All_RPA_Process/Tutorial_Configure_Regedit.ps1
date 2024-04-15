try{
	Write-Host "Abrindo Regedit..."
	regedit;
	Write-Host "Regedit aberto`n"
	Write-Host "No Regedit, siga os passos:`n"
	
	Write-Host "		1. Acessar caminho: 'Computador\HKEY_LOCAL_MACHINE\SOFTWARE'; `n
	2. Na pasta SOFTWARE, com botao direito do mouse abrir 'permissoes'; `n
	3. Conceder 'controle total' a users, 'aplicar' e 'ok'. `n"
	
	Write-Host "Pressione ENTER assim que concluir o passo-a-passo acima."
    Read-Host 
	Write-Host " "
	separador
	Write-Host " "
	Write-Host "Ainda no Regedit, siga os passos:`n"
	Write-Host "		1. Acessar caminho: 'Computador\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'; `n
	2. No arquivo 'Shell' , clicar com botao direito do mouse e abrir 'Modificar...'; `n
	3. Na lacuna, 'Dados do valor:', inserir o caminho em parenteses: `n(powershell -command `"cd 'C:\Program Files (x86)\Projetos\STIHL\Atualizador\'; .\AtualizacaoMesAutomatica.exe`");`n
	4. Ok."
	
	Write-Host "Pressione ENTER assim que concluir o passo-a-passo acima."
    Read-Host
	Write-Host "Configuracao no regedit concluida!`n"
}catch{
	Write-Host "Falha ao abrir Regedit.`nCaminho do regedit: C:\Windows `n"
	};
	
try{
	Write-Host $endMessage
	Read-Host 
}catch{
	write-Host "Necessario realizar atualizacao de profile para executar este script"
	write-Host "caminho: \\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\profile"
	read-host
} 