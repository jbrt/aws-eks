# AWS EKS Template

This project contains a fully fonctional Terraform template for creating a new 
EKS cluster into an AWS account. 

The resources below will be created:

- A dedicated VPC (with public subnets for load balancers and private subnets for EKS workers)
- One EKS Cluster and EC2 workers
- CloudWatch log groups & IAM configuration
- Deploying a Fluentd for sending logs from pods to CloudWatch
- Install the Kubernetes dashboard
- Install metrics-server for HPS (Horizontal Pod Scaling)

If you do not want to deploy the Kubernetes dashboard, you just have to delete 
the eks-addons.tf file before creating the cluster.

## Input variables

You can custom the installation of that cluster with the following input 
variables:

| Variable                | Purpose of that variable      | Default values    |
|-------------------------|-------------------------------|-------------------|
| region                  | AWS region                    | eu-west-1         |
| availability_zones      | List of AZs to use            | eu-west-1a, b & c |
| cluster_name            | Name of the cluster EKS       | my-eks-cluster    |
| cluster_version         | Version of K8s to deploy      | 1.11              |
| instance_size           | Family/size of the workers    | t2.medium         |
| log_retention           | Retention of the logs in days | 7                 |

## Schema

![eks](eks-diagram.png)

## Prerequisites

Before launching this template you **must** have installed the dependencies 
bellow:

- kubectl client
- aws-iam-authenticator (cf. https://docs.aws.amazon.com/fr_fr/eks/latest/userguide/install-aws-iam-authenticator.html)

**The aws-iam-authenticator client must be in your PATH variable.**

## Launching

Clone this Git repository and install dependencies (cf. Prerequisites chapter).

```bash
$ terraform init
$ terraform plan (enter your access keys as requested or create a .tfvars file)
$ terraform apply
```

For accessing to the dashboard you can follow these instructions:
https://github.com/kubernetes/dashboard

## Deploy a demo application

Note: the kubeconfig file will be created into the terraform directory after 
the apply step.

```bash
$ kubectl --kubeconfig kubeconfig_<CLUSTER-NAME> create namespace simple-demo
$ kubectl --kubeconfig kubeconfig_<CLUSTER-NAME> run --namespace simple-demo echoheaders --image=gcr.io/google_containers/echoserver:1.4 --replicas=1 --port=8080
$ kubectl --kubeconfig kubeconfig_<CLUSTER-NAME> expose --namespace=simple-demo deployment echoheaders --type=LoadBalancer --port=80 --target-port=8080 --name=echoheaders-public
$ kubectl --kubeconfig kubeconfig_<CLUSTER-NAME> --namespace=simple-demo describe service echoheaders-public
Name:           echoheaders-public
Namespace:      simple-demo
Labels:         run=echoheaders
Selector:       run=echoheaders
Type:           LoadBalancer
IP:         10.103.66.255
LoadBalancer Ingress:   a9201a1bdfc6411e68fdc06048bde387-495139964.us-west-1.elb.amazonaws.com
Port:           <unset> 80/TCP
NodePort:       <unset> 30031/TCP
Endpoints:      192.168.96.196:8080
Session Affinity:   None
Events:
  FirstSeen LastSeen    Count                       From      SubObjectPath   Type          Reason     Message
  --------- --------    -----                       ----      -------------   --------      ------     -------
  2m        2m          1   {service-controller }   Normal    Creating        LoadBalancer  Creating   load balancer
  1m        1m          1   {service-controller }   Normal    Created         LoadBalancer  Created    load balancer
```

Then, you can access to this application (after few minutes) by the ELB URL.
Here: http://a9201a1bdfc6411e68fdc06048bde387-495139964.us-west-1.elb.amazonaws.com

## Cleanup

**Before launching the destroy step, you have to delete your services.**
If you don't delete your services, you still have ELB (and SG) spawned in your 
VPC and it's will stuck your destroy process.

```bash
$ terraform destroy
```

## License

This template is under MIT license.
