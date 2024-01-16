# root/gcp-modules/gcp-vpc/outputs.tf

output "gcp_vpc_network_id" {
  value       = google_compute_network.gcp_vpc_vpn.id
  description = "ID of the GCP VPC network"
} 

output "gcp_vpc_private_subnet_id" {
  value       = google_compute_subnetwork.gcp_vpc_vpn_private_subn.id
  description = "ID of the GCP Private Subnet"
}

output "gcp_vpc_private_subn_cidr" {
  value = var.gcp_vpc_vpn_private_subn_ip_cidr_range
  description = "CIDR block of the GCP Private Subnet"
}