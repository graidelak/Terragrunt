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
