locals {
  prometheus_remote_write_api_url = var.vm_enabled && var.vm_insert_enabled ? "http://${helm_release.vm[0].metadata.name}-vminsert.${helm_release.vm[0].metadata.namespace}.svc.cluster.local:${var.vm_insert_service_port}/insert/0/prometheus" : ""
  prometheus_query_api_url        = var.vm_enabled && var.vm_select_enabled ? "http://${helm_release.vm[0].metadata.name}-vmselect.${helm_release.vm[0].metadata.namespace}.svc.cluster.local:${var.vm_select_service_port}/select/0/prometheus" : ""
}

data "helm_repository" "vm" {
  name = var.vm_chart_repository
  url  = var.vm_chart_repository_url
}

resource "helm_release" "vm" {
  count = var.vm_enabled ? 1 : 0

  name       = var.vm_release_name
  chart      = var.vm_chart
  repository = data.helm_repository.vm.metadata[0].name
  version    = var.vm_chart_version
  namespace  = var.vm_namespace

  max_history = var.vm_helm_release_max_history

  values = [
    data.template_file.vm[0].rendered,
  ]
}

data "template_file" "vm" {
  count = var.vm_enabled ? 1 : 0

  template = file("${path.module}/templates/victoriametrics.yaml")

  vars = {
    psp_enabled                 = var.vm_psp_enabled
    service_account_annotations = jsonencode(var.vm_service_account_annotations)

    select_enabled             = var.vm_select_enabled
    select_image_repository    = var.vm_select_image_repository
    select_image_tag           = var.vm_select_image_tag
    select_priority_class_name = var.vm_select_priority_class_name

    select_tolerations     = jsonencode(var.vm_select_tolerations)
    select_node_selector   = jsonencode(var.vm_select_node_selector)
    select_affinity        = jsonencode(var.vm_select_affinity)
    select_pod_annotations = jsonencode(var.vm_select_pod_annotations)
    select_replica_count   = var.vm_select_replica_count
    select_resources       = jsonencode(var.vm_select_resources)

    select_security_context = jsonencode(var.vm_select_security_context)

    select_service_annotations = jsonencode(var.vm_select_service_annotations)
    select_service_labels      = jsonencode(var.vm_select_service_labels)
    select_service_port        = var.vm_select_service_port
    select_service_type        = var.vm_select_service_type

    select_pv_enabled      = var.vm_select_pv_enabled
    select_pv_access_modes = jsonencode(var.vm_select_pv_access_modes)
    select_pv_annotations  = jsonencode(var.vm_select_pv_annotations)
    select_pv_size         = var.vm_select_pv_size

    insert_enabled             = var.vm_insert_enabled
    insert_image_repository    = var.vm_insert_image_repository
    insert_image_tag           = var.vm_insert_image_tag
    insert_priority_class_name = var.vm_insert_priority_class_name

    insert_tolerations     = jsonencode(var.vm_insert_tolerations)
    insert_node_selector   = jsonencode(var.vm_insert_node_selector)
    insert_affinity        = jsonencode(var.vm_insert_affinity)
    insert_pod_annotations = jsonencode(var.vm_insert_pod_annotations)
    insert_replica_count   = var.vm_insert_replica_count
    insert_resources       = jsonencode(var.vm_insert_resources)

    insert_security_context = jsonencode(var.vm_insert_security_context)

    insert_service_annotations = jsonencode(var.vm_insert_service_annotations)
    insert_service_labels      = jsonencode(var.vm_insert_service_labels)
    insert_service_port        = var.vm_insert_service_port
    insert_service_type        = var.vm_insert_service_type

    storage_enabled             = var.vm_storage_enabled
    storage_image_repository    = var.vm_storage_image_repository
    storage_image_tag           = var.vm_storage_image_tag
    storage_priority_class_name = var.vm_storage_priority_class_name

    storage_retention_period = var.vm_storage_retention_period
    storage_extra_args       = jsonencode(var.vm_storage_extra_args)

    storage_tolerations   = jsonencode(var.vm_storage_tolerations)
    storage_node_selector = jsonencode(var.vm_storage_node_selector)
    storage_affinity      = jsonencode(var.vm_storage_affinity)

    storage_pv_enabled      = var.vm_storage_pv_enabled
    storage_pv_access_modes = jsonencode(var.vm_storage_pv_access_modes)
    storage_pv_annotations  = jsonencode(var.vm_storage_pv_annotations)
    storage_pv_size         = var.vm_storage_pv_size

    storage_pod_annotations = jsonencode(var.vm_storage_pod_annotations)
    storage_replica_count   = var.vm_storage_replica_count
    storage_resources       = jsonencode(var.vm_storage_resources)

    storage_security_context = jsonencode(var.vm_storage_security_context)

    storage_service_annotations = jsonencode(var.vm_storage_service_annotations)
    storage_service_labels      = jsonencode(var.vm_storage_service_labels)
    storage_service_port        = var.vm_storage_service_port
    storage_vm_insert_port      = var.vm_storage_vm_insert_port
    storage_vm_select_port      = var.vm_storage_vm_select_port

    storage_termination_grace_period_seconds = var.vm_storage_termination_grace_period_seconds
  }
}
