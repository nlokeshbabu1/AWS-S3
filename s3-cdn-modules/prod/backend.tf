terraform {
  backend "s3" {
    bucket = "my-blog-terraform-state-bucket"
    key    = "prod/terraform.tfstate"
    region = "ap-south-2"
    use_lockfile = true


    # dynamodb_table = "values-blog-terraform-state-lock-table"
    # encrypt = true

  }
}