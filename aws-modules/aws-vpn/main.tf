# root/aws-modules/aws-vpn/main.tf 

# 1. AWS - Create VPN Gateway
resource "aws_vpn_gateway" "aws_vpn_gw" {
  vpc_id          = var.aws_vpc_id_out
  amazon_side_asn = var.aws_vpn_gw_amazon_side_asn 

  tags = {
    Name = var.aws_vpn_gw_tags
  }
} 

# 2. AWS - Create two customer gateways and configure them with the 
# external IP addresses of the GCP HA VPN gateway interfaces
resource "aws_customer_gateway" "customer_gateway_0" {
  bgp_asn    = var.gcp_bgp_asn    # Output from GCP router ASN
  ip_address = var.gcp_ha_vpn_int_0 # IP address from GCP HA VPN Interface 0
  type       = var.customer_gateway_type

  tags = {
    Name = var.customer_gateway_0_tag
  }

  depends_on = [var.gcp_ha_vpn_depend] 
} 

# 2.1 AWS - Create second customer gateway
resource "aws_customer_gateway" "customer_gateway_1" {
  bgp_asn    = var.gcp_bgp_asn    # Output from GCP router ASN                                            # Output from GCP router ASN (also a variable)
  ip_address = var.gcp_ha_vpn_int_1 # IP address from GCP HA VPN Interface 0
  type       = var.customer_gateway_type

  tags = {
    Name = var.customer_gateway_0_tag
  }

  depends_on = [var.gcp_ha_vpn_depend]
}
 
# 3. AWS - Create 2 VPN connections with dynamic routing to 
# the GCP HA VPN customer gateways
resource "aws_vpn_connection" "vpn_connection_0" {
  vpn_gateway_id      = aws_vpn_gateway.aws_vpn_gw.id
  customer_gateway_id = aws_customer_gateway.customer_gateway_0.id
  type                = var.vpn_connection_type

  tunnel1_inside_cidr   = var.vpn_connection_0_t1_inside_cidr 
  tunnel1_preshared_key = var.vpn_connection_0_t1_preshared_key
  tunnel2_inside_cidr   = var.vpn_connection_0_t2_inside_cidr
  tunnel2_preshared_key = var.vpn_connection_0_t2_preshared_key
}

# 3.1 AWS - Create second VPN connection
resource "aws_vpn_connection" "vpn_connection_1" {
  vpn_gateway_id      = aws_vpn_gateway.aws_vpn_gw.id
  customer_gateway_id = aws_customer_gateway.customer_gateway_1.id
  type                = var.vpn_connection_type

  tunnel1_inside_cidr   = var.vpn_connection_1_t1_inside_cidr
  tunnel1_preshared_key = var.vpn_connection_1_t1_preshared_key
  tunnel2_inside_cidr   = var.vpn_connection_1_t2_inside_cidr
  tunnel2_preshared_key = var.vpn_connection_1_t2_preshared_key
}