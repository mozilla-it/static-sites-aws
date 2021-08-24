# publicsuffix.org configuration

# Token is available in 1password
variable "github_token" {}
variable "acm_certificate" {
  default = "arn:aws:acm:us-east-1:369987351092:certificate/7e7179c2-a681-4096-9858-9cbd8ecc303e"
}

# AWS variables

variable "aws_region" {
  default = "us-east-1"
}

variable "aws_credentials_file" {
  default = "~/.aws/credentials"
}

variable "service_name" {
  default = "webops-publicsuffix"
}

variable "source_repository" {
  type = map
  default = {
    "https_url"           = "https://github.com/publicsuffix/publicsuffix.org",
    "https_url_secondary" = "https://github.com/publicsuffix/list",
    "owner"               = "publicsuffix"
    "name"                = "publicsuffix.org"
    "branch"              = "master"
  }
}

variable "website_domains" {
  type = list
  default = [
    "publicsuffix.org",
    "www.publicsuffix.org",
  ]
}

variable "description" {
  default = "publicsuffix.org"
}

variable "build_container" {
  default = "aws/codebuild/ubuntu-base:14.04"
}

variable "webops_tags" {
  type = map
  default = {
    ServiceName      = "webops-release-mozilla-org"
    TechnicalContact = "infra-webops@mozilla.com"
    Environment      = "prod"
    Purpose          = "website"
  }
}

variable "ordered_cache_behavior" {
  type = list
  default = [
    {
      allowed_methods        = ["GET", "HEAD", "OPTIONS"]
      cached_methods         = ["GET", "HEAD"]
      compress               = true
      default_ttl            = 3600
      max_ttl                = 3600
      min_ttl                = 0
      path_pattern           = "/list/public_suffix_list.dat"
      smooth_streaming       = false
      viewer_protocol_policy = "redirect-to-https"
      target_origin_id       = "origin-webops-publicsuffix"
      forwarded_values = [{
        headers                 = []
        query_string            = false
        query_string_cache_keys = []
        cookies = [{
          forward           = "none"
          whitelisted_names = []
        }]
      }]
    },
    {
      allowed_methods        = ["GET", "HEAD", "OPTIONS"]
      cached_methods         = ["GET", "HEAD"]
      compress               = true
      default_ttl            = 3600
      max_ttl                = 3600
      min_ttl                = 0
      path_pattern           = "/list/effective_tld_names.dat"
      smooth_streaming       = false
      viewer_protocol_policy = "redirect-to-https"
      target_origin_id       = "origin-webops-publicsuffix"
      forwarded_values = [{
        headers                 = []
        query_string            = false
        query_string_cache_keys = []
        cookies = [{
          forward           = "none"
          whitelisted_names = []
        }]
      }]
    }
  ]
}
