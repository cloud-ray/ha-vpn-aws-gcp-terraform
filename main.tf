# root/main.tf

### BEGIN GCP Resources Part 1 ###

## GCP Module 1 - VPC, Private Subnet 
module "gcp_vpc_network" {
  source                                 = "./gcp-modules/gcp-vpc"
  gcp_vpc_vpn_name                       = var.gcp_vpc_vpn_name
  auto_create_subnetworks                = var.auto_create_subnetworks
  gcp_vpc_vpn_routing                    = var.gcp_vpc_vpn_routing
  gcp_vpc_vpn_private_subn_name          = var.gcp_vpc_vpn_private_subn_name
  gcp_vpc_vpn_private_subn_region        = var.gcp_vpc_vpn_private_subn_region
  gcp_vpc_vpn_private_subn_ip_cidr_range = var.gcp_vpc_vpn_private_subn_ip_cidr_range
}

## GCP Module 2 - Firewalls (x3)
module "gcp_firewalls" {
  source                               = "./gcp-modules/gcp-firewalls"
  network_id                           = module.gcp_vpc_network.gcp_vpc_network_id
  allow_ssh_iap_name                   = var.allow_ssh_iap_name
  allow_ssh_iap_protocol               = var.allow_ssh_iap_protocol
  allow_ssh_iap_ports                  = var.allow_ssh_iap_ports
  allow_ssh_iap_source_ranges          = var.allow_ssh_iap_source_ranges
  allow_ssh_iap_target_tags            = var.allow_ssh_iap_target_tags
  allow_ingress_from_aws_name          = var.allow_ingress_from_aws_name
  allow_ingress_from_aws_direction     = var.allow_ingress_from_aws_direction
  allow_ingress_from_aws_protocol_1    = var.allow_ingress_from_aws_protocol_1
  allow_ingress_from_aws_ports         = var.allow_ingress_from_aws_ports
  allow_ingress_from_aws_protocol_2    = var.allow_ingress_from_aws_protocol_2
  allow_ingress_from_aws_source_ranges = var.allow_ingress_from_aws_source_ranges
  allow_ingress_from_target_tags       = var.allow_ingress_from_target_tags
  allow_egress_to_aws_name             = var.allow_egress_to_aws_name
  allow_egress_to_aws_direction        = var.allow_egress_to_aws_direction
  allow_egress_to_aws_protocol         = var.allow_egress_to_aws_protocol
  allow_egress_to_aws_dest_ranges      = var.allow_egress_to_aws_dest_ranges
  allow_egress_to_aws_target_tags      = var.allow_egress_to_aws_target_tags
}

## GCP Module 3 - VM Instance in Private Subnet
module "gcp_vm_private_subn" {
  source                   = "./gcp-modules/gcp-test-vm"
  network_id               = module.gcp_vpc_network.gcp_vpc_network_id
  private_subnetwork_id    = module.gcp_vpc_network.gcp_vpc_private_subnet_id
  gcp_test_vm_name         = var.gcp_test_vm_name
  gcp_test_vm_machine_type = var.gcp_test_vm_machine_type
  gcp_test_vm_zone         = var.gcp_test_vm_zone
  gcp_test_vm_image        = var.gcp_test_vm_image
  gcp_test_vm_my_label     = var.gcp_test_vm_my_label
  # gcp_test_vm_sa_email     = var.gcp_test_vm_sa_email
  gcp_test_vm_tags = var.gcp_test_vm_tags
}

