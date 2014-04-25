Self-Service
============

CocoaDialog based self-service scripts

This script is used in tandem with CocoaDialog to present users with a GUI interface for triggering scripts to be run as root.
In its current state it provides users the ability to change timezones and sync date & time with a time server.
In the GUI users pick which action(s) they want to perform and the GUI script uses the `touch` command to modify the trigger file.

This is only the script piece that allows users to interact wiht the action scripts.
The actions are setup based off of Recipe 4 of http://www.macnews.com/articles/mactech/Vol.25/25.09/2509MacEnterprise-launchdforLunch/index.html

Create a directory to store the triggers so users can "touch" them
mkdir /Library/Management/Triggers
sudo chown root /Library/Management/Triggers
sudo chmod 755 /Library/Management/Triggers

Create an empty file that a LaunchDaemon watches to start the action script
sudo touch /Library/Management/Triggers/<trigger-name>
sudo chmod 666 /Library/Management/Triggers/<trigger-name>

Create a LaunchDaemon to watch your trigger
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>org.myorg.softwareupdate</string>
  <key>ProgramArguments</key>
  <array>
    <string>/path/to/action-script or command</string>
  </array>
  <key>WatchPaths</key>
  <array>
    <string>/Library/Management/Triggers/<trigger-name> </string>
  </array>
</dict>
</plist>

