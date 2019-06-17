resource "helm_release" "cluster-autoscaler" {
  name  = "cluster-autoscaler"
  chart = "stable/cluster-autoscaler"
  namespace  = "kube-system"

  set {
    name  = "rbac.create=true"
    value = "true"
  }

  set {
    name  = "sslCertPath"
    value = "/etc/ssl/certs/ca-bundle.crt"
  }

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "awsRegion"
    value = "${var.region}"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = "${var.cluster_name}"
  }

  set {
    name  = "autoDiscovery.enabled"
    value = "true"
  }
}
