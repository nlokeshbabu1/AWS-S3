terraform {
  backend "s3" {
    bucket = "my-blog-terraform-state-bucket"
    key    = "dev/terraform.tfstate"
    region = "ap-south-2"

  }
}