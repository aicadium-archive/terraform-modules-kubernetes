# CloudSQL Proxy

## Providers

| Name | Version |
|------|---------|
| helm | >= 1.0 |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| affinity | Affinity for the pod | `map` | `{}` | no |
| chart\_name | Helm chart name to provision | `string` | `"cloudsql-proxy"` | no |
| chart\_namespace | Namespace to install the chart into | `string` | `"default"` | no |
| chart\_repository | Helm repository for the chart | `string` | `"amoy"` | no |
| chart\_repository\_url | URL for the chart repository | `string` | `"https://charts.amoy.ai"` | no |
| chart\_version | Version of Chart to install. Set to empty to install the latest version | `string` | `""` | no |
| command | Command for the proxy | `list` | <pre>[<br>  "/cloud_sql_proxy",<br>  "-instances=\u003cINSTANCE_CONNECTION_NAME\u003e=tcp:5432",<br>  "-log_debug_stdout",<br>  "-credential_file=/secrets/cloudsql/credentials.json"<br>]</pre> | no |
| deployment\_strategy | Deployment strategy | `map` | <pre>{<br>  "maxSurge": 1,<br>  "maxUnavailable": 0<br>}</pre> | no |
| enable | Enable Helm Chart | `bool` | `true` | no |
| env | Environment variables for the proxy container | `list` | `[]` | no |
| image | Docker image | `string` | `"gcr.io/cloudsql-docker/gce-proxy"` | no |
| max\_history | Max History for Helm | `number` | `20` | no |
| node\_selector | Node selector for the pod | `map` | `{}` | no |
| pod\_security\_context | Security context for the pod | `map` | <pre>{<br>  "fsGroup": 2000<br>}</pre> | no |
| port | Container pod. This should match the port you specify in the command | `number` | `5432` | no |
| release\_name | Helm release name | `string` | `"cloudsql-proxy"` | no |
| replicas | Number of replicas | `number` | `1` | no |
| resources | Resources for the pod | `map` | `{}` | no |
| security\_context | Security context for the container | `map` | <pre>{<br>  "runAsNonRoot": true,<br>  "runAsUser": 1000<br>}</pre> | no |
| service\_account\_annotations | Annotations for Service account | `map` | `{}` | no |
| service\_account\_name | Service account name | `string` | `""` | no |
| service\_port | Port on the Kubernetes Service | `number` | `5432` | no |
| service\_type | Type of Kubernetes service | `string` | `"ClusterIP"` | no |
| tag | Docker image tag | `string` | `"1.16"` | no |
| tolerations | List of tolerations for the pod | `list` | `[]` | no |
| volume\_mounts | Volume mounts for the proxy container | `list` | `[]` | no |
| volumes | Volumes for the pod | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| service | Name of the Kubernetes service |
