output "prometheus_remote_write_api" {
  description = "Prometheus Remote Write API: https://prometheus.io/docs/prometheus/latest/storage/#remote-storage-integrations"
  value       = var.vm_enabled && var.vm_insert_enabled ? "http://${var.vm_release_name}-vminsert.${var.vm_namespace}.svc.cluster.local:${var.vm_insert_service_port}/insert/0/prometheus/" : ""
}

output "prometheus_query_api" {
  description = "Prometheus query API: https://prometheus.io/docs/prometheus/latest/querying/api/#expression-queries"
  value       = var.vm_enabled && var.vm_select_enabled ? "http://${var.vm_release_name}-vmselect.${var.vm_namespace}.svc.cluster.local:${var.vm_select_service_port}/select/0/prometheus/" : ""
}
