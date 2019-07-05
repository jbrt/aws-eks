# Variables for workspace default

# AWS Region
region                    = "eu-west-1"
availability_zones        = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

# VPC 
vpc_cidr                  = "10.0.0.0/16"
public_subnets            = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets           = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]

# EKS
cluster_name              = "my-eks-cluster"
cluster_version           = "1.12"
public_endpoint           = true
private_endpoint          = false
cluster_enabled_log_types = []
instance_size             = "t2.medium"
key_pair                  = ""
encrypted_volumes         = true
kms_key_id                = ""
log_retention             = 7
