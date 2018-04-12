# Setup provider

provider "aws" {
  region                  = "${var.aws_region}"
  shared_credentials_file = "${var.aws_credentials_file}"
  profile                 = "${var.aws_profile}"
}

# Load configuration files from template

data "template_file" "buildspec" {
  template = "${file("./buildspec.yml")}"

  vars {
    bucket_name       = "${module.jekyll_blog.prod_bucket_name}"
    source_repository = "${var.source_repository["https_url"]}"
  }
}

# Create resources

module "static_site" {
  source            = "../tf_modules/s3_website"
  service_name      = "${var.service_name}"
  description       = "${var.description}"
  source_repository = "${var.source_repository}"
  website_domains   = "${var.website_domains}"
  container         = "${var.build_container}"
  buildspec         = "${data.template_file.buildspec.rendered}"
  github_token      = "${var.github_token}"
  acm_certificate   = "${var.acm_certificate}"
  webops_tags       = "${var.webops_tags}"
}
