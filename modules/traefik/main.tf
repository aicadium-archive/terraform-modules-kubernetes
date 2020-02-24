resource "helm_release" "traefik" {
  count = var.create ? 1 : 0

  name       = var.release_name
  chart      = var.chart_name
  repository = var.chart_repository
  version    = var.chart_version
  namespace  = var.chart_namespace

  max_history = var.max_history

  values = [
    local.rendered_values
  ]
}

locals {
  acme_enabled                = var.acme_enabled == "true"
  acme_dns_provider_variables = "${var.acme_dns_provider}: ${jsonencode(var.acme_dns_provider_variables)}"

  pod_annotations = merge(
    {
      "checksum/acme_vars" = sha256(local.acme_dns_provider_variables)
    },
    var.pod_annotations,
  )
}

locals {
  rendered_values = templatefile("${path.module}/templates/values.yaml", local.values)

  autoscaling = {
    minReplicas = var.autoscaling_min_replicas
    maxReplicas = var.autoscaling_max_replicas
    metrics     = var.autoscaling_metrics
  }

  values = {
    fullname_override = var.fullname_override != null ? jsonencode(var.fullname_override) : "null"

    image     = var.traefik_image_name
    image_tag = var.traefik_image_tag
    replicas  = var.replicas

    rbac_enabled   = var.rbac_enabled
    sa_annotations = jsonencode(var.sa_annotations)

    max_idle_conns_per_host = var.max_idle_conns_per_host

    service_type            = var.service_type
    lb_source_range         = jsonencode(var.lb_source_range)
    external_traffic_policy = jsonencode(var.external_traffic_policy)
    whitelist_source_range  = jsonencode(var.whitelist_source_range)
    node_port_http          = var.node_port_http
    node_port_https         = var.node_port_https
    static_ip               = var.static_ip != null ? jsonencode(var.static_ip) : "null"

    service_annotations = jsonencode(var.service_annotations)
    service_labels      = jsonencode(var.service_labels)

    pod_annotations       = jsonencode(local.pod_annotations)
    pod_labels            = jsonencode(var.pod_labels)
    pod_disruption_budget = jsonencode(var.pod_disruption_budget)
    pod_priority_class    = var.pod_priority_class != null ? jsonencode(var.pod_priority_class) : "null"

    deployment_strategy         = jsonencode(var.deployment_strategy)
    http_host_port_binding      = var.http_host_port_binding
    https_host_port_binding     = var.https_host_port_binding
    dashboard_host_port_binding = var.dashboard_host_port_binding

    root_ca   = jsonencode(var.root_ca)
    debug     = var.debug
    log_level = var.log_level

    resources = jsonencode(var.resources)

    node_selector = jsonencode(var.node_selector)
    affinity      = jsonencode(var.affinity)
    tolerations   = jsonencode(var.tolerations)

    namespaces     = jsonencode(var.namespaces)
    label_selector = var.label_selector
    ingress_class  = var.ingress_class

    kv_provider = yamlencode(var.kv_provider)

    ssl_enabled            = var.ssl_enabled
    ssl_enforced           = var.ssl_enforced
    ssl_permanent_redirect = var.ssl_permanent_redirect
    ssl_min_version        = var.ssl_min_version
    ssl_ciphersuites       = jsonencode(var.ssl_ciphersuites)

    acme_enabled         = var.acme_enabled
    acme_key_type        = var.acme_key_type
    acme_email           = var.acme_email
    acme_on_host_rule    = var.acme_on_host_rule
    acme_staging         = var.acme_staging
    acme_logging         = var.acme_logging
    acme_domains_enabled = length(var.acme_domains) > 0 ? "true" : "false"
    acme_domains         = jsonencode(var.acme_domains)

    acme_challenge              = var.acme_challenge
    acme_delay_before_check     = var.acme_delay_before_check
    acme_dns_provider           = var.acme_dns_provider
    acme_dns_provider_variables = local.acme_dns_provider_variables

    dashboard_enabled             = var.dashboard_enabled
    dashboard_domain              = var.dashboard_domain
    dashboard_service_type        = var.dashboard_service_type
    dashboard_service_annotations = jsonencode(var.dashboard_service_annotations)
    dashboard_ingress_annotations = jsonencode(var.dashboard_ingress_annotations)
    dashboard_ingress_labels      = jsonencode(var.dashboard_ingress_labels)
    dashboard_ingress_tls         = jsonencode(var.dashboard_ingress_tls)
    dashboard_auth                = jsonencode(var.dashboard_auth)
    dashboard_recent_errors       = var.dashboard_recent_errors

    prometheus_enabled             = var.prometheus_enabled
    prometheus_buckets             = jsonencode(var.prometheus_buckets)
    prometheus_service_name        = var.prometheus_service_name
    prometheus_service_annotations = jsonencode(var.prometheus_service_annotations)
    prometheus_service_port        = var.prometheus_service_port
    prometheus_service_type        = var.prometheus_service_type

    env               = jsonencode(var.env)
    startup_arguments = jsonencode(var.startup_arguments)
    security_context  = jsonencode(var.security_context)

    use_non_priviledged_ports = var.use_non_priviledged_ports

    traefik_log_format  = var.traefik_log_format
    access_logs_enabled = var.access_logs_enabled
    access_logs_filters = jsonencode(var.access_logs_filters)
    access_log_format   = var.access_log_format

    datadog_enabled       = var.datadog_enabled
    datadog_address       = var.datadog_address
    datadog_push_interval = var.datadog_push_interval

    statsd_enabled       = var.statsd_enabled
    statsd_address       = var.statsd_address
    statsd_push_interval = var.statsd_push_interval

    tracing_enabled      = var.tracing_enabled
    tracing_service_name = var.tracing_service_name
    tracing_backend      = var.tracing_backend
    tracing_settings     = var.tracing_enabled == "true" ? "${var.tracing_backend}: ${jsonencode(var.tracing_settings)}" : ""

    secret_files = jsonencode(var.secret_files)
    config_files = jsonencode(var.config_files)

    kv_store_acme            = var.kv_store_acme
    kv_acme_storage_location = var.kv_acme_storage_location

    extra_volumes       = jsonencode(var.extra_volumes)
    extra_volume_mounts = jsonencode(var.extra_volume_mounts)

    autoscaling = var.autoscaling_enable ? jsonencode(local.autoscaling) : "null"
  }
}
