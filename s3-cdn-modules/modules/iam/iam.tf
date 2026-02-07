resource "aws_iam_user" "s3_cdn_user" {
  name = var.iam_user_name

}

resource "aws_iam_policy" "s3_cdn_policy" {
  name        = "s3_cdn_policy"
  description = "Policy to allow S3 and CloudFront access"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "S3DeploymentAccess",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:DeleteObject",
                "s3:ListBucket"
            ],
            "Resource": [
                var.s3_bucket_arn,
                "${var.s3_bucket_arn}/*"
            ]
        },
        {
            "Sid": "CloudFrontInvalidationAccess",
            "Effect": "Allow",
            "Action": "cloudfront:CreateInvalidation",
            "Resource": var.cloudfront_distribution_arn != "" ? var.cloudfront_distribution_arn : "*"
        }
    ]
})

}

resource "aws_iam_user_policy_attachment" "s3_cdn_attachment" {
  user       = aws_iam_user.s3_cdn_user.name
  policy_arn = aws_iam_policy.s3_cdn_policy.arn
}