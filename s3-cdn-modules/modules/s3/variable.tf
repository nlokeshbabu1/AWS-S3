variable "bucket_name" {
    description = "value for aws s3 bucket"
    type        = string

}

variable "enable_versioning" {
    description = "value for aws s3 bucket versioning"
    type        = bool

}

variable "aws_cloudfront_distribution_arn" {
    description = "ARN of the CloudFront distribution for policy permissions"
    type        = string
    default     = ""  # Default to empty string if not provided
    
}

variable "distribution_arn" {
    description = "ARN of the CloudFront distribution for policy permissions"
    type        = string
    default     = ""  # Default to empty string if not provided
  
}
