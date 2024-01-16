# root/gcp-modules/gcp-firewalls/variables.tf

# For use with root/main.tf module values
variable "network_id" {}

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