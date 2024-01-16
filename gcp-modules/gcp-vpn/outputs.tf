# root/gcp-modules/gcp-vpn/outputs.tf

output "interface_0_ip" {
  value       = google_compute_ha_vpn_gateway.gcp_vpn_ha_gateway.vpn_interfaces.0.ip_address
  description = "IP address from GCP HA VPN Interface 0"
}

output "interface_1_ip" {
  value       = google_compute_ha_vpn_gateway.gcp_vpn_ha_gateway.vpn_interfaces.1.ip_address
  description = "IP address from GCP HA VPN Interface 1"
}

# Output of the GCP Router ASN
output "gcp_vpc_vpn_router_1_asn" {
  value       = var.gcp_vpc_vpn_router_1_asn
  description = "The Google ASN for the BGP session"
}

output "gcp_vpn_ha_gateway_dependency" {
  value = google_compute_ha_vpn_gateway.gcp_vpn_ha_gateway.id
  description = "HA VPN dependency for AWS customer gateways"
}
