#!/bin/bash
# Copyright (C) 2020-2021 Cicak Bin Kadal

# This free document is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# REV02 Sun 19 Sep 2021 15:44:11 WIB
# REV01 Sun 19 Sept 2021 16:41:47 WIB
# REV00 Sun 12 Sep 2021 03:10:00 WIB
# START Sun 12 Sep 2021 03:10:00 WIB

REC2="naufal.pramudya@ui.ac.id"
REC1="operatingsystems@vlsm.org"
FILES="my*.asc my*.txt my*.sh"
SHA="SHA256SUM"

[ -d $HOME/RESULT/ ] || mkdir -p $HOME/RESULT/
pushd $HOME/RESULT/
for II in W?? ; do
    [ -d $II ] || continue
    TARFILE=my$II.tar.bz2
    TARFASC=$TARFILE.asc
    rm -f $TARFILE $TARFASC
    echo "tar cfj $TARFILE $II/"
    tar cfj $TARFILE $II/
    echo "gpg --armor --output $TARFASC --encrypt --recipient $REC1 --recipient $REC2 $TARFILE"
    gpg --armor --output $TARFASC --encrypt --recipient $REC1 --recipient $REC2 $TARFILE
done
popd

for II in $HOME/RESULT/myW*.tar.bz2.asc ; do
   echo "Check and move $II..."
   [ -f $II ] && mv -f $II .
done

# Remove formerly made files
echo "rm -f $SHA $SHA.asc"
rm -f $SHA $SHA.asc

# Get all sha256 sum of all files
echo "sha256sum $FILES > $SHA"
sha256sum $FILES > $SHA

# Checksum of the sha
echo "sha256sum -c $SHA"
sha256sum -c $SHA

# Sign the sha
echo "gpg --output $SHA.asc --armor --sign --detach-sign $SHA"
gpg --output $SHA.asc --armor --sign --detach-sign $SHA

# Verify the sign
echo "gpg --verify $SHA.asc $SHA"
gpg --verify $SHA.asc $SHA

exit 0
