variable "release_name" {
  description = "Helm release name for Prometheus"
  default     = "prometheus-adapter"
}

variable "chart_name" {
  description = "Helm chart name to provision"
  default     = "prometheus-adapter"
}

variable "chart_repository" {
  description = "Helm repository for the chart"
  default     = "stable"
}

variable "chart_version" {
  description = "Version of Chart to install. Set to empty to install the latest version"
  default     = ""
}

variable "chart_namespace" {
  description = "Namespace to install the chart into"
  default     = "default"
}

variable "max_history" {
  description = "Max History for Helm"
  default     = 20
}

variable "affinity" {
  description = "Affinity for the pods"
  default     = {}
}

variable "image" {
  description = "Docker image for the Prometheus Adapter"
  default     = "directxman12/k8s-prometheus-adapter-amd64"
}

variable "tag" {
  description = "Docker Image tag for the Prometheus Adapter"
  default     = "latest"
}

variable "log_level" {
  description = "Numerical log level for the adapter"
  default     = 4
}

variable "priority_class_name" {
  description = "Pod Priority Class name"
  default     = ""
}

variable "prometheus_url" {
  description = "Address for Prometheus"
  default     = "http://prometheus.default.svc"
}

variable "prometheus_port" {
  description = "Prometheus port"
  default     = 9090
}

variable "replicas" {
  description = "Number of replicas"
  default     = 1
}

variable "resources" {
  description = "Resources for the pod"
  default     = {}
}

variable "extra_volumes" {
  description = "Extra volumes for the adapter"
  default     = []
}

variable "extra_volume_mounts" {
  description = "Extra volume mounts for the adapter container"
  default     = []
}

variable "tolerations" {
  description = "Tolerations for the pod"
  default     = []
}

variable "pod_annotations" {
  description = "Pod annotations"
  default     = {}
}

variable "rules_default" {
  description = "Use the default rules from the chart"
  default     = true
}

variable "rules_custom" {
  description = "Custom metrics rules"
  default     = []
}

variable "rules_existing" {
  description = "ConfigMap containing existing rules"
  default     = null
}

variable "rules_external" {
  description = "External metrics rules"
  default     = []
}

variable "rules_resource" {
  description = "Custom resource rules"
  default     = {}
}

variable "service_annotations" {
  description = "Service Annotations"
  default     = {}
}

variable "service_port" {
  description = "Service port"
  default     = "443"
}

variable "service_type" {
  description = "Service Type"
  default     = "ClusterIP"
}
