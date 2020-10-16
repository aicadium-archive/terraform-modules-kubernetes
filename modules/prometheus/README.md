# Prometheus

Deploys Prometheus and some supporting services on a Kubernetes cluster running in GCP.

This module makes use of the
[`prometheus`](https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus) chart.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| helm | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| helm | >= 1.0 |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alert\_relabel\_configs | Adds option to add alert\_relabel\_configs to avoid duplicate alerts in alertmanager useful in H/A prometheus with different external labels but the same alerts | `map` | `{}` | no |
| alertmanager\_affinity | Affinity for alertmanager pods | `map` | `{}` | no |
| alertmanager\_annotations | Annotations for Alertmanager pods | `map` | `{}` | no |
| alertmanager\_base\_url | External URL which can access alertmanager | `string` | `"/"` | no |
| alertmanager\_config\_file\_name | The configuration file name to be loaded to alertmanager Must match the key within configuration loaded from ConfigMap/Secret | `string` | `"alertmanager.yml"` | no |
| alertmanager\_config\_from\_secret | The name of a secret in the same kubernetes namespace which contains the Alertmanager config Defining configFromSecret will cause templates/alertmanager-configmap.yaml to NOT generate a ConfigMap resource | `string` | `""` | no |
| alertmanager\_config\_map\_override\_name | ConfigMap override where fullname is {{.Release.Name}}-{{.Values.alertmanager.configMapOverrideName} Defining configMapOverrideName will cause templates/alertmanager-configmap.yaml to NOT generate a ConfigMap resource | `string` | `""` | no |
| alertmanager\_enable | Enable Alert manager | `string` | `"true"` | no |
| alertmanager\_extra\_args | Extra arguments for Alertmanager container | `map` | `{}` | no |
| alertmanager\_extra\_env | Extra environment variables for Alertmanager container | `map` | `{}` | no |
| alertmanager\_extra\_secret\_mounts | Defines additional mounts with secrets. Secrets must be manually created in the namespace. | `list` | `[]` | no |
| alertmanager\_files | Additional ConfigMap entries for Alertmanager in YAML string | `string` | `"alertmanager.yml:\n  global: {}\n    # slack_api_url: ''\n\n  receivers:\n    - name: default-receiver\n      # slack_configs:\n      #  - channel: '@you'\n      #    send_resolved: true\n\n  route:\n    group_wait: 10s\n    group_interval: 5m\n    receiver: default-receiver\n    repeat_interval: 3h\n"` | no |
| alertmanager\_headless\_annotations | Annotations for alertmanager StatefulSet headless service | `map` | `{}` | no |
| alertmanager\_headless\_labels | Labels for alertmanager StatefulSet headless service | `map` | `{}` | no |
| alertmanager\_ingress\_annotations | Annotations for Alertmanager ingress | `map` | `{}` | no |
| alertmanager\_ingress\_enabled | Enable ingress for Alertmanager | `string` | `"false"` | no |
| alertmanager\_ingress\_extra\_labels | Additional labels for Alertmanager ingress | `map` | `{}` | no |
| alertmanager\_ingress\_hosts | List of Hosts for Alertmanager ingress | `list` | `[]` | no |
| alertmanager\_ingress\_tls | TLS configurationf or Alertmanager ingress | `list` | `[]` | no |
| alertmanager\_node\_selector | Node selector for alertmanager pods | `map` | `{}` | no |
| alertmanager\_pdb\_enable | Enable PDB | `bool` | `true` | no |
| alertmanager\_pdb\_max\_unavailable | Max unavailable pods for Alertmanager | `number` | `1` | no |
| alertmanager\_pod\_security\_policy\_annotations | PodSecurityPolicy annotations for alertmanager | `map` | <pre>{<br>  "apparmor.security.beta.kubernetes.io/allowedProfileNames": "runtime/default",<br>  "apparmor.security.beta.kubernetes.io/defaultProfileName": "runtime/default",<br>  "seccomp.security.alpha.kubernetes.io/allowedProfileNames": "docker/default,runtime/default",<br>  "seccomp.security.alpha.kubernetes.io/defaultProfileName": "runtime/default"<br>}</pre> | no |
| alertmanager\_prefix\_url | The URL prefix at which the container can be accessed. Useful in the case the '-web.external-url' includes a slug so that the various internal URLs are still able to access as they are in the default case. | `string` | `""` | no |
| alertmanager\_priority\_class\_name | Priority Class Name for Alertmanager pods | `string` | `""` | no |
| alertmanager\_pull\_policy | Image pull policy for Alertmanager | `string` | `"IfNotPresent"` | no |
| alertmanager\_pv\_access\_modes | alertmanager data Persistent Volume access modes | `list` | <pre>[<br>  "ReadWriteOnce"<br>]</pre> | no |
| alertmanager\_pv\_annotations | Annotations for Alertmanager PV | `map` | `{}` | no |
| alertmanager\_pv\_enabled | Enable persistent volume on Alertmanager | `string` | `"true"` | no |
| alertmanager\_pv\_existing\_claim | Use an existing PV claim for alertmanager | `string` | `""` | no |
| alertmanager\_pv\_size | alertmanager data Persistent Volume size | `string` | `"2Gi"` | no |
| alertmanager\_replica | Number of replicas for AlertManager | `number` | `1` | no |
| alertmanager\_repository | Docker repository for Alert Manager | `string` | `"prom/alertmanager"` | no |
| alertmanager\_resources | Resources for alertmanager | `map` | `{}` | no |
| alertmanager\_security\_context | Security context for alertmanager pods defined as a map which will be serialized to JSON.<br>  Due to limitations with Terraform 0.11 and below, integers are serialized as strings in JSON and<br>  this will not work for fields like `runAsUser`. Specify a JSON string with<br>  `alertmanager_security_context_json` instead | `map` | `{}` | no |
| alertmanager\_security\_context\_json | JSON string for security context for alertmanager pods | `string` | `""` | no |
| alertmanager\_service\_account | Name of the service account for AlertManager. Defaults to component's fully qualified name. | `string` | `""` | no |
| alertmanager\_service\_account\_annotations | Annotations for the service account | `map` | `{}` | no |
| alertmanager\_service\_annotations | Annotations for Alertmanager service | `map` | `{}` | no |
| alertmanager\_service\_cluster\_ip | Cluster IP for Alertmanager Service | `string` | `""` | no |
| alertmanager\_service\_external\_ips | External IPs for Alertmanager service | `list` | `[]` | no |
| alertmanager\_service\_labels | Labels for Alertmanager service | `map` | `{}` | no |
| alertmanager\_service\_lb\_ip | Load Balancer IP for Alertmanager service | `string` | `""` | no |
| alertmanager\_service\_lb\_source\_ranges | List of source CIDRs allowed to access the Alertmanager LB | `list` | `[]` | no |
| alertmanager\_service\_port | Service port for Alertmanager | `number` | `80` | no |
| alertmanager\_service\_type | Type of service for Alertmanager | `string` | `"ClusterIP"` | no |
| alertmanager\_storage\_class | Storage class for alertmanager PV. If set to "-", storageClassName: "", which disables dynamic provisioning | `string` | `""` | no |
| alertmanager\_sub\_path | Subdirectory of alertmanager data Persistent Volume to mount | `string` | `""` | no |
| alertmanager\_tag | Tag for Alertmanager Docker Image | `string` | `"v0.16.1"` | no |
| alertmanager\_tolerations | Tolerations for Alertmanager | `list` | `[]` | no |
| alertmanager\_volume\_binding\_mode | Alertmanager data Persistent Volume Binding Mode | `string` | `""` | no |
| chart\_name | Helm chart name to provision | `string` | `"prometheus"` | no |
| chart\_namespace | Namespace to install the chart into | `string` | `"default"` | no |
| chart\_repository | Helm repository for the chart | `string` | `"https://prometheus-community.github.io/helm-charts"` | no |
| chart\_version | Version of Chart to install. Set to empty to install the latest version | `string` | `""` | no |
| configmap\_extra\_args | Extra arguments for ConfigMap Reload | `map` | `{}` | no |
| configmap\_extra\_volumes | Extra volumes for ConfigMap Extra Volumes | `list` | `[]` | no |
| configmap\_image\_repo | Docker Image repo for ConfigMap Reload | `string` | `"jimmidyson/configmap-reload"` | no |
| configmap\_image\_tag | Docker image tag for ConfigMap Reload | `string` | `"v0.2.2"` | no |
| configmap\_name | Name of the ConfigMap Reload container | `string` | `"configmap-reload"` | no |
| configmap\_pull\_policy | Image pull policy for ConfigMap reload | `string` | `"IfNotPresent"` | no |
| configmap\_resources | Resources for ConfigMap Reload pod | `map` | `{}` | no |
| enable\_network\_policy | Create a NetworkPolicy resource | `string` | `"false"` | no |
| extra\_scrape\_configs | YAML String for extra scrape configs | `string` | `""` | no |
| image\_pull\_secrets | Image pull secrets, if any | `map` | `{}` | no |
| kube\_state\_metrics\_affinity | Affinity for Kube State Metrics | `map` | `{}` | no |
| kube\_state\_metrics\_annotations | Annotations for Kube State Metrics pods | `map` | `{}` | no |
| kube\_state\_metrics\_autosharding | If set to true, this will deploy kube-state-metrics as a StatefulSet and the data<br>will be automatically sharded across <.Values.replicas> pods using the built-in<br>autodiscovery feature: https://github.com/kubernetes/kube-state-metrics#automated-sharding<br>This is an experimental feature and there are no stability guarantees. | `bool` | `false` | no |
| kube\_state\_metrics\_chart\_name | Helm chart name to provision | `string` | `"kube-state-metrics"` | no |
| kube\_state\_metrics\_chart\_namespace | Namespace to install the chart into | `string` | `"default"` | no |
| kube\_state\_metrics\_chart\_repository | Helm repository for the chart | `string` | `"stable"` | no |
| kube\_state\_metrics\_chart\_version | Version of Chart to install. Set to empty to install the latest version | `string` | `""` | no |
| kube\_state\_metrics\_collection\_namespace | Specific namespaces to collect metrics for | `string` | `""` | no |
| kube\_state\_metrics\_collectors | Collectors for Kube state metrics | `map` | <pre>{<br>  "certificatesigningrequests": true,<br>  "configmaps": true,<br>  "cronjobs": true,<br>  "daemonsets": true,<br>  "deployments": true,<br>  "endpoints": true,<br>  "horizontalpodautoscalers": true,<br>  "ingresses": true,<br>  "jobs": true,<br>  "limitranges": true,<br>  "mutatingwebhookconfigurations": true,<br>  "namespaces": true,<br>  "networkpolicies": true,<br>  "nodes": true,<br>  "persistentvolumeclaims": true,<br>  "persistentvolumes": true,<br>  "poddisruptionbudgets": true,<br>  "pods": true,<br>  "replicasets": true,<br>  "replicationcontrollers": true,<br>  "resourcequotas": true,<br>  "secrets": true,<br>  "services": true,<br>  "statefulsets": true,<br>  "storageclasses": true,<br>  "validatingwebhookconfigurations": true,<br>  "verticalpodautoscalers": true,<br>  "volumeattachments": true<br>}</pre> | no |
| kube\_state\_metrics\_enable | Enable Kube State Metrics | `string` | `"true"` | no |
| kube\_state\_metrics\_extra\_args | Extra arguments for Kube State Metrics container | `map` | `{}` | no |
| kube\_state\_metrics\_extra\_env | Extra environment variables for Kube State Metrics container | `map` | `{}` | no |
| kube\_state\_metrics\_host\_network | Use host network for KSM | `bool` | `false` | no |
| kube\_state\_metrics\_labels | Labels for Kube State Metrics | `map` | `{}` | no |
| kube\_state\_metrics\_node\_selector | Node selector for Kube State Metrics pods | `map` | `{}` | no |
| kube\_state\_metrics\_pdb | PDB for Kubestatemetrics | `map` | <pre>{<br>  "maxUnavailable": 1<br>}</pre> | no |
| kube\_state\_metrics\_pod\_security\_policy\_annotations | PodSecurityPolicy annotations for Kube State Metrics | `map` | <pre>{<br>  "apparmor.security.beta.kubernetes.io/allowedProfileNames": "runtime/default",<br>  "apparmor.security.beta.kubernetes.io/defaultProfileName": "runtime/default",<br>  "seccomp.security.alpha.kubernetes.io/allowedProfileNames": "docker/default,runtime/default",<br>  "seccomp.security.alpha.kubernetes.io/defaultProfileName": "runtime/default"<br>}</pre> | no |
| kube\_state\_metrics\_priority\_class\_name | Priority Class Name for Kube State Metrics pods | `string` | `""` | no |
| kube\_state\_metrics\_pull\_policy | Image pull policy for Kube State Metrics | `string` | `"IfNotPresent"` | no |
| kube\_state\_metrics\_release\_name | Helm release name for Kube State Metrics | `string` | `"kube-state-metrics"` | no |
| kube\_state\_metrics\_replica | Number of replicas for Kube State Metrics | `number` | `1` | no |
| kube\_state\_metrics\_repository | Docker repository for Kube State Metrics | `string` | `"quay.io/coreos/kube-state-metrics"` | no |
| kube\_state\_metrics\_resources | Resources for Kube State Metrics | `map` | `{}` | no |
| kube\_state\_metrics\_security\_context | Security context for kube\_state\_metrics pods defined as a map which will be serialized to JSON.<br>  Due to limitations with Terraform 0.11 and below, integers are serialized as strings in JSON and<br>  this will not work for fields like `runAsUser`. Specify a JSON string with<br>  `kube_state_metrics_security_context_json` instead | `map` | `{}` | no |
| kube\_state\_metrics\_security\_context\_json | JSON string for security context for kube\_state\_metrics pods | `string` | `""` | no |
| kube\_state\_metrics\_service\_account | Name of the service account for kubeStateMetrics. Defaults to component's fully qualified name. | `string` | `""` | no |
| kube\_state\_metrics\_service\_account\_annotations | Annotations for the service account | `map` | `{}` | no |
| kube\_state\_metrics\_service\_annotations | Annotations for Kube State Metrics service | `map` | <pre>{<br>  "prometheus.io/scrape": "true"<br>}</pre> | no |
| kube\_state\_metrics\_service\_cluster\_ip | Cluster IP for Kube State Metrics Service | `string` | `"None"` | no |
| kube\_state\_metrics\_service\_lb\_ip | Load Balancer IP for Kube State Metrics service | `string` | `""` | no |
| kube\_state\_metrics\_service\_port | Service port for Kube State Metrics | `number` | `80` | no |
| kube\_state\_metrics\_service\_type | Type of service for Kube State Metrics | `string` | `"ClusterIP"` | no |
| kube\_state\_metrics\_tag | Tag for Kube State Metrics Docker Image | `string` | `"v1.5.0"` | no |
| kube\_state\_metrics\_tolerations | Tolerations for Kube State Metrics | `list` | `[]` | no |
| max\_history | Max History for Helm | `number` | `20` | no |
| node\_exporter\_annotations | Annotations for Node Exporter pods | `map` | `{}` | no |
| node\_exporter\_config\_map\_mounts | ConfigMap Mounts for Node Exporter | `list` | `[]` | no |
| node\_exporter\_enable | Enable Node Exporter | `string` | `"true"` | no |
| node\_exporter\_enable\_pod\_security\_policy | Create PodSecurityPolicy for Node Exporter | `string` | `"false"` | no |
| node\_exporter\_extra\_args | Extra arguments for Node Exporter container | `map` | `{}` | no |
| node\_exporter\_host\_network | Use the Host network namespace for Node Exporter | `string` | `"true"` | no |
| node\_exporter\_host\_path\_mounts | Host Path Mounts for Node Exporter | `list` | `[]` | no |
| node\_exporter\_host\_pid | Use the Network PID namespace for Node Exporter | `string` | `"true"` | no |
| node\_exporter\_labels | Labels for Node Exporter | `map` | `{}` | no |
| node\_exporter\_node\_selector | Node selector for node\_exporter pods | `map` | `{}` | no |
| node\_exporter\_pdb\_enable | Enable PDB | `bool` | `true` | no |
| node\_exporter\_pdb\_max\_unavailable | Max unavailable pods | `number` | `1` | no |
| node\_exporter\_pod\_security\_policy\_annotations | PodSecurityPolicy annotations for Node exporter | `map` | <pre>{<br>  "apparmor.security.beta.kubernetes.io/allowedProfileNames": "runtime/default",<br>  "apparmor.security.beta.kubernetes.io/defaultProfileName": "runtime/default",<br>  "seccomp.security.alpha.kubernetes.io/allowedProfileNames": "docker/default,runtime/default",<br>  "seccomp.security.alpha.kubernetes.io/defaultProfileName": "runtime/default"<br>}</pre> | no |
| node\_exporter\_priority\_class\_name | Priority Class Name for Node Exporter pods | `string` | `""` | no |
| node\_exporter\_pull\_policy | Image pull policy for Node Exporter | `string` | `"IfNotPresent"` | no |
| node\_exporter\_replica | Number of replicas for Node Exporter | `number` | `1` | no |
| node\_exporter\_repository | Docker repository for Node Exporter | `string` | `"prom/node-exporter"` | no |
| node\_exporter\_resources | Resources for node\_exporter | `map` | `{}` | no |
| node\_exporter\_security\_context | Security context for node\_exporter pods defined as a map which will be serialized to JSON.<br>  Due to limitations with Terraform 0.11 and below, integers are serialized as strings in JSON and<br>  this will not work for fields like `runAsUser`. Specify a JSON string with<br>  `node_exporter_security_context_json` instead | `map` | `{}` | no |
| node\_exporter\_security\_context\_json | JSON string for security context for node\_exporter pods | `string` | `""` | no |
| node\_exporter\_service\_account | Name of the service account for nodeExporter. Defaults to component's fully qualified name. | `string` | `""` | no |
| node\_exporter\_service\_account\_annotations | Annotations for the service account | `map` | `{}` | no |
| node\_exporter\_service\_annotations | Annotations for Node Exporter service | `map` | <pre>{<br>  "prometheus.io/scrape": "true"<br>}</pre> | no |
| node\_exporter\_service\_cluster\_ip | Cluster IP for Node Exporter Service | `string` | `"None"` | no |
| node\_exporter\_service\_external\_ips | External IPs for Node Exporter service | `list` | `[]` | no |
| node\_exporter\_service\_labels | Labels for Node Exporter service | `map` | `{}` | no |
| node\_exporter\_service\_lb\_ip | Load Balancer IP for Node Exporter service | `string` | `""` | no |
| node\_exporter\_service\_lb\_source\_ranges | List of source CIDRs allowed to access the Node Exporter LB | `list` | `[]` | no |
| node\_exporter\_service\_port | Service port for Node Exporter | `number` | `9100` | no |
| node\_exporter\_service\_type | Type of service for Node Exporter | `string` | `"ClusterIP"` | no |
| node\_exporter\_tag | Tag for Node Exporter Docker Image | `string` | `"v0.17.0"` | no |
| node\_exporter\_tolerations | Tolerations for Node Exporter | `list` | `[]` | no |
| pod\_security\_policy\_enable | Create PodSecurityPolicy Resources | `bool` | `true` | no |
| pushgateway\_annotations | Annotations for Pushgateway pods | `map` | `{}` | no |
| pushgateway\_enable | Enable Pushgateway | `string` | `"true"` | no |
| pushgateway\_extra\_args | Extra arguments for Pushgateway container | `map` | `{}` | no |
| pushgateway\_extra\_env | Extra environment variables for Pushgateway container | `map` | `{}` | no |
| pushgateway\_ingress\_annotations | Annotations for Pushgateway ingress | `map` | `{}` | no |
| pushgateway\_ingress\_enabled | Enable ingress for Pushgateway | `string` | `"false"` | no |
| pushgateway\_ingress\_extra\_labels | Additional labels for Pushgateway ingress | `map` | `{}` | no |
| pushgateway\_ingress\_hosts | List of Hosts for Pushgateway ingress | `list` | `[]` | no |
| pushgateway\_ingress\_tls | TLS configurationf or Pushgateway ingress | `list` | `[]` | no |
| pushgateway\_node\_selector | Node selector for pushgateway pods | `map` | `{}` | no |
| pushgateway\_pdb\_enable | Enable PDB | `bool` | `true` | no |
| pushgateway\_pdb\_max\_unavailable | Max unavailable pods | `number` | `1` | no |
| pushgateway\_pod\_security\_policy\_annotations | PodSecurityPolicy annotations for Pushgateway | `map` | <pre>{<br>  "apparmor.security.beta.kubernetes.io/allowedProfileNames": "runtime/default",<br>  "apparmor.security.beta.kubernetes.io/defaultProfileName": "runtime/default",<br>  "seccomp.security.alpha.kubernetes.io/allowedProfileNames": "docker/default,runtime/default",<br>  "seccomp.security.alpha.kubernetes.io/defaultProfileName": "runtime/default"<br>}</pre> | no |
| pushgateway\_priority\_class\_name | Priority Class Name for Pushgateway pods | `string` | `""` | no |
| pushgateway\_pull\_policy | Image pull policy for Pushgateway | `string` | `"IfNotPresent"` | no |
| pushgateway\_pv\_access\_modes | pushgateway data Persistent Volume access modes | `list` | <pre>[<br>  "ReadWriteOnce"<br>]</pre> | no |
| pushgateway\_pv\_annotations | Annotations for Pushgateway PV | `map` | `{}` | no |
| pushgateway\_pv\_enabled | Enable persistent volume on Pushgateway | `string` | `"true"` | no |
| pushgateway\_pv\_existing\_claim | Use an existing PV claim for pushgateway | `string` | `""` | no |
| pushgateway\_pv\_size | pushgateway data Persistent Volume size | `string` | `"2Gi"` | no |
| pushgateway\_replica | Number of replicas for pushgateway | `number` | `1` | no |
| pushgateway\_repository | Docker repository for Pushgateway | `string` | `"prom/pushgateway"` | no |
| pushgateway\_resources | Resources for pushgateway | `map` | `{}` | no |
| pushgateway\_security\_context | Security context for pushgateway pods defined as a map which will be serialized to JSON.<br>  Due to limitations with Terraform 0.11 and below, integers are serialized as strings in JSON and<br>  this will not work for fields like `runAsUser`. Specify a JSON string with<br>  `pushgateway_security_context_json` instead | `map` | `{}` | no |
| pushgateway\_security\_context\_json | JSON string for security context for pushgateway pods | `string` | `""` | no |
| pushgateway\_service\_account | Name of the service account for pushgateway. Defaults to component's fully qualified name. | `string` | `""` | no |
| pushgateway\_service\_account\_annotations | Annotations for the service account | `map` | `{}` | no |
| pushgateway\_service\_annotations | Annotations for Pushgateway service | `map` | <pre>{<br>  "prometheus.io/probe": "pushgateway"<br>}</pre> | no |
| pushgateway\_service\_cluster\_ip | Cluster IP for Pushgateway Service | `string` | `""` | no |
| pushgateway\_service\_external\_ips | External IPs for Pushgateway service | `list` | `[]` | no |
| pushgateway\_service\_labels | Labels for Pushgateway service | `map` | `{}` | no |
| pushgateway\_service\_lb\_ip | Load Balancer IP for Pushgateway service | `string` | `""` | no |
| pushgateway\_service\_lb\_source\_ranges | List of source CIDRs allowed to access the Pushgateway LB | `list` | `[]` | no |
| pushgateway\_service\_port | Service port for Pushgateway | `number` | `9091` | no |
| pushgateway\_service\_type | Type of service for Pushgateway | `string` | `"ClusterIP"` | no |
| pushgateway\_tag | Tag for Pushgateway Docker Image | `string` | `"v0.6.0"` | no |
| pushgateway\_tolerations | Tolerations for Pushgateway | `list` | `[]` | no |
| release\_name | Helm release name for Prometheus | `string` | `"prometheus"` | no |
| scrape\_skip\_apiserver\_tls\_verify | Skip verifying TLS Certificate for Kubernetes Master Server Scrape target. Warning: This is insecure | `bool` | `false` | no |
| scrape\_skip\_nodes\_tls\_verify | Skip verifying TLS Certificate for Kubernetes Nodes Scrape target. Warning: This is insecure | `bool` | `false` | no |
| server\_additional\_global | YAML string for additional global configuration for Prometheus Server | `string` | `""` | no |
| server\_affinity | Affinity for server pods | `map` | `{}` | no |
| server\_alerts | Prometheus server alerts entries in YAML. Ref: https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/ | `string` | `"[]\n# - name: Instances\n#   rules:\n#     - alert: InstanceDown\n#       expr: up == 0\n#       for: 5m\n#       labels:\n#         severity: page\n#       annotations:\n#         description: '{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 5 minutes.'\n#         summary: 'Instance {{ $labels.instance }} down'\n"` | no |
| server\_annotations | Annotations for server pods | `map` | `{}` | no |
| server\_base\_url | External URL which can access alertmanager | `string` | `""` | no |
| server\_config\_override | Overriding the Prometheus server config file in YAML | `string` | `""` | no |
| server\_data\_retention | Prometheus data retention period (i.e 360h) | `string` | `""` | no |
| server\_enable | Deploy Prometheus Server | `string` | `"true"` | no |
| server\_enable\_admin\_api | Enable Admin API for server | `string` | `"false"` | no |
| server\_enable\_service\_links | EnableServiceLinks indicates whether information about services should be injected into pod's environment variables, matching the syntax of Docker links. | `bool` | `true` | no |
| server\_evaluation\_interval | How frequently to evaluate rules | `string` | `"1m"` | no |
| server\_extra\_args | Extra arguments for server container | `map` | `{}` | no |
| server\_extra\_configmap\_mounts | Additional Prometheus server ConfigMap mounts | `list` | `[]` | no |
| server\_extra\_env | Extra environment variables for server container | `map` | `{}` | no |
| server\_extra\_host\_path\_mounts | Additional Prometheus server hostPath mounts | `list` | `[]` | no |
| server\_extra\_secret\_mounts | Extra secret mounts for server | `list` | `[]` | no |
| server\_extra\_volume\_mounts | Additional Prometheus server Volume mounts | `list` | `[]` | no |
| server\_extra\_volumes | Additional Prometheus server Volumes | `list` | `[]` | no |
| server\_headless\_annotations | Annotations for server StatefulSet headless service | `map` | `{}` | no |
| server\_headless\_labels | Labels for server StatefulSet headless service | `map` | `{}` | no |
| server\_ingress\_annotations | Annotations for server ingress | `map` | `{}` | no |
| server\_ingress\_enabled | Enable ingress for server | `string` | `"false"` | no |
| server\_ingress\_extra\_labels | Additional labels for server ingress | `map` | `{}` | no |
| server\_ingress\_hosts | List of Hosts for server ingress | `list` | `[]` | no |
| server\_ingress\_tls | TLS configurationf or server ingress | `list` | `[]` | no |
| server\_liveness\_probe\_initial\_delay | Initial delay before the probe starts checking. You might need to increase this for Prometheus to repair the TSDB servers if your pods keeps getting killed by probes during startup. | `number` | `30` | no |
| server\_liveness\_probe\_timeout | Number of seconds before a probe fails due to timeout | `number` | `10` | no |
| server\_node\_selector | Node selector for server pods | `map` | `{}` | no |
| server\_pdb\_enable | Enable PDB | `bool` | `true` | no |
| server\_pdb\_max\_unavailable | Max unavailable pods | `number` | `1` | no |
| server\_pod\_security\_policy\_annotations | PodSecurityPolicy annotations for server | `map` | <pre>{<br>  "apparmor.security.beta.kubernetes.io/allowedProfileNames": "runtime/default",<br>  "apparmor.security.beta.kubernetes.io/defaultProfileName": "runtime/default",<br>  "seccomp.security.alpha.kubernetes.io/allowedProfileNames": "docker/default,runtime/default",<br>  "seccomp.security.alpha.kubernetes.io/defaultProfileName": "runtime/default"<br>}</pre> | no |
| server\_prefix\_url | The URL prefix at which the container can be accessed. Useful in the case the '-web.external-url' includes a slug so that the various internal URLs are still able to access as they are in the default case. | `string` | `""` | no |
| server\_priority\_class\_name | Priority Class Name for server pods | `string` | `""` | no |
| server\_pull\_policy | Image pull policy for server | `string` | `"IfNotPresent"` | no |
| server\_pv\_access\_modes | server data Persistent Volume access modes | `list` | <pre>[<br>  "ReadWriteOnce"<br>]</pre> | no |
| server\_pv\_annotations | Annotations for server PV | `map` | `{}` | no |
| server\_pv\_enabled | Enable persistent volume on server | `string` | `"true"` | no |
| server\_pv\_existing\_claim | Use an existing PV claim for server | `string` | `""` | no |
| server\_pv\_size | server data Persistent Volume size | `string` | `"8Gi"` | no |
| server\_readiness\_probe\_initial\_delay | Initial delay before the probe starts checking. You might need to increase this for Prometheus to repair the TSDB servers if your pods keeps getting killed by probes during startup. | `number` | `30` | no |
| server\_readiness\_probe\_timeout | Number of seconds before a probe fails due to timeout | `number` | `10` | no |
| server\_replica | Number of replicas for server | `number` | `1` | no |
| server\_repository | Docker repository for server | `string` | `"prom/prometheus"` | no |
| server\_resources | Resources for server | `map` | `{}` | no |
| server\_rules | Prometheus server rules entries in YAML | `string` | `"[]\n# - name: k8s_health\n#   rules:\n#     - record: k8s_container_oom\n#       expr: increase(kube_pod_container_status_last_terminated_reason{reason=\"OOMKilled\"}[2m]) and on(pod) increase(kube_pod_container_status_restarts_total[2m])\n"` | no |
| server\_scrape\_interval | How frequently to scrape targets by default | `string` | `"1m"` | no |
| server\_scrape\_timeout | How long until a scrape request times out | `string` | `"10s"` | no |
| server\_security\_context | Security context for server pods defined as a map which will be serialized to JSON.<br>  Due to limitations with Terraform 0.11 and below, integers are serialized as strings in JSON and<br>  this will not work for fields like `runAsUser`. Specify a JSON string with<br>  `server_security_context_json` instead | `map` | `{}` | no |
| server\_security\_context\_json | JSON string for security context for server pods | `string` | `""` | no |
| server\_service\_account | Name of the service account for server. Defaults to component's fully qualified name. | `string` | `""` | no |
| server\_service\_account\_annotations | Annotations for the service account | `map` | `{}` | no |
| server\_service\_annotations | Annotations for server service | `map` | <pre>{<br>  "prometheus.io/probe": "server"<br>}</pre> | no |
| server\_service\_cluster\_ip | Cluster IP for server Service | `string` | `""` | no |
| server\_service\_external\_ips | External IPs for server service | `list` | `[]` | no |
| server\_service\_labels | Labels for server service | `map` | `{}` | no |
| server\_service\_lb\_ip | Load Balancer IP for server service | `string` | `""` | no |
| server\_service\_lb\_source\_ranges | List of source CIDRs allowed to access the server LB | `list` | `[]` | no |
| server\_service\_port | Service port for server | `number` | `9091` | no |
| server\_service\_type | Type of service for server | `string` | `"ClusterIP"` | no |
| server\_sidecar\_containers | Sidecar containers for server | `list` | `[]` | no |
| server\_skip\_tsdb\_lock | Disable TSDB locking for the server | `string` | `"false"` | no |
| server\_statefulset\_annotations | Annotations for server StatefulSet | `map` | `{}` | no |
| server\_tag | Tag for server Docker Image | `string` | `"v2.8.1"` | no |
| server\_termination\_grace\_seconds | Prometheus server pod termination grace period | `string` | `"300"` | no |
| server\_tolerations | Tolerations for server | `list` | `[]` | no |
| vm\_agent\_affinity | Affinity for VictoriaMetrics Agent server pods | `map` | `{}` | no |
| vm\_agent\_chart | Chart for VictoriaMetrics Agent | `string` | `"victoria-metrics-agent"` | no |
| vm\_agent\_chart\_repository\_url | Chart Repository URL for VictoriaMetrics Agent | `string` | `"https://victoriametrics.github.io/helm-charts/"` | no |
| vm\_agent\_chart\_version | Chart version for VictoriaMetrics Agent | `string` | `"0.4.7"` | no |
| vm\_agent\_enabled | Deploy VictoriaMetrics Agent | `bool` | `false` | no |
| vm\_agent\_extra\_args | Additional VictoriaMetrics Agent container arguments | `map` | `{}` | no |
| vm\_agent\_extra\_volume\_mounts | Extra volume mounts for VictoriaMetrics Agent | `list` | `[]` | no |
| vm\_agent\_extra\_volumes | Extra volumes for VictoriaMetrics Agent | `list` | `[]` | no |
| vm\_agent\_helm\_release\_max\_history | The maximum number of history releases to keep track for the VM helm release | `number` | `20` | no |
| vm\_agent\_image\_repository | Image repository for VictoriaMetrics Agent server | `string` | `"victoriametrics/vmagent"` | no |
| vm\_agent\_image\_tag | Image tag for VictoriaMetrics Agent server | `string` | `"v1.37.4"` | no |
| vm\_agent\_namespace | Namespace for VictoriaMetrics Agent | `string` | `"core"` | no |
| vm\_agent\_node\_selector | Node selector for VictoriaMetrics Agent server pods | `map` | `{}` | no |
| vm\_agent\_pod\_annotations | Annotations for VictoriaMetrics Agent server pods | `map` | `{}` | no |
| vm\_agent\_release\_name | Helm release name for VictoriaMetrics Agent | `string` | `"victoria-metrics-agent"` | no |
| vm\_agent\_replica\_count | Number of replicas for VictoriaMetrics Agent server | `number` | `1` | no |
| vm\_agent\_resources | Resources for VictoriaMetrics Agent server | `map` | `{}` | no |
| vm\_agent\_security\_context | Security context for VictoriaMetrics Agent server pods defined as a map which will be serialized to JSON. | `map` | `{}` | no |
| vm\_agent\_tolerations | Tolerations for VictoriaMetrics Agent server | `list` | `[]` | no |
| vm\_alert\_affinity | Affinity for VictoriaMetrics Alert server pods | `map` | `{}` | no |
| vm\_alert\_chart | Chart for VictoriaMetrics Alert | `string` | `"victoria-metrics-alert"` | no |
| vm\_alert\_chart\_repository\_url | Chart Repository URL for VictoriaMetrics Alert | `string` | `"https://victoriametrics.github.io/helm-charts/"` | no |
| vm\_alert\_chart\_version | Chart version for VictoriaMetrics Alert | `string` | `"0.0.16"` | no |
| vm\_alert\_enabled | Deploy VictoriaMetrics Alert | `bool` | `false` | no |
| vm\_alert\_extra\_args | Additional VictoriaMetrics Alert container arguments | `map` | `{}` | no |
| vm\_alert\_helm\_release\_max\_history | The maximum number of history releases to keep track for the VM helm release | `number` | `20` | no |
| vm\_alert\_image\_repository | Image repository for VictoriaMetrics Alert server | `string` | `"victoriametrics/vmalert"` | no |
| vm\_alert\_image\_tag | Image tag for VictoriaMetrics Alert server | `string` | `"v1.37.4"` | no |
| vm\_alert\_namespace | Namespace for VictoriaMetrics Alert | `string` | `"core"` | no |
| vm\_alert\_node\_selector | Node selector for VictoriaMetrics Alert server pods | `map` | `{}` | no |
| vm\_alert\_pod\_annotations | Annotations for VictoriaMetrics Alert server pods | `map` | `{}` | no |
| vm\_alert\_release\_name | Helm release name for VictoriaMetrics Alert | `string` | `"victoria-metrics-alert"` | no |
| vm\_alert\_replica\_count | Number of replicas for VictoriaMetrics Alert server | `number` | `1` | no |
| vm\_alert\_resources | Resources for VictoriaMetrics Alert server | `map` | `{}` | no |
| vm\_alert\_security\_context | Security context for VictoriaMetrics Alert server pods defined as a map which will be serialized to JSON. | `map` | `{}` | no |
| vm\_alert\_service\_annotations | Annotations for VictoriaMetrics Alert server service | `map` | `{}` | no |
| vm\_alert\_service\_labels | Labels for VictoriaMetrics Alert server service | `map` | `{}` | no |
| vm\_alert\_service\_port | Service port for VictoriaMetrics Alert server | `number` | `8880` | no |
| vm\_alert\_service\_type | Type of service for VictoriaMetrics Alert server | `string` | `"ClusterIP"` | no |
| vm\_alert\_tolerations | Tolerations for VictoriaMetrics Alert server | `list` | `[]` | no |
| vm\_chart | Chart for VictoriaMetrics | `string` | `"victoria-metrics-cluster"` | no |
| vm\_chart\_repository\_url | Chart Repository URL for VictoriaMetrics | `string` | `"https://victoriametrics.github.io/helm-charts/"` | no |
| vm\_chart\_version | Chart version for VictoriaMetrics | `string` | `"0.5.15"` | no |
| vm\_enabled | Deploy VictoriaMetrics cluster | `bool` | `false` | no |
| vm\_helm\_release\_max\_history | The maximum number of history releases to keep track for the VM helm release | `number` | `20` | no |
| vm\_insert\_affinity | Affinity for VictoriaMetrics Insert server pods | `map` | `{}` | no |
| vm\_insert\_enabled | Deploy VictoriaMetrics Insert | `bool` | `true` | no |
| vm\_insert\_extra\_args | Additional VictoriaMetrics Insert container arguments | `map` | `{}` | no |
| vm\_insert\_image\_repository | Image repository for VictoriaMetrics Insert server | `string` | `"victoriametrics/vminsert"` | no |
| vm\_insert\_image\_tag | Image tag for VictoriaMetrics Insert server | `string` | `"v1.37.4-cluster"` | no |
| vm\_insert\_node\_selector | Node selector for VictoriaMetrics Insert server pods | `map` | `{}` | no |
| vm\_insert\_pod\_annotations | Annotations for VictoriaMetrics Insert server pods | `map` | `{}` | no |
| vm\_insert\_priority\_class\_name | Priority Class Name for VictoriaMetrics Insert server | `string` | `""` | no |
| vm\_insert\_replica\_count | Number of replicas for VictoriaMetrics Insert server | `number` | `2` | no |
| vm\_insert\_resources | Resources for VictoriaMetrics Insert server | `map` | `{}` | no |
| vm\_insert\_security\_context | Security context for VictoriaMetrics Insert server pods defined as a map which will be serialized to JSON. | `map` | `{}` | no |
| vm\_insert\_service\_annotations | Annotations for VictoriaMetrics Insert server service | `map` | `{}` | no |
| vm\_insert\_service\_labels | Labels for VictoriaMetrics Insert server service | `map` | `{}` | no |
| vm\_insert\_service\_port | Service port for VictoriaMetrics Insert server | `number` | `8480` | no |
| vm\_insert\_service\_type | Type of service for VictoriaMetrics Insert server | `string` | `"ClusterIP"` | no |
| vm\_insert\_tolerations | Tolerations for VictoriaMetrics Insert server | `list` | `[]` | no |
| vm\_namespace | Namespace for VictoriaMetrics | `string` | `"core"` | no |
| vm\_psp\_enabled | Enable PodSecurityPolicy in VictoriaMetrics | `bool` | `true` | no |
| vm\_release\_name | Helm release name for VictoriaMetrics | `string` | `"victoria-metrics-cluster"` | no |
| vm\_select\_affinity | Affinity for VictoriaMetrics Select server pods | `map` | `{}` | no |
| vm\_select\_enabled | Deploy VictoriaMetrics Select | `bool` | `true` | no |
| vm\_select\_extra\_args | Additional VictoriaMetrics Select container arguments | `map` | `{}` | no |
| vm\_select\_image\_repository | Image repository for VictoriaMetrics Select server | `string` | `"victoriametrics/vmselect"` | no |
| vm\_select\_image\_tag | Image tag for VictoriaMetrics Select server | `string` | `"v1.37.4-cluster"` | no |
| vm\_select\_ingress\_annotations | Annotations for VictoriaMetrics Select server ingress | `map` | `{}` | no |
| vm\_select\_ingress\_enabled | Enable ingress for VictoriaMetrics Select server | `bool` | `false` | no |
| vm\_select\_ingress\_hosts | Ingress hosts for VictoriaMetrics Select server | `list` | `[]` | no |
| vm\_select\_node\_selector | Node selector for VictoriaMetrics Select server pods | `map` | `{}` | no |
| vm\_select\_pod\_annotations | Annotations for VictoriaMetrics Select server pods | `map` | `{}` | no |
| vm\_select\_priority\_class\_name | Priority Class Name for VictoriaMetrics Select server | `string` | `""` | no |
| vm\_select\_pv\_access\_modes | VictoriaMetrics Select server data Persistent Volume access modes | `list` | <pre>[<br>  "ReadWriteOnce"<br>]</pre> | no |
| vm\_select\_pv\_annotations | Annotations for VictoriaMetrics Select server PV | `map` | `{}` | no |
| vm\_select\_pv\_enabled | Enable persistent volume on VictoriaMetrics Select server | `bool` | `true` | no |
| vm\_select\_pv\_size | VictoriaMetrics Select server data Persistent Volume size | `string` | `"8Gi"` | no |
| vm\_select\_replica\_count | Number of replicas for VictoriaMetrics Select server | `number` | `2` | no |
| vm\_select\_resources | Resources for VictoriaMetrics Select server | `map` | `{}` | no |
| vm\_select\_security\_context | Security context for VictoriaMetrics Select server pods defined as a map which will be serialized to JSON | `map` | `{}` | no |
| vm\_select\_service\_annotations | Annotations for VictoriaMetrics Select server service | `map` | `{}` | no |
| vm\_select\_service\_labels | Labels for VictoriaMetrics Select server service | `map` | `{}` | no |
| vm\_select\_service\_port | Service port for VictoriaMetrics Select server | `number` | `8481` | no |
| vm\_select\_service\_type | Type of service for VictoriaMetrics Select server | `string` | `"ClusterIP"` | no |
| vm\_select\_tolerations | Tolerations for VictoriaMetrics Select server | `list` | `[]` | no |
| vm\_service\_account\_annotations | Service Account Annotations for VictoriaMetrics | `map` | `{}` | no |
| vm\_storage\_affinity | Affinity for VictoriaMetrics Storage server pods | `map` | `{}` | no |
| vm\_storage\_enabled | Deploy VictoriaMetrics Storage | `bool` | `true` | no |
| vm\_storage\_extra\_args | Additional VictoriaMetrics Storage container arguments | `map` | `{}` | no |
| vm\_storage\_image\_repository | Image repository for VictoriaMetrics Storage server | `string` | `"victoriametrics/vmstorage"` | no |
| vm\_storage\_image\_tag | Image tag for VictoriaMetrics Storage server | `string` | `"v1.37.4-cluster"` | no |
| vm\_storage\_node\_selector | Node selector for VictoriaMetrics Storage server pods | `map` | `{}` | no |
| vm\_storage\_pod\_annotations | Annotations for VictoriaMetrics Storage server pods | `map` | `{}` | no |
| vm\_storage\_priority\_class\_name | Priority Class Name for VictoriaMetrics Storage server | `string` | `""` | no |
| vm\_storage\_pv\_access\_modes | VictoriaMetrics Storage server data Persistent Volume access modes | `list` | <pre>[<br>  "ReadWriteOnce"<br>]</pre> | no |
| vm\_storage\_pv\_annotations | Annotations for VictoriaMetrics Storage server PV | `map` | `{}` | no |
| vm\_storage\_pv\_enabled | Enable persistent volume on VictoriaMetrics Storage server | `bool` | `true` | no |
| vm\_storage\_pv\_size | VictoriaMetrics Storage server data Persistent Volume size | `string` | `"8Gi"` | no |
| vm\_storage\_replica\_count | Number of replicas for VictoriaMetrics Storage server | `number` | `2` | no |
| vm\_storage\_resources | Resources for VictoriaMetrics Storage server | `map` | `{}` | no |
| vm\_storage\_retention\_period | VictoriaMetrics Storage data retention period in months | `number` | `1` | no |
| vm\_storage\_security\_context | Security context for VictoriaMetrics Storage server pods defined as a map which will be serialized to JSON | `map` | `{}` | no |
| vm\_storage\_service\_annotations | Annotations for VictoriaMetrics Storage server service | `map` | `{}` | no |
| vm\_storage\_service\_labels | Labels for VictoriaMetrics Storage server service | `map` | `{}` | no |
| vm\_storage\_service\_port | Service port for VictoriaMetrics Storage server | `number` | `8482` | no |
| vm\_storage\_termination\_grace\_period\_seconds | VictoriaMetrics Select server pods' termination grace period in seconds | `number` | `60` | no |
| vm\_storage\_tolerations | Tolerations for VictoriaMetrics Storage server | `list` | `[]` | no |
| vm\_storage\_vm\_insert\_port | Service port for for accepting connections from vminsert | `number` | `8400` | no |
| vm\_storage\_vm\_select\_port | Service port for for accepting connections from vmselect | `number` | `8401` | no |

## Outputs

| Name | Description |
|------|-------------|
| prometheus\_alerts\_api\_url | Prometheus query API URL: https://prometheus.io/docs/prometheus/latest/querying/api/#expression-queries |
| prometheus\_query\_api\_url | Prometheus query API URL: https://prometheus.io/docs/prometheus/latest/querying/api/#expression-queries |
| prometheus\_remote\_read\_api\_url | Prometheus Remote Read API URL: https://prometheus.io/docs/prometheus/latest/storage/#remote-storage-integrations |
| prometheus\_remote\_write\_api\_url | Prometheus Remote Write API URL: https://prometheus.io/docs/prometheus/latest/storage/#remote-storage-integrations |
