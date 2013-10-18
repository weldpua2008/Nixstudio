#!/bin/bash
rm -f KNOPPIX/md5sums; find -type f -not -name md5sums -not -name boot.cat -not -name isolinux.bin -exec md5sum '{}' \; >> KNOPPIX/md5sums
mkisofs -pad -l -r -J -v -V KNOPPIX -no-emul-boot -boot-load-size 4 -boot-info-table -b boot/isolinux/isolinux.bin -c boot/isolinux/boot.cat -hide-rr-moved -o /mnt/hda5/knoppix.iso /mnt/hda2/KnoppixCD/
