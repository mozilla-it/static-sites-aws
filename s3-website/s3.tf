# Production website bucket

resource "aws_s3_bucket" "prod_bucket" {
  bucket = "${var.service_name}-prod"
  acl    = "${var.acl}"

  website {
    index_document = "${var.index_document}"
  }

  logging {
    target_bucket = "${aws_s3_bucket.log_bucket.id}"
    target_prefix = "${var.service_name}-prod-logs/"
  }

  tags {
    ServiceName      = "release.mozilla.org"
    TechnicalContact = "infra-webops@mozilla.com"
    Environment      = "stage"
    Purpose          = "website"
  }
}

# S3 bucket access log storage

resource "aws_s3_bucket" "log_bucket" {
  bucket = "${var.service_name}-logs"
  acl    = "log-delivery-write"

  tags {
    ServiceName      = "release.mozilla.org"
    TechnicalContact = "infra-webops@mozilla.com"
    Environment      = "stage"
    Purpose          = "website"
  }
}
