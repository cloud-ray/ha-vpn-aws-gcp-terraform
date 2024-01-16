# root/aws-modules/aws-bastion-host/variables.tf 

# For use with root/main.tf module values
variable "vpc_id" {}
variable "public_subnet_id" {}
variable "vpc_cidr" {}

# AWS Module 3 - Bastion Host in Public Subnet w/ Security Group
# 1. AWS - Create a bastion host ec2 in the Public Subnet
variable "aws_bastion_ami" {}
variable "aws_bastion_type" {}
variable "aws_bastion_key_name" {}
variable "aws_bastion_tags" {}
 
# 2. AWS - Create SG for Bastion
variable "bastion_sg_name" {}
variable "bastion_sg_desc" {}
variable "bastion_sg_tags" {}

# 2.1 AWS - Create INGRESS Rules for Bastion Host for SSH
variable "allow_bastion_ssh_cidr" {}
variable "allow_bastion_ssh_from_port" {}
variable "allow_bastion_ssh_protocol" {}
variable "allow_bastion_ssh_to_port" {}

# 2.2 AWS - Create INGRESS Rules for Bastion Host for all traffic in VPC
variable "allow_bastion_vpc_protocol" {}

# 2.3 AWS - Create EGRESS Rules for Bastion Host for all outbound traffic
variable "allow_bastion_egress_cidr" {}
variable "allow_bastion_egress_protocol" {}