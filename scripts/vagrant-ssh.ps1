$userPath = "C:\Users\vagrant\.ssh"
if(Test-Path -Path "a:\vagrant.pub") {
    Write-Verbose "getting vagrant.pub from floppy"
    Copy-Item -Path "a:\vagrant.pub" -Destination "$userPath\authorized_keys"
}
else {
    Write-Verbose "downloading vagrant.pub"
    (New-Object System.Net.WebClient). `
        DownloadFile("https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub", `
                     "$userPath\authorized_keys")
}