## GCP Module 4 - HA VPN, Cloud Router
module "gcp_vpn" {
  source                              = "./gcp-modules/gcp-vpn"
  c0_t1_addr                          = module.aws_vpn.tunnel1_address_0
  c0_t2_addr                          = module.aws_vpn.tunnel2_address_0
  c1_t1_addr                          = module.aws_vpn.tunnel1_address_1
  c1_t2_addr                          = module.aws_vpn.tunnel2_address_1
  c0_t1_share_key                     = module.aws_vpn.c0_t1_shared_key
  c0_t2_share_key                     = module.aws_vpn.c0_t2_shared_key
  c1_t1_share_key                     = module.aws_vpn.c1_t1_shared_key
  c1_t2_share_key                     = module.aws_vpn.c1_t2_shared_key
  network_id                          = module.gcp_vpc_network.gcp_vpc_network_id
  aws_asn                             = module.aws_vpn.aws_vpn_gw_asn
  gcp_vpn_ha_gateway_region           = var.gcp_vpn_ha_gateway_region
  gcp_vpn_ha_gateway_name             = var.gcp_vpn_ha_gateway_name
  gcp_vpc_vpn_router_1_name           = var.gcp_vpc_vpn_router_1_name
  gcp_vpc_vpn_router_1_region         = var.gcp_vpc_vpn_router_1_region
  gcp_vpc_vpn_router_1_asn            = var.gcp_vpc_vpn_router_1_asn
  gcp_vpc_vpn_router_1_adv_mode       = var.gcp_vpc_vpn_router_1_adv_mode
  gcp_vpc_vpn_router_1_adv_group      = var.gcp_vpc_vpn_router_1_adv_group
  gcp_external_vpn_gw_name            = var.gcp_external_vpn_gw_name
  gcp_external_vpn_gw_desc            = var.gcp_external_vpn_gw_desc
  gcp_external_vpn_gw_redundancy_type = var.gcp_external_vpn_gw_redundancy_type
  gcp_vpc_vpn_tunnel_region           = var.gcp_vpc_vpn_tunnel_region
  gcp_vpc_vpn_tunnel_ike_version      = var.gcp_vpc_vpn_tunnel_ike_version
  gcp_vpc_vpn_tunnel_1_name           = var.gcp_vpc_vpn_tunnel_1_name
  gcp_vpc_vpn_tunnel_1_peer_gw_int    = var.gcp_vpc_vpn_tunnel_1_peer_gw_int
  gcp_vpc_vpn_tunnel_1_vpn_gw_int     = var.gcp_vpc_vpn_tunnel_1_vpn_gw_int
  gcp_vpc_vpn_tunnel_2_name           = var.gcp_vpc_vpn_tunnel_2_name
  gcp_vpc_vpn_tunnel_2_peer_gw_int    = var.gcp_vpc_vpn_tunnel_2_peer_gw_int
  gcp_vpc_vpn_tunnel_2_vpn_gw_int     = var.gcp_vpc_vpn_tunnel_2_vpn_gw_int
  gcp_vpc_vpn_tunnel_3_name           = var.gcp_vpc_vpn_tunnel_3_name
  gcp_vpc_vpn_tunnel_3_peer_gw_int    = var.gcp_vpc_vpn_tunnel_3_peer_gw_int
  gcp_vpc_vpn_tunnel_3_vpn_gw_int     = var.gcp_vpc_vpn_tunnel_3_vpn_gw_int
  gcp_vpc_vpn_tunnel_4_name           = var.gcp_vpc_vpn_tunnel_4_name
  gcp_vpc_vpn_tunnel_4_peer_gw_int    = var.gcp_vpc_vpn_tunnel_4_peer_gw_int
  gcp_vpc_vpn_tunnel_4_vpn_gw_int     = var.gcp_vpc_vpn_tunnel_4_vpn_gw_int
  gcp_router_int_region               = var.gcp_router_int_region
  gcp_router_int_1_name               = var.gcp_router_int_1_name
  gcp_router_int_1_ip_range           = var.gcp_router_int_1_ip_range
  gcp_router_int_2_name               = var.gcp_router_int_2_name
  gcp_router_int_2_ip_range           = var.gcp_router_int_2_ip_range
  gcp_router_int_3_name               = var.gcp_router_int_3_name
  gcp_router_int_3_ip_range           = var.gcp_router_int_3_ip_range
  gcp_router_int_4_name               = var.gcp_router_int_4_name
  gcp_router_int_4_ip_range           = var.gcp_router_int_4_ip_range
  bgp_peer_region                     = var.bgp_peer_region
  bgp_peer_1_peer_name                = var.bgp_peer_1_peer_name
  bgp_peer_1_peer_ip_addr             = var.bgp_peer_1_peer_ip_addr
  bgp_peer_2_peer_name                = var.bgp_peer_2_peer_name
  bgp_peer_2_peer_ip_addr             = var.bgp_peer_2_peer_ip_addr
  bgp_peer_3_peer_name                = var.bgp_peer_3_peer_name
  bgp_peer_3_peer_ip_addr             = var.bgp_peer_3_peer_ip_addr
  bgp_peer_4_peer_name                = var.bgp_peer_4_peer_name
  bgp_peer_4_peer_ip_addr             = var.bgp_peer_4_peer_ip_addr
}





### BEGIN AWS Resources ###

# AWS Module 1 - VPC, Private & Subnet, IGW, RTs
module "aws_vpc_network" {
  source                              = "./aws-modules/aws-vpc"
  aws_vpn_gw_out                      = module.aws_vpn.aws_vpn_gw_id
  gcp_private_subn_out                = module.gcp_vpc_network.gcp_vpc_private_subn_cidr
  aws_vpc_vpn_cidr_block              = var.aws_vpc_vpn_cidr_block
  aws_vpc_vpn_tags                    = var.aws_vpc_vpn_tags
  aws_vpc_vpn_private_subn_cidr_block = var.aws_vpc_vpn_private_subn_cidr_block
  aws_vpc_vpn_private_subn_avail_zone = var.aws_vpc_vpn_private_subn_avail_zone
  aws_vpc_vpn_private_subn_tags       = var.aws_vpc_vpn_private_subn_tags
  aws_vpc_vpn_public_subn_cidr_block  = var.aws_vpc_vpn_public_subn_cidr_block
  aws_vpc_vpn_public_subn_tags        = var.aws_vpc_vpn_public_subn_tags
  public_igw_tags                     = var.public_igw_tags
  aws_vpc_public_subn_rt_cidr         = var.aws_vpc_public_subn_rt_cidr
  aws_vpc_public_subn_rt_name         = var.aws_vpc_public_subn_rt_name
}

