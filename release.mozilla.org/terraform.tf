terraform {
  backend "s3" {
    bucket  = "webops-terraform-remote-state-store"
    region  = "us-west-2"
    key     = "websites/static/${var.service_name}/terraform.tfstate"
  }
}
