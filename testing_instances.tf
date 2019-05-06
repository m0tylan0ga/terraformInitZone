# ==============================================================================
# testing instances

resource "aws_instance" "test-SC" {
  count = "${var.number-avaliablility-zones}"


  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id      = "${aws_subnet.LandingZone.*.id[count.index]}"
  key_name = "GregorKey"

  tags = {
    Name = "HelloWorld"
  }
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


resource "aws_instance" "test-security" {
  count = "${var.number-avaliablility-zones}"


  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id      = "${aws_subnet.Security.*.id[count.index]}"
  key_name = "GregorKey"
  tags = {
    Name = "HelloWorld"
  }
}
