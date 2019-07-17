# Configure DNS for Consul
# https://www.consul.io/docs/platform/k8s/dns.html

data "kubernetes_service" "consul_dns" {
  metadata {
    name      = "${helm_release.consul.name}-dns"
    namespace = var.chart_namespace
  }
}

locals {
  kube_dns = {
    consul = [data.kubernetes_service.consul_dns.spec[0].cluster_ip]
  }

  core_dns = <<EOF
${var.core_dns_base}

consul {
  errors
  cache 30
  forward . ${data.kubernetes_service.consul_dns.spec[0].cluster_ip}
}
EOF
}

resource "kubernetes_config_map" "consul_kube_dns" {
  count = var.configure_kube_dns ? 1 : 0

  metadata {
    labels = {
      "addonmanager.kubernetes.io/mode" = "EnsureExists"
    }

    name = "kube-dns"
    namespace = "kube-system"
  }

  data = {
    "stubDomains" = jsonencode(local.kube_dns)
  }
}

resource "kubernetes_config_map" "consul_core_dns" {
  count = var.configure_core_dns ? 1 : 0

  metadata {
    labels = var.core_dns_labels

    name = "coredns"
    namespace = "kube-system"
  }

  data = {
    "Corefile" = local.core_dns
  }
}
