# S3 website hosting

### Summary

This Terraform module allows us to quickly build and manage our websites that
are hosted in the AWS S3 service.

### Future enhancements

The module itself will probably be moved into an isolated repository to enable
tagged releases. For now, it's reasonable to keep it alongside the sites we're
managing.

### Usage

A simple site could be configured with the following module snippet:

```
module "jekyll_blog" {
  source      = "../tf_modules/s3_website"
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
```

This should go into a `main.tf` file in a new folder that is named for the site.
The parameters like `source_repository` should be passed in through the
`variables.tf`, in the same folder, file like this:

```
# release.mozilla.org configuration

variable "service_name" {
  default = "webops-release-mozilla-org"
}

variable "source_repository" {
  default = "https://github.com/mozilla/release-blog.git"
}

variable "website_domains" {
  type    = "list"
  default = [
    "release.allizom.org"
  ]
}

variable "description" {
  default = "The Mozilla Release blog"
}

variable "build_container" {
  default = "jekyll/jekyll:latest"
}
```

At this point in time, the `buildspec.yml` needs to be written by us to reflect
the needs of the site we're setting up. Because it can change, I won't be
placing it as a template file in the `s3_website` module itself. We can reflect
on this over time and see if we should change how this works.
