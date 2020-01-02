###########################
# Jaeger with ES
###########################

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

variable "jaeger_es_client_resources" {
  description = "Kubernetes resources for Elasticsearch client node"
  default = {
    limits = {
      cpu    = "1"
      memory = "1536Mi"
    }
    requests = {
      cpu    = "25m"
      memory = "512Mi"
    }
  }
}

variable "jaeger_es_master_resources" {
  description = "Kubernetes resources for Elasticsearch master node"
  default = {
    limits = {
      cpu    = "1"
      memory = "1536Mi"
    }
    requests = {
      cpu    = "25m"
      memory = "512Mi"
    }
  }
}

variable "jaeger_es_data_resources" {
  description = "Kubernetes resources for Elasticsearch data node"
  default = {
    limits = {
      cpu    = "1"
      memory = "2560Mi"
    }
    requests = {
      cpu    = "25m"
      memory = "1536Mi"
    }
  }
}

variable "jaeger_es_data_replicas" {
  description = "Num of replicas of Elasticsearch data node"
  default     = 2
}

variable "jaeger_es_data_persistence_disk_size" {
  description = "Persistence disk size in each Elasticsearch data node"
  default     = "30Gi"
}

variable "jaeger_query_resources" {
  description = "Kubernetes resources for Jaeger Query service"
  default = {
    limits = {
      cpu    = "200m"
      memory = "128Mi"
    }
    requests = {
      cpu    = "25m"
      memory = "32Mi"
    }
  }
}

variable "jaeger_collector_resources" {
  description = "Kubernetes resources for Jaeger Collector service"
  default = {
    limits = {
      cpu    = "512m"
      memory = "256Mi"
    }
    requests = {
      cpu    = "50m"
      memory = "64Mi"
    }
  }
}

variable "jaeger_agent_resources" {
  description = "Kubernetes resources for Jaeger Agent service"
  default = {
    limits = {
      cpu    = "100m"
      memory = "128Mi"
    }
    requests = {
      cpu    = "25m"
      memory = "16Mi"
    }
  }
}

###########################
# Elasticsearch cluster
###########################
variable "elasticsearch_enabled" {
  description = "Enable/disable Elasticsearch"
  default     = false
}

variable "elasticsearch_release_name" {
  description = "Helm release name for Elasticsearch"
  default     = "jaeger-elasticsearch"
}

variable "elasticsearch_chart_name" {
  description = "Chart name for Elasticsearch"
  default     = "elasticsearch"
}

variable "elasticsearch_chart_repository" {
  description = "Chart repository for Elasticsearch"
  default     = "elastic"
}

variable "elasticsearch_chart_version" {
  description = "Chart version for Elasticsearch"
  default     = "7.5.1"
}

variable "elasticsearch_namespace" {
  description = "Kubernetes namespace to which Elasticsearch is deployed"
  default     = "core"
}

###########################
# Elasticsearch Curator
###########################
variable "curator_enabled" {
  description = "Enable/disable Curator"
  default     = false
}

variable "curator_release_name" {
  description = "Helm release name for Curator"
  default     = "elasticsearch-curator"
}

variable "curator_chart_name" {
  description = "Chart name for Curator"
  default     = "elasticsearch-curator"
}

variable "curator_chart_repository" {
  description = "Chart repository for Curator"
  default     = "stable"
}

variable "curator_chart_version" {
  description = "Chart version for Curator"
  default     = "2.0.0"
}

variable "curator_image_tag" {
  description = "Curator's docker image tag"
  default     = "5.7.6"
}

variable "curator_namespace" {
  description = "Kubernetes namespace to which Curator is deployed"
  default     = "core"
}

variable "curator_cron_schedule" {
  description = "Crontab which Curator will run"
  default     = "0 16 * * *"
}

variable "curator_actions" {
  description = "Curator actions"
  default = {
    actions = {
      1 = {
        action      = "delete_indices"
        description = "Clean up ES by deleting old indices"
        options = {
          timeout_override      = 300
          continue_if_exception = false
          disable_action        = false
          ignore_empty_list     = true
        }
        filters = [
          {
            filtertype = "age"
            source     = "creation_date"
            direction  = "older"
            unit       = "days"
            unit_count = 28
            exclude    = false
          }
        ]
      }
    }
  }
}

variable "curator_es_client_name_prefix" {
  description = "Name prefix for Curator to locate the ES client"
  default     = "es"
}

variable "curator_es_client_port" {
  description = ""
  default     = 9200
}
