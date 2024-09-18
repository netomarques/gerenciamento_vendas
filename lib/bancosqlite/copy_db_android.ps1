# Caminho para o arquivo no dispositivo Android
$deviceFilePath = "/storage/emulated/0/Android/data/br.com.wilsonnetodev.vendas_gerenciamento/files/vendaspanai_exportado.db"

# Caminho para o diretório no computador
$localDirectory = "D:\ProjetoVenda\gerenciamento_vendas\lib\bancosqlite"

# Comando ADB para copiar o arquivo
adb pull $deviceFilePath $localDirectory

Write-Output "Arquivo copiado com sucesso para $localDirectory."