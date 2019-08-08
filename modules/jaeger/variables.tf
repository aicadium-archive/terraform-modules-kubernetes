variable "jaeger_enabled" {
  description = "Enable/disable Jaeger"
  default     = false
}

variable "jaeger_release_name" {
  description = "Helm release name for Jaeger"
  default     = "jaeger"
}

variable "jaeger_chart_name" {
  description = "Chart name for Jaeger"
  default     = "jaeger"
}

variable "jaeger_chart_repository" {
  description = "Chart repository for Jaeger"
  default     = "incubator"
}

variable "jaeger_chart_version" {
  description = "Chart version for Jaeger"
  default     = "0.13.0"
}

variable "jaeger_image_tag" {
  description = "Jaeger's docker image tag"
  default     = "1.13.1"
}

variable "jaeger_namespace" {
  description = "Kubernetes namespace to which Jaeger is deployed"
  default     = "core"
}

variable "jaeger_ui_ingress_hosts" {
  description = "Ingress hosts for the Jaeger Query service"
  default     = {}
}

variable "jaeger_ui_ingress_annotations" {
  description = "Ingress annotations for the Jaeger Query service"
  default     = {}
}
