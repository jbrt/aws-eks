# Variables for workspace default

# AWS Region
region                    = "eu-west-1"

# VPC 
vpc_cidr                  = "10.0.0.0/16"

# EKS
cluster_name              = "my-eks-cluster"
cluster_version           = "1.12"
public_endpoint           = true
private_endpoint          = false
cluster_enabled_log_types = []
instance_size             = "t2.medium"
encrypted_volumes         = true
log_retention             = 3
