# Using runripi-autoupdate.sh and cron jobs to automate the update process of Runtipi.
\
**Pre-Staging the script**
1. Create a folder for your scipt to be stored. Ex. /opt/runtipi/scripts
```
mkdir /opt/runtipi/scripts
```
2. Download script into the created location, making sure to change the output, after ">>", to your directory.
```
curl -L https://raw.githubusercontent.com/DansNewLegs/DansNewLegs/main/runtipi-autoupdate.sh >> /opt/runtipi/scripts/runtipi-autoupdate.sh
```
3. Edit the script to add your runtipi path on line 3.
```
nano runtipi-autoupdate.sh
``` 
4. Make script executable. 
```
chmod +x /opt/runtipi/scripts/runtipi-autoupdate.sh
```
\
**Using the Crontab editor to schedule your script**
1. Enter the crontab editor using crontab -e
```
crontab -e
```
2. At the bottom of your file, enter your schedule in a format of Minute(0-59), Hour(0-24), Day of month(1-31), Month(1-12), Day of week(0-7)(Sunday=0 or 7). Use a * to mean all. Use https://crontab.guru/ to help calculate the time you want. Mine would look like this, for every night at 4am. 
```
0 4 * * * 
```
3. On the same line you place the action you want to preform. In this case it would be to run our script. It would look like:
```
0 4 * * * /opt/runtipi/scripts/runtipi-autoupdate.sh
```
4. To add logging enter output info like:
```
0 4 * * * /opt/runtipi/scripts/runtipi-autoupdate.sh >> /opt/runtipi/logs/runtipi-autoupdate.sh 2>&1
```
5. Save your edits. If using nano:
```
Ctrl + S
Ctrl + X
```
