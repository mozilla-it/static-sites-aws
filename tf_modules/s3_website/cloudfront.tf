resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.prod_bucket.website_endpoint
    origin_id   = "origin-${aws_s3_bucket.prod_bucket.id}"

    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port              = 80
      https_port             = 443
      origin_ssl_protocols   = ["TLSv1.2", "TLSv1.1", "TLSv1"]
    }
  }

  enabled             = true
  comment             = var.description
  default_root_object = "index.html"

  aliases = flatten([var.website_domains, "${var.service_name}.it-cdn.webops.mozilla.org"])

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "origin-${aws_s3_bucket.prod_bucket.id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = var.protocol_policy
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 3600
    compress               = true

    dynamic "lambda_function_association" {
      for_each = var.lambda_function_association
      content {
        event_type   = lambda_function_association.value.event_type
        include_body = lambda_function_association.value.include_body
        lambda_arn   = lambda_function_association.value.lambda_arn
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate
    ssl_support_method  = "sni-only"
  }

  tags = var.webops_tags

  dynamic "ordered_cache_behavior" {
    for_each = var.ordered_cache_behavior
    content {
      allowed_methods        = ordered_cache_behavior.value.allowed_methods
      cached_methods         = ordered_cache_behavior.value.cached_methods
      compress               = ordered_cache_behavior.value.compress
      default_ttl            = ordered_cache_behavior.value.default_ttl
      max_ttl                = ordered_cache_behavior.value.max_ttl
      min_ttl                = ordered_cache_behavior.value.min_ttl
      path_pattern           = ordered_cache_behavior.value.path_pattern
      smooth_streaming       = ordered_cache_behavior.value.smooth_streaming
      target_origin_id       = ordered_cache_behavior.value.target_origin_id
      viewer_protocol_policy = ordered_cache_behavior.value.viewer_protocol_policy

      dynamic "forwarded_values" {
        for_each = ordered_cache_behavior.value.forwarded_values
        content {
          headers                 = forwarded_values.value.headers
          query_string            = forwarded_values.value.query_string
          query_string_cache_keys = forwarded_values.value.query_string_cache_keys

          dynamic "cookies" {
            for_each = forwarded_values.value.cookies
            content {
              forward           = cookies.value.forward
              whitelisted_names = cookies.value.whitelisted_names
            }
          }
        }
      }
    }
  }
}
