# VPC
# Create a VPC with only a public subnet

provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.53.0"

  name               = "vpc-${var.cluster_name}"
  cidr               = "10.0.0.0/16"
  azs                = "${var.availability_zones}"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets     = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
  enable_nat_gateway = true

  #public_subnet_tags  = 
  tags               = "${local.tags}"
}
