# root/aws-modules/aws-private-ec2/variables.tf 

# AWS Module 2 - Private EC2 Instance w/ Security Group
# For use with root/main.tf module values
variable "aws_vpc_id_out" {}
variable "aws_private_subnet_id_out" {}
variable "gcp_private_subnet_cidr_out" {}

# 1. Get data for AWS ec2 instance
variable "ubuntu_most_recent" {}
variable "ubuntu_value" {}

# 2. Create AWS ec2 instance
variable "aws_test_vm_instance_type" {}
variable "aws_test_vm_avail_zone" {}
variable "aws_test_vm_assc_public_ip" {}
variable "aws_test_vm_tags" {}
variable "aws_test_vm_key_name" {}

# 3. AWS - Create AWS SG for Private EC2 to to GCP for testing
variable "allow_gcp_vpc_name" {}
variable "allow_gcp_vpc_desc" {}
variable "allow_gcp_vpc_tags" {}

# 3.1 AWS - Create INGRESS Rules for Private EC2 to allow SSH
variable "allow_gcp_vpc_ssh_cidr" {}
variable "allow_gcp_vpc_ssh_from_port" {}
variable "allow_gcp_vpc_ssh_protocol" {}
variable "allow_gcp_vpc_ssh_to_port" {}

# 3.2 AWS - Create INGRESS Rules for Private EC2 to allow all traffic from GCP
variable "allow_gcp_vpc_gcp_all_protocol" {}

# 3.3 AWS - Create EGRESS Rules for AWS SG for Private EC2 to to GCP for testing
variable "allow_gcp_vpc_egress_protocol" {}