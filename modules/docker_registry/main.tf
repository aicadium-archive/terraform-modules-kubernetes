terraform {
  required_providers {
    helm = ">= 1.0"
  }
}

locals {
  enabled = var.enabled ? 1 : 0

  values = {
    replica         = var.replica
    update_strategy = jsonencode(var.update_strategy)

    image             = var.image
    image_tag         = var.image_tag
    image_pull_policy = var.image_pull_policy

    pod_annotations = jsonencode(var.pod_annotations)
    pod_labels      = jsonencode(var.pod_labels)

    resources = jsonencode(var.resources)

    service_name        = var.service_name
    service_type        = var.service_type
    service_annotations = jsonencode(var.service_annotations)

    ingress_enabled     = jsonencode(var.ingress_enabled)
    ingress_path        = var.ingress_path
    ingress_hosts       = jsonencode(var.ingress_hosts)
    ingress_annotations = jsonencode(var.ingress_annotations)
    ingress_labels      = jsonencode(var.ingress_labels)
    ingress_tls         = jsonencode(var.ingress_tls)

    storage = var.storage

    s3    = jsonencode(var.s3)
    swift = jsonencode(var.swift)

    azure_secrets = jsonencode(var.azure_secrets)
    s3_secrets    = jsonencode(var.s3_secrets)
    swift_secrets = jsonencode(var.swift_secrets)

    configuration = jsonencode(var.configuration)

    pv_enabled       = jsonencode(var.pv_enabled)
    pv_access_mode   = var.pv_access_mode
    pv_size          = var.pv_size
    pv_storage_class = var.pv_storage_class

    security_context_enabled = var.security_context_enabled
    run_as_user              = var.run_as_user
    fs_group                 = var.fs_group

    priority_class_name   = var.priority_class_name
    pod_disruption_budget = jsonencode(var.pod_disruption_budget)
    node_selector         = jsonencode(var.node_selector)
    affinity              = jsonencode(var.affinity)
    tolerations           = jsonencode(var.tolerations)

    service_account_annotations = jsonencode(var.service_account_annotations)
  }
}

resource "helm_release" "registry" {
  count = local.enabled

  name       = var.release_name
  chart      = var.chart_name
  repository = var.chart_repository
  version    = var.chart_version
  namespace  = var.namespace

  max_history = var.max_history

  values = [
    templatefile("${path.module}/templates/values.yaml", local.values)
  ]
}
