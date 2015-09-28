if([string]::Compare($env:PACKER_BUILDER_TYPE, "virtualbox-iso", $True) -eq 0) {

    $driveLetter = "E"

    # install cert
    $certUtil = $driveLetter + ":\cert\VBoxCertUtil.exe"
    $cert = $driveLetter + ":\cert\oracle-vbox.cer"
    &$certUtil -v add-trusted-publisher $cert

    # install addtions
    $additions = $driveLetter + ":\VBoxWindowsAdditions.exe"
    &$additions  /S
}
