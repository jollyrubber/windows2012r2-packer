if([string]::Compare($env:PACKER_BUILDER_TYPE, "virtualbox-iso", $True) -eq 0) {

	# mount
    $imagePath = "C:\Users\vagrant\VBoxGuestAdditions.iso"
    Mount-DiskImage -ImagePath $imagePath
	#copy
    $source = (Get-DiskImage $imagePath | Get-Volume).DriveLetter + ":\"
    $target = "C:\Windows\Temp\virtualbox"
    Copy-Item $source $target -Recurse
	# unmount
    Dismount-DiskImage $imagePath
	Remove-Item -Path $imagePath -Force
	# install cert
    $certUtil = $target + "\cert\VBoxCertUtil.exe"
    $cert = $target + "\cert\oracle-vbox.cer"
    &$certUtil -v add-trusted-publisher $cert
	# install addtions
    $additions = $target + "\VBoxWindowsAdditions.exe"
    &$additions  /S
	
	# be patient
	Start-Sleep -Seconds 10
}