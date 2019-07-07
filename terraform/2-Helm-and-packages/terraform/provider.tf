provider "kubernetes" {
  version     = "1.6.2"
  config_path = "${path.module}/../../1-Create-EKS-Cluster/kubeconfig_${var.cluster_name}-${terraform.workspace}"
}

resource "kubernetes_service_account" "tiller" {
  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "tiller-rights" {
  metadata {
    name = "tiller"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  # api_group has to be empty because of a bug:
  # https://github.com/terraform-providers/terraform-provider-kubernetes/issues/204
  subject {
    api_group = ""
    kind      = "ServiceAccount"
    name      = "tiller"
    namespace = "kube-system"
  }
}

provider "helm" {
  version         = "0.9.1"
  install_tiller  = true
  service_account = "tiller"
  namespace       = "kube-system"

  kubernetes {
    config_path = "${path.module}/../../1-Create-EKS-Cluster/kubeconfig_${var.cluster_name}-${terraform.workspace}"
  }
}

