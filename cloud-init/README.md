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
sudo qemu-system-x86_64 -M q35,accel=kvm:tcg -m 4G -smp 2 -drive file=VMs/debian.qcow2,if=virtio -net nic,model=virtio -net user -cpu host
```

In PowerShell:


