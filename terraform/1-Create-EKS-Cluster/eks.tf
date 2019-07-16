# Creating an EKS cluster
# - EKS Cluster and workers
# - ASG Policy & Alarm for auto-scaling

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "5.0.0"

  cluster_version                    = var.cluster_version
  cluster_name                       = "${var.cluster_name}-${terraform.workspace}"
  subnets                            = module.vpc.private_subnets
  vpc_id                             = module.vpc.vpc_id
  cluster_enabled_log_types          = var.cluster_enabled_log_types
  cluster_endpoint_private_access    = var.private_endpoint
  cluster_endpoint_public_access     = var.public_endpoint

  worker_groups_launch_template = [
    {
      name                 = "worker-group-1"
      instance_type        = var.instance_size
      autoscaling_enabled  = true
      asg_desired_capacity = var.asg_desired
      asg_min_size         = var.asg_min
      asg_max_size         = var.asg_max
      key_name             = var.key_pair
      root_encrypted       = true
      root_kms_key_id      = var.kms_key_id
      enabled_metrics      = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity"]
    },
  ]

  tags = local.tags
}

