terraform {
  backend "s3" {
    bucket = "my-blog-terraform-state-bucket"
    key    = "s3-cdn-modules/terraform.tfstate"
    region = "ap-south-2"

  }
}