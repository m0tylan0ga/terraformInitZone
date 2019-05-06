data "aws_availability_zones" "available" {}

variable "cluster-name" {
  default = "LandingZone"
  type    = "string"
}

variable "number-avaliablility-zones" {
  default = 3
}

variable "internet-gateway-cidr" {
  default = "0.0.0.0/0"
  type    = "string"
}
