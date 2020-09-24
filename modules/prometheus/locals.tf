locals {
  prometheus_server_url       = "http://${helm_release.prometheus.metadata[0].name}-server.${helm_release.prometheus.metadata[0].namespace}.svc.cluster.local:${var.server_service_port}"
  prometheus_alertmanager_url = "http://${helm_release.prometheus.metadata[0].name}-alertmanager.${helm_release.prometheus.metadata[0].namespace}.svc.cluster.local:${var.alertmanager_service_port}"

  prometheus_remote_write_api_url = var.vm_enabled && var.vm_insert_enabled ? "http://${helm_release.vm[0].metadata[0].name}-vminsert.${helm_release.vm[0].metadata[0].namespace}.svc.cluster.local:${var.vm_insert_service_port}/insert/0/prometheus" : ""
  prometheus_remote_read_api_url  = var.vm_enabled && var.vm_select_enabled ? "http://${helm_release.vm[0].metadata[0].name}-vmselect.${helm_release.vm[0].metadata[0].namespace}.svc.cluster.local:${var.vm_select_service_port}/select/0/prometheus" : ""

  prometheus_query_api_url = coalesce(local.prometheus_remote_read_api_url, local.prometheus_server_url)
  prometheus_alerts_api_url = (
    var.vm_enabled && var.vm_alert_enabled ?
    "http://${helm_release.vm_alert[0].metadata[0].name}-server.${helm_release.vm_alert[0].metadata[0].namespace}.svc.cluster.local:${var.vm_alert_service_port}" :
    local.prometheus_server_url
  )

  self_scrape_config = local.vm_agent_enabled ? [
    {
      job_name = "vmagent"
      static_configs = [
        {
          targets = ["localhost:8429"]
        }
      ]
    }
    ] : [
    {
      job_name = "prometheus"
      static_configs = [
        {
          targets = ["localhost:9090"]
        }
      ]
    }
  ]

  scrape_config_values = {
    vm_agent_enabled = local.vm_agent_enabled

    scrape_skip_apiserver_tls_verify = var.scrape_skip_apiserver_tls_verify
    scrape_skip_nodes_tls_verify     = var.scrape_skip_nodes_tls_verify
  }
}
