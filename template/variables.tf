# release.mozilla.org configuration

variable "github_token" {}
variable "acm_certificate" {}

# AWS variables

variable "aws_profile" {}

variable "aws_region" {
  default = "us-west-2"
}

variable "aws_credentials_file" {
  default = "~/.aws/credentials"
}

variable "service_name" {
  default = "webops-REPLACE_ME"
}

variable "source_repository" {
  type    = "map"
  default = {
    "https_url"   = "https://github.com/mozilla/REPLACE_ME.git",
    "owner"       = "REPLACE_ME"
    "name"        = "REPLACE_ME"
    "branch"      = "REPLACE_ME"
  }
}

variable "website_domains" {
  type    = "list"
  default = [
    "REPLACE_ME",
  ]
}

variable "description" {
  default = "REPLACE_ME"
}

variable "build_container" {
  default = "REPLACE_ME"
}

variable "webops_tags" {
  type = "map"
  default = {
    ServiceName      = "webops-release-mozilla-org"
    TechnicalContact = "infra-webops@mozilla.com"
    Environment      = "prod"
    Purpose          = "website"
  }
}
