[System.Reflection.Assembly]::LoadWithPartialName("System.IO.Compression.FileSystem") | Out-Null

# Ultra Defrag
$pathToZip = "C:\Windows\Temp\ultradefrag.zip"
if(!(Test-Path -Path $pathToZip)) {
    # download
    Write-Verbose "downloading ultradefrag"
    (New-Object System.Net.WebClient). `
        DownloadFile("http://downloads.sourceforge.net/project/ultradefrag/stable-release/6.1.0/ultradefrag-portable-6.1.0.bin.amd64.zip", `
                     $pathToZip)
}
$ultradefrag = "C:\Windows\Temp\ultradefrag-portable-6.0.2.amd64\udefrag.exe"
if(!(Test-Path -Path $ultradefrag)) {
    # extract
    Write-Verbose "extracting ultradefrag"
    [System.IO.Compression.ZipFile]::ExtractToDirectory($pathToZip, "C:\Windows\Temp")
}
# run
Start-Process "$ultradefrag" -ArgumentList "--optimize --repeat C:" -NoNewWindow -Wait

# SDelete
$pathToZip = "C:\Windows\Temp\SDelete.zip"
if(!(Test-Path -Path $pathToZip)) {
    # download
    Write-Verbose "downloading sdelete"
    (New-Object System.Net.WebClient). `
        DownloadFile("http://download.sysinternals.com/files/SDelete.zip", `
                     $pathToZip)
}
$sdelete = "C:\Windows\Temp\sdelete.exe"
if(!(Test-Path -Path $sdelete)) {
    # extract
    Write-Verbose "extracting sdelete"
    [System.IO.Compression.ZipFile]::ExtractToDirectory($pathToZip, "C:\Windows\Temp")
}
# run
$sdeleteRegKey = "HKCU:\Software\Sysinternals\SDelete"
if(!(Test-Path -Path $sdeleteRegKey)) {
    New-Item -Path $sdeleteRegKey
    New-ItemProperty -Path $sdeleteRegKey -Name "EulaAccepted" -Value 1 -PropertyType "DWord"
}
Start-Process "$sdelete" -ArgumentList "-q -z C:" -NoNewWindow -Wait
Remove-Item $sdeleteRegKey

# clean out windows updates
Stop-Service wuauserv
Get-ChildItem -Path "C:\Windows\SoftwareDistribution\Download" -Include * | Remove-Item -Recurse
Start-Service wuauserv
