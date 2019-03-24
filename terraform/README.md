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
- Cluster-autoscaler (better auto-scaling by updating AWS ASG parameters)

### Kubernetes Dashboard

Once the Kubernetes Dashboard installed, you can access to this dashboard by typing this commands:

```bash
kubectl --kubeconfig kubeconfig_<CLUSTER_NAME> proxy
```

Then, go to this URL:

http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:https/proxy/

You will need to generate a token, you can do this with this following commands:

```bash
kubectl --kubeconfig kubeconfig_<CLUSTER_NAME> -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')
```
