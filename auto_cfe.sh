#!/bin/sh

nvram get bl_version
cat /dev/mtd0 > ./old_cfe.bin

echo
echo Old CFE content:
strings old_cfe.bin | grep -e mac -e secret > /tmp/cfe.old.key
cat /tmp/cfe.old.key
echo

replace()
{
   KEYWORD=$1
   SIZE=$2
   echo replacing $KEYWORD with $SIZE bytes
   I_OFFSET="`strings -o old_cfe.bin | grep $KEYWORD | awk '{print $1}'`"
   O_OFFSET="`strings -o new_cfe.bin | grep $KEYWORD | awk '{print $1}'`"
   let I_OFFSET="0$I_OFFSET"
   let O_OFFSET="0$O_OFFSET"
   I_OFFSET=`expr $I_OFFSET + ${#KEYWORD} + 1`
   O_OFFSET=`expr $O_OFFSET + ${#KEYWORD} + 1`
   echo "Offsets: $I_OFFSET -> $O_OFFSET"
   dd if=old_cfe.bin of=new_cfe.bin bs=1 count=$SIZE conv=notrunc skip=$I_OFFSET seek=$O_OFFSET 2>/dev/null
}

replace et0macaddr 17
replace 0:macaddr 17
replace 1:macaddr 17
replace secret_code 8

echo
echo New CFE content:
strings new_cfe.bin | grep -e mac -e secret > /tmp/cfe.new.key
cat /tmp/cfe.new.key
echo

# it is reported that diff is not available on stock rom, so I am changing to a more raw method
# If someone can test and report back, that'd be great.
#diff /tmp/cfe.new.key /tmp/cfe.old.key
STR1="`cat /tmp/cfe.new.key`"
STR2="`cat /tmp/cfe.old.key`"
if [ "$STR1" != "$STR2" ];then
   echo "something went wrong in crafting the new CFE image, please go back to the old manual method."
else
   echo "updating CFE..."
   ./mtd-write -i new_cfe.bin -d boot
   mtd-erase2 nvram
   sync;sync;sync
   echo "rebooting..."
   echo "if you do not trust mtd-erase2, manually clear nvram by holding WPS button for 20 seconds when powering on"
   reboot
fi

