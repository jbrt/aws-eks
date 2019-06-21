# Install packages into K8s with Terraform Helm provider 

Install additional packages with Terraform Helm provider:

- cluster-autoscaler
- kubernetes dashboard
- metrics-server (needed by HPA and cluster-autoscaler)

## Usage 

```bash
$ terraform plan
$ terraform apply
```