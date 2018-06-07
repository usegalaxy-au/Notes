#!/bin/bash
#
# [DNB 7-Jun-2018] Script to upgrade galaxy instance
#
# ==================================================
# 
# Some variables
NGINX_CLOUDMAN_TEMPLATE=/opt/cloudman/config/conftemplates/nginx_galaxy_locations
NGINX_FILE=/etc/nginx/sites-enabled/galaxy.locations
GALAXY_ROOT=/mnt/galaxy/galaxy-app

# Function to ensure that some parts of the code are indeed being run as galaxy
function test_galaxy_user() {
	galaxy_id=`id -u galaxy`
	if [ $EUID -ne $galaxy_id ]; then
		echo "The $1 function must be run as the galaxy user."
		exit 1
	fi
	echo "Running $1 function as galaxy user with uid of $galaxy_id"
}

# Function to change NGINX config as link from packed was dropped in this release
function change_nginx_config() {
	for file in ${NGINX_CLOUDMAN_TEMPLATE} ${NGINX_FILE}; do
		sed -e -i 's/\/packed//' ${file}
	done
}

# Function to be run as user galaxy for updating the galaxy code
function update_galaxy() {
	test_galaxy_user update_galaxy
	backup_location=/mnt/tmp/galaxy_startup_scripts
	cd ${GALAXY_ROOT}
	echo "Making a backup of run.sh and run_reports.sh in ${backup_location}"
	mkdir ${backup_location} && cp run.sh run_reports.sh ${backup_location}
	echo "Doing the git upgrade"
	echo git status
	git status
	git fetch origin && git checkout release_18.05 && git pull --ff-only origin release_18.05
	echo "Removing virtual env for galaxy: rm -rf .venv"
	rm -rf .venv
	echo "Copying back run.sh and run_reports.sh"
	cp ${backup_location}/run.sh ${backup_location}/run_reports.sh .
	echo "pull down the virtual env by running galaxy - should fail to start because of db"
	./run.sh
	echo "Do the following to finish the upgrade"
	echo "source .venv/bin/activate && pip install ephemeris"
}

# Function to update the database to be run as user galaxy
function update_database() {
	test_galaxy_user update_database
	echo "Doing the galaxy database upgrade: sh manage_db.sh upgrade"
	sh manage_db.sh upgrade
}

echo "Usage: source $0"
echo "Choose from the following options"
echo "    o change_nginx_config - as root - need to remove reference to old bundle in static path"
echo "    o update_galaxy - as galaxy - git upgrade of galaxy and virtual environment"
echo "    o update_database - as galaxy - upgrade of the galaxy database"
