# Prometheus Adapter

Installs the [Prometheus Adapter](https://github.com/DirectXMan12/k8s-prometheus-adapter)
for the Custom Metrics API. Custom metrics are used in Kubernetes by
[Horizontal Pod Autoscalers](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
to scale workloads based upon your own metric pulled from an external metrics provider like
Prometheus.

## Providers

| Name | Version |
|------|---------|
| helm | >= 1.0 |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| affinity | Affinity for the pods | `map` | `{}` | no |
| chart\_name | Helm chart name to provision | `string` | `"prometheus-adapter"` | no |
| chart\_namespace | Namespace to install the chart into | `string` | `"default"` | no |
| chart\_repository | Helm repository for the chart | `string` | `"stable"` | no |
| chart\_version | Version of Chart to install. Set to empty to install the latest version | `string` | `""` | no |
| extra\_volume\_mounts | Extra volume mounts for the adapter container | `list` | `[]` | no |
| extra\_volumes | Extra volumes for the adapter | `list` | `[]` | no |
| image | Docker image for the Prometheus Adapter | `string` | `"directxman12/k8s-prometheus-adapter-amd64"` | no |
| log\_level | Numerical log level for the adapter | `number` | `4` | no |
| max\_history | Max History for Helm | `number` | `20` | no |
| pod\_annotations | Pod annotations | `map` | `{}` | no |
| priority\_class\_name | Pod Priority Class name | `string` | `""` | no |
| prometheus\_port | Prometheus port | `number` | `9090` | no |
| prometheus\_url | Address for Prometheus | `string` | `"http://prometheus.default.svc"` | no |
| release\_name | Helm release name for Prometheus | `string` | `"prometheus-adapter"` | no |
| replicas | Number of replicas | `number` | `1` | no |
| resources | Resources for the pod | `map` | `{}` | no |
| rules\_custom | Custom metrics rules | `list` | `[]` | no |
| rules\_default | Use the default rules from the chart | `bool` | `true` | no |
| rules\_existing | ConfigMap containing existing rules | `any` | n/a | yes |
| rules\_external | External metrics rules | `list` | `[]` | no |
| rules\_resource | Custom resource rules | `map` | `{}` | no |
| service\_annotations | Service Annotations | `map` | `{}` | no |
| service\_port | Service port | `string` | `"443"` | no |
| service\_type | Service Type | `string` | `"ClusterIP"` | no |
| tag | Docker Image tag for the Prometheus Adapter | `string` | `"latest"` | no |
| tolerations | Tolerations for the pod | `list` | `[]` | no |

## Outputs

No output.
