terraform {
  backend "s3" {
    bucket  = "webops-terraform-shared-state"
    region  = "us-west-2"
    key     = "websites/static/publicsuffix/terraform.tfstate"
  }
}
