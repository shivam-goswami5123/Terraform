# Generate a random suffix for the bucket name
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper = false
}

# Use `locals` to define the dynamic bucket name
locals {
  bucket_name = "s3-website-test-${random_string.suffix.result}"
}

# Define the S3 bucket with the dynamic name
resource "aws_s3_bucket" "b" {
  bucket = local.bucket_name



  versioning {
    enabled = true
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

# ✅ Step 1: Allow Public Access by Disabling Restrictions
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.b.id
  block_public_acls       = false
  block_public_policy     = false
  restrict_public_buckets = false
  ignore_public_acls      = false
}

# ✅ Step 2: Set Object Ownership (Recommended)
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.b.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# ✅ Step 3: Allow public access via bucket policy
resource "aws_s3_bucket_policy" "b_policy" {
  bucket = aws_s3_bucket.b.id
  depends_on = [aws_s3_bucket_public_access_block.public_access] # Ensure policy is applied after disabling public block

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::${aws_s3_bucket.b.id}/*"
      }
    ]
  })
}

# Upload index.html
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.b.id
  key    = "index.html"
  source = "./assets/index.html"
  content_type = "text/html"
}

# Upload error.html
resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.b.id
  key    = "error.html"
  source = "./assets/error.html"
  content_type = "text/html"
}