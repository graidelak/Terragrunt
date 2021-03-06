variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-east-1)"
}

variable "name" {
  description = "The name of the DB"
}

variable "instance_class" {
  description = "The instance class of the DB (e.g. db.t2.micro)"
}

variable "allocated_storage" {
  description = "The amount of space, in GB, to allocate for the DB"
}

variable "storage_type" {
  description = "The type of storage to use for the DB. Must be one of: standard, gp2, or io1."
}

variable "master_username" {
  description = "The username for the master user of the DB"
}

variable "master_password" {
  description = "The password for the master user of the DB"
}

variable "mysql_port" {
  description = "mysql port"
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
