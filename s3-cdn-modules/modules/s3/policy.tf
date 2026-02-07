/*
# Policy with specific CloudFront distribution ARN restriction
resource "aws_s3_bucket_policy" "s3_cdn_policy_with_arn" {
  count  = var.cloudfront_distribution_arn != "" ? 1 : 0
  bucket = aws_s3_bucket.s3-blog.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipal",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.s3-blog.arn}/*",
            "Condition": {
                "ArnLike": {
                    "AWS:SourceArn": var.cloudfront_distribution_arn
                }
            }
        }
    ]
  })
}

# Policy without ARN restriction (more permissive) - used when ARN is not provided
resource "aws_s3_bucket_policy" "s3_cdn_policy_without_arn" {
  count  = var.cloudfront_distribution_arn == "" ? 1 : 0
  bucket = aws_s3_bucket.s3-blog.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipal",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.s3-blog.arn}/*"
        }
    ]
  })
}
*/

resource "aws_s3_bucket_policy" "cdn_policy" {
  bucket = aws_s3_bucket.s3-blog.id

  policy = jsonencode({
    Version = "2008-10-17"
    Id      = "PolicyForCloudFrontPrivateContent"
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipal"
        Effect    = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.s3-blog.arn}/*"
        Condition = {
          ArnLike = {
#            "AWS:SourceArn" = "${var.aws_cloudfront_distribution_arn}"
            "AWS:SourceArn" = "${var.distribution_arn}"
          }
        }
      }
    ]
  })
}
