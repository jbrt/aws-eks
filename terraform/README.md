# AWS-EKS Modules

This project is split into two separate parts. The first part will create a 
complete EKS cluster, the second part is focus on installation of useful 
services and addons.

## 1-Create-EKS-Cluster

Creation of a complete EKS cluster with:

- VPC (Public/Private Subnets)
- EKS Cluster
- CloudWatch LogGroups
- Fluentd agent for streaming logs onto CloudWatch Logs

## 2-Helm-and-packages

Installation of useful packages onto Kubernetes with HELM package manager.

- Kubernetes Dashboard
- Metrics server (for Horizontal Pod AutoScaling)
