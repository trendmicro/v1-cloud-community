#!/bin/bash

# exit when any command fails
set -e

COMMAND=$1
URL="http://$(kubectl get svc -n demo --selector=app=java-goof -o jsonpath='{.items[*].spec.clusterIP}')"

kubectl run attacker --rm -i --tty --image public.ecr.aws/k1q0d6m0/attacker "$URL" "$COMMAND"