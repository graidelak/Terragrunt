variable "aws_region" {
description = "Region for the VPC"
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

variable "instance_type" {
  description = "The type of EC2 Instnaces to run in the ASG (e.g. t2.micro)"
}

variable "key_name" {
  description = "The name of an EC2 Key Pair that can be used to SSH to the EC2 Instances in this cluster"
  default     = "flugel"
}
