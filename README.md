# windows2012r2-packer

A packer project focused on building a Vagrant box of Windows 2012 R2.
Based on [joefitzgerald/packer-windows](https://github.com/joefitzgerald/packer-windows)

## Download ISO

Download thew Windows 2012 R2 Evaluation ISO.
A script called `download.ps1` is located in the iso folder as a convenience.
Run this if you are on a Windows host.

## Building Base Box

This project has a Packer template to build a VirtualBox Vagrant base box.

You will need to install

* [Packer 0.8.x](https://www.packer.io)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

```bash
$ packer build template.json
```

## Running

Building the base box should of created a file called `windows2012r2.virtualbox.box`.
You need to add that to Vagrant. Then you can call `vagrant up` using the `Vagrantfile` included in this project.

You will need to install

* [Vagrant](https://www.vagrantup.com/downloads.html)

```bash
vagrant box add windows2012r2.virtualbox.box --name windows2012r2
vagrant up
```
