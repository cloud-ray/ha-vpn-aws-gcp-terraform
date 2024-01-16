# root/gcp-modules/gcp-vpn/variables.tf

# For use with root/main.tf module values
variable "network_id" {}
variable "aws_asn" {}
variable "c0_t1_addr" {}
variable "c0_t2_addr" {}
variable "c1_t1_addr" {}
variable "c1_t2_addr" {}
variable "c0_t1_share_key" {}
variable "c0_t2_share_key" {}
variable "c1_t1_share_key" {}
variable "c1_t2_share_key" {}

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