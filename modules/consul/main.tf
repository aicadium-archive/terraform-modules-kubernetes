resource "helm_release" "consul" {
  name       = var.release_name
  chart      = var.chart_name
  repository = var.chart_repository
  version    = var.chart_version
  namespace  = var.chart_namespace

  values = [
    data.template_file.values.rendered,
  ]
}

data "template_file" "values" {
  template = file("${path.module}/templates/values.yaml")

  vars = {
    fullname_override = var.fullname_override
    image             = "${var.consul_image_name}:${var.consul_image_tag}"
    image_k8s         = "${var.consul_k8s_image}:${var.consul_k8s_tag}"

    pod_security_policy_enable = var.pod_security_policy_enable

    datacenter = var.server_datacenter

    gossip_secret = var.gossip_encryption_key != null ? kubernetes_secret.secrets[0].metadata[0].name : "null"
    gossip_key    = var.gossip_encryption_key != null ? "gossip" : "null"

    consul_domain         = var.consul_domain
    server_replicas       = var.server_replicas
    server_storage        = var.server_storage
    server_storage_class  = var.server_storage_class
    server_resources      = jsonencode(jsonencode(var.server_resources))
    server_extra_config   = jsonencode(var.server_extra_config)
    server_extra_volumes  = jsonencode(var.server_extra_volumes)
    server_affinity       = jsonencode(var.server_affinity)
    server_tolerations    = jsonencode(var.server_tolerations)
    server_priority_class = var.server_priority_class
    server_annotations    = jsonencode(var.server_annotations)

    client_enabled        = var.client_enabled
    client_grpc           = var.client_grpc
    client_resources      = jsonencode(jsonencode(var.client_resources))
    client_extra_config   = jsonencode(var.client_extra_config)
    client_extra_volumes  = jsonencode(var.client_extra_volumes)
    client_tolerations    = jsonencode(var.client_tolerations)
    client_priority_class = var.client_priority_class
    client_annotations    = jsonencode(var.client_annotations)

    tls_enabled                    = var.tls_enabled
    tls_server_additional_dns_sans = jsonencode(var.tls_server_additional_dns_sans)
    tls_server_additional_ip_sans  = jsonencode(var.tls_server_additional_ip_sans)
    tls_verify                     = var.tls_verify
    tls_https_only                 = var.tls_https_only

    enable_sync_catalog           = var.enable_sync_catalog
    sync_by_default               = var.sync_by_default
    sync_to_consul                = var.sync_to_consul
    sync_to_k8s                   = var.sync_to_k8s
    sync_k8s_prefix               = var.sync_k8s_prefix
    sync_k8s_tag                  = var.sync_k8s_tag
    sync_cluster_ip_services      = var.sync_cluster_ip_services
    sync_node_port_type           = var.sync_node_port_type
    sync_add_k8s_namespace_suffix = var.sync_add_k8s_namespace_suffix
    sync_affinity                 = jsonencode(var.sync_affinity)
    sync_tolerations              = jsonencode(var.sync_tolerations)

    enable_ui          = var.enable_ui
    ui_service_type    = var.ui_service_type
    ui_annotations     = jsonencode(var.ui_annotations)
    ui_additional_spec = jsonencode(var.ui_additional_spec)

    connect_enable                    = var.connect_enable
    enable_connect_inject             = var.enable_connect_inject
    connect_inject_by_default         = var.connect_inject_by_default
    connect_inject_namespace_selector = var.connect_inject_namespace_selector
    connect_inject_affinity           = jsonencode(var.connect_inject_affinity)
    connect_inject_tolerations        = jsonencode(var.connect_inject_tolerations)
  }
}

resource "kubernetes_secret" "secrets" {
  count = var.gossip_encryption_key != null ? 1 : 0

  metadata {
    name        = var.secret_name
    annotations = var.secret_annotation
    namespace   = var.chart_namespace
  }

  type = "Opaque"

  data = {
    gossip = var.gossip_encryption_key
  }
}
