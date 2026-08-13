# Training VM build notes - Wayne Lewis

## Windows, x86_64

### Setting up VM

In WSL (Debian):

```
git clone https://github.com/osprey-dcs/training-vm.git

cd training-vm

sudo ./create_vm.sh -f debian -j 2 -g -r https://github.com/osprey-dcs/training-vm.git -b cloud-init
```

`sudo` required to allow access to `kvm`

### Running VM

In WSL (Debian):

```
sudo qemu-system-x86_64 -M q35,accel=kvm:tcg -m 4G -smp 2 -drive file=VMs/debian-x86_64.qcow2,if=virtio -net nic,model=virtio -net user -cpu host
```

`sudo` required to allow access to `kvm`

In PowerShell:

Does not need Administrator privilege.

TODO: Work out acceleration options. Note, `-cpu host` removed, and `kvm` removed from `-accel` options. Painfully slow without acceleration.

```
& 'C:\Program Files\qemu\qemu-system-x86_64.exe' -M q35,accel=tcg -m 4G -smp 2 -drive file=VMs/debian-x86_64.qcow2,if=virtio -net nic,model=virtio -net user
```

In VirtualBox:

* Create VM
* Use generated VDI image.

## aarch64

### Provision VM
sudo ./create_vm.sh -f debian -j 2 -g -r https://github.com/osprey-dcs/training-vm.git -b cloud-init

### Run VM using qemu

sudo qemu-system-aarch64 -M virt,accel=hvf:tcg -m 4G -smp 2 -drive file=VMs/debian-aarch64.qcow2,if=virtio -nic user,model=virtio-net-pci,id=NAT -cpu host -nographic -parallel none -drive if=pflash,format=raw,unit=0,readonly=on,snapshot=off,file=/opt/homebrew/Cellar/qemu/11.0.3/bin/../share/qemu/edk2-aarch64-code.fd -drive if=pflash,format=raw,unit=1,snapshot=off,file=/opt/homebrew/Cellar/qemu/11.0.3/share/qemu/edk2-arm-vars.fd

### MacOS testing

#### cloud-localds

curl -fsSL https://gist.githubusercontent.com/coughingmouse/8be6321b1b050d1552f75de1edcb717e/raw/e8ec2896a970c03a6fecdaab6800dc353752effe/cloud-localds -o cloud-localds

#### mkisofs

brew install cdrtools
