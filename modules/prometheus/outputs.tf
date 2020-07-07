output "prometheus_remote_write_api_url" {
  description = "Prometheus Remote Write API URL: https://prometheus.io/docs/prometheus/latest/storage/#remote-storage-integrations"
  value       = local.prometheus_remote_write_api_url
}

output "prometheus_remote_read_api_url" {
  description = "Prometheus Remote Read API URL: https://prometheus.io/docs/prometheus/latest/storage/#remote-storage-integrations"
  value       = local.prometheus_remote_read_api_url
}

output "prometheus_query_api_url" {
  description = "Prometheus query API URL: https://prometheus.io/docs/prometheus/latest/querying/api/#expression-queries"
  value       = local.prometheus_query_api_url
}

output "prometheus_alerts_api_url" {
  description = "Prometheus query API URL: https://prometheus.io/docs/prometheus/latest/querying/api/#expression-queries"
  value       = local.prometheus_alerts_api_url
}
