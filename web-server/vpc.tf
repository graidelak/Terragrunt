resource "aws_vpc" "terragrunt-vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "terragrunt-vpc"
  }
}

# public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = "${aws_vpc.terragrunt-vpc.id}"
  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch=true

  tags {
     Name = "terragrunt public subnet"
  }
}

# private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = "${aws_vpc.terragrunt-vpc.id}"
  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "us-east-2a"

  tags {
     Name = "terragrunt private subnet"
  }
}

# Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.terragrunt-vpc.id}"

  tags {
    Name = "vpc gateway"
  }
}

# route for internet
resource "aws_route_table" "public-route"{
  vpc_id = "${aws_vpc.terragrunt-vpc.id}"

#  route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id = "${aws_internet_gateway.gw.id}"
#  }

  tags {
    Name = "route table"
  }
}
# Internet Access
resource "aws_route" "internet_access"{
  route_table_id = "${aws_route_table.public-route.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.gw.id}"
}
# Route with subnet
resource "aws_route_table_association" "association"{
  subnet_id = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.public-route.id}"
}
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


