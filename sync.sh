#!/bin/bash

# exit when any command fails
set -e

# Check if number of arguments equals 3 or 4
if [ "$#" -ne 2 ]; then
    echo "You must enter 2 command line arguments: BUCKET_NAME AWS_PROFILE"
    exit
fi

# Check if AWS CLI is installed.
if ! command -v aws &> /dev/null
then
    echo "AWS CLI could not be found. Install it here: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html"
    exit
fi

# Check if JQ is installed.
if ! command -v jq &> /dev/null
then
    echo "JQ could not be found."
    exit
fi

# Get Bucket
BUCKET_NAME=$1
AWS_PROFILE=$2
Bucket_Location=$(aws s3api get-bucket-location --bucket ${BUCKET_NAME} --profile ${AWS_PROFILE} --output text)
if [ $Bucket_Location != '' ] && [ $Bucket_Location != 'None' ]
then
  BUCKET_REGION=${Bucket_Location}
else
  BUCKET_REGION="us-east-1"
fi
echo 'Bucket Region is '${BUCKET_REGION}
echo ""

#Remove cloudshell.zip
rm cloudshell.zip
echo "cloudshell.zip removed"
echo ""
#Recreate cloudshell.zip
zip cloudshell.zip -r -q cloudshell/*
echo "cloudshell.zip updated"
echo ""
# Sync local folder with S3
FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo 'Syncing local files to S3 bucket...'
aws s3 sync ${FOLDER} s3://${BUCKET_NAME}/ --exclude ".git/*" --profile ${AWS_PROFILE} --delete
echo 'Files synced!'
echo ''



