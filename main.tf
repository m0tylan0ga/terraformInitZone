provider "aws" {
  assume_role {
    role_arn     = "${replace(data.local_file.arn.content,"\n","")}"
  }
  region     = "${replace(data.local_file.region.content,"\n","")}"
}

terraform {
  backend "s3" {
    #bucket name here is hardcoded - we should try to create s3 bucket automatically by cloud formation and then try to find it eg by tag in terraform
    bucket = "tbase-terra-lock-bucket-initial"
    region  = "eu-west-2"
    dynamodb_table = "terraform-lock"
    key = "terraform/dev/terraform_dev.tfstate"
    encrypt = true
    access_key = "AKIAYV7NV5OMTAKSWLW4"
    secret_key = "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"
  }
}

data "local_file" "arn" {
    filename = "/opt/arn.txt"
}

data "local_file" "region" {
    filename = "/opt/region"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  count = "5"
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  tags = {
    Name = "jjj"
  }
}


