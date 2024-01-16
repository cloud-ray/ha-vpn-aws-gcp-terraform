# root/gcp-modules/gcp-vpn/main.tf

# 5. GCP - Create a HA VPN gateway 
resource "google_compute_ha_vpn_gateway" "gcp_vpn_ha_gateway" {
  region  = var.gcp_vpn_ha_gateway_region
  name    = var.gcp_vpn_ha_gateway_name
  network = var.network_id # output from gcp-vpc
}

# 6. GCP - Create a Cloud Router for dynamic routing
resource "google_compute_router" "gcp_vpc_vpn_router_1" {
  name    = var.gcp_vpc_vpn_router_1_name
  network = var.network_id # output from gcp-vpc
  region  = var.gcp_vpc_vpn_router_1_region

  # BGP Configuration for dynamic routing
  bgp {
    asn               = var.gcp_vpc_vpn_router_1_asn
    advertise_mode    = var.gcp_vpc_vpn_router_1_adv_mode
    advertised_groups = [var.gcp_vpc_vpn_router_1_adv_group]
    # TBD:
    # advertised_ip_ranges {
    #   range = "1.2.3.4"
    # }
    # advertised_ip_ranges {
    #   range = "6.7.0.0/16"
    # }
  }
}

# 7. GCP - Create External VPN Gateway
resource "google_compute_external_vpn_gateway" "gcp_external_vpn_gw" {
  name            = var.gcp_external_vpn_gw_name
  description     = var.gcp_external_vpn_gw_desc
  redundancy_type = var.gcp_external_vpn_gw_redundancy_type

  interface {
    id         = 0
    ip_address = var.c0_t1_addr 
    # Use the output from AWS VPN connection 0, tunnel 1
  }
 
  interface {
    id         = 1
    ip_address = var.c0_t2_addr
    # Use the output from AWS VPN connection 0, tunnel 2
  }

  interface {
    id         = 2
    ip_address = var.c1_t1_addr
    # Use the output from AWS VPN connection 1, tunnel 1
  }

  interface {
    id         = 3
    ip_address = var.c1_t2_addr
    # Use the output from AWS VPN connection 1, tunnel 2
  }
}

## 8. GCP - Create 4 VPN tunnels to connect to AWS
# 8.1 GCP - Create GCP VPN tunnel 1
resource "google_compute_vpn_tunnel" "gcp_vpc_vpn_tunnel_1" {
  name                            = var.gcp_vpc_vpn_tunnel_1_name
  peer_external_gateway           = google_compute_external_vpn_gateway.gcp_external_vpn_gw.self_link
  peer_external_gateway_interface = var.gcp_vpc_vpn_tunnel_1_peer_gw_int
  region                          = var.gcp_vpc_vpn_tunnel_region
  ike_version                     = var.gcp_vpc_vpn_tunnel_ike_version
  shared_secret                   = var.c0_t1_share_key
  router                          = google_compute_router.gcp_vpc_vpn_router_1.id
  vpn_gateway                     = google_compute_ha_vpn_gateway.gcp_vpn_ha_gateway.self_link
  vpn_gateway_interface           = var.gcp_vpc_vpn_tunnel_1_vpn_gw_int
}

# 8.2 GCP - Create GCP VPN tunnel 2
resource "google_compute_vpn_tunnel" "gcp_vpc_vpn_tunnel_2" {
  name                            = var.gcp_vpc_vpn_tunnel_2_name
  peer_external_gateway           = google_compute_external_vpn_gateway.gcp_external_vpn_gw.self_link
  peer_external_gateway_interface = var.gcp_vpc_vpn_tunnel_2_peer_gw_int
  region                          = var.gcp_vpc_vpn_tunnel_region
  ike_version                     = var.gcp_vpc_vpn_tunnel_ike_version
  shared_secret                   = var.c0_t2_share_key
  router                          = google_compute_router.gcp_vpc_vpn_router_1.id
  vpn_gateway                     = google_compute_ha_vpn_gateway.gcp_vpn_ha_gateway.self_link
  vpn_gateway_interface           = var.gcp_vpc_vpn_tunnel_2_vpn_gw_int
}

# 8.3 GCP - Create GCP VPN tunnel 3
resource "google_compute_vpn_tunnel" "gcp_vpc_vpn_tunnel_3" {
  name                            = var.gcp_vpc_vpn_tunnel_3_name
  peer_external_gateway           = google_compute_external_vpn_gateway.gcp_external_vpn_gw.self_link
  peer_external_gateway_interface = var.gcp_vpc_vpn_tunnel_3_peer_gw_int
  region                          = var.gcp_vpc_vpn_tunnel_region
  ike_version                     = var.gcp_vpc_vpn_tunnel_ike_version
  shared_secret                   = var.c1_t1_share_key
  router                          = google_compute_router.gcp_vpc_vpn_router_1.id
  vpn_gateway                     = google_compute_ha_vpn_gateway.gcp_vpn_ha_gateway.self_link
  vpn_gateway_interface           = var.gcp_vpc_vpn_tunnel_3_vpn_gw_int
}

