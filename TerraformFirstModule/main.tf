provider "aws" {
  region = "us-west-2"
}

#referencing other modules
module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami_value = "ami-0c55b159cbfafe1f0"
  instance_type_value = "t2.micro"
}

