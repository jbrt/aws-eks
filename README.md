# AWS EKS Template

This project contains a fully fonctional Terraform template for creating a new 
EKS cluster into an AWS account.

The resources below will be created:

- A dedicated VPC
- One EKS Cluster (and EC2 workers)
- CloudWatch log groups & IAM configuration
- Deploying a Fluentd for sending logs from pods to CloudWatch
- Install the Kubernetes dashboard

## Input variables

## Prerequisites

Before launching this template you **must** have installed the dependencies bellow:

- kubectl client
- the aws-iam-authenticator 

## Schema

## Licence

