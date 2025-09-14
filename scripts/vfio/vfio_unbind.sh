#!/usr/bin/env bash
set -x

echo "Reattaching GPU devices..."
sudo virsh nodedev-reattach $VIRSH_GPU_VIDEO
sudo virsh nodedev-reattach $VIRSH_GPU_AUDIO

## Wait for reattachment to complete
sleep 2

## Reset GPU PCI devices explicitly
echo "Resetting GPU PCI devices..."
for gpu_dev in $(ls /sys/bus/pci/devices/*:*:00.0/); do
    if [[ -e "$gpu_dev/driver_override" ]]; then
        echo "vfio-pci" > "$gpu_dev/driver_override" 2>/dev/null || true
        echo "${gpu_dev##*/}" > /sys/bus/pci/drivers/vfio-pci/unbind 2>/dev/null || true
        echo "" > "$gpu_dev/driver_override" 2>/dev/null || true
    fi
done

## Unload vfio modules
echo "Unloading VFIO modules..."
sudo modprobe -r vfio_pci
sudo modprobe -r vfio_iommu_type1
sudo modprobe -r vfio

## Force reload NVIDIA modules to ensure clean state
echo "Reloading NVIDIA drivers..."
sudo modprobe -r nvidia_uvm nvidia_drm nvidia_modeset nvidia 2>/dev/null || true
sleep 1
sudo modprobe nvidia
sudo modprobe nvidia_modeset
sudo modprobe nvidia_uvm
sudo modprobe nvidia_drm

## Restart display manager to refresh GPU state
echo "Restarting display manager..."
sudo systemctl restart display-manager

echo "NVIDIA drivers restored and display manager restarted"
