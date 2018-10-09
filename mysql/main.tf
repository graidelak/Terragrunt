provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {}
}

resource "aws_db_instance" "mysql" {
  engine         = "mysql"
  engine_version = "5.7.23"

  name     = "${var.name}"
  username = "${var.master_username}"
  password = "${var.master_password}"

  instance_class    = "${var.instance_class}"
  allocated_storage = "${var.allocated_storage}"
  storage_type      = "${var.storage_type}"
  db_subnet_group_name      = "${aws_db_subnet_group.rds.id}"
  vpc_security_group_ids    = ["${aws_security_group.rds.id}"]
  
  skip_final_snapshot = true
}
