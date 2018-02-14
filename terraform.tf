terraform {
  backend "s3" {
    bucket = "webops-terraform-remote-state-store"
    region = "us-west-2"
    key    = "prod/websites/static/webops-release-mozilla-org.tfstate"
  }
}
