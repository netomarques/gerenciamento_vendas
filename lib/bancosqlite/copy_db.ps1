# Caminho para o arquivo exportado
$sourcePath = "Este Computador\moto e(7)\Armazenamento interno compartilhado\Android\data\br.com.wilsonnetodev.vendas_gerenciamento\files\vendaspanai_exportado.db"

# Caminho para o diretório do projeto
# $projectPath = "C:\path\to\your\flutter\project"
$projectPath = "D:\ProjetoVenda\gerenciamento_vendas\lib\bancosqlite"

# Copia o arquivo para o diretório do projeto
Copy-Item -Path $sourcePath -Destination $projectPath

Write-Output "Arquivo copiado com sucesso para o diretório do projeto."