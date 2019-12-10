resource "helm_release" "prometheus_adapter" {
  name       = var.release_name
  chart      = var.chart_name
  repository = var.chart_repository
  version    = var.chart_version
  namespace  = var.chart_namespace

  values = [
    data.template_file.values.rendered,
  ]
}

data "template_file" "values" {
  template = file("${path.module}/templates/values.yaml")

  vars = {
    image    = var.image
    tag      = var.tag
    affinity = jsonencode(var.affinity)
    replicas = jsonencode(var.replicas)

    resources = jsonencode(var.resources)

    log_level           = jsonencode(var.log_level)
    priority_class_name = jsonencode(var.priority_class_name)

    prometheus_url  = var.prometheus_url
    prometheus_port = jsonencode(var.prometheus_port)

    service_type        = jsonencode(var.service_type)
    service_port        = jsonencode(var.service_port)
    service_annotations = jsonencode(var.service_annotations)

    extra_volumes       = jsonencode(var.extra_volumes)
    extra_volume_mounts = jsonencode(var.extra_volume_mounts)

    tolerations     = jsonencode(var.tolerations)
    pod_annotations = jsonencode(var.pod_annotations)

    rules_default  = jsonencode(var.rules_default)
    rules_existing = var.rules_existing != null ? jsonencode(var.rules_existing) : "null"
    rules_custom   = jsonencode(var.rules_custom)
    rules_external = jsonencode(var.rules_external)
    rules_resource = jsonencode(var.rules_resource)
  }
}
