# AWS EKS Template

This project contains a fully fonctional Terraform template for creating a new 
EKS cluster into an AWS account. **Work in progress**

The resources below will be created:

- A dedicated VPC (with only public subnets)
- One EKS Cluster (and EC2 workers)
- CloudWatch log groups & IAM configuration
- Deploying a Fluentd for sending logs from pods to CloudWatch
- Install the Kubernetes dashboard

## Input variables

You can custom the installation of that cluster with the following input variables:

| Variable                | Purpose of that variable      |
|-------------------------|-------------------------------|
| region                  | AWS region                    |
| availability_zones      | List of AZs to use            |
| cluster_name            | Name of the cluster EKS       |
| instance_size           | Family/size of the workers    |
| log_retention           | Retention of the logs in days |

## Prerequisites

Before launching this template you **must** have installed the dependencies bellow:

- kubectl client
- aws-iam-authenticator (cf. https://docs.aws.amazon.com/fr_fr/eks/latest/userguide/install-aws-iam-authenticator.html)

**The aws-iam-authenticator client must be in your PATH variable.**

## Schema

![eks](eks-diagram.png)

## License

This template is under MIT license.
