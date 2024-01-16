# root/gcp-modules/gcp-firewalls/main.tf

# 3. GCP - Create VM firewall to allow ssh
resource "google_compute_firewall" "allow_ssh_iap" {
  name    = var.allow_ssh_iap_name
  network = var.network_id
 
  allow {
    protocol = var.allow_ssh_iap_protocol
    ports    = [var.allow_ssh_iap_ports]
  }

  source_ranges = [var.allow_ssh_iap_source_ranges]
  target_tags   = [var.allow_ssh_iap_target_tags]
}

# 3.1 GCP - Create VPC firewall to allow ingress from AWS
resource "google_compute_firewall" "allow_ingress_from_aws" {
  name      = var.allow_ingress_from_aws_name
  network   = var.network_id
  direction = var.allow_ingress_from_aws_direction

  allow {
    protocol = var.allow_ingress_from_aws_protocol_1
    ports    = [var.allow_ingress_from_aws_ports] # Allow SSH for testing
  }

  allow {
    protocol = var.allow_ingress_from_aws_protocol_2 # Allow ICMP for testing
  }

  source_ranges = [var.allow_ingress_from_aws_source_ranges] # AWS VPC CIDR range
  target_tags   = [var.allow_ingress_from_target_tags]       # Apply to instances with this tag
}

# 3.2 GCP - Create VPC firewall to allow egress to AWS
resource "google_compute_firewall" "allow_egress_to_aws" {
  name      = var.allow_egress_to_aws_name
  network   = var.network_id
  direction = var.allow_egress_to_aws_direction

  allow {
    protocol = var.allow_egress_to_aws_protocol # Broader egress rule for connectivity
  }

  destination_ranges = [var.allow_egress_to_aws_dest_ranges] # AWS VPC CIDR range
  target_tags        = [var.allow_egress_to_aws_target_tags] # Apply to specific instances
}