#Terraform base settings
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

#Setting de provider (AWS)
provider "aws" {
  region  = "eu-central-1"
}

#Creates a Security group
resource "aws_security_group" "WWW_SG" {
  name        = "www security group"
  description = "www security group"
  vpc_id      = "<vpc_id>" // Change "<vpc_id>" by your VPC ID
  ingress {
    description      = "TLS from VPC"
    from_port        = 0  // Means all types of Inbounds
    to_port          = 0  // Means all types of Inbounds
    protocol         = -1 // Means all types of Inbounds
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0    //Means all types of Outbounds
    to_port          = 0    //Means all types of Outbounds
    protocol         = "-1" //Means all types of Outbounds
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "WWW_SG"
  }
}

#Creates an Ubuntu 20.04 instance (Ubuntu Server 20.04 LTS (HVM), SSD Volume Type)
resource "aws_instance" "www" {
  ami           = "ami-076bdd070268f9b8d"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.WWW_SG.id}"]  //Attaching the security group to ubuntu instance
  user_data = <<-EOF
    #!bin/bash
    sudo apt install net-tools
    sudo apt update
    sudo apt -y install apache2
    echo "<h1>Hello World</h1>" > /var/www/html/index.html
  EOF
  tags = {
    Name = "Ubuntu_20_04"
  }
}

# Generates a secure private key and encodes it as PEM
resource "tls_private_key" "private_key_pair" { // protocol TLS = Transfer Layer Security
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create the public Key Pair
resource "aws_key_pair" "key_pair" {
  key_name   = "ubuntu-key-pair"  
  public_key = tls_private_key.private_key_pair.public_key_openssh
}

# Save file
resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.key_pair.key_name}.pem"
  content  = tls_private_key.private_key_pair.private_key_pem
}

resource "aws_ec2_instance_state" "www_stop" {
  instance_id = aws_instance.www.id
  state       = "stopped"
}