# Dashboard

This module deploys the Kubernetes Dashboard.

## Providers

| Name | Version |
|------|---------|
| helm | >= 1.0 |
| kubernetes | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| dashboard\_affinity | Affinity for Dashboard | `map` | `{}` | no |
| dashboard\_annotations | Annotations for the dashboard deployment | `map` | `{}` | no |
| dashboard\_chart\_name | Chart name for Dashboard | `string` | `"stable/kubernetes-dashboard"` | no |
| dashboard\_chart\_repository | Chart repository for Dashboard | `string` | `""` | no |
| dashboard\_chart\_version | Chart version for Dashboard | `string` | `""` | no |
| dashboard\_cluster\_admin | Enable Cluster Admin role for the dashboard. Not recommended. | `bool` | `false` | no |
| dashboard\_enable\_skip\_login | Enable skipping of login for the dashboard to default to the service account rights for the dashboard | `string` | `"true"` | no |
| dashboard\_image | Docker image for Dashboard | `string` | `"k8s.gcr.io/kubernetes-dashboard-amd64"` | no |
| dashboard\_labels | Labels for the dashboard deployment | `map` | `{}` | no |
| dashboard\_namespace | Namespace to deploy the dashboard in | `string` | `"kube-system"` | no |
| dashboard\_pdb | YAML of PDB of the Dashboard | `string` | `"maxUnavailable: 1"` | no |
| dashboard\_pod\_annotations | Annotations for dashboard pods | `map` | `{}` | no |
| dashboard\_release\_name | Release name for Dashboard | `string` | `"kubernetes-dashboard"` | no |
| dashboard\_replica | Number of replicas for Dashboard | `string` | `"3"` | no |
| dashboard\_resources | Resources for Dashboard | `map` | <pre>{<br>  "limits": {<br>    "memory": "100Mi"<br>  },<br>  "requests": {<br>    "cpu": "100m"<br>  }<br>}</pre> | no |
| dashboard\_service\_annotations | Annotations for dashboard service | `map` | `{}` | no |
| dashboard\_service\_labels | Labels for dashboard service | `map` | `{}` | no |
| dashboard\_tag | Docker image tag for Dashboard. | `string` | `"v1.10.1"` | no |
| dashboard\_tolerations | Tolerations for Dashboard | `list` | `[]` | no |
| dashboard\_viewer\_role | Name of the Role for Dashboard proxy viewing | `string` | `"dashboard-viewer"` | no |
| dashboard\_viewers | Dashboard viewer subjects | <pre>list(<br>    object(<br>      {<br>        name      = string,<br>        kind      = string,<br>        namespace = string,<br>        api_group = string,<br>      }<br>    )<br>  )</pre> | n/a | yes |
| max\_history | Max History for Helm | `number` | `20` | no |

## Outputs

No output.
