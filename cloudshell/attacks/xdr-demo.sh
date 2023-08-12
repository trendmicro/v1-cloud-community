#!/bin/bash
# Bash Menu Script Example for V1CS SAE-Model Demo
 
# Set color green for echo output
green=$(tput setaf 2)
 
PS3='Select the number of the attack: '
options=("Terminal Shell in Container" "Compile After Delivery" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Terminal Shell in Container")
            echo "💬${green}Running shell in container..."
            kubectl run attacker-$RANDOM --rm -i --tty --image ubuntu/apache2:2.4-22.04_beta -- bash -c "ls -lh"
            ;;
        "Compile After Delivery")
            echo "💬${green}Running Compile After Delivery..."
            kubectl run attacker-$RANDOM --rm -i --tty --image ubuntu/apache2:2.4-22.04_beta -- bash -c "apt update;apt install wget gcc -y;wget https://raw.githubusercontent.com/SoOM3a/c-hello-world/master/hello.c;gcc hello.c;ls -lh"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done