# root/aws-modules/aws-vpn/outputs.tf

output "aws_vpn_gw_id" {
  value = aws_vpn_gateway.aws_vpn_gw.id
}

output "tunnel1_address_0" {
  value = aws_vpn_connection.vpn_connection_0.tunnel1_address
}

output "tunnel2_address_0" {
  value = aws_vpn_connection.vpn_connection_0.tunnel2_address
}
 
output "tunnel1_address_1" {
  value = aws_vpn_connection.vpn_connection_1.tunnel1_address
}

output "tunnel2_address_1" {
  value = aws_vpn_connection.vpn_connection_1.tunnel2_address
}



output "c0_t1_shared_key" {
  value = aws_vpn_connection.vpn_connection_0.tunnel1_preshared_key
}

output "c0_t2_shared_key" {
  value = aws_vpn_connection.vpn_connection_0.tunnel2_preshared_key
}

output "c1_t1_shared_key" {
  value = aws_vpn_connection.vpn_connection_1.tunnel1_preshared_key
}

output "c1_t2_shared_key" {
  value = aws_vpn_connection.vpn_connection_1.tunnel2_preshared_key
}

output "aws_vpn_gw_asn" {
  value = aws_vpn_gateway.aws_vpn_gw.amazon_side_asn
  
}