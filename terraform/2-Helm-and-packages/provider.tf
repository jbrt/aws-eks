

provider "helm" {
    kubernetes {
        config_path = "${path.module}/../1-Create-EKS-Cluster/kubeconfig_${var.cluster_name}"
    }
}
