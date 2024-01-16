# root/aws-modules/aws-bastion-host/main.tf 

# AWS Module 3 - Bastion Host in Public Subnet w/ Security Group


# 1. AWS - Create a bastion host ec2 in the Public Subnet
resource "aws_instance" "aws_bastion" {
  ami           = var.aws_bastion_ami # AWS Linux
  instance_type = var.aws_bastion_type
  key_name      = var.aws_bastion_key_name

  subnet_id     = var.public_subnet_id

  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = {
    Name = var.aws_bastion_tags
  }
} 
 
# 2. AWS - Create SG for Bastion Host
resource "aws_security_group" "bastion_sg" {
  name        = var.bastion_sg_name
  description = var.bastion_sg_desc
  vpc_id      = var.vpc_id
  tags = {
    Name = var.bastion_sg_tags
  }
}

# 2.1 AWS - Create INGRESS Rules for Bastion Host for SSH
resource "aws_vpc_security_group_ingress_rule" "allow_bastion_ssh" {
  security_group_id = aws_security_group.bastion_sg.id

  cidr_ipv4   = var.allow_bastion_ssh_cidr
  from_port   = var.allow_bastion_ssh_from_port
  ip_protocol = var.allow_bastion_ssh_protocol
  to_port     = var.allow_bastion_ssh_to_port
}

# 2.2 AWS - Create INGRESS Rules for Bastion Host for all traffic in VPC
resource "aws_vpc_security_group_ingress_rule" "allow_bastion_vpc" {
  security_group_id = aws_security_group.bastion_sg.id

  cidr_ipv4   = var.vpc_cidr
  ip_protocol = var.allow_bastion_vpc_protocol
}

# 2.3 AWS - Create EGRESS Rules for Bastion Host for all outbound traffic
resource "aws_vpc_security_group_egress_rule" "allow_bastion_egress" {
  security_group_id = aws_security_group.bastion_sg.id

  cidr_ipv4   = var.allow_bastion_egress_cidr
  ip_protocol = var.allow_bastion_egress_protocol
}