# Cluster-autoscaler

# Using a non HELM package for the moment (because I had some problems with)

data "template_file" "auto-scaler" {
  template = "${file("${path.module}/templates/cluster-autoscaler.tpl")}"
  vars = {
    VERSION = "1.12.3"
    CLUSTER = "${var.cluster_name}"
  }
}

resource "local_file" "cluster-autoscaler" {
  filename = "${path.module}/templates/cluster-autoscaler.yml"
  content  = "${data.template_file.auto-scaler.rendered}"

  depends_on = ["helm_release.metrics-server"]

  provisioner "local-exec" {
    command = "kubectl --kubeconfig ${path.module}/../1-Create-EKS-Cluster/kubeconfig_${var.cluster_name} apply -f ${path.module}/templates/cluster-autoscaler.yml"
  }
}
