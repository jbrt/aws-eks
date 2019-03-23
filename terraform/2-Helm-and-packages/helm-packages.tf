# Install packages into EKS cluster using HELM provider

# K8s Dashboard
resource "helm_release" "kubernetes-dashboard" {
    name      = "kubernetes-dashboard"
    chart     = "stable/kubernetes-dashboard"

    values = [<<EOF
rbac:
  create: false
EOF
]
}

# Metrics server (for Horizontal Pod AutoScaling)
resource "helm_release" "metrics-server" {
    name      = "metrics-server"
    chart     = "stable/metrics-server"
}

# Rights problem, fixed with that (will be fixed later)
# kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default