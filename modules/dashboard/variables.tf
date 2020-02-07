variable "dashboard_release_name" {
  description = "Release name for Dashboard"
  default     = "kubernetes-dashboard"
}

variable "dashboard_chart_name" {
  description = "Chart name for Dashboard"
  default     = "stable/kubernetes-dashboard"
}

variable "dashboard_chart_repository" {
  description = "Chart repository for Dashboard"
  default     = ""
}

variable "dashboard_chart_version" {
  description = "Chart version for Dashboard"
  default     = ""
}

variable "dashboard_image" {
  description = "Docker image for Dashboard"
  default     = "k8s.gcr.io/kubernetes-dashboard-amd64"
}

variable "dashboard_tag" {
  description = "Docker image tag for Dashboard. "
  default     = "v1.10.1"
}

variable "dashboard_replica" {
  description = "Number of replicas for Dashboard"
  default     = "3"
}

variable "dashboard_namespace" {
  description = "Namespace to deploy the dashboard in"
  default     = "kube-system"
}


variable "dashboard_resources" {
  description = "Resources for Dashboard"

  default = {
    requests = {
      cpu = "100m"
    }
    limits = {
      memory = "100Mi"
    }
  }
}

variable "dashboard_cluster_admin" {
  description = "Enable Cluster Admin role for the dashboard. Not recommended."
  default     = false
}

variable "dashboard_enable_skip_login" {
  description = "Enable skipping of login for the dashboard to default to the service account rights for the dashboard"
  default     = "true"
}

variable "dashboard_pdb" {
  description = "YAML of PDB of the Dashboard"
  default     = "maxUnavailable: 1"
}

variable "dashboard_annotations" {
  description = "Annotations for the dashboard deployment"
  default     = {}
}

variable "dashboard_labels" {
  description = "Labels for the dashboard deployment"
  default     = {}
}

variable "dashboard_pod_annotations" {
  description = "Annotations for dashboard pods"
  default     = {}
}

variable "dashboard_service_labels" {
  description = "Labels for dashboard service"
  default     = {}
}

variable "dashboard_service_annotations" {
  description = "Annotations for dashboard service"
  default     = {}
}

variable "dashboard_tolerations" {
  description = "Tolerations for Dashboard"

  default = []
}

variable "dashboard_affinity" {
  description = "Affinity for Dashboard"
  default     = {}
}

variable "dashboard_viewer_role" {
  description = "Name of the Role for Dashboard proxy viewing"
  default     = "dashboard-viewer"
}

variable "dashboard_viewers" {
  description = "Dashboard viewer subjects"
  type = list(
    object(
      {
        name      = string,
        kind      = string,
        namespace = string,
        api_group = string,
      }
    )
  )
}

variable "max_history" {
  description = "Max History for Helm"
  default     = 20
}
