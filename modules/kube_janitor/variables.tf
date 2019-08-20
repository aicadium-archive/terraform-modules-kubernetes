variable "kube_janitor_enabled" {
  description = "Enable/disable cleaning up of old resources"
  default     = false
}

variable "kube_janitor_release_name" {
  description = "Release name for Kube Janitor"
  default     = "kube-janitor"
}

variable "kube_janitor_chart_name" {
  description = "Chart name for Kube Janitor"
  default     = "kube-janitor"
}

variable "kube_janitor_chart_repository" {
  description = "Chart repository for Kube Janitor"
  default     = "amoy"
}

variable "kube_janitor_chart_version" {
  description = "Chart version for Kube Janitor"
  default     = "1.0.0"
}

variable "kube_janitor_schedule" {
  description = "Run frequency as a cron expression. Default hourly"
  default     = "0 * * * *"
}

variable "kube_janitor_rules" {
  description = "Cleaning rules"
  type        = map(any)
}

variable "kube_janitor_resources" {
  description = "Resources for Kube Janitor"

  default = {
    requests = {
      cpu    = "20m"
      memory = "100Mi"
    }
    limits = {
      cpu    = "100m"
      memory = "100Mi"
    }
  }
}

variable "kube_janitor_service_account" {
  description = "Service account for Kube Janitor"
  default     = "kube-janitor"
}

variable "kube_janitor_working_namespaces" {
  description = "Namespaces where Kube Janitor will clean resources"
}

variable "kube_janitor_dry_run" {
  description = "Run Kube Janitor in dry-run mode"
  default     = false
}
