# Install packages with Helm (but without Terraform Helm provider)

## Installing Helm tiller into your cluster

First of all, you have to download the Helm binary from https://helm.sh/

Before installing Helm tiller, you have to give to him the needed rights:

```bash
$ kubectl --kubeconfig KUBECONFIG_FILE apply -f tiller-rbac.yml
serviceaccount/tiller created
clusterrolebinding.rbac.authorization.k8s.io/tiller created
```

Then, let's installing the tiller:

```bash
$ helm --kubeconfig KUBECONFIG_FILE init --tiller-namespace kube-system --service-account tiller
$HELM_HOME has been configured at /Users/user/.helm.

Tiller (the Helm server-side component) has been installed into your Kubernetes Cluster.
```

Updating the Helm chart's list:

```bash
$ helm --kubeconfig KUBECONFIG_FILE repo update
Hang tight while we grab the latest from your chart repositories...
...Skip local chart repository
...Successfully got an update from the "stable" chart repository
Update Complete.
```

## Installing Metrics-server

```bash
$ helm --kubeconfig KUBECONFIG_FILE install stable/metrics-server --name metrics-server
NAME:   metrics-server
LAST DEPLOYED: Sat Jun 15 11:14:30 2019
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/ClusterRole
rbac:
NAME                                     AGE
rbac:
system:metrics-server                    1s
system:metrics-server-aggregated-reader  1s

==> v1/ClusterRoleBinding
NAME                                  AGE
metrics-server:system:auth-delegator  1s
system:metrics-server                 1s

==> v1/Deployment
NAME            READY  UP-TO-DATE  AVAILABLE  AGE
metrics-server  0/1    1           0          1s

==> v1/Pod(related)
NAME                             READY  STATUS             RESTARTS  AGE
metrics-server-76fcfd58d5-bkgjl  0/1    ContainerCreating  0         1s

==> v1/Service
NAME            TYPE       CLUSTER-IP     EXTERNAL-IP  PORT(S)  AGE
metrics-server  ClusterIP  172.20.136.83  <none>       443/TCP  1s

==> v1/ServiceAccount
NAME            SECRETS  AGE
metrics-server  1        1s

==> v1beta1/APIService
NAME                    AGE
v1beta1.metrics.k8s.io  1s

==> v1beta1/RoleBinding
NAME                        AGE
metrics-server-auth-reader  1s


NOTES:
The metric server has been deployed.

In a few minutes you should be able to list metrics using the following
command:

  kubectl get --raw "/apis/metrics.k8s.io/v1beta1/nodes"
```

**After few minutes** metrics should be available (you can check with 
"top nodes" command).

## Installating cluster-autoscaler

You have two ways for installing cluster-autoscaler.
The first one is based on a YAML file for parameters. In both case you have to 
**replace variables with the correct values**.

```bash
$ helm --kubeconfig KUBECONFIG_FILE install stable/cluster-autoscaler --name cluster-autoscaler --values=cluster-autoscaler.yml
```

The second way is by giving parameters directly on the command line:

```bash
$ helm --kubeconfig KUBECONFIG_FILE install stable/cluster-autoscaler --name cluster-autoscaler --set "rbac.create=true,sslCertPath=/etc/ssl/certs/ca-bundle.crt,cloudProvider=aws,awsRegion=YOUR_REGION,autoDiscovery.clusterName=YOUR_CLUSTER_NAME,autoDiscovery.enabled=true"
```
