variable "aws_credentials" {
    type = string
    description = "AWS Credentials File. Generated from AWS Access Key ID and secret Access Key"
    default = "credentials"
}
variable "aws_region" {
    type = string
    description = "AWS Region to deploy the resources"
    default = "us-east-1"
}

variable "aws_vpc_cidr" {
    type = string
    description = "AWS VPC CIDR to deploy EC2 Instance"
    default = "172.16.0.0/16"
}

variable "aws_vpc_sg_name" {
    type = string
    description = "Security Group attached to the EC2 VPC"
    default = "Allow ALL"
}

variable "aws_vpn_asn" {
    type = number
    description = "AWS VNG BGP ASN. Must be different from Azure side ASN"
    default = 64900
}

variable "aws_vpn_connection_1_tunnel1_bgp_cidr" {
    type = string
    description = "AWS IPSec connection to Azure VNG IN 0 Tunnel 1 CIDR. This is the subnet where variable azure_vpn_apipa_address_vngw_in_0 in azure_options_tf file belongs to"
    default = "169.254.21.0/30"
}

variable "aws_vpn_connection_1_tunnel2_bgp_cidr" {
    type = string
    description = "AWS IPSec connection to Azure VNG IN 0 Tunnel 2 CIDR. This is a bogus subnet because Azure VNG only supports a single BGP enabled tunnel per instance. It must be different from variable aws_vpn_connection_1_tunnel1_bgp_cidr above"
    default = "169.254.255.0/30"
}

variable "aws_vpn_connection_2_tunnel1_bgp_cidr" {
    type = string
    description = "AWS IPSec connection to Azure VNG IN 1 Tunnel 1 CIDR. This is the subnet where variable azure_vpn_apipa_address_vngw_in_1 in azure_options_tf file belongs to"
    default = "169.254.22.0/30"
}

variable "aws_vpn_connection_2_tunnel2_bgp_cidr" {
    type = string
    description = "AWS IPSec connection to Azure VNG IN 1 Tunnel 2 CIDR. This is a bogus subnet because Azure VNG only supports a single BGP enabled tunnel per instance. It must be different from variable aws_vpn_connection_1_tunnel1_bgp_cidr above"
    default = "169.254.255.4/30"
}

variable "dx_gateway" {
    type = string
    description = "Direct Connect Gateway Name"
    default = "dx-gateway"
}

variable "dx_asn" {
    type = number
    description = "BGP ASN Used for Direct Connect GW. Must be different from VNGW ASN"
    default = 64901
}

variable "dx_vlan" {
    type = number
    description = "VLAN ID Used for Direct Connect Port"
    default = 160
}

variable "aws_ami" {
    type = string
    description = "AWS AMI to use for the EC2 Instance. Default is Amazon Linux Free Tier"
    default = "ami-0c2b8ca1dad447f8a"
}

variable "aws_ec2_key_pair" {
    type = string
    description = "Public SSH Key Name used for the EC2 Instance"
    default = "ec2-ssh-key"
}