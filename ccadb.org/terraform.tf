terraform {
  backend "s3" {
    bucket  = "webops-ccadb-terraform-shared-state"
    region  = "us-east-1"
    key     = "websites/static/ccadb_org/terraform.tfstate"
  }
}
