variable "enabled" {
  description = "Enable Docker Registry"
  default     = true
}

variable "release_name" {
  description = "Helm Release name"
  default     = "docker-registry"
}

variable "chart_name" {
  description = "Name of the Chart"
  default     = "stable/docker-registry"
}

variable "chart_version" {
  description = "Chart version"
  default     = ""
}

variable "chart_repository" {
  description = "Chart repository"
  default     = ""
}

variable "namespace" {
  description = "Namespace to deploy resources to"
  default     = "default"
}

variable "replica" {
  description = "Number of replica"
  default     = 2
}

variable "update_strategy" {
  description = "Update strategy for deployment"
  default     = {}
}

variable "pod_annotations" {
  description = "Annotations for pods"
  default     = {}
}

variable "pod_labels" {
  description = "Labels for Pods"
  default     = {}
}

variable "image" {
  description = "Docker image for registry"
  default     = "registry"
}

variable "image_tag" {
  description = "Docker Image tag for registry"
  default     = "2.7"
}

variable "image_pull_policy" {
  description = "Image pull policy"
  default     = "IfNotPresent"
}

variable "service_name" {
  description = "Name of Service"
  default     = "docker-registry"
}

variable "service_type" {
  description = "Type of service"
  default     = "ClusterIP"
}

variable "service_annotations" {
  description = "Service Annotations"
  default     = {}
}

variable "ingress_enabled" {
  description = "Enable ingress"
  default     = false
}

variable "ingress_path" {
  description = "Path for ingress"
  default     = "/"
}

variable "ingress_hosts" {
  description = "List of hosts for ingress"
  default     = []
}

variable "ingress_annotations" {
  description = "Annotations for ingress"
  default     = {}
}

variable "ingress_labels" {
  description = "Labels for ingress"
  default     = {}
}

variable "ingress_tls" {
  description = "TLS configuration for ingress"
  default     = {}
}

variable "resources" {
  description = "Resources for Pods"
  default     = {}
}

variable "pv_enabled" {
  description = "Enable Persistent Volume"
  default     = false
}

variable "pv_access_mode" {
  description = "Persistent Volume access mode"
  default     = "ReadWriteOnce"
}

variable "pv_size" {
  description = "Persistent Volume Size"
  default     = "10Gi"
}

variable "pv_storage_class" {
  description = "PV Storage class"
  default     = "-"
}

variable "storage" {
  description = "Type of storage"
  default     = "filesystem"
}

variable "s3" {
  description = "Parameters for S3 storage"
  default     = {}
}

variable "swift" {
  description = "Parameters for Swift storage"
  default     = {}
}

variable "azure_secrets" {
  description = "Secrets for Azure storage"
  default     = {}
}

variable "s3_secrets" {
  description = "Secrets for S3 storage"
  default     = {}
}

variable "swift_secrets" {
  description = "Secrets for Swift storage"
  default     = {}
}

variable "configuration" {
  description = "Configuration for Registry"

  default = {
    version = "0.1"

    log = {
      fields = {
        service = "registry"
      }
    }

    storage = {
      cache = {
        blobdescriptor = "inmemory"
      }
    }

    http = {
      addr = ":5000"
      headers = {
        "X-Content-Type-Options" = ["nosniff"]
      }
    }

    health = {
      storagedriver = {
        enabled   = true
        interval  = "10s"
        threshold = 3
      }
    }
  }
}

variable "security_context_enabled" {
  description = "Enable security context"
  default     = true
}

variable "run_as_user" {
  description = "Run container as UID"
  default     = 1000
}

variable "fs_group" {
  description = "Filesystem group ID"
  default     = 1000
}

variable "priority_class_name" {
  description = "Priority Class name for pods"
  default     = ""
}

variable "pod_disruption_budget" {
  description = "Pod disruption budget"
  default = {
    minAvailable = 1
  }
}

variable "node_selector" {
  description = "Node selector for pods"
  default     = {}
}

variable "tolerations" {
  description = "Pod tolerations"
  default     = []
}

variable "max_history" {
  description = "Max History for Helm"
  default     = 20
}
