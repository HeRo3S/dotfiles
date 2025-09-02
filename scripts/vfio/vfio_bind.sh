#!/usr/bin/env bash

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
echo "VFIO drivers added"
