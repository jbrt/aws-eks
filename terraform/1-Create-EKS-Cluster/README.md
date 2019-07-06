# Creating EKS cluster

By default, these templates use the default Terraform workspace.
But you can define your own if you want and use a dedicated tfvars file.

```bash
$ terraform init
$ terraform plan -var-file=$(terraform workspace show).tfvars
$ terraform apply -var-file=$(terraform workspace show).tfvars
```

Or, if you don't plan to use workspaces:

```bash
$ terraform init
$ terraform plan -var-file=default.tfvars
$ terraform apply -var-file=default.tfvars
```

Tfvars files are automaticated loaded if:

- the tfvars is called terraform.tfvars
- the tfvars files ends with auto.tfvars (ex: dev.auto.tfvars)

In all other cases, you have to use -var-file argument for loading them.