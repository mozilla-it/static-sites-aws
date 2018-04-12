terraform {
  backend "s3" {
    bucket  = "webops-terraform-shared-state"
    region  = "us-east-1"
    key     = "websites/static/trackertest/terraform.tfstate"
  }
}
