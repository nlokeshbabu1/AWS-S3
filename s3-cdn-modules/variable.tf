variable "region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Base name for the S3 bucket"
  type        = string
}

variable "enable_versioning" {
  description = "Enable S3 bucket versioning"
  type        = bool
  default     = true
}

variable "iam_user_name" {
  description = "Name for the IAM user"
  type        = string
}

variable "cloudfront_distribution_arn" {
  description = "ARN of the CloudFront distribution for policy permissions"
  type        = string
  default     = ""  # Default to empty string if not provided
  
}

/*
# Backend configuration variables (for production use)
variable "backend_bucket" {
  description = "S3 bucket name for storing Terraform state"
  type        = string
  default     = ""  # Leave empty for local state
}

variable "backend_key" {
  description = "S3 key for storing Terraform state"
  type        = string
  default     = "s3-cdn-modules/terraform.tfstate"
}

variable "backend_region" {
  description = "AWS region for the S3 bucket storing Terraform state"
  type        = string
  default     = "us-east-1"
}
*/
