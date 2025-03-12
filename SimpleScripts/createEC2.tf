provider "aws" {
    region = "ap-south-1"  # Set your desired AWS region
}


resource "aws_instance" "this" {
  ami                     = "ami-05c179eced2eb9b5b"
  instance_type           = "t2.micro"
  key_name                = "terraform-test-key"
  subnet_id               = "subnet-id"
}