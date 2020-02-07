terraform {
  required_providers {
    helm = ">= 1.0"
  }
}

resource "helm_release" "cloudsql_proxy" {
  count = var.enable ? 1 : 0

  name       = var.release_name
  chart      = var.chart_name
  repository = data.helm_repository.amoy.name
  version    = var.chart_version
  namespace  = var.chart_namespace

  max_history = var.max_history

  values = [
    data.template_file.values[0].rendered,
  ]
}

data "helm_repository" "amoy" {
  name = var.chart_repository
  url  = var.chart_repository_url
}

data "template_file" "values" {
  count = var.enable ? 1 : 0

  template = file("${path.module}/templates/values.yaml")

  vars = {
    replicas            = jsonencode(var.replicas)
    deployment_strategy = jsonencode(var.deployment_strategy)

    image = var.image
    tag   = var.tag

    command = jsonencode(var.command)

    volumes       = jsonencode(var.volumes)
    volume_mounts = jsonencode(var.volume_mounts)

    service_account_name = var.service_account_name

    pod_security_context = jsonencode(var.pod_security_context)
    security_context     = jsonencode(var.security_context)

    port         = jsonencode(var.port)
    service_type = var.service_type
    service_port = jsonencode(var.service_port)

    resources     = jsonencode(var.resources)
    node_selector = jsonencode(var.node_selector)
    tolerations   = jsonencode(var.tolerations)
    affinity      = jsonencode(var.affinity)

    env = jsonencode(var.env)

    service_account_annotations = jsonencode(var.service_account_annotations)
  }
}
