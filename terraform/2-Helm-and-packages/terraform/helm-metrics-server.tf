# Metrics server (for Horizontal Pod AutoScaling)

resource "helm_release" "metrics-server" {
  depends_on = [kubernetes_cluster_role_binding.tiller-rights]
  name       = "metrics-server"
  chart      = "stable/metrics-server"
  namespace  = "kube-system"
}

