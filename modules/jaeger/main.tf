locals {
  jaeger_enabled    = var.jaeger_enabled ? 1 : 0
  jaeger_namespace  = var.jaeger_namespace
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

resource "helm_release" "curator" {
  count = local.curator_enabled

  name       = var.curator_release_name
  chart      = var.curator_chart_name
  repository = var.curator_chart_repository
  version    = var.curator_chart_version
  namespace  = local.curator_namespace

  values = [
    data.template_file.curator[0].rendered,
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

data "template_file" "curator" {
  count = local.curator_enabled

  template = file("${path.module}/templates/curator.yaml")

  vars = {
    image_tag             = var.curator_image_tag
    cron_schedule         = var.curator_cron_schedule
    es_client_name_prefix = var.curator_es_client_name_prefix
    es_client_port        = var.curator_es_client_port
  }
}
