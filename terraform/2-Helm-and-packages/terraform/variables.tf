# EKS Cluster variables

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "my-eks-cluster"
}

variable "region" {
  default = "eu-west-1"
}

