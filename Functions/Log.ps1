$logPath = "C:\Automated_MCM_Configuration\Log\script_log.txt"

# Verifica se o diretório do log existe
$logDirectory = Split-Path -Path $logPath -Parent
if (-not (Test-Path -Path $logDirectory)) {
    New-Item -Path $logDirectory -ItemType Directory -Force
}

function Write-Log {
    param (
		[string]$level,
        [string]$message
    )
	write-host $level
	write-host $message
	
	switch ($level) {
		10 {
            $levelTxt = "DEBUG"
        }
        20 {
           $levelTxt = "INFO" 
        }
        30 {
			$levelTxt = "WARNING" 
        }
        40 {
			$levelTxt = 	"ERROR" 
        }
		50 {
            $levelTxt = "CRITICAL"
        }
        default {
            $levelTxt = "NOTSET"
        }
    }
	
	# $cor = $levelTxt.Value
	# define cor
    # Cria o timestamp para a mensagem
    $timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
	
    $logMessage = "$timeStamp [$levelTxt] $message"
    
	Add-content -Path $logPath -value $logMessage

}