# VPC
# Create a VPC with only a public subnet

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.9.0"

  name            = "vpc-${var.cluster_name}-${terraform.workspace}"
  cidr            = var.vpc_cidr
  azs             = local.availability_zones
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets

  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = false

  tags = local.tags
  vpc_tags = merge(
    local.tags,
    {
      "kubernetes.io/cluster/${var.cluster_name}-${terraform.workspace}" = "shared"
    },
  )
  public_subnet_tags = merge(
    local.tags,
    {
      "kubernetes.io/cluster/${var.cluster_name}-${terraform.workspace}" = "shared"
    },
  )
  private_subnet_tags = merge(
    local.tags,
    {
      "kubernetes.io/role/internal-elb" = 1
    },
  )
}

