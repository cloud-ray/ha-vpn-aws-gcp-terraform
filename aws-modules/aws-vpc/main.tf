# root/aws-modules/aws-vpc/main.tf 

# 1. AWS - Create a VPC network on AWS
resource "aws_vpc" "aws_vpc_vpn" {
  cidr_block = var.aws_vpc_vpn_cidr_block

  tags = {
    Name = var.aws_vpc_vpn_tags
  }
}   


# 2. AWS - Create a Private Subnet in VPC
resource "aws_subnet" "aws_vpc_vpn_private_subn" {
  vpc_id            = aws_vpc.aws_vpc_vpn.id
  cidr_block        = var.aws_vpc_vpn_private_subn_cidr_block
  availability_zone = var.aws_vpc_vpn_private_subn_avail_zone
  tags = {
    Name = var.aws_vpc_vpn_private_subn_tags
  }
}


# 3. AWS - Create a Public Subnet in VPC
resource "aws_subnet" "aws_vpc_vpn_public_subn" {
  vpc_id     = aws_vpc.aws_vpc_vpn.id
  cidr_block = var.aws_vpc_vpn_public_subn_cidr_block

  tags = {
    Name = var.aws_vpc_vpn_public_subn_tags
  }
}


# 4. AWS - Create Internet Gateway for Public Subnet
resource "aws_internet_gateway" "public_igw" {
  vpc_id = aws_vpc.aws_vpc_vpn.id

  tags = {
    Name = var.public_igw_tags
  }
}


# 5. AWS - Create Route Table for Private Subnet
resource "aws_route_table" "aws_vpc_private_subn_rt" {
  vpc_id = aws_vpc.aws_vpc_vpn.id
  route {
    cidr_block = var.gcp_private_subn_out # The GCP VPC CIDR range
    gateway_id = var.aws_vpn_gw_out 
  } 
}

# 5.1 AWS - Associate Route Table with Private Subnet
resource "aws_route_table_association" "aws_vpc_private_subn_rt_assoc" {
  subnet_id      = aws_subnet.aws_vpc_vpn_private_subn.id
  route_table_id = aws_route_table.aws_vpc_private_subn_rt.id
}


# 6. AWS - Create Route Table for Public Subnet
resource "aws_route_table" "aws_vpc_public_subn_rt" {
  vpc_id = aws_vpc.aws_vpc_vpn.id

  route {
    cidr_block = var.aws_vpc_public_subn_rt_cidr
    gateway_id = aws_internet_gateway.public_igw.id
  }

  tags = {
    Name = var.aws_vpc_public_subn_rt_name
  }
}

# 6.1 AWS - Associate Public Subnet with Route Table
resource "aws_route_table_association" "aws_vpc_public_subn_rt_assoc" {
  subnet_id      = aws_subnet.aws_vpc_vpn_public_subn.id
  route_table_id = aws_route_table.aws_vpc_public_subn_rt.id
}