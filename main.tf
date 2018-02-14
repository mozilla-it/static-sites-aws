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
    source_repository = "https://github.com/mozilla/release-blog.git"
  }
}

# Create resources

module "release_mozilla_org" {
  source      = "./modules/s3-website"
  description = "The Mozilla Release blog"

  # S3
  service_name   = "webops-release-mozilla-org"
  index_document = "index.html"
  acl            = "public-read"

  # CloudFront
  website_domains = ["release.allizom.org"]

  # CodeBuild
  container         = "jekyll/jekyll:latest"
  buildspec         = "${data.template_file.buildspec.rendered}"
  source_repository = "https://github.com/mozilla/release-blog.git"
}
