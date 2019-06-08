# VPC
# Create a VPC with only a public subnet

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.53.0"

  name            = "vpc-${var.cluster_name}"
  cidr            = "${var.vpc_cidr}"
  azs             = "${var.availability_zones}"
  public_subnets  = "${var.public_subnets}"
  private_subnets = "${var.private_subnets}"

  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  tags                = "${local.tags}"
  vpc_tags            = "${merge(local.tags, map("kubernetes.io/cluster/${var.cluster_name}", "shared"))}"
  public_subnet_tags  = "${merge(local.tags, map("kubernetes.io/cluster/${var.cluster_name}", "shared"))}"
  private_subnet_tags = "${merge(local.tags, map("kubernetes.io/role/internal-elb", 1))}"
}
