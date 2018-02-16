# Production website bucket

resource "aws_s3_bucket" "prod_bucket" {
  bucket = "${var.service_name}-prod"
  acl    = "public-read"

  website {
    index_document = "index.html"
  }

  logging {
    target_bucket = "${aws_s3_bucket.log_bucket.id}"
    target_prefix = "${var.service_name}-prod-logs/"
  }

  tags = "${var.webops_tags}"
}

# S3 bucket access log storage

resource "aws_s3_bucket" "log_bucket" {
  bucket = "${var.service_name}-logs"
  acl    = "log-delivery-write"
  tags = "${var.webops_tags}"
}
