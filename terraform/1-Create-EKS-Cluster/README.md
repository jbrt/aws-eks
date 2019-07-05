# Creating EKS cluster

```bash
$  terraform plan -var-file=$(terraform workspace show).tfvars
$  terraform apply -var-file=$(terraform workspace show).tfvars
```

Or, if you don't plan to use workspaces:

```bash
$  terraform plan -var-file=default.tfvars
$  terraform apply -var-file=default.tfvars
```