# 8.4 GCP - Create GCP VPN tunnel 4
resource "google_compute_vpn_tunnel" "gcp_vpc_vpn_tunnel_4" {
  name                            = var.gcp_vpc_vpn_tunnel_4_name
  peer_external_gateway           = google_compute_external_vpn_gateway.gcp_external_vpn_gw.self_link
  peer_external_gateway_interface = var.gcp_vpc_vpn_tunnel_4_peer_gw_int
  region                          = var.gcp_vpc_vpn_tunnel_region
  ike_version                     = var.gcp_vpc_vpn_tunnel_ike_version
  shared_secret                   = var.c1_t2_share_key
  router                          = google_compute_router.gcp_vpc_vpn_router_1.id
  vpn_gateway                     = google_compute_ha_vpn_gateway.gcp_vpn_ha_gateway.self_link
  vpn_gateway_interface           = var.gcp_vpc_vpn_tunnel_4_vpn_gw_int
}

## 9. GCP - Create 4 Compute Router Interfaces 
# 9.1 GCP - Create Router Interface 1
resource "google_compute_router_interface" "gcp_router_int_1" {
  name       = var.gcp_router_int_1_name
  router     = google_compute_router.gcp_vpc_vpn_router_1.name
  region     = var.gcp_router_int_region
  ip_range   = var.gcp_router_int_1_ip_range
  vpn_tunnel = google_compute_vpn_tunnel.gcp_vpc_vpn_tunnel_1.id
}

# 9.2 GCP - Create Router Interface 2
resource "google_compute_router_interface" "gcp_router_int_2" {
  name       = var.gcp_router_int_2_name
  router     = google_compute_router.gcp_vpc_vpn_router_1.name
  region     = var.gcp_router_int_region
  ip_range   = var.gcp_router_int_2_ip_range
  vpn_tunnel = google_compute_vpn_tunnel.gcp_vpc_vpn_tunnel_2.id
}

# 9.3 GCP - Create Router Interface 3
resource "google_compute_router_interface" "gcp_router_int_3" {
  name       = var.gcp_router_int_3_name
  router     = google_compute_router.gcp_vpc_vpn_router_1.name
  region     = var.gcp_router_int_region
  ip_range   = var.gcp_router_int_3_ip_range
  vpn_tunnel = google_compute_vpn_tunnel.gcp_vpc_vpn_tunnel_3.id
}

# 9.4 GCP - Create Router Interface 4
resource "google_compute_router_interface" "gcp_router_int_4" {
  name       = var.gcp_router_int_4_name
  router     = google_compute_router.gcp_vpc_vpn_router_1.name
  region     = var.gcp_router_int_region
  ip_range   = var.gcp_router_int_4_ip_range
  vpn_tunnel = google_compute_vpn_tunnel.gcp_vpc_vpn_tunnel_4.id
}

## 10. GCP - Create 4 BGP Peers
# 10.1 GCP - Create BGP Peer 1
resource "google_compute_router_peer" "bgp_peer_1" {
  name            = var.bgp_peer_1_peer_name
  router          = google_compute_router.gcp_vpc_vpn_router_1.name
  peer_asn        = var.aws_asn # ASN for the AWS side of BGP session
  peer_ip_address = var.bgp_peer_1_peer_ip_addr    # Taken from vpn_connection_0_t1_inside_cidr
  interface       = google_compute_router_interface.gcp_router_int_1.id
  region          = var.bgp_peer_region
}
 
# 10.2 GCP - Create BGP Peer 2
resource "google_compute_router_peer" "bgp_peer_2" {
  name            = var.bgp_peer_2_peer_name
  router          = google_compute_router.gcp_vpc_vpn_router_1.name
  peer_asn        = var.aws_asn # ASN for the AWS side of BGP session
  peer_ip_address = var.bgp_peer_2_peer_ip_addr    # Taken from vpn_connection_0_t2_inside_cidr
  interface       = google_compute_router_interface.gcp_router_int_2.id
  region          = var.bgp_peer_region
}
 
# 10.3 GCP - Create BGP Peer 3
resource "google_compute_router_peer" "bgp_peer_3" {
  name            = var.bgp_peer_3_peer_name
  router          = google_compute_router.gcp_vpc_vpn_router_1.name
  peer_asn        = var.aws_asn # ASN for the AWS side of BGP session
  peer_ip_address = var.bgp_peer_3_peer_ip_addr    # Taken from vpn_connection_1_t1_inside_cidr
  interface       = google_compute_router_interface.gcp_router_int_3.id
  region          = var.bgp_peer_region
}

# 10.4 GCP - Create BGP Peer 4
resource "google_compute_router_peer" "bgp_peer_4" {
  name            = var.bgp_peer_4_peer_name
  router          = google_compute_router.gcp_vpc_vpn_router_1.name
  peer_asn        = var.aws_asn # ASN for the AWS side of BGP session
  peer_ip_address = var.bgp_peer_4_peer_ip_addr    # Taken from vpn_connection_1_t2_inside_cidr
  interface       = google_compute_router_interface.gcp_router_int_4.id
  region          = var.bgp_peer_region
}
