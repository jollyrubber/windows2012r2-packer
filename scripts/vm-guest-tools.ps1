Import-Module BitsTransfer

if([string]::Compare($env:PACKER_BUILDER_TYPE, "virtualbox-iso", $True) -eq 0) {

    $vboxVersion = Get-Content ~\.vbox_version
    $isoFile = [string]::Format("VBoxGuestAdditions_{0}.iso", $vboxVersion)
    $isoUrl = [string]::Format("http://download.virtualbox.org/virtualbox/{0}/{1}", $vboxVersion, $isoFile)

    Push-Location
    Set-Location $env:TEMP

    # download ISO
    if(!(Test-Path -Path $isoFile)) {
            Start-BitsTransfer -Source $isoUrl -Destination $isoFile
    }

    # mount
    $imagePath = Join-Path $env:TEMP $isoFile
    Mount-DiskImage -ImagePath $imagePath
    # copy
    $source = (Get-DiskImage $imagePath | Get-Volume).DriveLetter + ":\"
    $target = Join-Path $env:TEMP "virtualbox"
    Remove-Item $target -Recurse -Force -ErrorAction SilentlyContinue
    Copy-Item $source $target -Recurse
    # unmount
    Dismount-DiskImage $imagePath
    Remove-Item -Path $imagePath -Force
    # install cert
    $certUtil = Join-Path $target "cert\VBoxCertUtil.exe"
    $cert = Join-Path $target "cert\oracle-vbox.cer"
    &$certUtil -v add-trusted-publisher $cert
    # install addtions
    $additions = Join-Path $target "VBoxWindowsAdditions.exe"
    &$additions  /S

    Pop-Location
}
