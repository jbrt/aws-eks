# Istio

Let's deploy Istio (and related packages) into our EKS cluster.

## Prerequesites

- Get the helm CLI from https://helm.sh website
- Deploy an EKS cluster (with the template located under 1-Create-EKS-Cluster directory)

Note: template located under '2-Helm-and-packages' directory is not a required 
step.

## Installation steps

### Istio

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

## Uninstallation steps

### Istio

```bash
$ cd istio-1.1.5
$ helm --kubeconfig <KUBECONFIG_FILE> delete --purge istio
$ helm --kubeconfig <KUBECONFIG_FILE> delete --purge istio-init
$ kubectl --kubeconfig <KUBECONFIG_FILE> delete -f install/kubernetes/helm/istio-init/files
```
