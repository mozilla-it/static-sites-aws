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
  default = "webops-itisatrap_org"
}

variable "source_repository" {
  type    = "map"
  default = {
    "https_url"   = "https://github.com/mozilla/itisatrap.git",
    "owner"       = "mozilla"
    "name"        = "itisatrap"
    "branch"      = "master"
  }
}

variable "website_domains" {
  type    = "list"
  default = [
    "www.itisatrap.org",
    "itisatrap.org",
    "flashblock.itisatrap.org",
    "flashallow.itisatrap.org",
    "except.flashsubdoc.itisatrap.org",
    "except.flashallow.itisatrap.org",
    "except.flashblock.itisatrap.org",
    "flashsubdoc.itisatrap.org"
  ]
}

variable "description" {
  default = "'Its a trap' and 'Its an Attack' warning pages that showcase Firefox's phishing and malware protection feature"
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
