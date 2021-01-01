# Variables for workspace default

# AWS Region
region = "eu-west-1"

# VPC 
vpc_cidr = "10.0.0.0/16"

# EKS
cluster_name              = "my-eks-cluster"
cluster_version           = "1.18"
public_endpoint           = true
private_endpoint          = false
cluster_enabled_log_types = []

# EKS EC2 Workers
workers_nodes = [
    {
      name                 = "worker-group-1"
      instance_type        = "t2.large"
      asg_desired_capacity = 3
      asg_min_size         = 3
      asg_max_size         = 8
      public_ip            = false
    },
    {
      name                 = "worker-group-2"
      instance_type        = "m5.large"
      asg_desired_capacity = 1
      asg_min_size         = 1
      asg_max_size         = 3
      public_ip            = false
    },
  ]

# EKS Fargate Profiles
fargate_profiles = {
  fargate_1 = {
    namespace = "fargate"

    # Kubernetes labels for selection
    # labels = {
    #   Environment = "test"
    #   GithubRepo  = "terraform-aws-eks"
    #   GithubOrg   = "terraform-aws-modules"
    # }

    tags = {
      Owner = "test"
    }
  }
}
