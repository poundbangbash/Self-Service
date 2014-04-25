#!/bin/bash

# CocoaDialog executable path
CD="/Library/Management/Triggers/cocoaDialog.app/Contents/MacOS/CocoaDialog"

# Main app dialog display
#   Using checkboxes as multiple can be chosen at once.
#   Each item is a checkbox
#   Checkbox index starts at 0
dialog=$($CD checkbox --title "Meredith Self-Service" --float \
    --icon-file "/Applications/MDP Apps/IT Self Service.app/Contents/Resources/appIcon.icns" \
    --icon-size 128 \
    --icon notice \
    --text "Choose the self-service item(s) to perform:" \
    --items \
      "Sync Date & Time" \
      "Change Time Zone" \
    --button1 "OK" \
    --button2 "Cancel");

# Get the button pressed - OK = 1, Cancel = 2
button=$(echo "${dialog}" | awk 'NR==1{print}');

# Parse the results to evaluate the checkbox state below
checkboxes=($(echo "${dialog}" | awk 'NR>1{print $0}'));

# Start the checkbox array index variable at 0
i=0;

# Check if OK was clicked - OK = 1
if [ $button = 1 ]
then
    # Iterate thru each checkbox array index and see if they were checked or not - Checked = 1, unchecked = 0
    for state in ${checkboxes[*]}; do
        #   If the checkbox is checked it will return a state = 1
        if [ $state = 1 ]
        then
            # Now check which array index the checkbox is and act accordingly
            if [ $i = 0 ] #index 0 - Sync Date & Time
            then    
                    # Touch a file to trigger the Self Service script managed via a LaunchDaemon
                    touch /Library/Management/Triggers/setTime
            elif [ $i = 1 ] #index 1 - Change Time Zone
            then    
                    # Display a dropdown menu to the user to pick which time zone to set the computer to
                    timezonedialog=$($CD dropdown --text "Select the Time Zone you want to set the system to" \
                    --height "150"\
                    --items "Eastern" \
                            "Central" \
                            "Mountain" \
                            "Pacific" \
                    --button1 "OK");
                    # Parse which button was clicked in the TimeZone dialog - OK = 1
                    tzbutton=$(echo "${timezonedialog}" | awk 'NR==1{print}');
                    # Parse which option was chosen from the dropdown menu
                    #       Eastern = 0
                    #       Central = 1
                    #       Mountain = 2
                    #       Pacific = 3
                    tzitem=($(echo "${timezonedialog}" | awk 'NR>1{print $0}'));
                    # If OK was clicked, determine which option to act on
                    if [ $tzbutton = 1 ]
                    then
                        if [ $tzitem = 0 ]
                        then
                            touch /Library/Management/Triggers/TimeZone/eastern
                        elif [ $tzitem = 1 ]
                        then
                            touch /Library/Management/Triggers/TimeZone/central
                        elif [ $tzitem = 2 ]
                        then
                            touch /Library/Management/Triggers/TimeZone/mountain
                        elif [ $tzitem = 3 ]
                        then
                            touch /Library/Management/Triggers/TimeZone/pacific
                        else 
                            echo "User canceled"
                        fi
                    fi
: <<COMMENTBLOCK            
            elif [ $i = 2 ] #index 2
            then    
                    echo "Performing code for option 3"
            elif [ $i = 3 ] #index 3
            then    
                    echo "Performing code for option 4"
            elif [ $i = 4 ] #index 4
            then    
                    echo "Performing code for option 5"
            elif [ $i = 5 ] #index 5
            then    
                    echo "Performing code for option 6"
            elif [ $i = 6 ] #index 6          
            then    
                    echo "Performing code for option 7"
COMMENTBLOCK
          else
                    echo "No checkboxes checked"
            fi
        else
            #Checkbox not checked so sleep a second before checking the next checkbox
            sleep 1
        fi
        # Increment the array index counter
        let i+=1;
    done;
else
    # Button != 1 so the user must have clicked Cancel
    exit 1
fi