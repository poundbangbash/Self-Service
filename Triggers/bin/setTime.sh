#!/bin/bash
#Try setting the time from our internal server, if that fails use Apple's.

echo ""
echo "======INTERNAL ATTEMPT======"
echo "Attempting to set time from ntp.DOMAIN.com"
ntpdate -u ntp.DOMAIN.com 2>&1

if [ $? -eq 0 ];
then
    echo "======INTERAL SUCCESS======"
    echo ""
    exit 0
else
    echo "======INTERAL FAILED - EXTERNAL ATTEMPT======"
    echo "Attempting to set time from time.apple.com"
    ntpdate -u time.apple.com 2>&1
        if [ $? -eq 0 ];
        then
            echo "======EXTERNAL SUCCESS======"
            echo ""
            exit 0        
        else
            echo "======EXTERNAL FAILED======"
            echo "Time not changed"
            echo ""
        fi
fi


