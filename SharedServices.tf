resource "aws_vpc" "SharedServices" {
  cidr_block = "10.0.0.0/16"

    tags = {
       Name = "terraform-lz-node"
       }

}

resource "aws_subnet" "LandingZone" {
  count = "${var.number-avaliablility-zones}"

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "${cidrsubnet("10.0.0.0/16", 6, count.index * 16 )}"
  vpc_id            = "${aws_vpc.SharedServices.id}"

  tags = {
     Name = "terraform-lz-node"
     }
}

resource "aws_internet_gateway" "LandingZone" {
  vpc_id = "${aws_vpc.SharedServices.id}"

  tags = {
    Name = "SharedServices-InternetGatewat"
  }
}

resource "aws_route_table" "LandingZone" {
  vpc_id = "${aws_vpc.SharedServices.id}"
  route {
    cidr_block = "${var.internet-gateway-cidr}"
    gateway_id = "${aws_internet_gateway.LandingZone.id}"
  }
}

resource "aws_route_table_association" "LandingZone" {
  count = "${var.number-avaliablility-zones}"
  subnet_id      = "${aws_subnet.LandingZone.*.id[count.index]}"
  route_table_id = "${aws_route_table.LandingZone.id}"
}
