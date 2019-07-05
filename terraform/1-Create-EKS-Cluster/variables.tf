# Region and VPC variables

variable "region" {
  description = "Region where all AWS objects will be created"
}

variable "availability_zones" {
  description = "Which AZs will be used"
  type        = "list"
}

variable "vpc_cidr" {
  description = "CIDR of this VPC"
}

variable "public_subnets" {
  type = "list"
}

variable "private_subnets" {
  type = "list"
}

# EKS Cluster variables

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = "string"
}

variable "cluster_version" {
  description = "The version of Kubernetes to use in the EKS cluster"
  type        = "string"
}

variable "public_endpoint" {
  description = "Enable the public endpoint for EKS cluster"
}

variable "private_endpoint" {
  description = "Enable the private endpoint for EKS cluster"
}

variable "cluster_enabled_log_types" {
  description = "List of logs to send to CloudWatch (api, audit, authenticator , controllerManager, scheduler)"
  type        = "list"
}

variable "instance_size" {
  description = "The size of the instances used by EKS workers ASG"
  type        = "string"
}

variable "key_pair" {
  description = "Key pair used for the instance workers"
  type        = "string"
}

variable "encrypted_volumes" {
  description = "Encrypt EBS volumes for EKS workers"
}

variable "kms_key_id" {
  description = "KMS Key ID to use for encrypting volumes. If empty the default EBS key will be used."
}

# CloudWatch variables

variable "log_retention" {
  description = "Number of days for log retention"
}

# Tags

locals {
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  log_group_containers = "/eks/${var.cluster_name}/containers"
  log_group_systemd    = "/eks/${var.cluster_name}/systemd"
}
