#!/bin/bash
clear
echo "This script flashes everything Android related, this includes boot, recovery, system, product, etc. This script skips bootloader components, which means it is completely
safe, unable to hard brick your device, but depending on the device, you may NEED to flash bootloader images for Android to boot."
sleep 18
adb start-server
adb reboot bootloader
fastboot reboot bootloader
fastboot flash recovery recovery.img
fastboot flash dtbo dtbo.img
fastboot flash vendor_boot vendor_boot.img
fastboot flash boot boot.img
fastboot flash vbmeta vbmeta.img
fastboot flash vbmeta_system vbmeta_system.img
fastboot flash vbmeta_vendor vbmeta_vendor.img
clear
echo "Rebooting Into Userspace Fastboot! (FASTBOOTD)"
sleep 3
fastboot reboot fastboot
fastboot flash system system.img
fastboot flash system_ext system_ext.img
fastboot flash system_dlkm system_dlkm.img
fastboot flash odm odm.img
fastboot flash vendor vendor.img
fastboot flash vendor_dlkm vendor_dlkm.img
fastboot flash product product.img
clear
PS3="What Now?"
options=("Reboot To System" "Reboot To Recovery" "Reboot To Bootloader" "Exit Script For Extended Flashing")
select opt in "${options[@]}"
do
case $opt in
"Reboot To System")
fastboot reboot
;;
"Reboot To Recovery")
fastboot reboot recovery
;;
"Reboot To Bootloader")
fastboot reboot bootloader
;;
"Exit Script For Extended Flashing")
exit
;;
*)
echo "Invalid Option: $REPLY"
;;
esac
done
