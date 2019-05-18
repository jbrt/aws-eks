# Creating an EKS cluster
# - EKS Cluster and workers
# - ASG Policy & Alarm for auto-scaling

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "4.0.2"

  cluster_version                 = "${var.cluster_version}"
  cluster_name                    = "${var.cluster_name}"
  subnets                         = "${module.vpc.private_subnets}"
  vpc_id                          = "${module.vpc.vpc_id}"
  cluster_enabled_log_types       = "${var.cluster_enabled_log_types}"
  cluster_endpoint_private_access = "${var.private_endpoint}"
  cluster_endpoint_public_access  = "${var.public_endpoint}"

  worker_groups = [
    {
      instance_type        = "${var.instance_size}"
      asg_min_size         = 3
      asg_desired_capacity = 3
      asg_max_size         = 6
      autoscaling_enabled  = true
    },
  ]

  tags = "${local.tags}"
}
