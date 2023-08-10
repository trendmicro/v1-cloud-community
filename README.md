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

Then, show how Container Security is aware of that and how we detected it is vulnerable to the massive Apache Struts 2 vulnerability CVE-2017-5638 going to the Vulnerability View page and filtering the detections to this CVE only.



### Showcasing Time to Value

We want to be able to showcase how easy and simple it is to deploy Container Security and get insightful and actionable information about vulnerabilities in running containers in matter of minutes, if not seconds, being sure that if any vulnerability is exploited during the container lifetime we are capable of react to such an event.

0. Show the empty Vulnerability View page.
1. Deploy containers to your cluster.
2. Deploy Container Security to your cluster.
3. If you haven't yet, take a minute to explain what we are doing behind the scenes.
4. Go to the Vulnerability View page. You should now see the vulnerabilities of running containers.
5. Don't see the vulnerabilities? Wait a few seconds and hit the Refresh button.
6. Profit!

### Showcasing How we Scan Containers on Admission

We want to be able to showcase that we are able to scan containers quickly as they are admitted by the cluster.

0. Make sure you already have Container Security deployed to your cluster.
1. Show the Vulnerability View page and point to the fact it has no vulnerabilities related to the image you are about to deploy.
2. Deploy your container.
3. If you haven't yet, take a minute to explain what we are doing behind the scenes.
4. Go to the Vulnerability View page. You should now see the vulnerabilities of your newly deployed container.
5. Don't see the new vulnerabilities? Wait a few seconds and hit the Refresh button.
6. Profit!

## Container Images Suggestions

Do you need help with some container images and ways to trigger the detections?

Run ubuntu:

```bash
kubectl run my-ubuntu-shell --rm -i --tty --image ubuntu@sha256:bace9fb0d5923a675c894d5c815da75ffe35e24970166a48a4460a48ae6e0d19 -- bash
```

Run Debian:

```bash
kubectl run my-debian-shell --rm -i --tty --image debian@sha256:c11d2593cb741ae8a36d0de9cd240d13518e95f50bccfa8d00a668c006db181e -- bash
```

Run a Log4j vulnerable container:

```bash
kubectl run log4j --rm -i --tty --image guillaumem/java_app
```

Run the java-goof app, vulnerable to Apache Struts2:

```bash
kubectl run apache-struts-2 --rm -i --tty --image raphabot/java-goof@sha256:d4b6eea98318d874d902fb8d0e151b7726837954ffe459bc13f021cb178c7787
```

Run the java-goof app, vulnerable to Apache Struts2:

```bash
kubectl run apache-struts-2 --rm -i --tty --image raphabot/java-goof@sha256:d4b6eea98318d874d902fb8d0e151b7726837954ffe459bc13f021cb178c7787
```

Want to always have a pod running the background?

```bash
kubectl apply -f pods/node-web-app.yaml
```

## Showcasing Runtime Security

```bash
./attack.sh
```

This will take you to a CLI tool to enable you to run attacks from a separated container exploiting a vulnerability in a Apache Struts 2 application.

### Interesting Sources

<https://www.linuxfoundation.org/blog/a-summary-of-census-ii-open-source-software-application-libraries-the-world-depends-on/>

