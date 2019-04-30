provider "aws" {
  assume_role {
    role_arn     = "${replace(data.local_file.arn.content,"\n","")}"
  }
  region     = "${replace(data.local_file.region.content,"\n","")}"
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


