# EKS metrics-server

These files are coming from https://github.com/kubernetes-incubator/metrics-server/tree/v0.3.1.

Only the metrics-server-deployment.yaml file has been updated with these lines:

```yaml
  command:
    - /metrics-server
    - --kubelet-preferred-address-types=InternalIP
```

This is for fixing an issue with the HPA module as described here:
https://github.com/kubernetes-incubator/metrics-server/issues/207

