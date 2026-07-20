provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "security-scanning-demo-bucket"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.test_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}