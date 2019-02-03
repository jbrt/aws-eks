# Deployment of the metrics-server

resource "null_resource" "metrics-server" {
  depends_on = ["module.eks"]

  provisioner "local-exec" {
    command = "kubectl --kubeconfig ${path.module}/kubeconfig_${var.cluster_name} create -f ${path.module}/files/metrics-server/1.8+/"
  }
}