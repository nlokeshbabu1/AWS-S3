# Static Website Deployment: S3 + CloudFront + GitHub Actions

This repository contains a simple static website and a GitHub Actions workflow for automated deployment to an Amazon S3 bucket, optionally fronted by CloudFront.

## Features

- **Static site**: HTML, CSS, and JavaScript files for a responsive landing page.
- **CI/CD**: Automated deployment to AWS S3 on every push to the `main` branch using GitHub Actions.
- **CloudFront ready**: Designed for integration with CloudFront and Origin Access Control (OAC).

## Repository Structure

```
index.html         # Main HTML file
style.css          # Stylesheet
script.js          # Deployment simulation script
LICENSE            # Apache 2.0 License
.github/
  workflows/
    deploy.yml     # GitHub Actions workflow for S3 deployment
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
- Click **Next** and attach the following policy (custom or managed):

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



## License

This project is licensed under the [Apache License 2.0](LICENSE).