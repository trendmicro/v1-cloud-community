#!/bin/bash

# exit when any command fails
set -e

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin


# Check if jq is installed.
if ! command -v jq &> /dev/null
then
    echo "jq could not be found. Install it following this: https://stedolan.github.io/jq/download/"
    exit
fi

# Set color green for echo output
green=$(tput setaf 2)

# Defie State File name
STATE_FILE=".container-security-demo"

# First parameter is the cloudone dev us1 api key.
STACK_NAME=$1
AWS_REGION=$2

# Reads the cluster name and deletes it
echo "💬 ${green}Destroying the cluster..."
CLUSTER_NAME=$(cat $STATE_FILE | jq -r '.clustername')
eksctl delete cluster "$CLUSTER_NAME"


# Destroys the CFN stack
STACK_NAME=$(cat $STATE_FILE | jq -r '.stackname')
AWS_REGION=$(cat $STATE_FILE | jq -r '.region')
echo "💬 ${green}Destroying the Stack..."
aws cloudformation delete-stack --stack-name "$STACK_NAME" --region "$AWS_REGION"

echo "💬 ${green}Demo was succesfully deleted."