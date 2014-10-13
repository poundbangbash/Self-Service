#!/bin/bash
#Check if file exists to prompt user that computer was shut down improperly.
# This file is not deletable by non-admin users so the prompt appears after every reboot

currentPanicFile="/private/var/db/PanicReporter/current.panic"

if [ -f $currentPanicFile ]
then
    echo `date` " $currentPanicFile found.  Deleting."
    rm $currentPanicFile
    exit 0
fi