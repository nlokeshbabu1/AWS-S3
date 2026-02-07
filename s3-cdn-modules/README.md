# AWS S3 + CloudFront Terraform Modules

This repository contains Terraform modules for deploying a static website infrastructure on AWS using S3 and CloudFront. The modules are organized to provide reusable components for creating S3 buckets, CloudFront distributions, and IAM users with appropriate policies.

## Module Structure

The infrastructure is divided into three main modules:

### 1. S3 Module (`modules/s3`)
Creates and configures an S3 bucket for hosting static website content with the following features:
- Random ID suffix for unique bucket names
- Public access block to secure the bucket
- Versioning support (configurable)

**Variables:**
- `bucket_name` (string) - Base name for the S3 bucket
- `enable_versioning` (bool) - Whether to enable versioning on the bucket

**Outputs:**
- `bucket_name` - The name of the created S3 bucket
- `bucket_arn` - The ARN of the created S3 bucket

### 2. CDN Module (`modules/cdn`)
Sets up a CloudFront distribution to serve content from the S3 origin with global caching capabilities.

**Variables:**
- `bucket_name` (string) - Name of the S3 bucket to use as origin
- `bucket_arn` (string) - ARN of the S3 bucket to use as origin

### 3. IAM Module (`modules/iam`)
Creates an IAM user with a policy granting necessary permissions for S3 and CloudFront operations.

**Variables:**
- `iam_user_name` (string) - Name for the IAM user
- `s3_bucket_arn` (string) - ARN of the S3 bucket for policy permissions

**Outputs:**
- `iam_user_name` - The name of the created IAM user
- `iam_user_arn` - The ARN of the created IAM user

## Prerequisites

Before running these Terraform modules, ensure you have:

1. **Terraform** installed (v1.0 or later)
2. **AWS CLI** configured with appropriate credentials
3. An AWS account with permissions to create S3 buckets, CloudFront distributions, and IAM resources

## How to Use the Modules

### 1. Initialize Terraform

Navigate to your Terraform configuration directory and initialize:

```bash
terraform init
```

### 2. Create a Terraform Configuration

Create a `main.tf` file that references the modules:

```hcl
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
```

### 3. Define Variables

Create a `variables.tf` file to define your inputs:

```hcl
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
```

### 4. Configure Provider

Create a `provider.tf` file:

```hcl
provider "aws" {
  region = var.region
}
```

### 5. Plan and Apply

Run the following commands to plan and apply your infrastructure:

```bash
# Review the execution plan
terraform plan \
  -var="bucket_name=my-unique-bucket-name" \
  -var="region=us-west-2"

# Apply the changes
terraform apply \
  -var="bucket_name=my-unique-bucket-name" \
  -var="region=us-west-2"
```

Alternatively, you can create a `terraform.tfvars` file to store your variable values:

```hcl
bucket_name = "my-unique-bucket-name"
region = "us-west-2"
enable_versioning = true
```

Then simply run:

```bash
terraform plan
terraform apply
```

### 6. Outputs

After successful deployment, Terraform will display outputs showing the created resources:

- S3 bucket name and ARN
- IAM user name and ARN
- CloudFront distribution details (when implemented)

## Destroying Resources

To remove all created resources:

```bash
terraform destroy
```

## Best Practices

1. **State Management**: Store your Terraform state remotely using S3 backend for team collaboration
2. **Variable Validation**: Validate your variable values before applying
3. **Access Control**: Limit IAM permissions to the minimum required for operations
4. **Naming Conventions**: Use consistent naming for resources across modules
5. **Versioning**: Pin module versions in production environments

## Security Considerations

- The IAM policy grants specific permissions for S3 and CloudFront operations
- S3 buckets are created with public access blocked by default
- Use AWS Secrets Manager or SSM Parameter Store for sensitive values in production

## Troubleshooting

Common issues and solutions:

- **Bucket name conflicts**: S3 bucket names must be globally unique; the module adds a random suffix to prevent conflicts
- **Region limitations**: Some CloudFront features may have regional restrictions
- **Permission errors**: Ensure your AWS credentials have sufficient permissions to create all resource types