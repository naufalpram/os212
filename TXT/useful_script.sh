#!/bin/bash
# REV00 Sun 19 Sept 2021 16:32:00 WIB
# START Sun 19 Sept 2021 16:32:00 WIB

# This script is used to append an element to a file

FILE="$1"
Append="$2"
echo "File name: $FILE"
echo

# Before appending to file
echo "Before Appending:"
cat $FILE
echo

# After appending to file
echo $Append >> $FILE
echo "After Appending:"
cat $FILE
echo

exit 0
