output "release" {
  description = "Helm Release Object"
  value       = helm_release.traefik
}

output "static_ip" {
  description = "Address of the Traefik Load balancer static IP"
  value       = var.static_ip
}
