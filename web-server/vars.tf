variable "aws_region" {
description = "AWS region to deploy to"
}

variable "instance_type" {
description = "the type of the EC2 instances to run"
}

variable "name" {
  description = "This name is also used to namespace all the other resources created by this module."
}

variable "ssh_port" {
 description = "ssh port number for remote connections"
}

variable "http_port" {
description = "The port number the webserver should listen on for HTTP requests"
}

variable "ami" {
description = "Ubuntu xenial 16.04"
default = "ami-759bc50a"
}

variable "key_name" {
description = "ssh key name"
default = "flugel"
}
