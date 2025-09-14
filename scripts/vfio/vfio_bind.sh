#!/usr/bin/env bash
set -x

echo "Stopping display manager and killing GPU processes..."
sudo systemctl stop display-manager

# Kill any remaining processes using GPU
echo "Killing processes using GPU..."
sudo lsof /dev/nvidia* 2>/dev/null | awk '{print $2}' | grep -v PID | xargs -r kill -9
sudo fuser -v /dev/nvidia* 2>/dev/null | grep -o '[0-9]*' | xargs -r kill -9

echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

## Unload nvidia
sudo modprobe -r nvidia_drm
sudo modprobe -r nvidia_modeset
sudo modprobe -r nvidia_uvm
sudo modprobe -r nvidia
sudo modprobe -r ipmi_devintf
sudo modprobe -r ipmi_msghandler

## Load vfio
sudo modprobe vfio
sudo modprobe vfio_iommu_type1
sudo modprobe vfio_pci

## Unbind gpu from nvidia and bind to vfio
sudo virsh nodedev-detach $VIRSH_GPU_VIDEO
sudo virsh nodedev-detach $VIRSH_GPU_AUDIO
# virsh nodedev-detach $VIRSH_GPU_USB
# virsh nodedev-detach $VIRSH_GPU_SERIAL
# ## Unbind ssd from nvme and bind to vfio
# virsh nodedev-detach $VIRSH_NVME_SSD
#
sleep 5
sudo systemctl start display-manager

echo "VFIO drivers added"
