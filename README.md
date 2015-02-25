# windows2012r2-packer
A packer project focused on building a Vagrant box of Windows 2012 R2. Based on [joefitzgerald/packer-windows](https://github.com/joefitzgerald/packer-windows)

# Setup Packer
* Download [Packer](https://www.packer.io)
* Extract and add to to your path

# Download ISO
Download thew Windows 2012R2 Evaluation ISO. A script called `download.ps1` is located in the iso folder as a convenience. Run this if you are on a Windows host.

# Build
```bash
$ packer build template.json
```
