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

variable "instance_size" {
  description = "The size of the instances used by EKS workers ASG"
  type        = string
}

variable "key_pair" {
  description = "Key pair used for the instance workers"
  type        = string
  default     = ""
}

variable "encrypted_volumes" {
  description = "Encrypt EBS volumes for EKS workers"
}

variable "kms_key_id" {
  description = "KMS Key ID to use for encrypting volumes. If empty the default EBS key will be used."
  type        = string
  default     = ""
}

variable "asg_min" {
  description = "Minimal number of instances"
  default     = 2
}

variable "asg_desired" {
  description = "Desired number of instances"
  default     = 3
}

variable "asg_max" {
  description = "Minimal number of instances"
  default     = 6
}

# CloudWatch variables

variable "log_retention" {
  description = "Number of days for log retention"
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

  log_group_containers = "/eks/${var.cluster_name}/containers"
  log_group_systemd    = "/eks/${var.cluster_name}/systemd"
}

