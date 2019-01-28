module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "2.1.0"

  cluster_name = "${var.cluster_name}"
  subnets      = "${module.vpc.public_subnets}"
  vpc_id       = "${module.vpc.vpc_id}"

  worker_groups = [
    {
      instance_type        = "t2.small"
      asg_min_size         = 3
      asg_desired_capacity = 3
      asg_max_size         = 6
    }
  ]

  tags = "${local.tags}"
}