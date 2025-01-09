resource "aws_cloudfront_distribution" "cloudfront" {
  origin {
    domain_name = "bucket-pedrovargas.s3.us-east-1.amazonaws.com"
    origin_id   = "bucket-pedrovargas"
  }

  enabled = true

  default_cache_behavior {
    target_origin_id = "bucket-pedrovargas"

    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]


    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  web_acl_id = aws_wafv2_web_acl.waf.arn

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
