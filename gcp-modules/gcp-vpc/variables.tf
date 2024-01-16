# root/gcp-modules/gcp-vpc/variables.tf

# 1. GCP - Create a VPC network on Google Cloud
variable "gcp_vpc_vpn_name" {}
variable "auto_create_subnetworks" {}
variable "gcp_vpc_vpn_routing" {}
 
# 2. GCP - Create a private subnet within the VPC
variable "gcp_vpc_vpn_private_subn_name" {}
variable "gcp_vpc_vpn_private_subn_region" {}
variable "gcp_vpc_vpn_private_subn_ip_cidr_range" {}