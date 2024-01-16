# root/aws-modules/aws-vpn/variables.tf 

# For use with root/main.tf module values
variable "aws_vpc_id_out" {}
variable "gcp_bgp_asn" {}
variable "gcp_ha_vpn_int_0" {}
variable "gcp_ha_vpn_int_1" {}
variable "gcp_ha_vpn_depend" {}

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