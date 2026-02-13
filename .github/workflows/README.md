# Infrastructure as Code (IaC) CI/CD Pipeline

This GitHub Actions workflow automates the deployment of infrastructure resources and application files to AWS using Terraform and AWS CLI.

## Overview

The `Iac.yml` workflow is triggered on pushes to the `main` branch when changes are made to files in the `s3-cdn-modules/` directory. It performs infrastructure provisioning and application deployment in two main jobs:

1. **Terraform Job**: Creates and manages AWS infrastructure resources
2. **Deploy_to_s3 Job**: Deploys application files to the provisioned S3 bucket

## Workflow Configuration

### Trigger Events
- Runs on `push` events to the `main` branch
- Specifically triggers when files in the `s3-cdn-modules/**` path are modified

### Permissions
- `id-token: write`: Required for requesting JWT tokens for AWS OIDC authentication
- `contents: read`: Required for checking out the repository code

### Concurrency
- `group: terraform`: Ensures only one instance of this workflow runs at a time to prevent conflicts during Terraform operations
- `cancel-in-progress: false`: Prevents cancellation of running workflows, ensuring Terraform operations complete safely

## Jobs

### 1. Terraform Job

This job handles the creation and management of AWS infrastructure resources using Terraform.

#### Steps:
- **Checkout Code**: Retrieves the repository code
- **Setup Terraform**: Installs the latest version of Terraform
- **Configure AWS Credentials**: Authenticates with AWS using IAM roles and secrets
- **Initialize Terraform**: Prepares the working directory for other commands
- **Validate Configuration**: Checks for syntax errors in Terraform files
- **Format Check**: Ensures Terraform code follows proper formatting standards
- **Plan Changes**: Generates an execution plan showing what resources will be created/modified
- **Apply Changes**: Applies the plan to create/modify infrastructure (only on main branch)
- **Get Outputs**: Extracts the S3 bucket name and CloudFront domain name for use in the next job

#### Environment Variables Required:
- `ACCOUNT_NUMBER`: AWS account number
- `AWS_REGION`: Target AWS region

### 2. Deploy_to_s3 Job

This job deploys application files to the S3 bucket created in the previous job and invalidates the CloudFront cache.

#### Dependencies:
- Waits for the Terraform job to complete successfully
- Requires the `production` environment to be configured in GitHub

#### Steps:
- **Checkout Code**: Retrieves the repository code
- **Configure AWS Credentials**: Authenticates with AWS using IAM roles and secrets
- **Sync Files to S3**: Uploads specific files (`index.html`, `style.css`, `script.js`) to the S3 bucket
- **Invalidate CloudFront Cache**: Clears the CDN cache to serve fresh content

## Security

- Uses AWS IAM roles with OIDC authentication for secure credential management
- Leverages GitHub Secrets for sensitive information like account numbers and regions
- Implements proper AWS region configuration through secrets

## File Deployment

The workflow specifically syncs only these files to the S3 bucket:
- `index.html`
- `style.css`
- `script.js`

Other files are excluded from the deployment to maintain security and efficiency.

## Output Variables

The workflow exports these important values:
- `s3_bucket_name`: Name of the created S3 bucket
- `cloudfront_domain_name`: Domain name of the CloudFront distribution
- `cloudfront_distribution_id`: ID of the CloudFront distribution (used for cache invalidation)