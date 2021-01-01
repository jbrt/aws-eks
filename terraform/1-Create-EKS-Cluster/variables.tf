# Region and VPC variables

variable "region" {
  description = "Region where all AWS objects will be created"
}

variable "vpc_cidr" {
  description = "CIDR of this VPC"
}

# EKS Cluster variables

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "The version of Kubernetes to use in the EKS cluster"
  type        = string
}

variable "public_endpoint" {
  description = "Enable the public endpoint for EKS cluster"
}

variable "private_endpoint" {
  description = "Enable the private endpoint for EKS cluster"
}

variable "cluster_enabled_log_types" {
  description = "List of logs to send to CloudWatch (api, audit, authenticator , controllerManager, scheduler)"
  type        = list(string)
}

# EKS Workers variables

variable "workers_nodes" {
  description = "Description of the worker groups to create"
}

variable "fargate_profiles" {
  description = "Description of the Fargate Profile to create"
}

# Network & Tags

locals {
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  # Will create AZ a,b,c
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
  public_subnets     = [cidrsubnet(var.vpc_cidr, 8, 1), cidrsubnet(var.vpc_cidr, 8, 2), cidrsubnet(var.vpc_cidr, 8, 3)]
  private_subnets    = [cidrsubnet(var.vpc_cidr, 8, 10), cidrsubnet(var.vpc_cidr, 8, 20), cidrsubnet(var.vpc_cidr, 8, 30)]

}
