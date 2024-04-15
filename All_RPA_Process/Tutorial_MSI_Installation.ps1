$nextMessage = 'Pressione ENTER assim que concluir o passo-a-passo acima.'
# # Tutorial_MSI_Installation.ps1
	try{
	Write-Host "Abrindo Notepad..."
	notepad;
	Write-Host "Notepad aberto `n"
	Write-Host "No notepad, siga os passos:"
	
	Write-Host "		1. acessar arquivo>abrir; `n
	2. Acessar caminho: 'C:\Program Files (x86)\Softwares MES'; `n
	3. No canto inferior direito, selecione a opcao 'Todos arquivo (*.*)' da combobox. `n
	4. Deve aparecer 4 pacotes do tipo '.MSI'"
	
	Write-Host $nextMessage
    Read-Host
	separador
	Write-Host "Ainda no Notepad, siga os passos:"
	Write-Host "		1. Em 'OPC.NET' ir em propriedades'; `n
	2. Acessar a aba compatibilidade; `n
	3. Em 'modo de compatibilidade' habilitar a caixa 'Executar este programa em modo de compatibilidade'; `n
	4. Aplicar e Ok."
	
	Write-Host $nextMessage
    Read-Host
	separador
	Write-Host "Instalar 'OPC.NET', siga os passos:"
	Write-Host "		1. Clicar com botao direito do mouse e instalar;`n
	2. Selecionar a opcao 'Install Development Enviroment'; `n
	3. Inserir caminho (quando solicitado): 'C:\Program Files (x86)\OPC'; `n
	4. Selecionar a opcao Everyone"
	
	Write-Host $nextMessage
    Read-Host
	separador
	Write-Host "Instalar HID-OMINIKEY, siga os passos:`n
	1. Marcar a opcao 'complete' quando solicitado."
	
	Write-Host $nextMessage
    Read-Host
	separador
	Write-Host "Instalar HID_Global_USB. nao ha requisitos para esta instalacao :)`n"
	
	Write-Host $nextMessage
    Read-Host
	separador
	Write-Host "Instalar Sequor Service Global Variables. `n:
	Durante a instalacao verificar:`n
	1. Diretorio da instalacao: 'C:\Program Files (x86)\Sequor\Sequor Service Global Variables\'; `n
	2. Marcar a opcao 'Everyone' se nao estiver selecionada."
	
	Write-Host $nextMessage
       Read-Host
	
	Write-Host "Instalacao dos pacotes concluida!`n"
	}catch{
		Write-Host "Falha ao abrir Notepad.`nCaminho do notepad: C:\Windows`n"
	}
	Write-Host $endMessage
	Read-Host 