#!/bin/bash

# exit when any command fails
set -e
echo 'Begining Trend Vision One - Container Security Demo Environment Deployment'
echo ""
echo 'Checking for required parameters...'
echo ""
# Check if number of arguments equals 3 or 4
if [ "$#" -ne 2 ]; then
    echo "You must enter a command line arguments: STACK_NAME AWS_REGION"
    exit
fi

# Check if JQ is installed.
if ! command -v jq &> /dev/null
then
    echo "JQ could not be found."
    exit
fi

# Check if overrides exists
filename="overrides.yaml"  # Replace this with your file's name

if [ -e "$filename" ]; then
    echo "File exists: $filename"
else
    echo "File does not exist: $filename"
    exit 1  # Exit with an error code
fi

# Get Bucket
BUCKET_NAME="v1-demo-environments"
Bucket_Location=$(aws s3api get-bucket-location --bucket ${BUCKET_NAME} --output text)
if [ $Bucket_Location != '' ] && [ $Bucket_Location != 'None' ]
then
  BUCKET_REGION=${Bucket_Location}
else
  BUCKET_REGION="us-east-1"
fi
echo 'Bucket Region is '${BUCKET_REGION}
echo ""

# Set Region
if [ $2 != ''] && [ $2 != 'None' ]
then
  AWS_REGION=$2
else
  AWS_REGION="us-east-1"
fi
echo 'Region to be deployed to is '${AWS_REGION}


# Create CloudFormation Stack
STACK_NAME=$1
BUCKET_URL="https://"${BUCKET_NAME}".s3."${BUCKET_REGION}".amazonaws.com"
TEMPLATE_URL=""${BUCKET_URL}"/utils/main.template.yaml"
PARAMETER1="true"
PARAMETER2="true"
echo 'Deploying Stack...'
# You should add more parameters as needed under the --parameters flag, like:
# ParameterKey=PARAMETER1,ParameterValue=${PARAMETER1} \
# ParameterKey=PARAMETER2,ParameterValue=${PARAMETER2} \
aws cloudformation create-stack --stack-name ${STACK_NAME} \
    --template-url ${TEMPLATE_URL} \
    --parameters ParameterKey=BuildEcs,ParameterValue=true \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
    --disable-rollback --region ${AWS_REGION}

echo 'Stack deployed!'

#Get EKS Launch Files
echo 'Fetching Supporting Files!'
curl --silent "https://v1-demo-environments.s3.us-east-1.amazonaws.com/cloudshell.zip" > cloudshell.zip
unzip -o -q cloudshell.zip
rm cloudshell.zip
cd cloudshell
#Install latest version of EksCtl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
sudo yum install -y openssl
#Install Latest version of helm
curl --silent https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
echo 'Files Fetched!'
echo 'Waiting for VPC to be created....'
echo 'This may take a minute...'
sleep 60
#Get the Subnets to pass to eksctl
VpcStack=$(aws cloudformation list-stacks --region ${AWS_REGION} --query "StackSummaries[?contains(StackName, '${STACK_NAME}-VPC') && StackStatus == 'CREATE_COMPLETE'].StackName" --output text)
echo "VPC Stack Name: ${VpcStack}"
Subnet1=$(aws cloudformation describe-stacks --region ${AWS_REGION} --query "Stacks[?StackName=='${VpcStack}'][].Outputs[?OutputKey=='PublicSubnet1ID'].OutputValue" --output text)
Subnet2=$(aws cloudformation describe-stacks --region ${AWS_REGION} --query "Stacks[?StackName=='${VpcStack}'][].Outputs[?OutputKey=='PublicSubnet2ID'].OutputValue" --output text)
#Run the EKS Deploy Script
./deploy.sh ${STACK_NAME} ${AWS_REGION} ${Subnet1} ${Subnet2}