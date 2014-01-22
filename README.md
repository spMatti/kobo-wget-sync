kobo-wget-sync
===============

Forked from https://github.com/wernerb/kobo-wget-sync. Thank you for the good work :)

Refactored the code a little so that it's easier to download files from Google Drive with wget. Now user must provide file `.wget-sync/script.sh` that is executed when kobo is online.


Install
---------------

1. If you have kobo-grive-sync installed you must uninstall it first. Download package from [here](https://googledrive.com/host/0B8PUwax9miFkU3lBVXM0dFY3TzA/packages/kobo-grive-sync-uninstall/KoboRoot.tgz) to your kobo's /.kobo directory and disconnect the kobo.
2. Download package from [here](https://googledrive.com/host/0B8PUwax9miFkU3lBVXM0dFY3TzA/packages/kobo-wget-sync/KoboRoot.tgz) to your kobo's /.kobo directory and disconnect the kobo.
   You will see it updating and restart.
3. Press `Sync` or activate wifi to start the script. (It watches the activation of wifi through udev rules)
4. Connect your kobo again and a dir called `.wget-sync` should be created that contains `script.sh`
5. Edit `script.sh` by uncommenting the sample command and setting the folder ID of your public Google Drive folder.
6. Disconnect usb, activate wifi and your kobo should sync with the public folder. If it does not go well you can check the log in `.wget-sync` to check what went wrong.

