#!/bin/bash

YOUR_PATH=/srv/docker_registry
USER_NAME=testuser
PASSWORD=testpassword
DOCKER_HOST=localhost

if [ -d $YOUR_PATH/auth/ ]
   then echo auth directory in $YOUR_PATH is created.
   else echo auth directory in $YOUR_PATH is not created.
fi

if [ -d $YOUR_PATH/data/ ]
   then echo data directory in $YOUR_PATH is created.
   else echo data directory in $YOUR_PATH is not created.
fi

if [ -d $YOUR_PATH/certs/ ]
   then echo certs directory in $YOUR_PATH is created.
   else echo certs directory in $YOUR_PATH is not created.
fi

if [ -f $YOUR_PATH/auth/htpasswd ]
   then echo htpasswd file in $YOUR_PATH/auth exist.
   else echo htpasswd file in $YOUR_PATH/auth does not exist.
fi

CREATED_USER=$(cut $YOUR_PATH/auth/htpasswd -d: -f1)

if [ $CREATED_USER == $USER_NAME ]
   then echo $USER_NAME in htpasswd file is created.
   else echo $USER_NAME in htpasswd file is created.
fi

if service docker status &> /dev/null
   then echo docker is started.
   else echo docker is stopped.
fi

docker login --username=$USER_NAME --password=$PASSWORD $DOCKER_HOST

