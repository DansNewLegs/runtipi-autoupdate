# Using runripi-autoupdate.sh and cron jobs to automate the update process of Runtipi.
\
**Setup**
1. Create a new script file in a new runtipi/scripts folder called auto-update.sh and paste the code found in "runtipi-autoupdate.sh". This script will check if a new release is available and if so, it will backup your current installation and update to the latest release.
2. Make the script executable by running the following command:
```
chmod +x ./auto-update.sh
```
3. Open your crontab file by running the following command:
```
sudo crontab -e
```
4. Add a new line at the bottom of the file with the following content:
```
0 4 * * * /path/to/runtipi/scripts/auto-update.sh
```
Or if you want to log the output of the script to a file for debugging purposes:
```
0 4 * * * /path/to/runtipi/scripts/auto-update.sh >> /path/to/runtipi/scripts/auto-update.log 2>&1
```
This will run the script every day at 4am. You can change the time to your liking. Crontab Guru is a great tool to help you with creating cron jobs.
