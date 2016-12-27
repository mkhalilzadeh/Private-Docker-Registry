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
#
##############################################################################
# START SCRIPT
##############################################################################

# Using the private_docker_registry.conf in this script
source ./private_docker_registry.conf

# Checks if the user is root or not.
ROOT_UID=0     # Only users with $UID 0 have root privileges.
E_NOTROOT=87   # Non-root exit error.
if [ $UID -ne ${ROOT_UID} ]
then
  echo "Please run as root."
  exit ${E_NOTROOT}
else
  echo "The user is root."
fi

# Make required directories
mkdir -p ${YOUR_PATH}/data
mkdir -p ${YOUR_PATH}/auth
mkdir -p ${YOUR_PATH}/certs

# Create a password file for basic authentication
docker run --entrypoint htpasswd registry -Bbn ${USER_NAME} ${PASSWORD} > ${YOUR_PATH}/auth/htpasswd

# Generate your own certificate
# sudo openssl req -newkey rsa:4096 -nodes -sha256 -keyout ${YOUR_PATH}/certs/domain.key -x509 -days 365 -out ${YOUR_PATH}/certs/domain.crt

# Create required .yml file
cat  > ./docker-compose.yml << _EOF_
registry:
  restart: always
  image: registry
  ports:
    - ${DOCKER_PORT}:5000
  environment:
    # REGISTRY_HTTP_TLS_CERTIFICATE: /certs/domain.crt
    # REGISTRY_HTTP_TLS_KEY: /certs/domain.key
    REGISTRY_AUTH: htpasswd
    REGISTRY_AUTH_HTPASSWD_PATH: /auth/htpasswd
    REGISTRY_AUTH_HTPASSWD_REALM: Registry Realm
  volumes:
    - ${YOUR_PATH}/data:/var/lib/registry
    - ${YOUR_PATH}/auth:/auth
    - ${YOUR_PATH}/certs:/certs
_EOF_

# Start registry
docker-compose up -d

##############################################################################
## END SCRIPT
##############################################################################

