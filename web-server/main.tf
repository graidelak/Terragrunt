provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

#resource "aws_key_pair" "default" {
#  key_name = "terrakeypar"
#  public_key = "${var.public_key}"
#}

resource "aws_instance" "terraform-aws" {
   ami  = "${var.ami}"
   instance_type = "t2.micro"
   key_name = "langroo"
   subnet_id = "${aws_subnet.public-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.terraform.id}"]
   associate_public_ip_address = true
   source_dest_check = false

  tags {
    Name = "terraform-aws"
  }
}

output "ip" {

value="${aws_instance.terraform-aws.public_ip}"

}
