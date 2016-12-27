#!/usr/bin/env bash
# ----------------------------------------------------------------------------
# SCRIPT: private_docker_registry_test.bash
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
# PURPOSE: This script tests if the private docker registry is started correctly
# according to the configurations specified in .conf file.
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

# Test whether the required directories has been created.
if [ -d ${YOUR_PATH}/auth/ ]
   then echo auth directory in ${YOUR_PATH} is created.
   else echo auth directory in ${YOUR_PATH} is not created.
fi

if [ -d ${YOUR_PATH}/data/ ]
   then echo data directory in ${YOUR_PATH} is created.
   else echo data directory in ${YOUR_PATH} is not created.
fi

if [ -d ${YOUR_PATH}/certs/ ]
   then echo certs directory in ${YOUR_PATH} is created.
   else echo certs directory in ${YOUR_PATH} is not created.
fi

# Test whether the password file has been created.
if [ -f ${YOUR_PATH}/auth/htpasswd ]
   then echo htpasswd file in ${YOUR_PATH}/auth exist.
   else echo htpasswd file in ${YOUR_PATH}/auth does not exist.
fi

# Test whether the specified user account has been created.
CREATED_USER=$(cut ${YOUR_PATH}/auth/htpasswd -d: -f1)
if [ ${CREATED_USER} == ${USER_NAME} ]
   then echo ${USER_NAME} in htpasswd file is created.
   else echo ${USER_NAME} in htpasswd file is created.
fi

# Test whether the docker service is started.
if service docker status &> /dev/null
   then echo docker is started.
   else echo docker is stopped.
fi

# Login to the private docker registry
docker login --username=${USER_NAME} --password=${PASSWORD} ${DOCKER_HOST}

#############################################################################
# END SCRIPT
#############################################################################

