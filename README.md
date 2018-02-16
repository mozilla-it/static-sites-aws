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

This should go into a `main.tf` file in a new folder that is named for the site.
The parameters like `source_repository` should be passed in through the
`variables.tf` file.
