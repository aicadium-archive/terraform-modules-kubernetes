data "helm_repository" "jaeger" {
  name = var.jaeger_chart_repository
  url  = var.jaeger_chart_repository_url
}

data "helm_repository" "elastic" {
  name = var.elasticsearch_chart_repository
  url  = var.elasticsearch_chart_repository_url
}
