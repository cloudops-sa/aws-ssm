provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

resource "aws_instance" "ssm-instances" {
  count = 4  # Number of instances to create

  ami           = "ami-0ff8a91507f77f867"  # Replace with your desired AMI ID
  instance_type = "t2.micro"      # Replace with your desired instance type

  tags = {
    "Name" = "ssm-instance-${count.index+1}"
    "team" = "dev-ops"
  }

  iam_instance_profile = aws_iam_instance_profile.ec2-readonly.name
}