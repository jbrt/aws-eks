# CloudWatch configuration and Fluentd deployment
# - Creation of 2 log group 
# - Attach a new IAM policy to the EKS workers IAM role
# - Generate Fluentd YAML manifest and launching 'kubectl apply' command

# Log Groups
resource "aws_cloudwatch_log_group" "log_group_containers" {
  name              = "${local.log_group_containers}"
  retention_in_days = "${var.log_retention}"
  tags              = "${local.tags}"
}

resource "aws_cloudwatch_log_group" "log_group_systemd" {
  name              = "${local.log_group_systemd}"
  retention_in_days = "${var.log_retention}"
  tags              = "${local.tags}"
}

# IAM Policy and attachment
resource "aws_iam_policy" "policy_cloudwatch" {
  name        = "EKSCloudWatchLogPolicy"
  description = "This policy allow EKS workers to send logs into cloudwatch"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:CreateLogGroup",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = "${module.eks.worker_iam_role_name}"
  policy_arn = "${aws_iam_policy.policy_cloudwatch.arn}"
}

# Generating Fluentd YAML template and applying to EKS cluster
data "template_file" "fluentd_template" {
  template = "${file("${path.module}/files/fluentd.tpl")}"
  vars = {
    region               = "${var.region}"
    cluster_name         = "${var.cluster_name}"
    log_group_containers = "${local.log_group_containers}"
    log_group_systemd    = "${local.log_group_systemd}"
  }
}

resource "local_file" "fluentd_config" {
    filename = "${path.module}/files/fluentd.yml"
    content = "${data.template_file.fluentd_template.rendered}"
    
    depends_on = ["module.eks"]

    provisioner "local-exec" {
        command = "kubectl --kubeconfig ${path.module}/kubeconfig_${var.cluster_name} apply -f ${path.module}/files/fluentd.yml"
  }
}
