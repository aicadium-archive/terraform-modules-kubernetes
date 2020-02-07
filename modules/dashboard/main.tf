terraform {
  required_providers {
    helm = ">= 1.0"
  }
}

resource "helm_release" "dashboard" {
  depends_on = [kubernetes_secret.kubernetes_dashboard_key_holder]

  name       = var.dashboard_release_name
  chart      = var.dashboard_chart_name
  repository = var.dashboard_chart_repository
  version    = var.dashboard_chart_version
  namespace  = var.dashboard_namespace

  max_history = var.max_history

  values = [
    data.template_file.dashboard.rendered,
  ]
}

data "template_file" "dashboard" {
  template = file("${path.module}/templates/dashboard.yaml")

  vars = {
    image     = var.dashboard_image
    tag       = var.dashboard_tag
    replica   = var.dashboard_replica
    resources = jsonencode(var.dashboard_resources)

    tolerations = jsonencode(var.dashboard_tolerations)
    affinity    = jsonencode(var.dashboard_affinity)
    pdb         = indent(2, var.dashboard_pdb)

    annotations         = jsonencode(var.dashboard_annotations)
    labels              = jsonencode(var.dashboard_labels)
    pod_annotations     = jsonencode(var.dashboard_pod_annotations)
    service_annotations = jsonencode(var.dashboard_service_annotations)
    service_labels      = jsonencode(var.dashboard_service_labels)

    cluster_admin_role     = var.dashboard_cluster_admin ? "true" : "false"
    cluster_read_only_role = var.dashboard_cluster_admin ? "false" : "true"
    enable_skip_login      = var.dashboard_enable_skip_login
  }
}

# Create missing secrets
resource "kubernetes_secret" "kubernetes_dashboard_key_holder" {
  metadata {
    name      = "kubernetes-dashboard-key-holder"
    namespace = var.dashboard_namespace
  }

  # Dummy data
  data = {
    foo = "bar"
  }

  lifecycle {
    ignore_changes = [data]
  }
}

# See https://stackoverflow.com/a/47796023
resource "kubernetes_role" "dashboard_viewer" {
  metadata {
    name      = var.dashboard_viewer_role
    namespace = var.dashboard_namespace
  }

  rule {
    api_groups = [""]
    resources = [
      "services"
    ]
    verbs = [
      "get",
      "list",
      "watch",
    ]
  }

  rule {
    api_groups = [""]
    resources = [
      "services/proxy",
    ]
    verbs = [
      "get",
      "list",
      "watch",
      "create",
    ]
  }
}

resource "kubernetes_role_binding" "dashboard_viewer" {
  count = length(var.dashboard_viewers) > 0 ? 1 : 0


  metadata {
    name      = var.dashboard_viewer_role
    namespace = var.dashboard_namespace
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.dashboard_viewer.metadata[0].name
  }

  dynamic "subject" {
    for_each = var.dashboard_viewers

    content {
      name = subject.value.name
      kind = subject.value.kind

      namespace = lookup(subject.value, "namespace", null)
      api_group = lookup(subject.value, "api_group", null)
    }
  }
}
