resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_s3_bucket" "s3-blog" {
  bucket = "${var.bucket_name}-${random_id.bucket_id.hex}"

  force_destroy = true

}

resource "aws_s3_bucket_public_access_block" "name" {
  bucket = aws_s3_bucket.s3-blog.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.s3-blog.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

