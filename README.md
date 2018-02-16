# S3 website hosting

### Summary

This Terraform module allows us to quickly build and manage our websites that
are hosted in the AWS S3 service.

### Future enhancements

The module itself will probably be moved into an isolated repository to enable
tagged releases.

### Usage

A simple site could be configured with the following module snippet:

```
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
```

In addition to this, you would want to prepare a template that Terraform can
render and pass into the `buildspec` parameter. You will also want to update the
`terraform.tf` file to include your Terraform shared state backend
configuration.
