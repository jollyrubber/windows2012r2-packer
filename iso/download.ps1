$isos = @{
            "9600.16384.WINBLUE_RTM.130821-1623_X64FRE_SERVER_EVAL_EN-US-IRM_SSS_X64FREE_EN-US_DV5.ISO" `
                = "http://download.microsoft.com/download/6/2/A/62A76ABB-9990-4EFC-A4FE-C7D698DAEB96/9600.16384.WINBLUE_RTM.130821-1623_X64FRE_SERVER_EVAL_EN-US-IRM_SSS_X64FREE_EN-US_DV5.ISO";
         }

Import-Module BitsTransfer

Push-Location
Split-Path -Parent $MyInvocation.MyCommand.Definition | Set-Location

foreach($iso in $isos.GetEnumerator()) {

    if(!(Test-Path -Path $iso.Key)) {
        Write-Host -BackgroundColor DarkGreen -ForegroundColor White `
                   "Downloading" $iso.Key
        Start-BitsTransfer `
            -Source $iso.Value `
            -Destination $iso.Key `
            -DisplayName $iso.Key
    }
    else {
        Write-Host -BackgroundColor DarkGreen -ForegroundColor White `
                   "Skipping" $iso.Key
    }
}

Pop-Location