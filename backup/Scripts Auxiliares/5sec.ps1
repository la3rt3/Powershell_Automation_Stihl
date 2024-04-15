# Definir o nome do adaptador de rede
$adapterName = "ETH2"

# Encontra o adaptador de rede pelo nome
$adapter = Get-NetAdapter | Where-Object { $_.Name -eq $adapterName }

# Verifica se o adaptador foi encontrado
if ($adapter) {
    Write-Host "Desconectando o adaptador de rede '$adapterName'..."

    # Desativa o adaptador
    Disable-NetAdapter -Name $adapterName -Confirm:$false

    # Aguarda 5 segundos
    Start-Sleep -Seconds 1

    Write-Host "Reconectando o adaptador de rede '$adapterName'..."

    # Ativa o adaptador
    Enable-NetAdapter -Name $adapterName -Confirm:$false

    Write-Host "Operação concluída com sucesso!"
} else {
    Write-Host "Adaptador de rede '$adapterName' não encontrado."
}
