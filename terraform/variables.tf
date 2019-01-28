variable "access_key" {}
variable "secret_key" {}

variable "region" {
  description = "Region where all AWS objects will be created"
  default     = "eu-west-1"
}

variable "availability_zones" {
  description = "Which AZs will be used"
  type        = "list"
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = "string"
  default     = "my-eks-cluster"
}

locals {
    tags = {
        Terraform   = "true"
        Environment = "dev"
  }
}
