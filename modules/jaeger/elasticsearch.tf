resource "helm_release" "elasticsearch" {
  count = local.elasticsearch_enabled

  name       = var.elasticsearch_release_name
  chart      = var.elasticsearch_chart_name
  repository = var.elasticsearch_chart_repository
  version    = var.elasticsearch_chart_version
  namespace  = local.elasticsearch_namespace

  values = [
    data.template_file.elasticsearch[0].rendered,
  ]
}

data "template_file" "elasticsearch" {
  count = local.elasticsearch_enabled

  template = file("${path.module}/templates/elasticsearch.yaml")

  vars = {
    es_client_resources           = jsonencode(var.jaeger_es_client_resources)
    es_master_resources           = jsonencode(var.jaeger_es_master_resources)
    es_data_replicas              = var.jaeger_es_data_replicas
    es_data_resources             = jsonencode(var.jaeger_es_data_resources)
    es_data_persistence_disk_size = var.jaeger_es_data_persistence_disk_size
  }
}
