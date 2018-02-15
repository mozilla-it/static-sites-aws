# Module outputs

output "prod_website_endpoint" {
  value = "${aws_s3_bucket.prod_bucket.website_endpoint}"
}

output "prod_bucket_name" {
  value = "${aws_s3_bucket.prod_bucket.id}"
}
