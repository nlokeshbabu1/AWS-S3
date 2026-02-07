variable "bucket_name" {
  description = "The name of the S3 bucket to be used as the origin for the CDN."
  type        = string
  
}

variable "bucket_arn" {
  description = "The ARN of the S3 bucket to be used as the origin for the CDN."
  type        = string
  
}

variable "bucket_regional_domain_name" {
  type = string
}