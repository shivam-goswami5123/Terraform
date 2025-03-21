output "bucket-id" {
  value = aws_s3_bucket.b.id
  description = "Unique Name of S3 Bucket"
}

output "website-public-url" {
   value = "http://${aws_s3_bucket.b.website_endpoint}/"
   description = "Public URL of the S3 static website"
}

