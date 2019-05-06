resource "aws_vpc" "Security" {
  cidr_block = "10.0.0.0/16"

    tags = {
       Name = "terraform-security-node"
       }
}

resource "aws_subnet" "Security" {
  count = "${var.number-avaliablility-zones}"

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "${cidrsubnet("10.0.0.0/16", 6, count.index * 16 + 1 )}"
  vpc_id            = "${aws_vpc.Security.id}"

  tags = {
     Name = "terraform-security-node"
     }
}
