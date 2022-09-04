# Designate a cloud provider, region, and credentials
provider "aws" {
  region = "us-east-1"
  access_key = "AKIA2VTVKYJEU5WFDLZF"
  secret_key = "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"
}

resource "aws_instance" "udacity_M4" {
  ami           = "ami-05fa00d4c63e32376" 
  instance_type = "m4.large"
  count = "2"
  tags = {
    Name = "Udacity M4"
    
  }
}
resource "aws_instance" "udacity_T2" {
  ami           = "ami-05fa00d4c63e32376" 
  instance_type = "t2.micro"
  count = "4"
  tags = {
    Name = "Udacity T2"
    
  }
  
}

