# Creating an EKS cluster
# - EKS Cluster and workers
# - ASG Policy & Alarm for auto-scaling

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "3.0.0"

  cluster_version                 = "${var.cluster_version}"
  cluster_name                    = "${var.cluster_name}"
  subnets                         = "${module.vpc.private_subnets}"
  vpc_id                          = "${module.vpc.vpc_id}"
  cluster_enabled_log_types       = "${var.cluster_enabled_log_types}"
  cluster_endpoint_private_access = "${var.private_endpoint}"
  cluster_endpoint_public_access  = "${var.public_endpoint}"

  worker_groups = [
    {
      instance_type        = "${var.instance_size}"
      asg_min_size         = 3
      asg_desired_capacity = 3
      asg_max_size         = 6
    },
  ]

  tags = "${local.tags}"
}

# Define the Auto-Scaling Policy & Alarm
resource "aws_autoscaling_policy" "eks-autoscaling-policy" {
  name                   = "eks-autoscaling-policy"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 2
  cooldown               = 300
  autoscaling_group_name = "${module.eks.workers_asg_names[0]}"
}

resource "aws_cloudwatch_metric_alarm" "eks-asg-alarm" {
  alarm_name          = "eks-autoscaling-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"

  dimensions = {
    AutoScalingGroupName = "${module.eks.workers_asg_names[0]}"
  }

  alarm_description = "This metric monitors EKS workers ec2 instances cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.eks-autoscaling-policy.arn}"]
}
