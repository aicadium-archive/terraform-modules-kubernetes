# Docker Registry

This module provisions [Docker Registry](https://docs.docker.com/registry/) with the
[Stable chart](https://github.com/helm/charts/tree/master/stable/docker-registry).

## Providers

| Name | Version |
|------|---------|
| helm | >= 1.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| azure\_secrets | Secrets for Azure storage | `map` | `{}` | no |
| chart\_name | Name of the Chart | `string` | `"stable/docker-registry"` | no |
| chart\_repository | Chart repository | `string` | `""` | no |
| chart\_version | Chart version | `string` | `""` | no |
| configuration | Configuration for Registry | `map` | <pre>{<br>  "health": {<br>    "storagedriver": {<br>      "enabled": true,<br>      "interval": "10s",<br>      "threshold": 3<br>    }<br>  },<br>  "http": {<br>    "addr": ":5000",<br>    "headers": {<br>      "X-Content-Type-Options": [<br>        "nosniff"<br>      ]<br>    }<br>  },<br>  "log": {<br>    "fields": {<br>      "service": "registry"<br>    }<br>  },<br>  "storage": {<br>    "cache": {<br>      "blobdescriptor": "inmemory"<br>    }<br>  },<br>  "version": "0.1"<br>}</pre> | no |
| enabled | Enable Docker Registry | `bool` | `true` | no |
| fs\_group | Filesystem group ID | `number` | `1000` | no |
| image | Docker image for registry | `string` | `"registry"` | no |
| image\_pull\_policy | Image pull policy | `string` | `"IfNotPresent"` | no |
| image\_tag | Docker Image tag for registry | `string` | `"2.7"` | no |
| ingress\_annotations | Annotations for ingress | `map` | `{}` | no |
| ingress\_enabled | Enable ingress | `bool` | `false` | no |
| ingress\_hosts | List of hosts for ingress | `list` | `[]` | no |
| ingress\_labels | Labels for ingress | `map` | `{}` | no |
| ingress\_path | Path for ingress | `string` | `"/"` | no |
| ingress\_tls | TLS configuration for ingress | `map` | `{}` | no |
| max\_history | Max History for Helm | `number` | `20` | no |
| namespace | Namespace to deploy resources to | `string` | `"default"` | no |
| node\_selector | Node selector for pods | `map` | `{}` | no |
| pod\_annotations | Annotations for pods | `map` | `{}` | no |
| pod\_disruption\_budget | Pod disruption budget | `map` | <pre>{<br>  "minAvailable": 1<br>}</pre> | no |
| pod\_labels | Labels for Pods | `map` | `{}` | no |
| priority\_class\_name | Priority Class name for pods | `string` | `""` | no |
| pv\_access\_mode | Persistent Volume access mode | `string` | `"ReadWriteOnce"` | no |
| pv\_enabled | Enable Persistent Volume | `bool` | `false` | no |
| pv\_size | Persistent Volume Size | `string` | `"10Gi"` | no |
| pv\_storage\_class | PV Storage class | `string` | `"-"` | no |
| release\_name | Helm Release name | `string` | `"docker-registry"` | no |
| replica | Number of replica | `number` | `2` | no |
| resources | Resources for Pods | `map` | `{}` | no |
| run\_as\_user | Run container as UID | `number` | `1000` | no |
| s3 | Parameters for S3 storage | `map` | `{}` | no |
| s3\_secrets | Secrets for S3 storage | `map` | `{}` | no |
| security\_context\_enabled | Enable security context | `bool` | `true` | no |
| service\_annotations | Service Annotations | `map` | `{}` | no |
| service\_name | Name of Service | `string` | `"docker-registry"` | no |
| service\_type | Type of service | `string` | `"ClusterIP"` | no |
| storage | Type of storage | `string` | `"filesystem"` | no |
| swift | Parameters for Swift storage | `map` | `{}` | no |
| swift\_secrets | Secrets for Swift storage | `map` | `{}` | no |
| tolerations | Pod tolerations | `list` | `[]` | no |
| update\_strategy | Update strategy for deployment | `map` | `{}` | no |

## Outputs

No output.

