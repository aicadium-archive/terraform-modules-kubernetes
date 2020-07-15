resource "helm_release" "kube_state_metrics" {
  count = var.kube_state_metrics_enable ? 1 : 0

  name       = var.kube_state_metrics_release_name
  chart      = var.kube_state_metrics_chart_name
  repository = var.kube_state_metrics_chart_repository
  version    = var.kube_state_metrics_chart_version
  namespace  = var.kube_state_metrics_chart_namespace

  max_history = var.max_history

  values = [
    templatefile("${path.module}/templates/kube_state_metrics.yaml", local.kube_state_metrics_values),
  ]
}

locals {
  kube_state_metrics_values = {
    repository  = var.kube_state_metrics_repository
    tag         = var.kube_state_metrics_tag
    pull_policy = var.kube_state_metrics_pull_policy

    autosharding = var.kube_state_metrics_autosharding

    replica   = var.kube_state_metrics_replica
    resources = jsonencode(var.kube_state_metrics_resources)

    annotations   = jsonencode(var.kube_state_metrics_annotations)
    tolerations   = jsonencode(var.kube_state_metrics_tolerations)
    labels        = jsonencode(var.kube_state_metrics_labels)
    node_selector = jsonencode(var.kube_state_metrics_node_selector)
    affinity      = jsonencode(var.kube_state_metrics_affinity)

    security_context = coalesce(
      var.kube_state_metrics_security_context_json,
      jsonencode(var.kube_state_metrics_security_context),
    )

    priority_class_name = var.kube_state_metrics_priority_class_name
    extra_args          = jsonencode(var.kube_state_metrics_extra_args)

    service_annotations = jsonencode(var.kube_state_metrics_service_annotations)
    service_cluster_ip  = jsonencode(var.kube_state_metrics_service_cluster_ip)
    service_lb_ip       = jsonencode(var.kube_state_metrics_service_lb_ip)
    service_port        = var.kube_state_metrics_service_port
    service_type        = var.kube_state_metrics_service_type

    service_account             = var.kube_state_metrics_service_account
    service_account_annotations = jsonencode(var.kube_state_metrics_service_account_annotations)

    pdb          = jsonencode(var.kube_state_metrics_pdb)
    host_network = var.kube_state_metrics_host_network

    psp_enable      = var.pod_security_policy_enable
    psp_annotations = jsonencode(var.kube_state_metrics_pod_security_policy_annotations)

    collection_namespace = var.kube_state_metrics_collection_namespace
    collectors           = jsonencode(var.kube_state_metrics_collectors)
  }
}
