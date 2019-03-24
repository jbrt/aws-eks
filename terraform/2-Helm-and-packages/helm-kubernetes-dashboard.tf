# Install K8s Dashboard

# Rights for Dashboard
# Secret
resource "kubernetes_secret" "dashboard-secret" {
  metadata {
    name      = "kubernetes-dashboard-certs"
    namespace = "kube-system"

    labels = {
      k8s-app = "kubernetes-dashboard"
    }
  }
}

# Service Account
resource "kubernetes_service_account" "dashboard-account" {
  metadata {
    name      = "kubernetes-dashboard"
    namespace = "kube-system"

    labels = {
      k8s-app = "kubernetes-dashboard"
    }
  }
}

# Role
resource "kubernetes_role" "dashboard-role" {
  metadata {
    name      = "kubernetes-dashboard-minimal"
    namespace = "kube-system"
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["create"]
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["create"]
  }

  rule {
    api_groups     = [""]
    resources      = ["secrets"]
    resource_names = ["kubernetes-dashboard-key-holder", "kubernetes-dashboard-certs"]
    verbs          = ["get", "update", "delete"]
  }

  rule {
    api_groups     = [""]
    resources      = ["configmaps"]
    resource_names = ["kubernetes-dashboard-settings"]
    verbs          = ["get", "update"]
  }

  rule {
    api_groups     = [""]
    resources      = ["services"]
    resource_names = ["heapster"]
    verbs          = ["proxy"]
  }

  rule {
    api_groups     = [""]
    resources      = ["services/proxy"]
    resource_names = ["heapster", "http:heapster:", "https:heapster:"]
    verbs          = ["get"]
  }
}

# Role Binding
resource "kubernetes_role_binding" "dashboard-rolebinding" {
  metadata {
    name      = "kubernetes-dashboard-minimal"
    namespace = "kube-system"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "kubernetes-dashboard-minimal"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "kubernetes-dashboard"
    namespace = "kube-system"
  }
}

# Finaly, Helm install the Dashboard
resource "helm_release" "kubernetes-dashboard" {
  depends_on = ["kubernetes_cluster_role_binding.tiller-rights"]
  name       = "kubernetes-dashboard"
  chart      = "stable/kubernetes-dashboard"
  namespace  = "kube-system"
}
