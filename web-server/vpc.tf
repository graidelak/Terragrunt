# security group
resource "aws_security_group" "websg" {
  name = "${var.name}-web}"
}

resource "aws_security_group_rule" "web_allow_all_outbound" {
  type			= "egress"
  from_port		= 0
  to_port		= 0
  protocol		= "-1"
  cidr_blocks		= ["0.0.0.0/0"]
  security_group_id	= "${aws_security_group.websg.id}"

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
}


