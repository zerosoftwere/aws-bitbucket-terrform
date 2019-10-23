resource "aws_vpc" "beanstack_vpc" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true

  tags {
    Name = "beanstalk-vpc"
  }
}

resource "aws_subnet" "beanstack_subnet" {
  cidr_block              = "192.168.1.0/24"
  vpc_id                  = "${aws_vpc.beanstack_vpc.id}"
  map_public_ip_on_launch = true

  tags {
    Name = "beanstalk-subnet - beanstalk-vpc"
  }
}

resource "aws_internet_gateway" "beanstalk_internet_gw" {
  vpc_id = "${aws_vpc.beanstack_vpc.id}"

  tags {
    Name = "beanstalk-internet-gateway - beanstalk-vpc"
  }
}

resource "aws_route_table" "beanstalk_route_table" {
  vpc_id = "${aws_vpc.beanstack_vpc.id}"

  tags {
    Name = "beanstalk-route-table - beanstalk-vpc"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.beanstalk_internet_gw.id}"
  }
}

resource "aws_route_table_association" "beanstalk_subnet_route_association" {
  subnet_id      = "${aws_subnet.beanstack_subnet.id}"
  route_table_id = "${aws_route_table.beanstalk_route_table.id}"
}

resource "aws_security_group" "beanstalk_security_group" {
  vpc_id = "${aws_vpc.beanstack_vpc.id}"

  tags {
    Name = "beanstalk-security-group"
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
