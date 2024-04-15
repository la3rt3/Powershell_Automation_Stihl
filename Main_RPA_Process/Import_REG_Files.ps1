 # # 1 importacao dos arquivos .reg - import_reg_files.ps1
 write-host "importacao dos arquivos reg."
try {
	write-host "`ndesabilitar_configuracoes_de_entrada_teclado:"
	reg import "\\br00srvcol005r1\frontend$\arquivos_em_lotes\mes\desabilitar_configuracoes_de_entrada_teclado.reg";
	write-host "`ndesabilitar_gestos_touch:"
	reg import "\\br00srvcol005r1\frontend$\arquivos_em_lotes\mes\desabilitar_gestos_touch.reg";
	write-host "`nregistro_ie_mcm-kio:"
	reg import "\\br00srvcol005r1\frontend$\arquivos_em_lotes\mes\registro_ie_mcm-kio.reg";
	write-host "`nShell:"
	reg import "\\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\REG\Shell.reg"
} catch {
	write-host "ocorreu um erro ao importar os arquivos .reg: $_"
};

try{
	Write-Host $endMessage
	Read-Host 
}catch{
	write-Host "Necessario realizar atualizacao de profile para executar este script"
	write-Host "caminho: \\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\profile"
	read-host
} 