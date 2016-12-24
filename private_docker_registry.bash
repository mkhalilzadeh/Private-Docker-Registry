#
# The path to install registry
#
YOUR_PATH=/srv/docker_registry
#
# Make required directories
#
sudo mkdir -p $YOUR_PATH/data
sudo mkdir -p $YOUR_PATH/auth
sudo mkdir -p $YOUR_PATH/certs
#
# Create a password file for basic authentication 
#
USER_NAME=testuser
PASSWORD=testpassword
sudo docker run --entrypoint htpasswd registry -Bbn $USER_NAME $PASSWORD > $YOUR_PATH/auth/htpasswd
#
# Generate your own certificate
#
# sudo openssl req -newkey rsa:4096 -nodes -sha256 -keyout $YOUR_PATH/certs/domain.key -x509 -days 365 -out $YOUR_PATH/certs/domain.crt
#
# Start registry
#
sudo docker-compose up -d
#
