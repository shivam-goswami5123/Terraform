provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "test-server" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"
}

resource "aws_s3_bucket" "s3_bucket_statefile"{                              
  bucket = "bucket-name"
}