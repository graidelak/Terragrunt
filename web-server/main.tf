provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {}
}

#resource "aws_key_pair" "default" {
#  key_name = "terrakeypar"
#  public_key = "${var.public_key}"
#}

resource "aws_instance" "webserver" {
   ami  = "${var.ami}"
   instance_type = "${var.instance_type}"
   key_name = "${var.key_name}"
   subnet_id = "${aws_subnet.public-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.websg.id}"]
   associate_public_ip_address = true
   source_dest_check = false

   user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF



  tags {
    Name = "webserver"
  }
}

