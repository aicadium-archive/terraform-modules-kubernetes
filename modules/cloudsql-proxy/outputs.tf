output "service" {
  description = "Name of the Kubernetes service"
  value       = helm_release.cloudsql_proxy.name
}
