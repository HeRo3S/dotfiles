#!/usr/bin/env bash

## Unbind gpu from vfio and bind to nvidia
sudo virsh nodedev-reattach $VIRSH_GPU_VIDEO
sudo virsh nodedev-reattach $VIRSH_GPU_AUDIO
# virsh nodedev-reattach $VIRSH_GPU_USB
# virsh nodedev-reattach $VIRSH_GPU_SERIAL
# ## Unbind ssd from vfio and bind to nvme
# virsh nodedev-reattach $VIRSH_NVME_SSD

## Unload vfio
sudo modprobe -r vfio_pci
sudo modprobe -r vfio_iommu_type1
sudo modprobe -r vfio

echo "NVIDIA drivers added"
