resource "aws_cloudfront_origin_access_control" "this" {
  name        = "${var.bucket_name}-oac"
  description = "Origin Access Control for S3 bucket ${var.bucket_name}"
  origin_access_control_origin_type = "s3"
  signing_protocol = "sigv4"
  signing_behavior = "always"
}

resource "aws_cloudfront_distribution" "s3-cdn" {
    enabled             = true
    is_ipv6_enabled     = true
    comment             = "CDN Distribution for S3 bucket ${var.bucket_name}"
    default_root_object = "index.html"
    
    origin {
#        domain_name = "${var.bucket_name}.s3.amazonaws.com"
        origin_id   = "S3-${var.bucket_name}"
        domain_name =  var.bucket_regional_domain_name
        origin_access_control_id = aws_cloudfront_origin_access_control.this.id

        s3_origin_config {
            origin_access_identity = ""
        }
    }
    
    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD", "OPTIONS"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "S3-${var.bucket_name}"
    
        forwarded_values {
        query_string = false
        cookies {
            forward = "none"
        }
        }
    
        viewer_protocol_policy = "redirect-to-https"
        min_ttl                = 0  #TTL = how long CloudFront keeps a cached object before checking S3 for updates.
        default_ttl            = 3600  #
        max_ttl                = 86400
    }
    
    restrictions {
        geo_restriction {
        restriction_type = "none"
        }
    }
    
    viewer_certificate {
        cloudfront_default_certificate = true
    }
  
}