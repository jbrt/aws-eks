variable "access_key" {}
variable "secret_key" {}

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

# EKS Cluster variables

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = "string"
  default     = "my-eks-cluster"
}

# CloudWatch variables

variable "log_retention" {
    description = "Number of days for log retention"
    default     = 1
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
