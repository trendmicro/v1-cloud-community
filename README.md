# Container Security Demo Documentation

Welcome to the Vision One Container Security Demo Documentation. This package contains all required files to demo Trend Vision One - Container Security from zero to hero!

## Requirements

* AWS Account with Admin permissions
* Trend Vision One Account with access to Container Security
* Internet access 😅 - <https://bfy.tw/Tm18>

## Lets Get Started!

1. Login to your AWS Account
2. Select the AWS CloudShell service
3. Create the overrides.yaml file needed to deploy container security
<details>
<summary>Click here if you need help with this step!</summary>

1. Visit the Trend Vision One Documentation to learn how to add a cluster (LINK)
2. Download the override.yaml file from the k8s provisioning UI flow
3. [Upload the file into AWS Cloudshell](https://docs.aws.amazon.com/cloudshell/latest/userguide/getting-started.html#folder-upload)
</details>

4. Run the following 3 commands
     1. wget https://v1-demo-environments.s3.amazonaws.com/launch.sh
     2. chmod +x launch.sh
     3. ./launch.sh REPLACE_WITH_STACK_NAME REPLACE_WITH_AWS_REGION

5. Have fun!


This will:

1. Deploy an ECS cluster with a vulnerable service/task (not exposed to the internet)
2. Deploy an EKS cluster with worker nodes
3. Deploy Container Security to your EKS Cluster using the overrides files you uploaded
4. Deploy purposefully vulnerable applications to the EKS cluster

> ⚠️ The deployment process can take up to 30 minutes.

## How to Demo it

### Vulnerable Running Application

First, show that the cluster has the application running running:

```bash
kubectl get pods --namespace demo 
```

### Showcasing How we Scan Containers on Admission

We want to be able to showcase that we are able to scan containers quickly as they are admitted by the cluster.

0. Make sure you already have Container Security deployed to your cluster.
1. Show the Vulnerability View page and point to the fact it has no vulnerabilities related to the image you are about to deploy.
2. Deploy your container.
3. If you haven't yet, take a minute to explain what we are doing behind the scenes.
4. Go to the Vulnerability View page. You should now see the vulnerabilities of your newly deployed container.
5. Don't see the new vulnerabilities? Wait a few seconds and hit the Refresh button.
6. Profit!

## Showcasing Runtime Security

```bash
./attack.sh
```

This will take you to a CLI tool to enable you to run attacks from a separated container exploiting a vulnerability in a Apache Struts 2 application.

### Interesting Sources

<https://www.linuxfoundation.org/blog/a-summary-of-census-ii-open-source-software-application-libraries-the-world-depends-on/>

