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
  default = "webops-trackertest"
}

variable "source_repository" {
  type    = "map"
  default = {
    "https_url"   = "https://github.com/mozilla/trackertest.git",
    "owner"       = "mozilla"
    "name"        = "trackertest"
    "branch"      = "master"
  }
}

variable "website_domains" {
  type    = "list"
  default = [
    "trackertest.org",
    "itisatracker.com",
    "itisatracker.org"
  ]
}

variable "description" {
  default = "Test domain for tracking protection: https://trackertest.org"
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
