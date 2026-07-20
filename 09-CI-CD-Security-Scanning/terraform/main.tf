provider "aws" {
  region = "eu-west-1"
}


resource "aws_kms_key" "s3_key" {
  description = "S3 encryption key for security scanning demo"
}


resource "aws_s3_bucket" "test_bucket" {
  bucket = "security-scanning-demo-bucket"
}


resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.test_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.test_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_key.arn
    }
  }
}


resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.test_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_logging" "logging" {
  bucket = aws_s3_bucket.test_bucket.id

  target_bucket = aws_s3_bucket.test_bucket.id
  target_prefix = "logs/"
}


resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.test_bucket.id

  rule {
    id     = "security-lifecycle"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }

    expiration {
      days = 90
    }
  }
}


resource "aws_s3_bucket_notification" "notifications" {
  bucket = aws_s3_bucket.test_bucket.id
}