# Deploy Consul Exporter for Prometheus
resource "helm_release" "consul_exporter" {
  count      = var.enable_exporter ? 1 : 0
  depends_on = [helm_release.consul]

  name       = var.exporter_release_name
  chart      = var.exporter_chart_name
  repository = var.exporter_chart_repository
  version    = var.exporter_chart_version
  namespace  = var.chart_namespace

  values = [
    data.template_file.exporter_values[0].rendered,
  ]
}

data "template_file" "exporter_values" {
  count = var.enable_exporter ? 1 : 0

  template = file("${path.module}/templates/exporter-values.yaml")

  vars = {
    replica = var.exporter_replica
    image   = var.exporter_image
    tag     = var.exporter_tag

    resources = jsonencode(var.exporter_resources)
    affinity  = jsonencode(var.exporter_affinity)

    consul_server_and_port = "consul-server.${var.chart_namespace}.svc.cluster.local:8500"
  }
}
