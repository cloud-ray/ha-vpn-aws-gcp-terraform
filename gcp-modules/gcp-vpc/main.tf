# root/gcp-modules/gcp-vpc/main.tf

# 1. GCP - Create a VPC network on Google Cloud
resource "google_compute_network" "gcp_vpc_vpn" {
  name                    = var.gcp_vpc_vpn_name
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.gcp_vpc_vpn_routing
}

# 2. GCP - Create a private subnet within the VPC
resource "google_compute_subnetwork" "gcp_vpc_vpn_private_subn" {
  name          = var.gcp_vpc_vpn_private_subn_name
  region        = var.gcp_vpc_vpn_private_subn_region
  network       = google_compute_network.gcp_vpc_vpn.id
  ip_cidr_range = var.gcp_vpc_vpn_private_subn_ip_cidr_range
} 