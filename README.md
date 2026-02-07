# Static Website Deployment: S3 + CloudFront + GitHub Actions

This repository contains a simple static website and a GitHub Actions workflow for automated deployment to an Amazon S3 bucket, optionally fronted by CloudFront.

## Features

- **Static site**: HTML, CSS, and JavaScript files for a responsive landing page.
- **CI/CD**: Automated deployment to AWS S3 on every push to the `main` branch using GitHub Actions.
- **CloudFront ready**: Designed for integration with CloudFront and Origin Access Control (OAC).
- **Terraform modules**: Reusable infrastructure-as-code modules for easy deployment.

## Repository Structure

```
index.html              # Main HTML file
style.css               # Stylesheet
script.js               # Deployment simulation script
LICENSE                 # Apache 2.0 License
.github/
  workflows/
    deploy.yml          # GitHub Actions workflow for S3 deployment
s3-cdn-modules/         # Terraform modules for S3 + CloudFront infrastructure
  ├── modules/
  │   ├── s3/           # S3 bucket module
  │   ├── cdn/          # CloudFront distribution module
  │   └── iam/          # IAM user and policy module
  ├── main.tf           # Main Terraform configuration
  ├── variables.tf      # Variable definitions
  ├── provider.tf       # Provider configuration
  ├── backend.tf        # Backend configuration
  └── terraform.tfvars  # Variable values
```

## Infrastructure as Code (Terraform)

The `s3-cdn-modules` directory contains reusable Terraform modules for deploying the complete S3 + CloudFront infrastructure:

### Module Structure

- **S3 Module**: Creates and configures an S3 bucket for hosting static website content
- **CDN Module**: Sets up a CloudFront distribution to serve content from the S3 origin
- **IAM Module**: Creates an IAM user with appropriate permissions for S3 and CloudFront operations

### Prerequisites

Before using the Terraform modules, ensure you have:

1. **Terraform** installed (v1.0 or later)
2. **AWS CLI** configured with appropriate credentials
3. An AWS account with permissions to create S3 buckets, CloudFront distributions, and IAM resources

### How to Deploy with Terraform

1. Navigate to the s3-cdn-modules directory:
   ```bash
   cd s3-cdn-modules
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review the execution plan:
   ```bash
   terraform plan
   ```

4. Apply the infrastructure:
   ```bash
   terraform apply
   ```

5. To destroy the infrastructure when no longer needed:
   ```bash
   terraform destroy
   ```

## Deployment Workflow

The workflow in [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml) runs on every push to `main` and:

1. Checks out the code.
2. Configures AWS credentials using repository secrets.
3. Syncs files to your S3 bucket.
4. Invalidates CloudFront cache.

## Setup Instructions

### 1. Create an IAM User and Attach Policy

- Go to the [IAM Console](https://console.aws.amazon.com/iam/).
- Click **Users** > **Add users**.
- Enter a username (e.g., `github-actions-deployer`).
- Select **Access key - Programmatic access**.
- Click **Next**

### 2 . Create Policy and Attach Policy to user

- Go to the [IAM Console](https://console.aws.amazon.com/iam/).
- Click **Policies** > **Create Policy**.
- Click on JSON and Copy the below Policy.
- Click **Next** and give name of policy (Eg: git-action-policy).
- Click on **Create policy** .

#### Example IAM Policy

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "S3DeploymentAccess",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:DeleteObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::BUCKET_NAME",
                "arn:aws:s3:::BUCKET_NAME/*"
            ]
        },
        {
            "Sid": "CloudFrontInvalidationAccess",
            "Effect": "Allow",
            "Action": "cloudfront:CreateInvalidation",
            "Resource": "arn:aws:cloudfront::ACCOUNT_NUMBER:distribution/DISTRIBUTION_ID"
        }
    ]
}
```
Replace `YOUR_BUCKET_NAME` with your actual bucket name.
Replace `ACCOUNT_NUMBER` with your actual bucket name.
Replace `DISTRIBUTION_ID` with your actual bucket name.

- Complete the user creation and **download the Access Key ID and Secret Access Key**.


### 2. Update the Workflow

Edit [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml) and ensure your bucket and distribution IDs are referenced via secrets.

## Using Terraform Modules

For infrastructure provisioning using Terraform modules, refer to the [s3-cdn-modules/README.md](s3-cdn-modules/README.md) file for detailed instructions on how to customize and deploy the complete S3 + CloudFront infrastructure.

## Deploying Files to S3

To upload your static website files to the S3 bucket while skipping the s3-cdn-modules directory (which contains Terraform configuration files), use the following command:

```bash
aws s3 cp . s3://your-bucket-name --recursive --exclude "s3-cdn-modules/*"
```

Alternatively, if you want to sync only the website files and exclude the Terraform modules:

```bash
aws s3 sync . s3://your-bucket-name --exclude "s3-cdn-modules/*" --delete
```

The `--exclude "s3-cdn-modules/*"` option ensures that your Terraform configuration files are not uploaded to your S3 bucket, keeping your infrastructure code separate from your website content.

## License

This project is licensed under the [Apache License 2.0](LICENSE).