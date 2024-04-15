# criar grupos e usuarios "Todos" nas 3 pastas criadas anteriormente - Apply_Permission_For_Paths.ps1
	
	# pasta: ReferenciasWsqolean
	$dirPath = "C:\ReferenciasWsqolean"
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
			try {
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
			} catch {
				Write-Host "Ocorreu um erro ao adicionar a permissao para o grupo '$group': $_"
			}
		}
	};
	
	# pasta: Sequor
	$dirPath = "C:\Program Files (x86)\Sequor"
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
			try {
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
			} catch {
				Write-Host "Ocorreu um erro ao adicionar a permissao para o grupo '$group': $_"
			}
		}
	};
	
	# pasta: projetos
	$dirPath = "C:\Program Files (x86)\Projetos"
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
			try {
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
			} catch {
				Write-Host "Ocorreu um erro ao adicionar a permissao para o grupo '$group': $_"
			}
		}
	};
	
try{
Write-Host $endMessage
Read-Host 
}catch{
	write-Host "Necessário executar atualizacao de profile e executar novamente"
	write-Host "caminho: \\10.208.160.23\clientsupdates$\SuporteMES\Configuracao\profile"
}