#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage $0 <path-to-deb-pack>"
  exit 1
fi

#Set path to deb-pack
DEB_PACKAGE=$1

#Create a temporary directory to extract the contents of the deb-pack
WORK_DIR=$(mktemp -d)

#Extract deb-pack contents to temporary directory 
dpkg-deb -x $DEB_PACKAGE $WORK_DIR >> /dev/null/ 2>&1

#Get list executable files
EXEC_FILES=$(find $WORK_DIR -type f -executable) >> /dev/null/ 2>&1

#Get all libraries list
LIBS=$(ldd $EXEC_FILES | grep -oE '/lib.*\.[0-9]') >> /dev/null/ 2>&1

#Get all packages list 
PACKAGES=$(dpkg -S $LIBS | cut -d: -f1 | sort -u) >> /dev/null/ 2>&1 
if [ -z "$PACKAGES" ]; then
  echo "For execute files from $DEB_PACKAGE all packages installed"
else

#Print a list of required packages that need to be installed
echo "For execute files in $DEB_PACKAGE need install this packages:"
echo "$PACKAGES"
fi

#Request to print all packs for deb-pack
while true; do
  read -p "Print all pack-list in file required_packs_for_$(basename "$DEB_PACKAGE")_$(date +%d_%m_%Y)?(y/n)" choice
  case "$choice" in
    y|Y|yes|Yes|YES )
    #Get all lib list
    ALL_LIBS=$(ldd $EXEC_FILES | grep -oE '/lib.*\.[0-9] | /usr/lib.*\.[0-9]') >> /dev/null/ 2>&1 

    #Get all packages list
    ALL_PACKAGES=$(dpkg -S $ALL_LIBS | cut -d: -f1 | sort -u) >> /dev/null/ 2>&1

    #Print list all packs
    echo "Packages list for all required files from $DEB_PACKAGE successful save in required_packs_for_$(basename "$DEB_PACKAGE")_$(date +%d_%m_%Y)"
    echo "ALL_PACKAGES" >> required_packs_for_$(basename "$DEB_PACKAGE")_$(date +%d_%m_%Y)
    break;;
    n|N|No|no|NO ) break;;
    * ) echo "Please enter y or n";;
  esac
done

rm -rf $WORK_DIR
