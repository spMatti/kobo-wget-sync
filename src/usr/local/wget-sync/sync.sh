#!/bin/sh

# (I know config is called from udev_program.sh) keep config also here so it's easy to dev
BASEDIR=$(dirname $0)
. $BASEDIR/config.sh

# some line might rely that settings directory exists
mkdir -p $wget_sync_settings

# ensure that application is installed
$wget_sync_home/install_app.sh

# wait that internet connection is established
date
echo "$0: connecting..."
$wget_sync_home/ping-test.sh www.google.com
if [ $? != 0 ]; then
    echo "$0: no connection"
    exit 1;
fi
echo "$0: connected"
# ensure that SD card is ready or create virtual SD card
$wget_sync_home/virtual_sd.sh

cd $wget_sync_libfolder
# check if we should reset authentication code
if [ -e $wget_sync_settings/config.sh ]; then
    echo "$0: Loading config.sh.";
    source $wget_sync_settings/config.sh
else
    echo "Did not find $wget_sync_settings/config.sh. Exiting"
    exit 1
fi

#synchronize
echo "$0: Starting Sync";
pwd

mkdir -p "$wget_sync_libfolder"

#get everything with wget, if this fails then everything fails..
wgetoutput=$($wget_sync_settings/script.sh 2>&1 )
#TODO: exit status doesn't work apparently..
wgetstatus=$?
if [ $wgetstatus -ne 0 ]; then
    echo "Something went wrong. Stopping."
    exit 1
fi
echo "$wgetoutput"

numindexes=$(echo "$wgetoutput" | grep -o "since it should be rejected." | wc -l)
wgetresult=$(echo "$wgetoutput" | tail -1)
numdownloads=$(echo "$wgetresult" | grep -o '[0-9]\+\sfiles' | grep -o '[0-9]\+')
echo "----"

numrealdownloads=$((numdownloads - numindexes))
echo "Num indexes: $numindexes | Num downloads: $numrealdownloads"
echo "----"
echo "Sync complete"
echo "----"
if [ $numrealdownloads -ne 0 ] || [ $deletestatus -eq 0 ]; then
    echo "$0: $modified_files_count new file(s). Refresh library.";
    $wget_sync_home/refresh_library.sh
else 
    echo "$0: No new files. Skip library refresh.";
fi
