function Install-WindowsUpdate([string]$kb, [Uri]$url, [string]$file, [string]$cab)
{
  if (!(Get-HotFix -id $kb -ea SilentlyContinue))
  {
    $temp = (Get-Item -LiteralPath $env:TEMP).FullName
    $out = Join-Path $temp $file
    $extractPath = Join-Path $temp $kb
    $packagePath = Join-Path $extractPath $cab
    $logPath = Join-Path $temp "$kb.dism.log"

    Write-Host("Downloading package...")
    (New-Object System.Net.WebClient).DownloadFile($url, $out)

    Write-Host("Installing update $kb...")
    &wusa $out /extract:$extractPath | Out-Null
    &dism.exe /Online /Add-Package /PackagePath:$packagePath /NoRestart /Quiet /LogPath:$logPath | Out-Null

    if (Get-HotFix -id $kb -ea SilentlyContinue)
    {
      Write-Host("Install success.")
      rm -r "$extractPath"
    }
    else
    {
      throw "Hotfix still not applied after install."
    }
  }
}

# KB2919442
Install-WindowsUpdate "KB2919442" `
    'http://download.microsoft.com/download/C/F/8/CF821C31-38C7-4C5C-89BB-B283059269AF/Windows8.1-KB2919442-x64.msu' `
    "Windows8.1-KB2919442-x64.msu" `
    "Windows8.1-KB2919442-x64.cab"

# KB2919442
Install-WindowsUpdate "KB2919355" `
    'http://download.microsoft.com/download/D/B/1/DB1F29FC-316D-481E-B435-1654BA185DCF/Windows8.1-KB2919355-x64.msu' `
    "Windows8.1-KB2919355-x64.msu" `
    "Windows8.1-KB2919355-x64.cab"

# 3010 means reboot
if ($LastExitCode -eq 3010)
{
    exit 0
}
