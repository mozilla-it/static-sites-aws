variable "description" {}
variable "container" {}
variable "service_name" {}
variable "buildspec" {}
variable "github_token" {}
variable "acm_certificate" {}

variable "protocol_policy" {
  default = "redirect-to-https"
}

variable "website_domains" {
  type = list
}

variable "source_repository" {
  type = map
}

variable "webops_tags" {
  type = map
}

variable "ordered_cache_behavior" {
  type = list
}

variable "lambda_function_association" {
  type = list
}
