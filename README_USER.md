# Training VM User Notes

## Users

EPICS Developer aka `epics-dev`. No password. `sudo` privilege enabled.

Pre-installed IOCs run as `epics-run`. Not writeable by `epics-dev`. Recommended
to copy any pre-installed files/directories to an `epics-dev` writeable
location prior to editing.

## Updating VM

```
cd ~/training/vm-setup
./update.sh ..
```

OR

```
cd ~/training
./vm-setup/update.sh
```

Check for any errors in git submodule updates. If git is unable to update to the
desired submodule commits due to changes, either `git restore ...` or `git
stash` to resolve the issue then rerun the `update.sh` script.

## VM Resources

Suggested minimum: 2 CPUs, 4 GiB RAM
Recommended: 4 CPUs, 6 GiB RAM

## VM Images

Download from:

https://www.dropbox.com/scl/fo/qz06u8y75b7ybnikjcani/AB9Dx1N4AguWj_L174G6N2U?rlkey=m2z6bj3c5m2ksyvytud0acjes&st=265t7t5i&dl=0

Note: filenames in this documentation may vary slightly from those available in
the Dropbox folder.

## Windows, x86_64

### WSL

#### Installing WSL

* Open PowerShell
* wsl --install -d Debian
* (optional) - add WSL to PowerShell profiles (Settings -> Add New Profile ->
    ...)

#### Setting Up Debian (WSL)

* Open Debian session
* Create Debian user (user name is arbitrary)
* Give sudo permissions to created user
* Install packages:
```
$ sudo apt update
$ sudo apt install curl
$ sudo apt install vim git
$ sudo apt install qemu-system-x86 qemu-utils
$ sudo apt install bash-completion
$ sudo apt install git-completion
$ sudo apt install sed
```
* Install any other packages you may want on a Debian system

#### Download `.qcow2` Image

Get the image from the link in [VM images](#vm-images)

#### Transfer Image Into WSL Filesystem

In WSL:

```
$ cd ~
$ mkdir VMs
$ cp /mnt/c/Users/<user-name>/Downloads/epics-training-debian13-x86_64-v3.qcow2
VMs (modify source path depending on download location)
```

#### Launch VM

```
sudo qemu-system-x86_64 -M q35,accel=kvm:tcg -m 4G -smp 2 -drive file=VMs/epics-training-debian13-x86_64-v3.qcow2,if=virtio -net nic,model=virtio -net user -cpu host
```

Adjust CPUs with -smp option, memory with -m option, path to VM image in -drive
option.

`sudo` required to allow access to `kvm`

### VirtualBox

#### Download image

Get the `.ova` image from the link in [VM images](#vm-images)

#### Import the image into VirtualBox

VirtualBox -> File -> Import Appliance -> select downloaded `.ova` file

## macOS, aarch64

### UTM

#### Install UTM application. 

https://mac.getutm.app/

#### Get image

Get the `.utm` folder from the link in [VM images](#vm-images)

#### Import image

Import image into UTM:

* File -> Open
* Locate downloaded epics-training-debian13-aarch64-v3.utm folder
* Select Open

#### Start VM

Adjust CPU, memory prior to starting via Edit option

Select Play button on VM

## Tests

### EPICS

#### Channel Access

```
$ caget EPICSTraining:Ramp
$ camonitor EPICSTraining:Ramp
```

#### IOC console

```
$ socat - unix:/var/run/ioc@iocdemopvs/control
$ socat - unix:/var/run/ioc@iocstats/control
```

### Archiver

#### Web interface

* Double-click "Training-VM Homepage" icon on Desktop
* "Archiver" -> Archiver web interface

### Phoebus

#### Launch Phoebus

```
$ run-phoebus
```

#### Open demo display

```
/opt/opi/training/demo_opis/demopvs.bob
```

#### Test archiver integration

* Right click on any of the PVs on `demopvs.bob`
* Select Data Browser
