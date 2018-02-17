# Setup provider

provider "aws" {
  region                  = "us-west-2"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "daniel"
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

module "jekyll_blog" {
  source            = "../tf_modules/s3_website"
  service_name      = "${var.service_name}"
  description       = "${var.description}"
  source_repository = "${var.source_repository}"
  website_domains   = "${var.website_domains}"
  container         = "${var.build_container}"
  buildspec         = "${data.template_file.buildspec.rendered}"
  github_token      = "${var.github_token}"
}
