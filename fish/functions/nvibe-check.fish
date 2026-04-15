function nvibe-check --wraps='cat /sys/bus/pci/devices/0000:01:00.0/power_state' --description 'alias nvibe-check=cat /sys/bus/pci/devices/0000:01:00.0/power_state'
    cat /sys/bus/pci/devices/0000:01:00.0/power_state $argv
end
