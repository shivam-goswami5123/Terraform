terraform {
  backend "s3" {
    bucket = "remote-backend-bucket16032025"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}

