variable "ami_value"{
    description = "The AMI ID to use for the instance"
}

variable "instance_type_value"{
    description = "The type of instance to start"
}



provider "aws" {
    region = "us-west-2"
}

resource "aws_instance" "example" {
    ami           = var.ami_value
    instance_type = var.instance_type_value
} 





