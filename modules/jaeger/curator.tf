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

data "template_file" "curator" {
  count = local.curator_enabled

  template = file("${path.module}/templates/curator.yaml")

  vars = {
    image_tag             = var.curator_image_tag
    cron_schedule         = var.curator_cron_schedule
    actions               = jsonencode(var.curator_actions)
    es_client_name_prefix = var.curator_es_client_name_prefix
    es_client_port        = var.curator_es_client_port
  }
}
