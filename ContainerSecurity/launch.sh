#!/bin/bash
# Bash Menu Script Example
# Set color green for echo output
green=$(tput setaf 2)

PS3='Welcome to the Trend Vision One Container Security Demo Automation Tool. Please select an option: '
options=("Deploy EKS + ECS + Fargate Environment" "Deploy EKS + ECS w/o Fargate Environment" "Generate Events" "Delete Environment" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "Deploy EKS + ECS + Fargate Environment")
            echo "Deploying Environment..."
            echo "Not Ready yet! Try Another Option"
            #curl --silent "https://v1-demo-environments.s3.us-east-1.amazonaws.com/launch-full.sh" > launch-full.sh
            #chmod +x launch-full.sh
            #echo "What Region?"
            #read REGION
            #echo "What Cluster Name?"
            #read STACK_NAME
            #./launch-full.sh $STACK_NAME $REGION
            ;;
        "Deploy EKS + ECS w/o Fargate Environment")
            echo "Deploying Environment..."
            echo "AWS EKS + ECS w/o Fargate Environment Launching"
            curl --silent "https://v1-demo-environments.s3.us-east-1.amazonaws.com/launch-standard.sh" > launch-standard.sh
            chmod +x launch-standard.sh
            echo "What Region?"
            read REGION
            echo "What Cluster Name?"
            read STACK_NAME
            ./launch-standard.sh $STACK_NAME $REGION
            ;;
        "Generate Events")
            echo "💬${green}Launching attacker..."
            ./cloudshell/attack.sh
            ;;
        "Delete Environment")
            echo "💬${green}Cleaning up environment..."
            ./cloudshell/cleanup.sh
            ;;
        "Exit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
