provider "aws" {
 region = "${var.aws_region}"
}

terraform {
  backend "s3" {}
}

resource "aws_instance" "webserver" {
   ami = "${var.ami}"
   instance_type = "${var.instance_type}"
   key_name = "${var.key_name}"
   vpc_security_group_ids = ["${aws_security_group.websg.id}"]
   associate_public_ip_address = true

   user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.http_port}" &
              EOF

   tags {
      Name = "webserver"
   }
}

# security group
resource "aws_security_group" "websg" {
  name = "webserver"
}

resource "aws_security_group_rule" "web_allow_all_outbound" {
  type                  = "egress"
  from_port             = 0
  to_port               = 0
  protocol              = "-1"
  cidr_blocks           = ["0.0.0.0/0"]
  security_group_id     = "${aws_security_group.websg.id}"

}
resource "aws_security_group_rule" "web_allow_ssh_inbound" {
  type                  = "ingress"
  from_port             = "${var.ssh_port}"
  to_port               = "${var.ssh_port}"
  protocol              = "tcp"
  cidr_blocks           = ["0.0.0.0/0"]
  security_group_id     = "${aws_security_group.websg.id}"
  }

resource "aws_security_group_rule" "web_allow_http_inbound" {
  type                  = "ingress"
  from_port             = "${var.http_port}"
  to_port               = "${var.http_port}"
  protocol              = "tcp"
  cidr_blocks           = ["0.0.0.0/0"]
  security_group_id     = "${aws_security_group.websg.id}" 
