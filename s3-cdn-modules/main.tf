# ----------------------
# S3 Module
# ----------------------
module "s3" {
  source            = "./modules/s3"
  bucket_name       = var.bucket_name  # base name, random suffix added inside module
  enable_versioning = var.enable_versioning
#  cloudfront_distribution_arn = var.cloudfront_distribution_arn
  distribution_arn = module.cdn.distribution_arn  # Pass the ARN from the CDN module

}

# ----------------------
# IAM Module
# ----------------------
module "iam" {
  source     = "./modules/iam"
  iam_user_name = var.iam_user_name
  s3_bucket_arn = module.s3.bucket_arn
  cloudfront_distribution_arn = module.cdn.distribution_arn
}


# ----------------------
# CDN Module
# ----------------------
module "cdn" {
  source      = "./modules/cdn"
  bucket_name = module.s3.bucket_name  # includes random suffix
  bucket_arn  = module.s3.bucket_arn
  bucket_regional_domain_name = module.s3.bucket_regional_domain_name
}