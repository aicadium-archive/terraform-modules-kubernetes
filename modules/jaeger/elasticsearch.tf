# Elasticsearch master nodes
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

# Elasticsearch data nodes
resource "helm_release" "elasticsearch_data" {
  count = local.elasticsearch_enabled

  name       = "${var.elasticsearch_release_name}-data"
  chart      = var.elasticsearch_chart_name
  repository = var.elasticsearch_chart_repository
  version    = var.elasticsearch_chart_version
  namespace  = local.elasticsearch_namespace

  values = [
    data.template_file.elasticsearch_data[0].rendered,
  ]
}

# Elasticsearch client nodes
resource "helm_release" "elasticsearch_client" {
  count = local.elasticsearch_enabled

  name       = "${var.elasticsearch_release_name}-client"
  chart      = var.elasticsearch_chart_name
  repository = var.elasticsearch_chart_repository
  version    = var.elasticsearch_chart_version
  namespace  = local.elasticsearch_namespace

  values = [
    data.template_file.elasticsearch_client[0].rendered,
  ]
}

data "template_file" "elasticsearch" {
  count = local.elasticsearch_enabled

  template = file("${path.module}/templates/elasticsearch.yaml")

  vars = {
    es_image                        = var.jaeger_es_image
    es_image_tag                    = var.jaeger_es_image_tag
    es_major_version                = var.jaeger_es_major_version
    es_rbac_enable                  = var.jaeger_es_rbac_enable || var.jaeger_es_psp_enable
    es_psp_enable                   = var.jaeger_es_psp_enable
    es_master_minimum_replicas      = var.jaeger_es_master_minimum_replicas
    es_master_replicas              = var.jaeger_es_master_replicas
    es_master_resources             = jsonencode(var.jaeger_es_master_resources)
    es_master_persistence_disk_size = var.jaeger_es_master_persistence_disk_size
  }
}

data "template_file" "elasticsearch_data" {
  count = local.elasticsearch_enabled

  template = file("${path.module}/templates/elasticsearch_data.yaml")

  vars = {
    es_image                      = var.jaeger_es_image
    es_image_tag                  = var.jaeger_es_image_tag
    es_major_version              = var.jaeger_es_major_version
    es_rbac_enable                = var.jaeger_es_rbac_enable || var.jaeger_es_psp_enable
    es_psp_enable                 = var.jaeger_es_psp_enable
    es_data_replicas              = var.jaeger_es_data_replicas
    es_data_resources             = jsonencode(var.jaeger_es_data_resources)
    es_data_persistence_disk_size = var.jaeger_es_data_persistence_disk_size
  }
}

data "template_file" "elasticsearch_client" {
  count = local.elasticsearch_enabled

  template = file("${path.module}/templates/elasticsearch_client.yaml")

  vars = {
    es_image                        = var.jaeger_es_image
    es_image_tag                    = var.jaeger_es_image_tag
    es_major_version                = var.jaeger_es_major_version
    es_rbac_enable                  = var.jaeger_es_rbac_enable || var.jaeger_es_psp_enable
    es_psp_enable                   = var.jaeger_es_psp_enable
    es_client_replicas              = var.jaeger_es_client_replicas
    es_client_resources             = jsonencode(var.jaeger_es_client_resources)
    es_client_persistence_disk_size = var.jaeger_es_client_persistence_disk_size
  }
}
