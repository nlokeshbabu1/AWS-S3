output "bucket_name" {
    description = "The name of the S3 bucket"
    value       = aws_s3_bucket.s3-blog.id

}

output "bucket_arn" {
    description = "The ARN of the S3 bucket"
    value       = aws_s3_bucket.s3-blog.arn
  
}

output "bucket_regional_domain_name" {
    description = "The regional domain name of the S3 bucket"
    value       = aws_s3_bucket.s3-blog.bucket_regional_domain_name
  
}
