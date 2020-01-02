variable "enable" {
  description = "Enable Helm Chart"
  default     = true
}

variable "release_name" {
  description = "Helm release name"
  default     = "cloudsql-proxy"
}

variable "chart_name" {
  description = "Helm chart name to provision"
  default     = "cloudsql-proxy"
}

variable "chart_repository" {
  description = "Helm repository for the chart"
  default     = "amoy"
}

variable "chart_version" {
  description = "Version of Chart to install. Set to empty to install the latest version"
  default     = ""
}

variable "chart_namespace" {
  description = "Namespace to install the chart into"
  default     = "default"
}

variable "chart_repository_url" {
  description = "URL for the chart repository"
  default     = "https://charts.amoy.ai"
}

variable "replicas" {
  description = "Number of replicas"
  default     = 1
}

variable "deployment_strategy" {
  description = "Deployment strategy"
  default = {
    maxSurge       = 1
    maxUnavailable = 0
  }
}

variable "image" {
  description = "Docker image"
  default     = "gcr.io/cloudsql-docker/gce-proxy"
}

variable "tag" {
  description = "Docker image tag"
  default     = "1.16"
}

variable "command" {
  description = "Command for the proxy"

  default = [
    "/cloud_sql_proxy",
    "-instances=<INSTANCE_CONNECTION_NAME>=tcp:5432",
    # Log to stdout instead of stderr
    "-log_debug_stdout",
    # If running on a VPC, the Cloud SQL proxy can connect via Private IP. See:
    # https://cloud.google.com/sql/docs/mysql/private-ip for more info.
    # "-ip_address_types=PRIVATE",
    "-credential_file=/secrets/cloudsql/credentials.json",
  ]
}

variable "volumes" {
  description = "Volumes for the pod"
  default     = []
}

variable "volume_mounts" {
  description = "Volume mounts for the proxy container"
  default     = []
}

variable "service_account_name" {
  description = "Service account name"
  default     = ""
}

variable "pod_security_context" {
  description = "Security context for the pod"

  default = {
    fsGroup = 2000
  }
}

variable "security_context" {
  description = "Security context for the container"

  default = {
    runAsUser    = 1000
    runAsNonRoot = true
  }
}

variable "port" {
  description = "Container pod. This should match the port you specify in the command"
  default     = 5432
}

variable "service_type" {
  description = "Type of Kubernetes service"
  default     = "ClusterIP"
}

variable "service_port" {
  description = "Port on the Kubernetes Service"
  default     = 5432
}

variable "resources" {
  description = "Resources for the pod"
  default     = {}
}

variable "node_selector" {
  description = "Node selector for the pod"
  default     = {}
}

variable "tolerations" {
  description = "List of tolerations for the pod"
  default     = []
}

variable "affinity" {
  description = "Affinity for the pod"
  default     = {}
}

variable "env" {
  description = "Environment variables for the proxy container"
  default     = []
}

variable "service_account_annotations" {
  description = "Annotations for Service account"
  default     = {}
}
