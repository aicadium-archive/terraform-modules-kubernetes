output "service" {
  description = "Name of the Kubernetes service"
  value       = var.enable ? helm_release.cloudsql_proxy[0].name : ""
}
