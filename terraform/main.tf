terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = var.region
  
}

#Criação da VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "wordpress-vpc" }

}

#Criação da Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "wordpress-igw"
  }
}

#Criação da Route Table Pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }

}

#Criação da Subnet Pública 1
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_1_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

#Criação da Subnet Pública 2
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_2_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

#Criação da Subnet Privada 1
resource "aws_subnet" "private_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_1_cidr

  tags = {
    Name = "private-subnet-1"
  }
}

#Criação da Subnet Privada 2
resource "aws_subnet" "private_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_2_cidr

  tags = {
    Name = "private-subnet-2"
  }
}

#Associando a Subnet Pública 1 à Route Table Pública
resource "aws_route_table_association" "public_subnet_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

#Associando a Subnet Pública 1 à Route Table Pública 2
resource "aws_route_table_association" "public_subnet_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id

}

#Criação do Elastic IP
resource "aws_eip" "nat_eip" {

}

#Criação do Nat-Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_1.id

  tags = { Name = "nat-gateway" }

}

#Criação da Route Table Privada
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = { Name = "private-route-table" }
}

#Associação da Route Table privada com a Subnet Privada 1
resource "aws_route_table_association" "private_subnet_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private.id
}

#Associação da Route Table privada com a Subnet Privada 2
resource "aws_route_table_association" "private_subnet_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private.id
}