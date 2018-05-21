# Upgrade of usegalaxy.org.au server

The existing Galaxy service on usegalaxy.org.au will be migrated to a new virtual machine with a new version of Galaxy.

## Prior to Upgrade
A number of important tasks need to be completed prior to the upgrade.
* Update TTL in DNS to 5 minutes to allow speedy change over of DNS as the new virtual machine will have a different IP address. [DNB 18-05-2018 Done]
* Modify landing page for cloudman to contain outage information in a message box that's always visible to the user so that when galaxy is down users are informed. As the migration will take some time.  We estimate about an hour. https://usegalaxy.org.au/errdoc/outage_index.html [DNB 21-05-2018 Done]
* Sort out Email strategy for new usegalaxy.org.au server [DNB 18-05-2018]
* Ensure SSL certs will work on new server.

## Upgrade Steps
These steps need to be performed in the following order:
* Shutdown services FTP server, Galaxy and Reports services, on usegalaxy.org.au and galaxy-aust.genome.edu.au
* Dump the Galaxy database on usegalaxy.org.au and place on the galaxy partition and then shutdown the database.
* Unmount the Galaxy-Volume on usegalaxy.org.au and remount on galaxy-aust.genome.edu.au under /mnt/new_galaxy
* Move all files and folders under /mnt/new_galaxy to /mnt/new_galaxy/OLD_DATA
* Rsync all files from /mnt/galaxy to /mnt/new_galaxy
* Drop Galaxy database on galaxy-aust.genome.edu.au and restore from copy on /mnt/new_galaxy
* Replace /mnt/new_galaxy/files with /mnt/new_galaxy/OLD_DATA/files
* Ensure that /mnt/new_galaxy/galaxy-app/config/job_conf.xml contains memory limits see /mnt/new_galaxy/OLD_DATA/galaxy-app/config/job_conf.xml
* Edit persistent_data-current.yaml on usegalaxy.org.au (under /mnt/cm) and replace volume vol-32789b6c with volume vol-00003eca and upload this to cm-362518089830e0a03ef6c62f2fd9f2b8
* Reboot usegalaxy.org.au
* Adopt the brace postion

## After Upgrade
After the upgrade as a precaution do the following:
* Remove cloudman.conf from /etc/init on the old usegalaxy.org.au
* Change the DNS record for usegalaxy.org.au to point to galaxy-aust.genome.edu.au
* Wait for DNS to filter through and then update SSL cert on new usegalaxy.org.au
* Make sure cloudman is located on SSL and not http
* Start Galaxy.
* Notify users.

