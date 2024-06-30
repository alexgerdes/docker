#!/bin/bash

IMAGE=$1            # Name of image, optionally with a tag 
WORKDIR=${2:-.}     # Directory to mount as workspace, defaults to current

# Print usage
function usage() {
  printf "Usage:\n\n\tdrun.sh <image:tag> <directory>\n\n"
  printf "The tag defaults to 'latest', and the directory to the current one.\n"
  exit 1
}

# Check if image exists
if [ -z $IMAGE ] || [ -z "$(docker images -q $IMAGE 2> /dev/null)" ]; then
  printf "Unkown image! It should be one of these:\n\n"
  docker images --format "{{.Repository}}:{{.Tag}}" 
  printf "\n"
  usage
fi

## Check that the second argument is a valid directory
if ! [ -d $WORKDIR ]; then
  printf "The second argument should be an existing directory. "
  usage
elif [ $WORKDIR -ef $HOME ] || [ $WORKDIR -ef "/" ]; then 
  printf "Don't mount the root or your home directory, please specify a directory. "
  usage
fi

echo "Launching a container from the $IMAGE image..."

# Start container with SSH agent forwarding
docker run --rm -it \
  --mount type=bind,src=/run/host-services/ssh-auth.sock,target=/run/host-services/ssh-auth.sock \
  -e SSH_AUTH_SOCK="/run/host-services/ssh-auth.sock" \
  -v ~/.config/zsh_history:/root/zsh_history \
  -v $WORKDIR:/root/workspace \
  $IMAGE
