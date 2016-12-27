#!/usr/bin/env bash
# ----------------------------------------------------------------------------
# SCRIPT: private_docker_registry.bash
# Usage:
#
# AUTHOR: Mehdi Khalilzadeh
# DATE: 2016-12-27
# REV: 1.1.A (Valid are A, B, D, T and P)
# (For Alpha, Beta, Dev, Test and Production)
#
# PLATFORM: Linux (SPECIFY: AIX, HP-UX, Linux, OpenBSD, Solaris
# or Not platform dependent)
#
# PURPOSE: This script run the docker registry according to the configurations
# specified in .conf file.
#
# REV LIST:
# DATE:
# BY:
# MODIFICATION:
#
# set -n # Uncomment to check script syntax, without execution.
# # NOTE: Do not forget to put the comment back in or
# # the shell script will not execute!
# set -x # Uncomment to debug this shell script
#
# ----------------------------------------------------------------------------

##############################################################################
# START SCRIPT
##############################################################################

# Using the private_docker_registry.conf in this script
source ./private_docker_registry.conf

# Make required directories
sudo mkdir -p ${YOUR_PATH}/data
sudo mkdir -p ${YOUR_PATH}/auth
sudo mkdir -p ${YOUR_PATH}/certs

# Create a password file for basic authentication 
sudo docker run --entrypoint htpasswd registry -Bbn ${USER_NAME} ${PASSWORD} > ${YOUR_PATH}/auth/htpasswd

# Generate your own certificate
# sudo openssl req -newkey rsa:4096 -nodes -sha256 -keyout ${YOUR_PATH}/certs/domain.key -x509 -days 365 -out ${YOUR_PATH}/certs/domain.crt

# Start registry
sudo docker-compose up -d

#############################################################################
# END SCRIPT
#############################################################################
