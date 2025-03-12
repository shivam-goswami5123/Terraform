terraform {
  backend "s3" {
    bucket = "bucket-name"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}

