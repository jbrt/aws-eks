
provider "kubernetes" {
  config_path = "${path.module}/../1-Create-EKS-Cluster/kubeconfig_${var.cluster_name}"
}

provider "helm" {
    kubernetes {
        config_path = "${path.module}/../1-Create-EKS-Cluster/kubeconfig_${var.cluster_name}"
    }
}

# Rights for Tiller
resource "kubernetes_cluster_role_binding" "tiller-rights" {
    metadata {
        name = "add-on-cluster-admin"
    }
    role_ref {
        api_group = "rbac.authorization.k8s.io"
        kind = "ClusterRole"
        name = "cluster-admin"
    }
    subject {
        kind = "User"
        name = "admin"
        api_group = "rbac.authorization.k8s.io"
    }
    subject {
        kind = "ServiceAccount"
        name = "default"
        namespace = "kube-system"
    }
    subject {
        kind = "Group"
        name = "system:masters"
        api_group = "rbac.authorization.k8s.io"
    }
}