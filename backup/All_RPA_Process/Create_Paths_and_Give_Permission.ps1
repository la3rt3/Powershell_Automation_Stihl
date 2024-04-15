# # 4  cria pastas "OPC" e "SOFTWARES MES" com acesso de "Users" e "Todos" - Create_Paths_and_Give_Permission.ps1
Write-Host "`nAguarde, este processo pode demorar um pouco."
$dirPath = "C:\Program Files (x86)"
$groups = @("Todos", "Users")

# Define as permissoes que deseja conceder (controle total)
$permissions = "FullControl"

$accessControl = Get-Acl -Path $dirPath

foreach ($group in $groups) {
	# Verifica se o grupo ja existe nas permissoes
	$existingRule = $accessControl.Access | Where-Object { $_.IdentityReference -eq $group }

	if ($existingRule) {
		Write-Host "O grupo '$group' ja possui permissoes no diretorio."
	} else {
		# Cria a regra de permissao para o grupo atual com o mesmo acesso
		$rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
			$group,
			$permissions,
			"ContainerInherit, ObjectInherit",
			"None",
			"Allow"
		)

		# Adiciona a regra ao conjunto de permissoes
		$accessControl.AddAccessRule($rule)

		# Aplica as alteracoes ao diretorio
		Set-Acl -Path $dirPath -AclObject $accessControl
		Write-Host "Permissao adicionada com sucesso ao diretorio $dirPath para o grupo '$group'."
	}
};

# Cria as pastas "Softwares MES" e "OPC" (verificar OPC)
$softwaresMESPath = Join-Path $dirPath "Softwares MES"
$opcPath = Join-Path $dirPath "OPC"

if (!(Test-Path $softwaresMESPath)) {
	New-Item -ItemType Directory -Path $softwaresMESPath | Out-Null
	Write-Host "Pasta 'Softwares MES' criada com sucesso."
}

if (!(Test-Path $opcPath)) {
	New-Item -ItemType Directory -Path $opcPath | Out-Null
	Write-Host "Pasta 'OPC' criada com sucesso."
};

# Aplica as mesmas permissoes das pastas anteriores às novas pastas
$softwaresMESAccessControl = Get-Acl -Path $softwaresMESPath
$opcAccessControl = Get-Acl -Path $opcPath

foreach ($group in $groups) {
	$existingRuleSoftwaresMES = $softwaresMESAccessControl.Access | Where-Object { $_.IdentityReference -eq $group }
	$existingRuleOPC = $opcAccessControl.Access | Where-Object { $_.IdentityReference -eq $group }

	if (!$existingRuleSoftwaresMES) {
		$rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
			$group,
			$permissions,
			"ContainerInherit, ObjectInherit",
			"None",
			"Allow"
		)
		$softwaresMESAccessControl.AddAccessRule($rule)
	}

	if (!$existingRuleOPC) {
		$rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
			$group,
			$permissions,
			"ContainerInherit, ObjectInherit",
			"None",
			"Allow"
		)
		$opcAccessControl.AddAccessRule($rule)
	}
};

Set-Acl -Path $softwaresMESPath -AclObject $softwaresMESAccessControl;
Set-Acl -Path $opcPath -AclObject $opcAccessControl;

Write-Host "Permissoes aplicadas com sucesso as pastas 'Softwares MES' e 'OPC'.";
Write-Host $endMessage
Read-Host 