# AWS Module 2 - Private EC2 Instance w/ Security Group
module "aws_ec2_private" {
  source                         = "./aws-modules/aws-private-ec2"
  aws_vpc_id_out                 = module.aws_vpc_network.aws_vpc_id
  aws_private_subnet_id_out      = module.aws_vpc_network.aws_private_subnet_id
  gcp_private_subnet_cidr_out    = module.gcp_vpc_network.gcp_vpc_private_subn_cidr
  ubuntu_most_recent             = var.ubuntu_most_recent
  ubuntu_value                   = var.ubuntu_value
  aws_test_vm_instance_type      = var.aws_test_vm_instance_type
  aws_test_vm_avail_zone         = var.aws_test_vm_avail_zone
  aws_test_vm_assc_public_ip     = var.aws_test_vm_assc_public_ip
  aws_test_vm_tags               = var.aws_test_vm_tags
  aws_test_vm_key_name           = var.aws_test_vm_key_name
  allow_gcp_vpc_name             = var.allow_gcp_vpc_name
  allow_gcp_vpc_desc             = var.allow_gcp_vpc_desc
  allow_gcp_vpc_tags             = var.allow_gcp_vpc_tags
  allow_gcp_vpc_ssh_cidr         = var.allow_gcp_vpc_ssh_cidr
  allow_gcp_vpc_ssh_from_port    = var.allow_gcp_vpc_ssh_from_port
  allow_gcp_vpc_ssh_protocol     = var.allow_gcp_vpc_ssh_protocol
  allow_gcp_vpc_ssh_to_port      = var.allow_gcp_vpc_ssh_to_port
  allow_gcp_vpc_gcp_all_protocol = var.allow_gcp_vpc_gcp_all_protocol
  allow_gcp_vpc_egress_protocol  = var.allow_gcp_vpc_egress_protocol
}

# AWS Module 3 - Bastion Host in Public Subnet w/ Security Group
module "aws_bastion" {
  source                        = "./aws-modules/aws-bastion-host"
  vpc_id                        = module.aws_vpc_network.aws_vpc_id
  public_subnet_id              = module.aws_vpc_network.aws_public_subnet_id
  vpc_cidr                      = module.aws_vpc_network.aws_vpc_vpn_cidr_block
  aws_bastion_ami               = var.aws_bastion_ami
  aws_bastion_type              = var.aws_bastion_type
  aws_bastion_key_name          = var.aws_bastion_key_name
  aws_bastion_tags              = var.aws_bastion_tags
  bastion_sg_name               = var.bastion_sg_name
  bastion_sg_desc               = var.bastion_sg_desc
  bastion_sg_tags               = var.bastion_sg_tags
  allow_bastion_ssh_cidr        = var.allow_bastion_ssh_cidr
  allow_bastion_ssh_from_port   = var.allow_bastion_ssh_from_port
  allow_bastion_ssh_protocol    = var.allow_bastion_ssh_protocol
  allow_bastion_ssh_to_port     = var.allow_bastion_ssh_to_port
  allow_bastion_vpc_protocol    = var.allow_bastion_vpc_protocol
  allow_bastion_egress_cidr     = var.allow_bastion_egress_cidr
  allow_bastion_egress_protocol = var.allow_bastion_egress_protocol
}

# AWS Module 4 - VPN Gateway, Customer GWs, VPN Connection 
module "aws_vpn" {
  source                            = "./aws-modules/aws-vpn"
  aws_vpc_id_out                    = module.aws_vpc_network.aws_vpc_id
  gcp_bgp_asn                       = module.gcp_vpn.gcp_vpc_vpn_router_1_asn
  gcp_ha_vpn_int_0                  = module.gcp_vpn.interface_0_ip
  gcp_ha_vpn_int_1                  = module.gcp_vpn.interface_1_ip
  gcp_ha_vpn_depend                 = module.gcp_vpn.gcp_vpn_ha_gateway_dependency
  aws_vpn_gw_tags                   = var.aws_vpn_gw_tags
  aws_vpn_gw_amazon_side_asn        = var.aws_vpn_gw_amazon_side_asn
  customer_gateway_type             = var.customer_gateway_type
  customer_gateway_0_tag            = var.customer_gateway_0_tag
  customer_gateway_1_tag            = var.customer_gateway_1_tag
  vpn_connection_type               = var.vpn_connection_type
  vpn_connection_0_t1_inside_cidr   = var.vpn_connection_0_t1_inside_cidr
  vpn_connection_0_t1_preshared_key = var.vpn_connection_0_t1_preshared_key
  vpn_connection_0_t2_inside_cidr   = var.vpn_connection_0_t2_inside_cidr
  vpn_connection_0_t2_preshared_key = var.vpn_connection_0_t2_preshared_key
  vpn_connection_1_t1_inside_cidr   = var.vpn_connection_1_t1_inside_cidr
  vpn_connection_1_t1_preshared_key = var.vpn_connection_1_t1_preshared_key
  vpn_connection_1_t2_inside_cidr   = var.vpn_connection_1_t2_inside_cidr
  vpn_connection_1_t2_preshared_key = var.vpn_connection_1_t2_preshared_key
}