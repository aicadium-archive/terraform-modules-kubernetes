resource "helm_release" "bulldozer" {
  name       = var.bulldozer_release_name
  chart      = var.bulldozer_chart_name
  repository = var.bulldozer_chart_repository
  version    = var.bulldozer_chart_version

  values = [
    local.rendered_values
  ]
}

locals {
  rendered_values = templatefile("${path.module}/templates/values.template.yml", local.values)

  values = {
    github_integration_id  = var.bulldozer_github_integration_id
    github_webhook_secret  = var.bulldozer_github_webhook_secret
    github_private_key_pem = jsonencode(var.bulldozer_github_private_key_pem)
    bulldozer_image_name   = var.bulldozer_image_name
    bulldozer_image_tag    = var.bulldozer_image_tag
    name_override          = var.name_override != null ? jsonencode(var.name_override) : "null"

    fullname_override = var.fullname_override != null ? jsonencode(var.fullname_override) : "null"

    image     = var.bulldozer_image_name
    image_tag = var.bulldozer_image_tag
    replicas  = var.replicas

    ingress_enabled = var.bulldozer_ingress_enabled
    ingress_host    = var.bulldozer_ingress_host

    ingress_annotations = jsonencode(var.bulldozer_ingress_annotations)
    service_annotations = jsonencode(var.bulldozer_service_annotations)
  }
}
