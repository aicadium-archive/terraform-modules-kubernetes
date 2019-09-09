variable "bulldozer_image_name" {
  description = "Image name for the bot image"
  default     = "palantirtechnologies/bulldozer"
}

variable "bulldozer_image_tag" {
  description = "Image tag for the bot image"
  default     = "1.7.0"
}

variable "bulldozer_release_name" {
  description = "Release name"
  default     = "bulldozer"
}

variable "bulldozer_chart_name" {
  description = "Name of the chart to use"
  default     = "bulldozer-bot"
}

variable "bulldozer_chart_version" {
  description = "Version of the chart"
  default     = "0.1.11"
}

variable "bulldozer_chart_repository" {
  description = "Repository holding the chart"
  default     = "amoy"
}

variable "replicas" {
  description = "Replica count for the bot"
  default     = 1
}

variable "bulldozer_ingress_enabled" {
  description = "Whether ingress is enabled"
  default     = false
}

variable "bulldozer_ingress_annotations" {
  description = "Annotation for ingress object"
  default     = {}
}

variable "bulldozer_service_annotations" {
  description = "Annotation for service object"
  default     = {}
}

variable "bulldozer_ingress_host" {
  description = "Ingress host name"
}

variable "bulldozer_github_integration_id" {
  description = "Github app id for Bulldozer app"
}

variable "bulldozer_github_webhook_secret" {
  description = "Github webhook secret for Bulldozer app"
}

variable "bulldozer_github_private_key_pem" {
  description = "Github private key for Bulldozer app"
}

variable "fullname_override" {
  description = "Fullname for Bulldozer deployment"
  default     = null
}

variable "name_override" {
  description = "Name for Bulldozer deployment"
  default     = null
}
