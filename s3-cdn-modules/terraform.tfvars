# AWS Region for deployment
region = "ap-south-2"

# S3 Bucket Configuration
bucket_name       = "my-terraform-s3-cdn-bucket-cicd"
enable_versioning = true

# IAM User Configuration
iam_user_name = "s3-cdn-cicd-user" # CloudFront Distribution ARN (optional, can be left empty if not needed for permissions) cloudfront_distribution_arn = "" # Will be populated by the CDN module output