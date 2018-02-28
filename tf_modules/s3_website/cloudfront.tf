resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.prod_bucket.website_endpoint}"
    origin_id   = "origin-${aws_s3_bucket.prod_bucket.id}"

    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port              = 80
      https_port             = 443
      origin_ssl_protocols   = ["TLSv1.2", "TLSv1.1", "TLSv1"]
    }
  }

  enabled             = true
  comment             = "${var.description}"
  default_root_object = "index.html"

  aliases = "${var.website_domains}"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "origin-${aws_s3_bucket.prod_bucket.id}"

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 600
    max_ttl                = 600
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${var.acm_certificate}"
    ssl_support_method  = "sni-only"
  }

  tags = "${var.webops_tags}"
}
