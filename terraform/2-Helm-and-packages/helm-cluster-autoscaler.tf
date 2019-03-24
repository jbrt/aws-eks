# Cluster-autoscaler

resource "helm_release" "cluster-autoscaler" {
  depends_on = ["kubernetes_cluster_role_binding.tiller-rights"]
  name       = "cluster-autoscaler"
  chart      = "stable/cluster-autoscaler"
}
