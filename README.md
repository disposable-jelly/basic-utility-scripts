# basic-utility-scripts
Batch or Powershell scripts for specific basic uses.
These scripts are used when solving some basic problems or doing mundane tasks in Windows:

tuneup-disable-services.bat
A batch script to disable services sysmain and diagtrack, as well as unnecessary autostart or background tasks for tools myself or some colleagues use, such as CCleaner's Performance Optimizer service, and several Glary's Utilities background services. I am in no way affiliated with CC or GU. I find disabling these services doesn't cause any problems, but your mileage may vary. Needs to be run as administrator.

win-preconfig-calling-card.ps1
Powershell script to  change some customer information in the LogMeIn Rescue Calling Card for Nerds On Call. I am not affiliated with GoTo/LogMeIn. It specifically looks for channel IDs related to Nerds On Call, so it will not affect LMI Rescue Calling Cards for other companies. Needs to be run as administrator.

start-cc-config-admin.bat
A batch file to invoke the previous powsershell script. This is useful for running the script without needing to go through the permission popups when running a powershell script directly. It only runs the customer information configuration PS script. Needs to be run as administrator.

clear-acrobat-cache-admin.bat
*EXPERIMENTAL* A batch script to clear the Adobe Acrobat cache. Other utilities like CCleaner or Glary's Utilities should be able to do that, but I don't much like installing CC on people's computers and GU doesn't reliably clear the cache. Needs to be run as administrator.

clear-print-queue-admin.bat
A basic batch script to stop the print spooler service, clear the spooler folder, then restart the print spooler service. Needs to be run as administrator.
