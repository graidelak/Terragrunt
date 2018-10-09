variable "aws_region" {
description = "Region for the VPC"
default = "us-east-1"
}

variable "vpc_cidr" {
description = "CIDR"
default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
description = "public_subnet"
default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
description = "private_subnet"
default = "10.0.2.0/24"
}

variable "ami" {
description = "Ubuntu xenial 16.04"
default = "ami-759bc50a"
}


variable "aws_access_key" {
  default = "AKIAJ2KCALARJ27YK3JA"
  description = "the user aws access key"
}
variable "aws_secret_key" {
  default = "rLDgAxRRO9utZ50ZZB1NRz6pDUvkYAYyu/74I5Eu"
  description = "the user aws secret key"
}
