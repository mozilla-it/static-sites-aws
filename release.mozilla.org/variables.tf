# release.mozilla.org configuration

variable "service_name" {
  default = "webops-release-mozilla-org"
}

variable "source_repository" {
  default = "https://github.com/mozilla/release-blog.git"
}

variable "website_domains" {
  type    = "list"
  default = [
    "release.allizom.org"
  ]
}

variable "description" {
  default = "The Mozilla Release blog"
}

variable "build_container" {
  default = "jekyll/jekyll:latest"
}
