# root/aws-modules/aws-private-ec2/main.tf 

# 1. AWS - Get data for AWS ec2 instance
data "aws_ami" "ubuntu" {
  most_recent = var.ubuntu_most_recent

  filter {
    name   = "name"
    values = [var.ubuntu_value]
  }
 
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
 
# 2. AWS - Create AWS ec2 instance
resource "aws_instance" "aws_test_vm" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.aws_test_vm_instance_type
  subnet_id     = var.aws_private_subnet_id_out

  # Add the key_name property:
  key_name      = var.aws_test_vm_key_name

  vpc_security_group_ids = [aws_security_group.allow_gcp_vpc.id]

  availability_zone = var.aws_test_vm_avail_zone 

  associate_public_ip_address = var.aws_test_vm_assc_public_ip 

  tags = {
    Name = var.aws_test_vm_tags
  }
}

# 3. AWS - Create AWS SG for Private EC2 to to GCP for testing
resource "aws_security_group" "allow_gcp_vpc" {
  name        = var.allow_gcp_vpc_name
  description = var.allow_gcp_vpc_desc
  vpc_id      = var.aws_vpc_id_out
  tags = {
    Name = var.allow_gcp_vpc_tags
  }
}

# 3.1 AWS - Create INGRESS Rules for Private EC2 to allow SSH
resource "aws_vpc_security_group_ingress_rule" "allow_gcp_vpc_ssh" {
  security_group_id = aws_security_group.allow_gcp_vpc.id

  cidr_ipv4   = var.allow_gcp_vpc_ssh_cidr
  from_port   = var.allow_gcp_vpc_ssh_from_port
  ip_protocol = var.allow_gcp_vpc_ssh_protocol
  to_port     = var.allow_gcp_vpc_ssh_to_port
}

# 3.2 AWS - Create INGRESS Rules for Private EC2 to allow all traffic from GCP
resource "aws_vpc_security_group_ingress_rule" "allow_gcp_vpc_gcp_all" {
  security_group_id = aws_security_group.allow_gcp_vpc.id

  cidr_ipv4   = var.gcp_private_subnet_cidr_out
  ip_protocol = var.allow_gcp_vpc_gcp_all_protocol
}

# 3.3 AWS - Create EGRESS Rules for AWS SG for Private EC2 to to GCP for testing
resource "aws_vpc_security_group_egress_rule" "allow_gcp_vpc_egress" {
  security_group_id = aws_security_group.allow_gcp_vpc.id

  cidr_ipv4   = var.gcp_private_subnet_cidr_out
  ip_protocol = var.allow_gcp_vpc_egress_protocol
}