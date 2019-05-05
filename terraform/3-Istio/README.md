# Istio

Let's deploy Istio (and related packages) into our EKS cluster.

## Prerequesites

- Get the helm CLI from https://helm.sh website
- Deploy an EKS cluster (with the template located under 1-Create-EKS-Cluster directory)

Note: template located under '2-Helm-and-packages' directory is not a required 
step.

## Installation steps

### Istio (without Kiali integration)

First, get the last version of Istio (here, version 1.1.5):

```bash
$ curl -L https://git.io/getLatestIstio | ISTIO_VERSION=1.1.5 sh -
$ cd istio-1.1.5
```

Then, we have to create the needed role service account for Tiller and install 
it:

```bash
$ kubectl --kubeconfig <KUBECONFIG_FILE> apply -f install/kubernetes/helm/helm-service-account.yaml
$ helm --kubeconfig <KUBECONFIG_FILE> init --service-account tiller
```

Install the istio-init chart to bootstrap all the Istio’s CRDs:

```bash
helm --kubeconfig <KUBECONFIG_FILE> install install/kubernetes/helm/istio-init --name istio-init --namespace istio-system
```

It can take a while for installing all the needed CRDs (58 CRDs).
Finally, installation of Istio himself:

```bash
helm --kubeconfig <KUBECONFIG_FILE> install install/kubernetes/helm/istio --name istio --namespace istio-system
```

### Istio (with Kiali integration)

First, get the last version of Istio (here, version 1.1.5):

```bash
$ curl -L https://git.io/getLatestIstio | ISTIO_VERSION=1.1.5 sh -
$ cd istio-1.1.5
```

Then, we have to create the needed role service account for Tiller and install 
it:

```bash
$ kubectl --kubeconfig <KUBECONFIG_FILE> apply -f install/kubernetes/helm/helm-service-account.yaml
$ helm --kubeconfig <KUBECONFIG_FILE> init --service-account tiller
```

Install the istio-init chart to bootstrap all the Istio’s CRDs:

```bash
helm --kubeconfig <KUBECONFIG_FILE> install install/kubernetes/helm/istio-init --name istio-init --namespace istio-system
```

Secret creation (for Kiali creation).
If you're using Bash shell:

```bash
$ KIALI_USERNAME=$(read -p 'Kiali Username: ' uval && echo -n $uval | base64)
$ KIALI_PASSPHRASE=$(read -sp 'Kiali Passphrase: ' pval && echo -n $pval | base64)
```

If you're using ZSH shell:
```bash
KIALI_USERNAME=$(read '?Kiali Username: ' uval && echo -n $uval | base64)
KIALI_PASSPHRASE=$(read -s "?Kiali Passphrase: " pval && echo -n $pval | base64)
```

Then, let's create the secret:

```bash
$ NAMESPACE=istio-system
$ kubectl --kubeconfig <KUBECONFIG_FILE> create namespace $NAMESPACE
$ cat <<EOF | kubectl --kubeconfig <KUBECONFIG_FILE> apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: kiali
  namespace: $NAMESPACE
  labels:
    app: kiali
type: Opaque
data:
  username: $KIALI_USERNAME
  passphrase: $KIALI_PASSPHRASE
EOF
```

Finally, let's install Istio and Kiali:

```bash
$ helm --kubeconfig <KUBECONFIG_FILE> template \
    --set kiali.enabled=true \
    --set "kiali.dashboard.jaegerURL=http://jaeger-query:16686" \
    --set "kiali.dashboard.grafanaURL=http://grafana:3000" \
    install/kubernetes/helm/istio \
    --name istio --namespace istio-system | kubectl --kubeconfig <KUBECONFIG_FILE> apply -f -
```

### Install a sample application

For testing Istio/Kiali now, we'll deploy a sample application.
Still inside the Istio directory, use these commands:

```bash
$ kubectl --kubeconfig <KUBECONFIG_FILE> label namespace default istio-injection=enabled
$ kubectl --kubeconfig <KUBECONFIG_FILE> apply -f samples/bookinfo/platform/kube/bookinfo.yaml
```

To make the application accessible from the outside:

```bash
$ kubectl --kubeconfig <KUBECONFIG_FILE> apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
```

## Accessing Kiali console



## Uninstallation steps

### Istio

```bash
$ cd istio-1.1.5
$ helm --kubeconfig <KUBECONFIG_FILE> delete --purge istio
$ helm --kubeconfig <KUBECONFIG_FILE> delete --purge istio-init
$ kubectl --kubeconfig <KUBECONFIG_FILE> delete -f install/kubernetes/helm/istio-init/files
```
