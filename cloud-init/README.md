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
