# Terraform Block
terraform {
  required_version = ">= 1.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  } 
}  
# Provider Block
provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "myVPC"
    "hmkim" = "terraform-vpc"
  }
}

resource "aws_subnet" "example" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    "hmkim" = "terraform-subnet"
    Name = "mySubnet"
  }
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "Public rtb"
  }
}

resource "aws_route" "public_rtb" {
  route_table_id         = aws_route_table.public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_rtb" {
  subnet_id      = aws_subnet.example.id
  route_table_id = aws_route_table.public_rtb.id
}

/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/

