# root/aws-modules/aws-vpc/variables.tf 

# AWS Module 1 - VPC, Private & Subnet, IGW, RTs
# For use with root/main.tf module values
variable "aws_vpn_gw_out" {}
variable "gcp_private_subn_out" {}

# 1. AWS - Create a VPC network on AWS
variable "aws_vpc_vpn_cidr_block" {}
variable "aws_vpc_vpn_tags" {}

# 2. AWS - Create a Private Subnet in VPC
variable "aws_vpc_vpn_private_subn_cidr_block" {}
variable "aws_vpc_vpn_private_subn_avail_zone" {}
variable "aws_vpc_vpn_private_subn_tags" {}

# 3. AWS - Create a Public Subnet in VPC
variable "aws_vpc_vpn_public_subn_cidr_block" {}
variable "aws_vpc_vpn_public_subn_tags" {}

# 4. AWS - Create Internet Gateway for Public Subnet
variable "public_igw_tags" {}

# 6. AWS - Create Route Table for Public Subnet
variable "aws_vpc_public_subn_rt_cidr" {}
variable "aws_vpc_public_subn_rt_name" {}