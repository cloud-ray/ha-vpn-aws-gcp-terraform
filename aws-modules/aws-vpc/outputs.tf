# root/aws-modules/aws-vpc/outputs.tf

output "aws_vpc_id" {
  value       = aws_vpc.aws_vpc_vpn.id
  description = "ID of the AWS VPC"
} 
 
output "aws_vpc_vpn_cidr_block" {
  value       = aws_vpc.aws_vpc_vpn.cidr_block
  description = "The CIDR block range of the AWS VPC VPN"
}

output "aws_private_subnet_id" {
  value       = aws_subnet.aws_vpc_vpn_private_subn.id
  description = "ID of the AWS VPC Subnet"
}

output "aws_public_subnet_id" {
  value       = aws_subnet.aws_vpc_vpn_public_subn.id
  description = "ID of the AWS VPC Subnet"
}
