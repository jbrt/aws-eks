data "template_file" "fluentd_template" {
  template = "${file("${path.module}/files/fluentd.tpl")}"
  vars = {
    region = "${var.region}"
    cluster_name = "${var.cluster_name}"
  }
}

resource "local_file" "fluentd_config" {
    filename = "${path.module}/files/fluentd.yml"
    content = "${data.template_file.fluentd_template.rendered}"
}
