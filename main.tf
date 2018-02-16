# Setup provider

provider "aws" {
  region                  = "us-west-2"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "it-cdn"
}

# Load configuration files from template

data "template_file" "buildspec" {
  template = "${file("./buildspec.yml")}"

  vars {
    bucket_name       = "${module.release_mozilla_org.prod_bucket_name}"
    source_repository = "${var.source_repository}"
  }
}

# Create resources

module "jekyll_blog" {
  source      = "./modules/s3-website"
  description = "${var.description}"

  # S3
  service_name   = "${var.service_name}"

  # CloudFront
  website_domains = "${var.website_domains}"

  # CodeBuild
  container         = "${var.build_container}"
  buildspec         = "${data.template_file.buildspec.rendered}"
  source_repository = "${var.source_repository}"
}
