variable "iam_user_name" {
    description = "value for aws iam user"
    type = string

}

variable "s3_bucket_arn" {
    description = "ARN of the S3 bucket"
    type = string

}

variable "cloudfront_distribution_arn" {
    description = "ARN of the CloudFront distribution for policy permissions"
    type = string
    default = ""  # Default to empty string if not provided
}