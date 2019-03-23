# Here, we install some Kubernetes utilities like Dashboard

resource "null_resource" "cluster" {
  depends_on = ["module.eks"]

  provisioner "local-exec" {
    command = "kubectl --kubeconfig ${path.module}/kubeconfig_${var.cluster_name} apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml"
  }
}
