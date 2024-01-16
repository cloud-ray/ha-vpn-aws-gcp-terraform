# root/variables.tf
variable "gcp_project" {}
variable "gcp_region" {}
variable "aws_region" {}


##### GCP VARIABLES #####

## GCP Module 1 - VPC, Private Subnet 

# 1. GCP - Create a VPC network on Google Cloud
variable "gcp_vpc_vpn_name" {}
variable "auto_create_subnetworks" {}
variable "gcp_vpc_vpn_routing" {}

# 2. GCP - Create a private subnet within the VPC
variable "gcp_vpc_vpn_private_subn_name" {}
variable "gcp_vpc_vpn_private_subn_region" {}
variable "gcp_vpc_vpn_private_subn_ip_cidr_range" {}



## GCP Module 2 - 3 Firewalls (x3)

# 3. GCP - Create VM firewall to allow ssh
variable "allow_ssh_iap_name" {}
variable "allow_ssh_iap_protocol" {}
variable "allow_ssh_iap_ports" {}
variable "allow_ssh_iap_source_ranges" {}
variable "allow_ssh_iap_target_tags" {}

# 3.1 GCP - Create VPC firewall to allow ingress from AWS
variable "allow_ingress_from_aws_name" {}
variable "allow_ingress_from_aws_direction" {}
variable "allow_ingress_from_aws_protocol_1" {}
variable "allow_ingress_from_aws_ports" {}
variable "allow_ingress_from_aws_protocol_2" {}
variable "allow_ingress_from_aws_source_ranges" {}
variable "allow_ingress_from_target_tags" {}

# 3.2 GCP - Create VPC firewall to allow egress to AWS
variable "allow_egress_to_aws_name" {}
variable "allow_egress_to_aws_direction" {}
variable "allow_egress_to_aws_protocol" {}
variable "allow_egress_to_aws_dest_ranges" {}
variable "allow_egress_to_aws_target_tags" {}



## GCP Module 3 - VM Instance in Private Subnet

# 4. Create VM in GCP in private subnet
variable "gcp_test_vm_name" {}
variable "gcp_test_vm_machine_type" {}
variable "gcp_test_vm_zone" {}
variable "gcp_test_vm_image" {}
variable "gcp_test_vm_my_label" {}
# variable "gcp_test_vm_sa_email" {}
variable "gcp_test_vm_tags" {}



## GCP Module 4 - HA VPN, Cloud Router

# 5. GCP - Create a HA VPN gateway
variable "gcp_vpn_ha_gateway_name" {}
variable "gcp_vpn_ha_gateway_region" {}

# 6. GCP - Create a Cloud Router for dynamic routing
variable "gcp_vpc_vpn_router_1_name" {}
variable "gcp_vpc_vpn_router_1_region" {}
variable "gcp_vpc_vpn_router_1_asn" {}
variable "gcp_vpc_vpn_router_1_adv_mode" {}
variable "gcp_vpc_vpn_router_1_adv_group" {}

# 7. GCP - Create External VPN Gateway
variable "gcp_external_vpn_gw_name" {}
variable "gcp_external_vpn_gw_desc" {}
variable "gcp_external_vpn_gw_redundancy_type" {}

# 8. GCP - Create 4 VPN tunnels to connect to AWS
variable "gcp_vpc_vpn_tunnel_region" {}
variable "gcp_vpc_vpn_tunnel_ike_version" {}

# 8.1 GCP - Create GCP VPN tunnel 1
variable "gcp_vpc_vpn_tunnel_1_name" {}
variable "gcp_vpc_vpn_tunnel_1_peer_gw_int" {}
variable "gcp_vpc_vpn_tunnel_1_vpn_gw_int" {}

# 8.2 GCP - Create GCP VPN tunnel 2
variable "gcp_vpc_vpn_tunnel_2_name" {}
variable "gcp_vpc_vpn_tunnel_2_peer_gw_int" {}
variable "gcp_vpc_vpn_tunnel_2_vpn_gw_int" {}

# 8.3 GCP - Create GCP VPN tunnel 3
variable "gcp_vpc_vpn_tunnel_3_name" {}
variable "gcp_vpc_vpn_tunnel_3_peer_gw_int" {}
variable "gcp_vpc_vpn_tunnel_3_vpn_gw_int" {}

# 8.4 GCP - Create GCP VPN tunnel 4
variable "gcp_vpc_vpn_tunnel_4_name" {}
variable "gcp_vpc_vpn_tunnel_4_peer_gw_int" {}
variable "gcp_vpc_vpn_tunnel_4_vpn_gw_int" {}

# 9. GCP - Create 4 Compute Router Interfaces 
variable "gcp_router_int_region" {}

# 9.1 GCP - Create 4 Compute Router Interfaces 
variable "gcp_router_int_1_name" {}
variable "gcp_router_int_1_ip_range" {}

# 9.2 GCP - Create 4 Compute Router Interfaces 
variable "gcp_router_int_2_name" {}
variable "gcp_router_int_2_ip_range" {}

# 9.3 GCP - Create 4 Compute Router Interfaces 
variable "gcp_router_int_3_name" {}
variable "gcp_router_int_3_ip_range" {}

# 9.4 GCP - Create 4 Compute Router Interfaces 
variable "gcp_router_int_4_name" {}
variable "gcp_router_int_4_ip_range" {}

## 10. GCP - Create 4 BGP Peers
variable "bgp_peer_region" {}

# 10.1 GCP - Create BGP Peer 1
variable "bgp_peer_1_peer_name" {}
variable "bgp_peer_1_peer_ip_addr" {}

# 10.2 GCP - Create BGP Peer 2
variable "bgp_peer_2_peer_name" {}
variable "bgp_peer_2_peer_ip_addr" {}

# 10.3 GCP - Create BGP Peer 3
variable "bgp_peer_3_peer_name" {}
variable "bgp_peer_3_peer_ip_addr" {}

# 10.4 GCP - Create BGP Peer 4
variable "bgp_peer_4_peer_name" {}
variable "bgp_peer_4_peer_ip_addr" {}










##### AWS VARIABLES #####

## AWS Module 1 - VPC, Private & Subnet, IGW, RTs

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



## AWS Module 2 - Private EC2 Instance w/ Security Group

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



## AWS Module 3 - Bastion Host in Public Subnet w/ Security Group

# 1. AWS - Create a bastion host ec2 in the Public Subnet
variable "aws_bastion_ami" {}
variable "aws_bastion_type" {}
variable "aws_bastion_key_name" {}
variable "aws_bastion_tags" {}

# 2. AWS - Create SG for Bastion Host for SSH
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



## AWS Module 4 - VPN, VPN Gateway, Customer GW, VPN Connection

# 1. AWS - Create VPN Gateway
variable "aws_vpn_gw_tags" {}
variable "aws_vpn_gw_amazon_side_asn" {}

# 2. AWS - Create 2 customer gateways on AWS
variable "customer_gateway_type" {}
variable "customer_gateway_0_tag" {}
variable "customer_gateway_1_tag" {}

# 3. AWS - Create VPN connections with dynamic routing
# to the GCP customer gateways
variable "vpn_connection_type" {}
variable "vpn_connection_0_t1_inside_cidr" {}
variable "vpn_connection_0_t1_preshared_key" {}
variable "vpn_connection_0_t2_inside_cidr" {}
variable "vpn_connection_0_t2_preshared_key" {}
variable "vpn_connection_1_t1_inside_cidr" {}
variable "vpn_connection_1_t1_preshared_key" {}
variable "vpn_connection_1_t2_inside_cidr" {}
variable "vpn_connection_1_t2_preshared_key" {}