terraform {
  required_providers {
    aws = ">= 2.33"
  }
}

provider "aws" {
  profile = "chaserx"
  region  = "us-east-2"
}

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr_vpc}"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = "devbox-vpc"
    Environment = "${var.environment_tag}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Environment = "${var.environment_tag}"
  }
}

resource "aws_subnet" "subnet_public" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.cidr_subnet}"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.availability_zone}"
  tags = {
    Environment = "${var.environment_tag}"
  }
}

resource "aws_route_table" "rtb_public" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags = {
    Environment = "${var.environment_tag}"
  }
}

resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = "${aws_subnet.subnet_public.id}"
  route_table_id = "${aws_route_table.rtb_public.id}"
}

resource "aws_security_group" "devbox_allow_ssh" {
  name        = "devbox_allow_ssh"
  description = "Allow ssh inbound traffic from office and home IPs"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["74.136.72.59/32", "74.136.207.48/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = "${var.environment_tag}"
  }
}

resource "aws_key_pair" "ec2key" {
  key_name   = "publicKey"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "DevInstance" {
  ami                    = "${var.instance_ami}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${aws_subnet.subnet_public.id}"
  vpc_security_group_ids = ["${aws_security_group.devbox_allow_ssh.id}"]
  key_name               = "${aws_key_pair.ec2key.key_name}"
  tags = {
    Environment = "${var.environment_tag}"
    Name        = "DevBox"
  }
}

output "instance_dns" {
  value = ["${aws_instance.DevInstance.public_dns}"]
}
