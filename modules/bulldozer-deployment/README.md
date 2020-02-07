# Bulldozer

## Providers

| Name | Version |
|------|---------|
| helm | >= 1.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| bulldozer\_chart\_name | Name of the chart to use | `string` | `"bulldozer-bot"` | no |
| bulldozer\_chart\_repository | Repository holding the chart | `string` | `"amoy"` | no |
| bulldozer\_chart\_version | Version of the chart | `string` | `"0.1.12"` | no |
| bulldozer\_github\_integration\_id | Github app id for Bulldozer app | `any` | n/a | yes |
| bulldozer\_github\_private\_key\_pem | Github private key for Bulldozer app | `any` | n/a | yes |
| bulldozer\_github\_webhook\_secret | Github webhook secret for Bulldozer app | `any` | n/a | yes |
| bulldozer\_image\_name | Image name for the bot image | `string` | `"palantirtechnologies/bulldozer"` | no |
| bulldozer\_image\_tag | Image tag for the bot image | `string` | `"1.7.0"` | no |
| bulldozer\_ingress\_annotations | Annotation for ingress object | `map` | `{}` | no |
| bulldozer\_ingress\_enabled | Whether ingress is enabled | `bool` | `false` | no |
| bulldozer\_ingress\_host | Ingress host name | `any` | n/a | yes |
| bulldozer\_release\_name | Release name | `string` | `"bulldozer"` | no |
| bulldozer\_service\_annotations | Annotation for service object | `map` | `{}` | no |
| fullname\_override | Fullname for Bulldozer deployment | `any` | n/a | yes |
| max\_history | Max History for Helm | `number` | `20` | no |
| name\_override | Name for Bulldozer deployment | `any` | n/a | yes |
| replicas | Replica count for the bot | `number` | `1` | no |

## Outputs

No output.
