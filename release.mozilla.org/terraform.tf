terraform {
  backend "s3" {
    bucket  = "webops-terraform-state-prod"
    region  = "us-west-2"
    key     = "websites/static/webops-release-mozilla-org/terraform.tfstate"
    profile = "daniel"
  }
}
