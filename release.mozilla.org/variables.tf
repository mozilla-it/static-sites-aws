# release.mozilla.org configuration

variable "github_token" {}
variable "acm_certificate" {}

variable "service_name" {
  default = "webops-release-mozilla-org"
}

variable "source_repository" {
  type    = "map"
  default = {
    "https_url"   = "https://github.com/mozilla/release-blog.git",
    "owner"       = "mozilla"
    "name"        = "release-blog"
    "branch"      = "gh-pages"
  }
}

variable "website_domains" {
  type    = "list"
  default = [
    "release.allizom.org",
    "release.mozilla.org"
  ]
}

variable "description" {
  default = "The Mozilla Release blog"
}

variable "build_container" {
  default = "jekyll/jekyll:latest"
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
