data "helm_repository" "kube_janitor" {
  name = var.kube_janitor_chart_repository
  url  = var.kube_janitor_chart_repository_url
}
