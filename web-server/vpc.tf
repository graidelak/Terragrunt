resource "aws_vpc" "terra-aws" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "-vpc"
  }
}

# public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = "${aws_vpc.terra-aws.id}"
  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch=true

  tags {
     Name = "Test public subnet"
  }
}

# private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = "${aws_vpc.terra-aws.id}"
  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "us-east-1b"

  tags {
     Name = "Test private subnet"
  }
}

# Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.terra-aws.id}"

  tags {
    Name = "vpc gateway"
  }
}

# route for internet
resource "aws_route_table" "public-route"{
  vpc_id = "${aws_vpc.terra-aws.id}"

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
  name = "webserver"
  description = "inbound rules"

  egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "${var.ssh_port}"
    to_port = "${var.ssh_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "${var.http_port}"
    to_port = "${var.http_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id="${aws_vpc.terra-aws.id}"

  tags {
    Name = "websg"
  }
}
