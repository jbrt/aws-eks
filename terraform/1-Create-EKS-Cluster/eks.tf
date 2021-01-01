# Creating an EKS cluster
# - EKS Cluster and workers
# - CMK needed for secrets encryption

resource "aws_kms_key" "cmk_for_eks" {
  description = "EKS Secret Encryption Key"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "13.2.1"

  cluster_version                 = var.cluster_version
  cluster_name                    = "${var.cluster_name}-${terraform.workspace}"
  subnets                         = module.vpc.private_subnets
  vpc_id                          = module.vpc.vpc_id
  cluster_enabled_log_types       = var.cluster_enabled_log_types
  cluster_endpoint_private_access = var.private_endpoint
  cluster_endpoint_public_access  = var.public_endpoint

  cluster_encryption_config = [
    {
      provider_key_arn = aws_kms_key.cmk_for_eks.arn
      resources        = ["secrets"]
    }
  ]

  // worker_groups_launch_template variable will create a EKS non-managed workers groups
  // (node_groups variable is the equivalent for managed nodes groups)
  worker_groups_launch_template = var.workers_nodes
  fargate_profiles = var.fargate_profiles

  tags = local.tags
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
