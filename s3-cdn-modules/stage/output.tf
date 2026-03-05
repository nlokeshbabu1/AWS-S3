output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.s3.bucket_name

}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = module.s3.bucket_arn

}

output "iam_user_name" {
  description = "Name of the IAM user"
  value       = module.iam.iam_user_name

}

output "iam_user_arn" {
  description = "ARN of the IAM user"
  value       = module.iam.iam_user_arn

}

output "cloudfront_distribution_id" {
  description = "ID of the CloudFront distribution"
  value       = module.cdn.distribution_id

}

output "cloudfront_distribution_arn" {
  description = "ARN of the CloudFront distribution"
  value       = module.cdn.distribution_arn

}

output "cloudfront_domain_name" {
  description = "Domain name of the CloudFront distribution"
  value       = module.cdn.domain_name

}