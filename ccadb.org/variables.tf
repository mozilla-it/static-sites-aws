# ccadb.org configuration

variable "github_token"    {}
variable "acm_certificate" {}
variable "lambda_arn"      {}

variable "service_name" {
  default = "webops-ccadb-org"
}

variable "source_repository" {
  type    = "map"
  default = {
    "https_url"   = "https://github.com/mozilla/www.ccadb.org.git",
    "owner"       = "mozilla"
    "name"        = "www.ccadb.org"
    "branch"      = "gh-pages"
  }
}

variable "website_domains" {
  type    = "list"
  default = [
    "ccadb.allizom.org",
    "ccadb.org"
  ]
}

variable "description" {
  default = "The Common CA Database"
}

variable "build_container" {
  default = "jekyll/jekyll:latest"
}

variable "webops_tags" {
  type = "map"
  default = {
    ServiceName      = "webops-ccadb-org"
    TechnicalContact = "infra-webops@mozilla.com"
    Environment      = "prod"
    Purpose          = "website"
  }
}
