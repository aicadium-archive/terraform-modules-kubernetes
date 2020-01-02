locals {
  jaeger_enabled    = var.jaeger_enabled ? 1 : 0
  jaeger_namespace  = var.jaeger_namespace

  elasticsearch_enabled    = var.elasticsearch_enabled ? 1 : 0
  elasticsearch_namespace  = var.elasticsearch_namespace

  curator_enabled   = var.curator_enabled ? 1 : 0
  curator_namespace = var.curator_namespace
}

resource "helm_release" "jaeger" {
  count = local.jaeger_enabled

  name       = var.jaeger_release_name
  chart      = var.jaeger_chart_name
  repository = var.jaeger_chart_repository
  version    = var.jaeger_chart_version
  namespace  = local.jaeger_namespace

  values = [
    data.template_file.jaeger[0].rendered,
  ]
}

data "template_file" "jaeger" {
  count = local.jaeger_enabled

  template = file("${path.module}/templates/jaeger.yaml")

  vars = {
    image_tag                     = var.jaeger_image_tag
    ingress_hosts                 = jsonencode(var.jaeger_ui_ingress_hosts)
    ingress_annotations           = jsonencode(var.jaeger_ui_ingress_annotations)
    es_client_resources           = jsonencode(var.jaeger_es_client_resources)
    es_master_resources           = jsonencode(var.jaeger_es_master_resources)
    es_data_replicas              = var.jaeger_es_data_replicas
    es_data_resources             = jsonencode(var.jaeger_es_data_resources)
    es_data_persistence_disk_size = var.jaeger_es_data_persistence_disk_size
    agent_resources               = jsonencode(var.jaeger_agent_resources)
    collector_resources           = jsonencode(var.jaeger_collector_resources)
    query_resources               = jsonencode(var.jaeger_query_resources)
  }
}
