# Consul

Deploys a [Consul](https://www.consul.io/) cluster on Kubernetes cluster running on any cloud
provider. This module makes use of the official Hashicorp
[Helm Chart](https://www.consul.io/docs/platform/k8s/helm.html).

For more information regarding Consul's integration with Kubernetes, see the
[documentation](https://www.consul.io/docs/platform/k8s/index.html).

## Requirements

You will need to have the following resources available:

- A Kubernetes cluster, managed by your cloud provider, or not
- [Helm](https://helm.sh/) with Tiller running on the Cluster or you can opt to run
    [Tiller locally](https://docs.helm.sh/using_helm/#running-tiller-locally)

You will need to have the following configured on your machine:

- Credentials for your Cloud Provider
- Credentials for Kubernetes configured for `kubectl`

## Usage

### Consul Server Persistent Volumes

The Consul servers are deployed with
[persistent volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) in a
[`StatefulSet`](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/).

If you are running your own cluster in your cloud provider, you will have to define your own set
of storage classes.

If you are using your cloud provider's managed Kubernetes service such as GKE or EKS, they would
have defined their own set of default storage class.

You can use the
[`kubernetes_storage_class`](https://www.terraform.io/docs/providers/kubernetes/r/storage_class.html)
Terraform resource to create a new `StorageClass`.

### Consul Server Resources

You might want to refer to HashiCorp's [guide](https://www.consul.io/docs/guides/performance.html)
and [summary](https://learn.hashicorp.com/consul/advanced/day-1-operations/reference-architecture)
on considering the resources needed for your Consul servers.

### Configuring Consul DNS for `kube-dns`

You can configure Consul to act as the
[DNS resolver](https://www.consul.io/docs/platform/k8s/dns.html) for `.consul` domains. By default,
this module does not attempt to do so manually because there is no good way to append to any
existing `kube-dns` or `CoreDNS` configuration. If you would like to do so, you can set the
`configure_kube_dns` to `true` to **overwrite** any existing `kube-dns` configuration.

#### Error Configuring `kube-dns`

If you get the error:

```text
1 error(s) occurred:

* module.consul.kubernetes_config_map.consul_dns: 1 error(s) occurred:

* kubernetes_config_map.consul_dns: configmaps "kube-dns" already exists

```

You have an existing `kube-dns` configuration. Use
`kubectl describe configMap -n kube-system kube-dns` to see the existing configuration. You can
append to it using the documentation [here](https://www.consul.io/docs/platform/k8s/dns.html).

Alternatively, if the configuration is empty, you can delete it with
`kubectl delete configMap -n kube-system kube-dns`, set variable `configure_kube_dns` to `true`
and let this module manage the configuration.

### Configuring Consul DNS for `CoreDNS`

You can configure Consul to act as the
[DNS resolver](https://www.consul.io/docs/platform/k8s/dns.html) for `.consul` domains. By default,
this module does not attempt to do so manually because there is no good way to append to any
existing `kube-dns` or `CoreDNS` configuration. If you would like to do so, you can set the
`configure_kube_dns` to `true` to **overwrite** any existing `CoreDNS` configuration.

However, you should probably get any existing `CoreDNS` settings and set it to the `core_dns_base` variable.

You can do so by running `kubectl get configmap/coredns -n kube-system -o yaml`.
