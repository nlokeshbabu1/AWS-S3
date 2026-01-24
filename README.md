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
3. (You should update the workflow to sync files to your S3 bucket.)

**Example sync command:**
```yaml
- name: Sync files to S3
  run: |
    aws s3 sync . s3://<your-bucket-name> --exclude ".git/*" --exclude ".github/*" --acl public-read
```

## Setup Instructions

1. **Create an S3 bucket** (private recommended).
2. **Set up AWS credentials** as GitHub repository secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
3. **Update the workflow** in [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml) with your bucket name.
4. **(Optional)** Configure CloudFront with OAC for secure public access.

## Local Development

Open `index.html` in your browser to preview the site. Use the "Simulate Deployment" button for a mock deployment status.

## License

This project is licensed under the [Apache License 2.0](LICENSE).