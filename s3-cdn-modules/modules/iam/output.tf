output "iam_user_name" {
  description = "The name of the IAM user"
  value       = aws_iam_user.s3_cdn_user.name
  
}

output "iam_user_arn" {
  description = "The ARN of the IAM user"
  value       = aws_iam_user.s3_cdn_user.arn

}