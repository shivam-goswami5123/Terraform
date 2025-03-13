provider "aws" {
  region="ap-south-1"
}

variable isACLAllowed{
    description = "ACL Allowed or not"
    type = bool
    default = false
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-tf-test-bucket-13032025"
  acl = var.isACLAllowed ? "public-read" : "private"
} 


resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}