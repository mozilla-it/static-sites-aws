variable "description"       {}
variable "container"         {}
variable "service_name"      {}
variable "buildspec"         {}
variable "github_token"      {}

variable "website_domains" {
  type = "list"
}

variable "source_repository" {
  type = "map"
}
