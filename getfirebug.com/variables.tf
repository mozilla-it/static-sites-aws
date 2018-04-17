# getfirebug.com configuration

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
  default = "webops-getfirebug"
}

variable "source_repository" {
  type    = "map"
  default = {
    "https_url"   = "https://github.com/mozilla-it/getfirebug.git",
    "owner"       = "mozilla-it"
    "name"        = "getfirebug"
    "branch"      = "master"
  }
}

variable "website_domains" {
  type    = "list"
  default = [
    "getfirebug.com",
  ]
}

variable "description" {
  default = "getfirebug.com"
}

variable "build_container" {
  default = "aws/codebuild/ubuntu-base:14.04"
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
