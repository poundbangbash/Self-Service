#!/bin/bash
watchFolderPath="/Library/Management/Triggers/TimeZone"

#On run, list the contents of the directory and use that to pick which timezone to change to
setToTimeZone=`ls $watchFolderPath | grep -v .filewavefile | grep -v .DS_Store`

#Set the appropriate time zone
if [ "$setToTimeZone" = "eastern" ]
then
    date
    systemsetup -settimezone America/New_York
elif [ "$setToTimeZone" = "central" ]
then
    date
    systemsetup -settimezone America/Chicago
elif [ "$setToTimeZone" = "mountain" ]
then
    date
    systemsetup -settimezone America/Denver
elif [ "$setToTimeZone" = "pacific" ]
then
    date
    systemsetup -settimezone America/Los_Angeles
else
    exit 1
fi

#Delete the file so it doesn't continually run
rm ${watchFolderPath}/${setToTimeZone}

exit 0   
    