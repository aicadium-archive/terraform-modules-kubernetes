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

  vars = {}
}

data "template_file" "elasticsearch_data" {
  count = local.elasticsearch_enabled

  template = file("${path.module}/templates/elasticsearch_data.yaml")

  vars = {}
}

data "template_file" "elasticsearch_client" {
  count = local.elasticsearch_enabled

  template = file("${path.module}/templates/elasticsearch_client.yaml")

  vars = {}
}
