# Region and VPC variables

variable "region" {
  description = "Region where all AWS objects will be created"
  default     = "eu-west-1"
}

variable "availability_zones" {
  description = "Which AZs will be used"
  type        = "list"
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "vpc_cidr" {
  description = "CIDR of this VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = "list"
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  type    = "list"
  default = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
}

# EKS Cluster variables

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = "string"
  default     = "my-eks-cluster"
}

variable "cluster_version" {
  description = "The version of Kubernetes to use in the EKS cluster"
  type        = "string"
  default     = "1.12"
}

variable "public_endpoint" {
  description = "Enable the public endpoint for EKS cluster"
  default     = true
}

variable "private_endpoint" {
  description = "Enable the private endpoint for EKS cluster"
  default     = false
}

variable "cluster_enabled_log_types" {
  description = "List of logs to send to CloudWatch (api, audit, authenticator , controllerManager, scheduler)"
  type        = "list"
  default     = []
}

variable "instance_size" {
  description = "The size of the instances used by EKS workers ASG"
  type        = "string"
  default     = "t2.medium"
}

variable "key_pair" {
  description = "Key pair used for the instance workers"
  type        = "string"
  default     = ""
}

variable "encrypted_volumes" {
  description = "Encrypt EBS volumes for EKS workers"
  default     = false
}

variable "kms_key_id" {
  description = "KMS Key ID to use for encrypting volumes. If empty the default EBS key will be used."
  default     = ""
}

# CloudWatch variables

variable "log_retention" {
  description = "Number of days for log retention"
  default     = 7
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
