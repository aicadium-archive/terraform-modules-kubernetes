locals {
  prometheus_remote_write_api_url = var.vm_enabled && var.vm_insert_enabled ? "http://${helm_release.vm[0].metadata[0].name}-vminsert.${helm_release.vm[0].metadata[0].namespace}.svc.cluster.local:${var.vm_insert_service_port}/insert/0/prometheus" : ""

  prometheus_query_api_url = (
    var.vm_enabled && var.vm_select_enabled ?
    "http://${helm_release.vm[0].metadata[0].name}-vmselect.${helm_release.vm[0].metadata[0].namespace}.svc.cluster.local:${var.vm_select_service_port}/select/0/prometheus" :
    "http://${helm_release.prometheus[0].metadata[0].name}-server.${helm_release.prometheus[0].metadata[0].namespace}.svc.cluster.local:${var.server_service_port}"
  )

  prometheus_alertmanager_url = "http://${helm_release.prometheus[0].metadata[0].name}-alertmanager.${helm_release.prometheus[0].metadata[0].namespace}.svc.cluster.local:${var.alertmanager_service_port}"
}
